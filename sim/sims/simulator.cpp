#include "simulator.hpp"
#include "mmio.hpp"
#include "../utils/utils.hpp"
#include "fpu.hpp"
#include <iostream>
#include <fstream>
#include <filesystem>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <cmath>
#include <set>
#include <chrono>
#include <algorithm>

namespace fs = std::filesystem;

static const std::string NOT_IMPLEMENTED_FOR_MULTI_FILES = "この機能は複数ファイル実行時に使えません";
static const std::string TIME_FORMAT = "Time: %.10lfms\n";

static const std::string CACHE_PARAMETER_ERROR = "パラメータの大きさが不適切です";
static const std::string CACHE_PRINT_USE_RATE = "キャッシュ使用率: ";
static const std::string CACHE_PRINT_ACCESS =   "アクセス回数: ";
static const std::string CACHE_PRINT_MISS_RATE =     "ミス率     : ";
static const std::string CACHE_PRINT_ALL_MISS_RATE =     "ミス率(All): ";
static constexpr int CACHE_PRINT_W = 10;
// 時間予測のパラメータ
static const double  WRITE_MISS_TIME = 0.002; 
static const double  READ_MISS_TIME = 0.002;

// ラベルのジャンプ回数表示
static const std::string PRINT_JUMP_LABEL_ERROR = "まだ一度もラベルにジャンプしていません";
static const std::string PRINT_JUMP_INTERVAL = "   ";
static constexpr int PRINT_JUMP_INT_W = 12;

// 浮動小数点テーブルランキング表示
static constexpr int PRINT_FLOAT_TABLE_INT_W = 12;
static constexpr int PRINT_FLOAT_TABLE_HEX_W = 8;
static const std::string PRINT_FLOAT_TABLE_INT_SUB = "     ";
static const std::string PRINT_FLOAT_BELOW_0 = "以下アクセス回数0";

// デバッグ用
static const std::string PROF_SEPARATOR = "---";
static const std::string PROF_PARAM_SEP = "_";

Cache::Cache(const uint32_t &cacheWay, const uint32_t &offsetLen,
         const uint32_t &tagLen):
    cacheWay(cacheWay), offsetLen(offsetLen), tagLen(tagLen){
    indexLen = REGISTER_BIT_N - offsetLen - tagLen;
    if(offsetLen + tagLen >= REGISTER_BIT_N){
        throw SimException(CACHE_PARAMETER_ERROR);
    }
    cacheIndexN = 1 << indexLen;
    cacheSize = cacheIndexN * cacheWay;
    indexMask = (1 << indexLen) - 1; // アドレスをoffsetビットだけシフトした後にかけてindexにするマスク
    indexTagMask = ~((1 << offsetLen) - 1); 
    reset();
}

void Cache::reset(){
    for(int i = 0; i < cacheSize; i++){
        CacheRow row = {0, false, false};
        cache[i] = row;
    }

    for (int i = 0; i < Cache::TYPES_N; i++)
    {
        hitN[i] = 0;
        initMissN[i] = 0;
        otherMissN[i] = 0;
    }
}

// backコマンドでもとに戻すとき，cacheのデータも巻き戻す
void Cache::backCache(const BeforeData &before){
    if(before.clearLRU){
        // LRUをクリアしたので，該当箇所と同一インデックスのusedbitを該当箇所以外全部立てる
        uint32_t cacheAddress = (before.cacheAddress / cacheWay) * cacheWay;
        for(uint32_t i = 0; i < cacheWay; i++){
            if(cacheAddress != before.cacheAddress){
                cache[cacheAddress].used = true;
            }else{
                cache[cacheAddress].used = false;
            }
            ++cacheAddress;
        }
    }
    if(before.changeCache){
        //キャッシュミスしてた
        cache[before.cacheAddress] = before.cacheRow;
        if(before.isNewAccess){
            // 初期参照ミス
            --initMissN[before.writeMem ? WRITE : READ];
        }else{
            --otherMissN[before.writeMem ? WRITE : READ];
        }
    }else{
        // キャッシュヒット
        --hitN[before.writeMem ? WRITE : READ];
    }
}

// キャッシュの情報を表示
void Cache::printCacheSystem()const{
    int32_t usedCacheN = 0;
    for(uint32_t i = 0; i < cacheSize; i++){
        CacheRow e = cache[i];
        usedCacheN += e.valid ? 1 : 0;
    }
    float cacheUseRate = ((float) usedCacheN) / cacheSize * 100;
    std::cout << CACHE_PRINT_USE_RATE << std::setprecision(3) << cacheUseRate << "%" << std::endl;
    for(int i = 0; i < TYPES_N; i++) {
        std::string type = i == READ ? "読み込み: " : "書き込み";
        std::cout << type << std::endl;

        int typeInt = i == READ ? READ : WRITE;

        int32_t accessN = hitN[typeInt] + initMissN[typeInt] + otherMissN[typeInt];
        std::cout << std::setw(CACHE_PRINT_W) << std::setfill(' ')<<
             CACHE_PRINT_ACCESS << accessN << std::endl;
        std::cout << std::setw(CACHE_PRINT_W) << std::setfill(' ') <<
             CACHE_PRINT_MISS_RATE << std::setprecision(3) <<
            ((float) otherMissN[typeInt]) / accessN  * 100 << "%" << std::endl;
        std::cout << std::setw(CACHE_PRINT_W) << std::setfill(' ') <<
             CACHE_PRINT_ALL_MISS_RATE << std::setprecision(3) <<
            ((float) otherMissN[typeInt] + initMissN[typeInt]) / accessN  * 100 << "%" << std::endl;
    }

}

// ミス時のストール数を計算
// 128, 512, 2048, 8192bitの時のデータに基づく
double Cache::calcStallN(const int &forWrite)const{
    double con = 53;
    double exp = offsetLen >= 4 ? (std::pow(4.0, ((double)offsetLen-4) / 2 + 1) - 1) / 3 : 0 ;
    double ans = con + exp;
    return forWrite == WRITE ? ans * 1.5 : ans;
}


// デバッグ用
// キャッシュシステムのパラメータを出力
void Cache::outputCacheInfo(std::ostream &stream)const{
    stream << cacheWay << " " << offsetLen << " " <<
         tagLen << " " << indexLen <<  std::endl;
    for(int i = 0; i < TYPES_N; i++){
        stream << hitN[i] << " " << initMissN[i] << " " <<
            otherMissN[i] << std::endl;
    }
}

// outputの逆
void Cache::inputCacheInfo(std::istream &stream){
    std::string line;
    std::getline(stream, line);
    std::istringstream iss(line);
    std::string unit1, unit2, unit3, unit4;
    iss >> unit1 >> unit2 >> unit3 >> unit4;
    cacheWay = std::stoull(unit1);
    offsetLen = std::stoull(unit2);
    tagLen = std::stoull(unit3);
    indexLen = std::stoull(unit4);

    for(int i = 0; i < TYPES_N; i++){
        std::getline(stream, line);
        std::istringstream issIn(line);
        std::string access1, access2, access3;
        issIn >> access1 >> access2 >> access3;
        hitN[i] = std::stoull(access1);
        initMissN[i] = std::stoull(access2);
        otherMissN[i] = std::stoull(access3);
    }

}


AssemblySimulator::AssemblySimulator(const AssemblyParser& parser, const bool &useBin,
                                     const bool &forGUI, const MMIO &mmio, const uint32_t &cacheWay,
                                      const uint32_t &offsetLen, const uint32_t &tagLen):
        useBinary(useBin), forGUI(forGUI), pc(0),  end(false),
        parser(parser), registers(),
        instCount(0), opCounter({}), efficientOpCounter({}), expectMissN(0), hazardStallN(0),  breakPoints({}), historyN(0),
        historyPoint(0), beforeHistory(), mmio(mmio), cache(cacheWay, offsetLen, tagLen){
    dram = new std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N>;
    wordAccessCheckMem = new std::array<bool, MEM_BYTE_N / WORD_BYTE_N>;
    MemoryUnit mu;
    
    mu.i = 0;
    (*dram).fill(mu);
    for(int i = 0; i < REGISTERS_N; i++){
        registers[i] = MemoryUnit(0);
    }
    // opcounterをすべて0に
    for(const auto & item : opcodeInfoMap){
        opCounter.insert({item.first, 0});
        efficientOpCounter.insert({static_cast<uint8_t>(item.second[5]), 0});
    }
    wordAccessCheckN = 0;
    fpu = FPU();
    inverseOpMap = AssemblyParser::getInverseOpMap();
    lastPC = static_cast<long>(parser.instructionVector.size()) * INST_BYTE_N;
}

        
AssemblySimulator::~AssemblySimulator(){
    delete dram;
    delete wordAccessCheckMem;
    
}

// 内部状態をリセットし、命令を実行前の状態にする
// ブレークポイントはそのまま
void AssemblySimulator::reset(){
    pc = 0;
    end = false;
    instCount = 0;
    nowLine = 0;
    for(auto &e: opCounter){
        opCounter[e.first] = 0;
    }
    for(auto &e: efficientOpCounter){
        efficientOpCounter[e.first] = 0;
    }
    for(int i = 0; i < REGISTERS_N; i++){
        MemoryUnit mu_(0u);
        registers[i] = mu_;
    }
    MemoryUnit mu;
    mu.i = 0;
    // breakPoints.clear();
    historyN = 0;
    historyPoint = 0;
    beforeHistory.fill({});
    (*dram).fill({0});
    (*wordAccessCheckMem).fill(false);
    floatTableAccessMem.fill(0);
    mmio.reset();
    cache.reset();
    expectMissN = 0;
    hazardStallN = 0;
}


// レジスタの番号を受け取り，その情報を文字列で返す
std::string AssemblySimulator::getRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign, const bool &useFNotation) const {
    std::stringstream ss;
    std::stringstream sin;
    std::stringstream ssreg;
    std::string regName;
    std::string prefix;
    if(!forGUI){
        // GUI用でなければレジスタ名も表示
        if(regN < REGISTERS_N / 2){
            ssreg << "x" << std::setw(2) << std::setfill('0') << std::dec << regN;
            regName = ssreg.str();
        }else if(regN < REGISTERS_N ){
            ssreg << "f" << std::setw(2) << std::setfill('0') << std::dec << regN - REGISTERS_N / 2;
            regName = ssreg.str();
        }else {
            regName = "pc ";
        }
        regName += " ";
    }else{
        // GUI用にはレジスタをint32_tで表記
        if(regN < REGISTERS_N){
            return std::to_string(registers[regN].si);
        }else{
            return std::to_string(pc);
        }

    }



    uint32_t value = regN < REGISTERS_N ? registers[regN].i : pc;


    if(useFNotation){
        ss << regName << std::setw(12) << std::to_string(registers[regN].f);
    }else{
        unsigned int  numSize = 0;
        switch (base){
            case NumberBase::BIN :
                prefix = "0b";
                numSize = 32;
                sin << std::bitset<REGISTER_BIT_N>(value);
                break;
            case NumberBase::OCT :
                prefix = "0o";
                numSize = 11;
                sin << std::oct << value;
                break;
            case NumberBase::HEX :
                prefix = "0x";
                numSize = 8;
                sin << std::hex << value;
                break;
            default :
                prefix = "";
                numSize = 12;
                if (sign){
                    ss << regName  << std::setw(numSize) << std::internal <<  static_cast<int32_t>(value);
                }else{
                    ss << regName  << std::setw(numSize) << std::internal <<   value;
                }
                return ss.str();
                break;
        }
        ss << regName <<  prefix << std::setw(numSize) << std::setfill('0') << sin.str();
    }

    return ss.str();
}


void AssemblySimulator::printRegisters(const NumberBase &base, const bool &sign, const bool& useFNotation) const {
    // レジスタの内容をすべて表示
    // GUI用には 1行目 pcのみ　2行目 x0~x31レジスタを空白文字による分割 3行目 f0~f31をhex表記で
    // pc
    std::cout << getRegisterInfoUnit(REGISTERS_N, base, sign, false) << std::endl;

    if(forGUI){
        std::stringstream ss;
        for(int i = 0; i < REGISTERS_N / 2; i++){
            ss << getRegisterInfoUnit(i, NumberBase::DEC, true, false) << " ";
        }
        std::cout << ss.str() << std::endl;
        ss.str(" ");
        ss.clear(std::stringstream::goodbit);
        for(int i = REGISTERS_N / 2; i < REGISTERS_N; i++){
            ss << getRegisterInfoUnit(i, NumberBase::HEX, false, false) << " ";
        }
        std::cout << ss.str() << std::endl;

        return;
        

    }else{
        for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL / 2; i++){
            std::string res;
            for(int j = 0; j < PRINT_REGISTERS_COL; j++){
                res += getRegisterInfoUnit(i*PRINT_REGISTERS_COL + j, base, sign, false) + ", ";
            }
            std::cout << res << std::endl;    
        }
        for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL / 2; i++){
            std::string res;
            for(int j = 0; j < PRINT_REGISTERS_COL; j++){
                res += getRegisterInfoUnit(i*PRINT_REGISTERS_COL + j + REGISTERS_N / 2, base, sign, useFNotation) + ", ";
            }
            std::cout << res << std::endl;   
        }
    }

}

void AssemblySimulator::makeDif(const std::string &path){

}

// difをファイルに出力し，以前のものと比較
// 最初から実行するためにresetを行うことに注意
void AssemblySimulator::checkDif(){
    reset();
    fs::path difFile = parser.filePaths[0];
    difFile.replace_extension(DIF_EXTENSION);

    std::ifstream ifs(difFile);
    bool isOld = ifs.is_open();
    // True  ... すでにdifファイルがあるのでそれと比較
    // False ... 新たにdifファイルを作成

    std::ofstream outFile;
    if(!isOld){
        outFile.open(difFile.string(), std::ios::out);
    }

    std::string lineNew,lineNewAll, lineOld;

    while(!end){
        int instInd = pc/INST_BYTE_N;
        const Instruction &inst = parser.instructionVector[instInd];
        nowLine = inst.lineN;
        BeforeData beforeData = efficientDoInst(inst);
        std::string opcode;
        try{
            opcode = inverseOpMap.at(beforeData.opcodeInt);
        }catch(const std::out_of_range &e){
            launchError(ILEGAL_INNER_OPCODE);
        }
        auto indPair = parser.getFileNameAndLine(inst.lineN);
        if(isOld){
            // 一行ずつ比較
            std::ostringstream oss;
            flowInstByRegInd(indPair.second, inst, oss);
            flowDif(beforeData, false, opcode, oss);
            lineNewAll = oss.str();
            std::istringstream iss(lineNewAll);
            while(std::getline(iss, lineNew)){
                std::getline(ifs, lineOld);
                if(lineNew != lineOld){
                    std::cout << FOUND_DIF << std::endl;
                    std::cout << lineNewAll << std::endl;
                    std::cout << std::endl;
                    std::cout << FOUND_BEFORE << std::endl;
                    std::cout << lineOld << std::endl;
                    std::cout << FOUND_AFTER << std::endl;
                    std::cout << lineNew << std::endl; 
                    reset();
                    return;                  
                }
            }
        }else{
            flowInstByRegInd(indPair.second, inst, outFile);
            flowDif(beforeData, false, opcode, outFile);
        }
    }
    if(!isOld){
        outFile.close();
    }

    reset();
    

}

// 終了まで実行する
void AssemblySimulator::launch(const bool &printTime){
    if(end){
        // すでに終わっている
        if(forGUI){
            std::cout << GUI_ALREADY_END << std::endl;
            
        }else{
            std::cout << ALREADY_ENDED << std::endl;
        }
        return;
    }
    std::chrono::system_clock::time_point  startT, endT;
    startT = std::chrono::system_clock::now();
    while(!end){
        next(false, false);
    }
    endT = std::chrono::system_clock::now(); 
    double elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(endT-startT).count();
    if(printTime && !forGUI){
        printf(TIME_FORMAT.c_str(), elapsed);
    }
    if(!forGUI) printCalculatedTime();
}

// 終了まで実行する(高速版だが back, 統計が使えない)
void AssemblySimulator::launchFast(const bool &printTime){
    if(end){
        // すでに終わっている
        if(forGUI){
            std::cout << GUI_ALREADY_END << std::endl;
            
        }else{
            std::cout << ALREADY_ENDED << std::endl;
        }
        return;
    }
    std::chrono::system_clock::time_point  startT, endT;
    startT = std::chrono::system_clock::now();
    while(!end){
        int instInd = pc/INST_BYTE_N;
        const Instruction &inst = parser.instructionVector[instInd];
        nowLine = inst.lineN;
        efficientDoInst(inst);
    }
    endT = std::chrono::system_clock::now(); 
    double elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(endT-startT).count();
    if(printTime && !forGUI){
        printf(TIME_FORMAT.c_str(), elapsed);
    }
    if(!forGUI) printCalculatedTime();
}

void AssemblySimulator::doNextBreak(){
    // 次のブレークポイントまで実行
    next(false, false); //最初は実行できる
    while(!end){
        int instInd = pc / INST_BYTE_N;
        if(breakPoints.find(instInd) != breakPoints.end()){
            if(forGUI){
                // std::cout << GUI_STOP << std::endl;
                // ちょうど止まった命令のファイル内での行数を表示(先頭に差し込まれたjalrが0indになる)
                auto ans =  parser.getFileNameAndLine( parser.instructionVector[instInd].lineN);
                std::cout << ans.second << std::endl;
                
            }else{
                std::cout << "Stopped: " << std::endl;
                Instruction inst = parser.instructionVector[instInd];
                printInstructionInSim(inst.lineN, inst);
            }
            break;
        }
        next(false, false);
    }

}

void AssemblySimulator::next(bool jumpComment, const bool& printInst){
    // 現在PCで示している命令を実行する
    // jumpComment ... コメント、ラベルは飛ばして次の命令も実行する
    // printInst   ... 命令の内容を表示
    do{
        if(end){
            // すでに終わっている
            if(forGUI){
                std::cout << GUI_ALREADY_END << std::endl;
                
            }else{
                std::cout << ALREADY_ENDED << std::endl;

            }
            return;
        }


        int instInd = pc/INST_BYTE_N;
        const Instruction &inst = parser.instructionVector[instInd];
        nowLine = inst.lineN;
        jumpComment = false;
        BeforeData beforeData = efficientDoInst(inst);
        // if(useEfficient){
        // }else{
        //     beforeData = doInst(inst);
        // }

        efficientOpCounter[beforeData.opcodeInt] = efficientOpCounter[beforeData.opcodeInt] +1;
        if(printInst){
            std::string opcode;
            try{
                opcode = inverseOpMap.at(beforeData.opcodeInt);
            }catch(const std::out_of_range &e){
                launchError(ILEGAL_INNER_OPCODE);
            }
            if(!forGUI){
                printInstructionInSim(inst.lineN, inst);
            }
            printDif(beforeData, false, opcode);
        }

        addHistory(beforeData);
    }while(jumpComment);

}

void AssemblySimulator::addHistory(const BeforeData &input){
    // 履歴を追加
    beforeHistory[historyPoint] = input;
    historyPoint = (historyPoint + 1) % HISTORY_RESERVE_N;
    historyN = historyN >= HISTORY_RESERVE_N ? HISTORY_RESERVE_N : historyN +1;
}

BeforeData AssemblySimulator::popHistory(){
    // 履歴をポップする　もう履歴がなければout_of_range例外を送る
    if(historyN==0){
        throw std::out_of_range(NO_HISTORY);
    }
    historyN --;
    historyPoint = (historyPoint-1 + HISTORY_RESERVE_N) % HISTORY_RESERVE_N;
    return beforeHistory[historyPoint];
}

// ひとつ前に戻る
// pcとそのほかのレジスタは別々に戻しているのでjalrなどにも対応
void AssemblySimulator::back(){
    BeforeData before;
    std::string opcode;
    try{
        before = popHistory();
        if(USE_EFFICIENT){
            // before.instruction を入力する
            try{
                opcode = inverseOpMap.at(before.opcodeInt);
            }catch(const std::out_of_range &e){
                launchError(ILEGAL_INNER_OPCODE);
            }
        }
    }catch (const std::out_of_range & e){
        if(forGUI){
            std::cout << GUI_NO_HISTORY << std::endl;
        }else{
            std::cout << NO_HISTORY << std::endl;
        }
        return;        
    }
    if(opcode != "" &&  forGUI){
        printDif(before, true, opcode);
    }
    end = false;
    if(before.jumpToLabel){
        // jumpedLabelCountが更新された
        
        jumpedLabelCount[pc] = jumpedLabelCount[pc] - 1;
    }
    pc = before.pc;
    if(opcode != ""){
        instCount--;
        efficientOpCounter[before.opcodeInt] = efficientOpCounter[before.opcodeInt] -1;
        if(before.regInd >= 0){
            MemoryUnit mu;
            mu.si = before.regValue;
            registers[before.regInd] = mu;
        }
        // メモリ，キャッシュ系を戻す
        if(before.useMem){
            cache.backCache(before);
            if(before.writeMem){
                writeMem(before.memAddress, MemAccess::WORD, before.memValue);
            }

        }else if(before.isMMIO){
            // MMIO
            if(!before.MMIOvalid){
                mmio.back(before.MMIOsend);
            }
        }


    }else{
        // 前の命令はコメントやラベルだった
        if(forGUI){
            std::cout << GUI_NO_CHANGE << std::endl;
            
        }
    }

    if(before.isNewAccess){
        (*wordAccessCheckMem)[before.newAccessAddress/4] = false;
        --wordAccessCheckN;
    }


}
void  AssemblySimulator::flowInstByRegInd(const int & lineN, const Instruction &instruction, std::ostream &stream){
    std::stringstream ss;
    ss << std::setw(PRINT_INST_NUM_SIZE) << std::to_string(lineN) << ":";
    ss <<  std::setw(PRINT_INST_NUM_SIZE) << instruction.opcode;
    auto instInfo = opcodeInfoMap[instruction.opcode];
    switch(instInfo[4]){
        case INST_REGONLY:
        case INST_2REGF:
            for(int i = 0; i < instruction.operandN; i++){
                ss << std::setw(PRINT_INST_NUM_SIZE) << " %" +  std::to_string(instruction.regInd[i]);
            }
            break;
        case INST_REGIMM:
        case INST_CONTROL:
            if(instruction.opcode == "jr" || instruction.opcode == "jalr"){
                for(int i = 0; i < instruction.operandN -1; i++){
                    ss << std::setw(PRINT_INST_NUM_SIZE) << " %" +  std::to_string(instruction.regInd[i]);
                }
                ss <<  " " << std::setw(3) <<   std::to_string(instruction.immediate);
                ss << "(" << "%" +  std::to_string(instruction.regInd[instruction.operandN-1]) << ")";
            }else{
                for(int i = 0; i < instruction.operandN; i++){
                    ss << std::setw(PRINT_INST_NUM_SIZE) << " %" +  std::to_string(instruction.regInd[i]);
                }
                ss <<  " " <<  std::setw(PRINT_INST_NUM_SIZE-1) << std::to_string(instruction.immediate);
            }
            break;
        case INST_LOAD:
        case INST_STORE:
            for(int i = 0; i < instruction.operandN -1; i++){
                ss << std::setw(PRINT_INST_NUM_SIZE) << " %" +  std::to_string(instruction.regInd[i]);
            }
            ss <<  " " << std::setw(3)<<  std::to_string(instruction.immediate);
            ss << "(" << "%" +  std::to_string(instruction.regInd[instruction.operandN-1]) << ")";
            break;
        case INST_OTHERS:
            break;
        default:
            stream << IMPLEMENT_ERROR << std::endl;
            return;
            

    }
    stream << ss.str() << std::endl;
}


void AssemblySimulator::printInstByRegInd(const int & lineN, const Instruction &instruction){
    flowInstByRegInd(lineN, instruction, std::cout);
}

void AssemblySimulator::printInstruction(const int & lineN, const Instruction &instruction){
    std::stringstream ss;
    ss << std::setw(PRINT_INST_NUM_SIZE) << std::to_string(lineN) << ":";
    ss <<  std::setw(PRINT_INST_NUM_SIZE) << instruction.opcode;
    for(int i = 0; i < instruction.operandN; i++){
        ss << std::setw(PRINT_INST_NUM_SIZE) << " " +  instruction.operand[i];
    }
    std::cout << ss.str() << std::endl;
}

void AssemblySimulator::printInstructionInSim(const int & lineN, const Instruction &instruction)const{
    // 受け取った命令を画面表示
    auto indPair = parser.getFileNameAndLine(lineN);
    // if(useBinary){
    printInstByRegInd(indPair.second, instruction);
    // }else{
    // printInstruction(indPair.second, instruction);
    // }
}


// ブレークポイントの登録，削除用のインデックスに変換する
// 機械語ファイルを使うとき→ 命令ベクトルのインデックス+1で指定(最初の命令を1行目にする)
// アセンブラを使うとき　→　ファイルの行数で指定
// bool ... 適切な範囲内か
// int32_t ... breakPoint用のインデックス
std::pair<bool, int32_t> AssemblySimulator::translateBreakInd(const int & instInd)const{
    bool valid = false;
    uint32_t ind = 0;
    if(instInd < 0) return {false, 0};
    if(!useBinary){
        // ファイルの行数以内か
        valid = instInd >= 0 && instInd < static_cast<int>(parser.lineIndMap.size());
        if(valid){
            // この時点でvalidじゃなかったら設置不可
            ind = parser.lineIndMap[instInd];
            valid = ind != NOT_INST_LINE_IND;
        }
    }else{
        ind = static_cast<uint32_t>(instInd);
        valid = ind >= 0 && ind < static_cast<uint32_t>(parser.instructionVector.size());
    }

    return {valid, ind};
}

void AssemblySimulator::deleteBreakPoint(const int &instInd){
    auto ans = translateBreakInd(instInd);
    int i = 0;
    if(ans.first){
        i = breakPoints.erase(ans.second);
    }
    if(i == 0){
        if(forGUI){
            std::cout << GUI_WARNING << std::endl;
        }else{
            std::cout << BREAKPOINT_NOT_FOUND << std::endl;
        }
    }
}

// ブレークポイントを設置 instructionVectorのインデックス
// 　…　複数ファイルでのこの機能は工事中
void AssemblySimulator::setBreakPoint(const int &instInd){
    if(parser.filePaths.size() > 1){
        // 複数ファイルでは使えない
        std::cout << NOT_IMPLEMENTED_FOR_MULTI_FILES << std::endl;
        return;
    }
    auto ans = translateBreakInd(instInd);

    if(ans.first){
        breakPoints.insert(ans.second);
    }else{
        // 範囲外のため設置不可
        if(forGUI){
            std::cout << GUI_WARNING << std::endl;
        }else{
            std::cout << OUT_OF_RANGE_BREAKPOINT << std::endl;   
        }
    }
}


void AssemblySimulator::printBreakList()const{
    // ブレークポイントの命令を表示
    // breakPointsはcontainsを高速にするためunorderedにしているため，ここでソートする
    std::vector<int32_t> breakVector(breakPoints.begin(), breakPoints.end());
    sort(breakVector.begin(), breakVector.end());
    for(auto &e: breakVector){
        printInstByRegInd(parser.instructionVector[e].lineN-1, parser.instructionVector[e]);
    }

}

void AssemblySimulator::printDif(const BeforeData & before, const bool &back, const std::string &opcode)const{
    // 差分を表示 GUI用にbackのときも実装
    flowDif(before, back, opcode, std::cout);
}

void AssemblySimulator::flowDif(const BeforeData &before, const bool &back, const std::string &opcode, std::ostream &stream)const{
    if(forGUI){
        // 変化のあったレジスタ名とその変化後の値を表示
        if(opcode != "nop"){
            if(before.pc != pc -4){
                if(back){
                    stream << "pc " << before.pc << std::endl;
                }else{
                    stream << "pc " << pc << std::endl;
                }
                if(before.regInd >= 0){
                    int change = 0;
                    if(back){
                        change = before.regValue;
                    }else{
                        change = registers[before.regInd].si;
                    }
                    stream <<"x"<< std::setw(2) << std::setfill('0') <<   std::internal << before.regInd 
                        << " " << change <<  std::endl;
                }
                return;
            }else if(before.regInd >= 0){
                int32_t change = 0;
                std::string pref = "";
                if(before.regInd < REGISTERS_N / 2){
                    pref = "x";
                }else{
                    pref = "f";
                }
                if(back){
                    change = before.regValue;
                }else{
                    change = registers[before.regInd].si;
                }
                stream <<pref<< std::setw(2) << std::setfill('0') <<  std::internal << before.regInd 
                    << " " << change <<  std::endl;
                return;
            }else if(before.writeMem){
                
                // メモリの変更があったことを示すため，GUI_MEM_CHANGEをまず表示
                stream << GUI_MEM_CHANGE << std::endl;
                //アドレス
                stream  << before.memAddress << " ";
                uint32_t value;
                if(back){
                    value = before.memValue;
                }else{
                    value = readMem(before.memAddress, MemAccess::WORD);
                }
                stream << getSeparatedWordString(value) << std::endl;

            } else if(before.MMIOsend){
                    // サーバに送った
                    // mmioの情報はioコマンドで受け取るのでOK?
                    stream << GUI_NO_CHANGE << std::endl;
                    // stream << GUI_SEND << " " << static_cast<int32_t>(mmio.getLast()) << std::endl;
            }else{
                stream << GUI_NO_CHANGE << std::endl;
                
            }
        }else{
             stream << GUI_NO_CHANGE << std::endl;
        }
    }else{
        stream << "  " << std::setfill(' ') ;
        bool isChanged = false;
        if(opcode != "nop"){
            if(before.pc != pc -4){
                // pcと同時にレジスタが変わることもあるので，returnはしない
                stream << "pc:" <<  std::setw(11) << std::internal <<before.pc << " -> " 
                    << std::setw(11) << std::internal << pc  << std::endl;
                isChanged = true;

            }else if(before.writeMem){
            
                uint32_t nowValue = readMem(before.memAddress, MemAccess::WORD);
                //アドレス
                stream <<  "0x" << std::setw(MEM_ADDRESS_HEX_LEN) << std::setfill('0') << std::hex << before.memAddress;
                // 旧値
                stream <<  ": 0x" << std::setw(WORD_BYTE_N) << std::setfill('0') << std::hex << before.memValue;
                stream << " -> ";
                stream <<  "0x" << std::setw(WORD_BYTE_N) << std::setfill('0') << std::hex << nowValue << std::endl;
                return;
            }else if(before.MMIOsend){
                    // サーバに送った
                    stream << GUI_SEND << " " << static_cast<int32_t>(mmio.getLast()) << std::endl;
                    return ;
            }
            if(before.regInd >= 0){
                bool useFNotation = before.regInd >=  REGISTERS_N / 2;
                std::string regInfo = getRegisterInfoUnit(before.regInd, NumberBase::DEC, true, useFNotation);
                MemoryUnit mu;
                mu.si = before.regValue;
                stream << regInfo.substr(0, 3) << " " << std::setw(11) <<   std::internal << std::dec<<
                (useFNotation ? mu.f : mu.si) << " -> " << regInfo.substr(3) << std::endl;
                return;
            }
        }
        if(!isChanged){
            stream << "--- No Change ---" << std::endl;
        }
        
        
    }
    return;

}

// GUI用表記で1ワードのメモリをLSB側から1バイトずつint8_tで表示する
// ※JavaのByteは符号付きのため
std::string AssemblySimulator::getSeparatedWordString(const uint32_t &value)const{
    MemoryUnit mu;
    mu.i = value;
    std::stringstream ss;
    for (size_t i = 0; i < WORD_BYTE_N; i++)
    {
        ss << static_cast<int>(mu.sb[i]) << " ";
    }
    return ss.str();
    
}


// レジスタのインデックスとそれが整数レジスタに属するかを返す
std::pair<int, bool> AssemblySimulator::getRegInd(const std::string &regName){

    if(regName == "pc" || regName == "%pc"){
        return {REGISTERS_N, true};
    }else if(regName == "zero" || regName == "%zero"){
        return {0, true};
    }else{
        try{
            if(startsWith(regName, IREG_PREFIX)){
                return {std::stoi(regName.substr(2)), true};
            }else if(startsWith(regName, IREG_PREFIX.substr(1))){
                return {std::stoi(regName.substr(1)), true};
            }else if(startsWith(regName, FREG_PREFIX)){
                return {std::stoi(regName.substr(2)), false};
            }else if(startsWith(regName, FREG_PREFIX.substr(1))){
                return {std::stoi(regName.substr(1)), false};
            }else{
                // レジスタ名が不正
                return {-1, true};
            }

        }catch(const std::invalid_argument & e){
            // レジスタ名が不正
            return {-1, true};
        }catch(const std::out_of_range & e){
            // レジスタ名が不正
            return {-1, true};
        }
    }
}



std::pair<int, bool> AssemblySimulator::getRegIndWithError(const std::string &regName)const{
    auto pair = getRegInd(regName);
    int ind = pair.first;
    if(ind < 0){
        launchError(INVALID_REGISTER);
        return {-1, true};

    }
    return pair;
}




void AssemblySimulator::launchError(const std::string &message)const{
    auto linePair = parser.getFileNameAndLine(nowLine);
    if(forGUI){
        // GUI用にエラー通知
        std::cout << GUI_ERROR << std::endl;
        std::cout << linePair.first << ": " << linePair.second << std::endl;
        std::cout << message << std::endl;
        
    }else{
        printRegisters(NumberBase::HEX, false, true);
    }
    throw SimException(linePair.first + ": " + std::to_string(linePair.second) + "行目:" + message);
}
void AssemblySimulator::launchWarning(const std::string &message)const{
    if(onWarning && (!forGUI)){
        auto linePair = parser.getFileNameAndLine(nowLine);

        std::cout << "Warning: " + linePair.first + ": " + std::to_string(linePair.second) + "行目:" + message << std::endl;

    }
}



void AssemblySimulator::printOpCounterWithParam(std::ostream &stream, const bool &GUIMode)const{
    // 実行命令の統計をプリント
    bool useGUIMode = GUIMode;
    if(useGUIMode){
        stream << instCount << std::endl;
    }else{
        stream << "総実行命令数: " <<  std::to_string(instCount) << std::endl;
    }
    
    std::stringstream ss;
    int count = 0;

    if(USE_EFFICIENT){
        for(auto x:opcodeInfoMap){
            if(useGUIMode){
                // 各命令につき一行
                stream << x.first << "  " <<  efficientOpCounter.at(static_cast<uint8_t>((x.second)[5])) << std::endl;
                
            }else{
                ss << std::setw(PRINT_INST_NUM_SIZE)<< x.first <<  ": " << std::setw(PRINT_INFO_NUM_SIZE) <<
                    std::internal << efficientOpCounter.at(static_cast<uint8_t>((x.second)[5])) << ",     ";
                
                if(++count == PRINT_INST_COL){
                    count = 0;
                    stream << ss.str() << std::endl;
                    ss.str("");
                    ss.clear(std::stringstream::goodbit);
                }
            }
        }
    }else{
        for(auto x:opCounter){
            if(useGUIMode){
                // 各命令につき一行
                stream << x.first << " " << x.second << std::endl;
                
            }else{
                ss << std::setw(PRINT_INST_NUM_SIZE)<< x.first <<  ": " << std::setw(PRINT_INST_NUM_SIZE) <<
                    std::internal << x.second << ",     ";
                
                if(++count == PRINT_INST_COL){
                    count = 0;
                    stream << ss.str() << std::endl;
                    ss.str("");
                    ss.clear(std::stringstream::goodbit);
                }
            }
        }

    }

    // アクセスされたワード数
    if(useGUIMode){

    }else{
        stream << "ワードアクセスされた箇所数: " << wordAccessCheckN << std::endl;
    }

}

void AssemblySimulator::printOpCounter() const{
    printOpCounterWithParam(std::cout, false);
}



 std::string AssemblySimulator::getMemWordString(const uint32_t & address)const{
    std::stringstream ss;
    int subAddress = address % WORD_BYTE_N;
    if(subAddress == 0){
        MemoryUnit memory;
        memory.i = readMem(address, MemAccess::WORD);
        for (size_t i = 0; i < WORD_BYTE_N; i++)
        {
            ss << std::setw(2) << std::setfill('0') << std::hex << static_cast<int>(memory.b[i]) << " ";
        }
        
    }else{
        int mainAddress = address - subAddress;
        MemoryUnit memory1, memory2;
        memory1.i = readMem(mainAddress, MemAccess::WORD);
        memory2.i = readMem(mainAddress + WORD_BYTE_N, MemAccess::WORD);
        for (size_t i = subAddress; i < WORD_BYTE_N; i++)
        {
            ss << std::setw(2) << std::setfill('0') << std::hex << static_cast<int>(memory1.b[i]) << " ";
        }
        for (size_t i = 0; static_cast<int>(i) < subAddress; i++)
        {
            ss << std::setw(2) << std::setfill('0') << std::hex << static_cast<int>(memory2.b[i]) << " ";
        }
    }
    return ss.str();
    
 }

void AssemblySimulator::printMem(const uint32_t &address, const uint32_t &wordN, const int &lineN)const{
    uint32_t nowAddress = address;
    int repeatN = (wordN % lineN == 0) ? wordN / lineN : wordN / lineN + 1;
    for (size_t i = 0; static_cast<int>(i) < repeatN; i++)
    {
        if(!forGUI){
            std::cout << "0x" <<std::setw(MEM_ADDRESS_HEX_LEN) << std::setfill('0') <<
                std::hex << nowAddress << ": ";
        }
        for (size_t j= 0; static_cast<int>(j) < lineN; j++)
        {
            if(forGUI){
                uint32_t value = readMem(nowAddress, MemAccess::WORD);
                std::cout << getSeparatedWordString(value);
                
            }else{
                std::cout << getMemWordString(nowAddress) << " ";
            }
            nowAddress += WORD_BYTE_N;
            if((static_cast<int>(i) ==repeatN -1 )&& ((wordN % lineN) - 1 == j)) break;
        }
        std::cout  << std::endl;
    }
    
}


// 時間予測
double AssemblySimulator::calculateTime(){
    double ans = 0;
    // 命令の実行数
    // for(auto count: opcodeInfoMap){
    //     uint8_t key = count.second[5];
    //     ans += (efficientOpCounter[key]) * (count.second[6] + 1);
    // }
    ans += efficientOpCounter[opcodeInfoMap["fdiv"][5]]; // fdivは一回ストール
    ans += instCount;
    ans += hazardStallN;
    ans += expectMissN * EXPECT_MISS_PENALTY;
    ans /= HZ;

    for(int i = 0; i < Cache::TYPES_N; i++){
        double stallTimes = cache.otherMissN[i] + cache.initMissN[i];
        stallTimes = stallTimes * cache.calcStallN(i) / HZ;
        ans += stallTimes;
    }

    ans += mmio.calculateTime();

    return ans;
}

void AssemblySimulator::printCalculatedTime(){
    printf("実行時間予測: %10.4lfs\n", calculateTime());
}

// アクセスされたアドレスを全表示
void AssemblySimulator::printAccessedAddress(){
    std::cout << "使用箇所" << std::endl;
    
    uint32_t address = 0;
    uint32_t startAddress = 0;
    while(address < MEM_BYTE_N / WORD_BYTE_N){
        if((*wordAccessCheckMem)[address]){
            startAddress = address;
            while(address < MEM_BYTE_N / WORD_BYTE_N && (*wordAccessCheckMem)[address]){
                ++address;
            }
            std::cout << "0x" <<std::setw(MEM_ADDRESS_HEX_LEN) << std::setfill('0') <<
                std::hex << startAddress * WORD_BYTE_N << " ~ ";
            std::cout << "0x" <<std::setw(MEM_ADDRESS_HEX_LEN) << std::setfill('0') <<
                std::hex << address * WORD_BYTE_N << std::endl;
            continue;
        }
        ++address;
    }
}

// ジャンプしたアドレスを多い順に表示
void AssemblySimulator::printJumpLabelRanking(const unsigned int &printN){
    // 一度もラベルにジャンプしていない
    if(jumpedLabelCount.size() == 0){
        std::cout << PRINT_JUMP_LABEL_ERROR  << std::endl;
        return;
    }

    std::cout << std::setw(PRINT_JUMP_INT_W) << std::setfill(' ') << "Times"
        << std::setw(PRINT_JUMP_INT_W) << "Line" 
        << PRINT_JUMP_INTERVAL << "Label name" << std::endl;

    // マップをソートするためにvectorを作る
    std::vector<std::pair<uint32_t, uint64_t>> jumpedLabelVector;
    jumpedLabelVector.reserve(jumpedLabelCount.size());
    for(const auto &item: jumpedLabelCount){
        jumpedLabelVector.emplace_back(item);
    }
    std::sort(jumpedLabelVector.begin(), jumpedLabelVector.end(), 
            [](const auto &x, const auto &y){return x.second > y.second;});
    
    for(unsigned int  i = 0 ;i < printN; i++){
        if(i == jumpedLabelCount.size()) break;
        int32_t address = jumpedLabelVector[i].first;
        uint32_t count = jumpedLabelVector[i].second;
        int index = address / INST_BYTE_N;
        std::cout << std::setw(PRINT_JUMP_INT_W) << count
         << std::setw(PRINT_JUMP_INT_W) << parser.instructionVector[index].lineN -1
         << PRINT_JUMP_INTERVAL << parser.invLabelMap.at(address) << std::endl;
        
    }
}

// 浮動小数点テーブルアクセスが多い順に表示
void AssemblySimulator::printFloatTableAccessRanking(const unsigned int &printN){
    // 一度もラベルにジャンプしていない
    unsigned int printCount = printN;
    if(printN == 0) printCount = floatTableAccessMem.size();

    std::cout << std::setw(PRINT_FLOAT_TABLE_INT_W) << std::setfill(' ') << "Times"
        << std::setw(PRINT_FLOAT_TABLE_INT_W) << "Address" << std::endl;

    // マップをソートするためにvectorを作る
    std::vector<std::pair<uint32_t, uint64_t>> floatTableVector;
    floatTableVector.reserve(floatTableAccessMem.size());
    for(int i = 0; i < floatTableAccessMem.size(); i++){
        std::pair<uint32_t, uint64_t> pair = {FLOAT_TABLE_START + i * WORD_BYTE_N, floatTableAccessMem[i]};
        floatTableVector.emplace_back(pair);
    }
    std::sort(floatTableVector.begin(), floatTableVector.end(), 
            [](const auto &x, const auto &y){return x.second > y.second;});
    
    for(unsigned int  i = 0 ;i < printCount; i++){
        int32_t address = floatTableVector[i].first;
        uint32_t count = floatTableVector[i].second;
        if(count == 0) break;
        std::cout << std::setw(PRINT_FLOAT_TABLE_INT_W) << std::setfill(' ') 
         <<  std::dec << count
         <<  PRINT_FLOAT_TABLE_INT_SUB  << "0x"
         <<  std::setw(PRINT_FLOAT_TABLE_HEX_W) << std::setfill('0') 
         <<  std::hex << address << std::endl;
        
    }
    std::cout << PRINT_FLOAT_TABLE_INT_SUB << PRINT_FLOAT_BELOW_0 << std::endl;
}

// デバッグ用
// 時間予測に使うパラメタをファイル出力
void AssemblySimulator::outputProfile(){
    fs::path programFile(parser.filePaths[0]);
    fs::path dataFile(mmio.dataPath);
    std::string profDirectory = PROF_FOLDER + programFile.stem().string() + "-" + dataFile.stem().string();
    fs::create_directories(profDirectory);

    // 共通データ　(programDataファイル)
    // 命令数とmmioの送受信数, ハザード，予測ミス
    std::string pdFilePath = profDirectory + "/" + PROF_DATA;
    std::ofstream programDataFile;
    programDataFile.open(pdFilePath, std::ios::out);
    printOpCounterWithParam(programDataFile, true);
    programDataFile << PROF_SEPARATOR << std::endl;
    programDataFile << hazardStallN << " " << expectMissN << std::endl;
    mmio.outputMMIOInfo(programDataFile);
    programDataFile.close();

    // パラメータによるデータ
    std::string paramFilePath = 
        profDirectory + "/" + std::to_string(cache.cacheWay) + PROF_PARAM_SEP + 
         std::to_string(cache.offsetLen) + PROF_PARAM_SEP + 
         std::to_string(cache.tagLen) + PROF_PARAM_EXT;
    std::ofstream paramFile;
    paramFile.open(paramFilePath, std::ios::out);
    cache.outputCacheInfo(paramFile);
    paramFile.close();

}

// ファイルからパラメータを復元
void AssemblySimulator::inputProfileFromFiles(std::string &dataPath, std::string &paramPath){
    std::ifstream programDataFile;
    programDataFile.open(dataPath, std::ios::in);
    // opCounterの復元
    std::string line;
    std::string op, countN;
    std::getline(programDataFile, line);
    instCount = std::stoull(line);
    std::getline(programDataFile, line);
    while( line != PROF_SEPARATOR){
        std::istringstream iss(line);
        iss >> op >> countN;
        uint8_t key = opcodeInfoMap[op][5];
        efficientOpCounter[key] = std::stoull(countN);
        std::getline(programDataFile, line);
    }
    //ハザード数，予測ミス数
    std::getline(programDataFile, line);
    std::istringstream iss(line);
    std::string hazardS, expectMissS;
    iss >> hazardS >> expectMissS;
    hazardStallN = std::stoull(hazardS);
    expectMissN = std::stoull(expectMissS);

    mmio.inputMMIOInfo(programDataFile);
    programDataFile.close();

    // パラメータによるデータ
    std::ifstream paramDataFile;
    paramDataFile.open(paramPath, std::ios::in);
    cache.inputCacheInfo(paramDataFile);
    paramDataFile.close();

}

void AssemblySimulator::inputProfile(){
fs::path programFile(parser.filePaths[0]);
    fs::path dataFile(mmio.dataPath);
    std::string profDirectory = PROF_FOLDER + programFile.stem().string() + "-" + dataFile.stem().string();

    // 共通データ　(programDataファイル)
    // 命令数とmmioの送受信数, ハザード，予測ミス
    std::string pdFilePath = profDirectory + "/" + PROF_DATA;

    // パラメータによるデータ
    std::string paramFilePath = 
        profDirectory + "/" + std::to_string(cache.cacheWay) + PROF_PARAM_SEP + 
         std::to_string(cache.offsetLen) + PROF_PARAM_SEP + 
         std::to_string(cache.tagLen) + PROF_PARAM_EXT;

    inputProfileFromFiles(pdFilePath, paramFilePath);
}