#include "simulator.hpp"
#include "../utils/utils.hpp"
#include "fpu.hpp"
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <cmath>
#include <set>
#include <chrono>


static const std::string TIME_FORMAT = "Time: %.10lfms\n";
static const std::string CACHE_PRINT_USE_RATE = "キャッシュ使用率: ";
static const std::string CACHE_PRINT_ACCESS = "  アクセス回数: ";
static const std::string CACHE_PRINT_RATE = "  ヒット率: ";
static const std::string CACHE_PRINT_READ = "";

AssemblySimulator::AssemblySimulator(const AssemblyParser& parser, const bool &useBin,
                                     const bool &forGUI, const int & cacheWay):
        useBinary(useBin), forGUI(forGUI), pc(0), fcsr(0), end(false),
        parser(parser), iRegisters({0}), fRegisters({MemoryUnit(0)}),
        instCount(0), opCounter({}), efficientOpCounter({}), breakPoints({}), historyN(0),
        historyPoint(0), beforeHistory(), cache(), cacheWay(cacheWay), cacheIndexN(CASH_SIZE / cacheWay), 
        cacheRHitN(0), cacheWHitN(0), cacheRMissN(0), cacheWMissN(0){
    dram = new std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N>;
    MemoryUnit mu;
    mu.i = 0;
    (*dram).fill(mu);
    // opcounterをすべて0に
    for(const auto & item : opcodeInfoMap){
        opCounter.insert({item.first, 0});
        efficientOpCounter.insert({static_cast<uint8_t>(item.second[5]), 0});
    }
    fpu = FPUUnit();
    inverseOpMap = AssemblyParser::getInverseOpMap();
    lastPC = static_cast<long>(parser.instructionVector.size()) * INST_BYTE_N;
}

        
AssemblySimulator::~AssemblySimulator(){
    delete dram;
    
}

void AssemblySimulator::reset(){
    // 内部状態をリセットし、起動時と同じ状態にする
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
        iRegisters[i] = 0;
        MemoryUnit mu_(0u);
        fRegisters[i] = mu_;
    }
    MemoryUnit mu;
    mu.i = 0;
    breakPoints.clear();
    historyN = 0;
    historyPoint = 0;
    beforeHistory.fill({});
    (*dram).fill({0});
    for(int i = 0; i < CASH_SIZE; i++){
        CacheRow row = {false, 0};
        cache[i] = row;
    }
    cacheRHitN = 0;
    cacheWHitN = 0;
    cacheRMissN = 0;
    cacheWMissN = 0;
}

// レジスタ番号を受け取り，その情報を文字列で返す
std::string AssemblySimulator::getRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign, const bool&isInteger) const {
    if(isInteger){
        return getIRegisterInfoUnit(regN, base, sign);
    }else{
        return getFRegisterInfoUnit(regN, base, sign, true);
    }
}

// 浮動小数点レジスタの番号を受け取り，その情報を文字列で返す
std::string AssemblySimulator::getFRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign, const bool &useFNotation) const {
    std::stringstream ss;
    std::stringstream sin;
    std::stringstream ssreg;
    std::string regName;
    std::string prefix;
    if(!forGUI){
        // GUI用でなければレジスタ名も表示
        if(regN < REGISTERS_N){
            ssreg << "f" << std::setw(2) << std::setfill('0') << std::dec << regN;
            regName = ssreg.str();
        }else{
            regName = "fcsr ";
        }
        regName += " ";
    }else{
        // GUI用にはレジスタをint32_tで表記
        if(regN < REGISTERS_N){
            return std::to_string(fRegisters[regN].si);
        }else{
            return std::to_string(static_cast<int32_t>(fcsr));
        }

    }

    uint32_t value = regN < REGISTERS_N ? fRegisters[regN].i : fcsr;


    if(useFNotation){
        ss << regName << std::setw(12) << std::to_string(fRegisters[regN].f);
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
                    ss << regName  << std::setw(numSize) << std::internal << value;
                }else{
                    ss << regName  << std::setw(numSize) << std::internal << value;
                }
                return ss.str();
                break;
        }
        ss << regName <<  prefix << std::setw(numSize) << std::setfill('0') << sin.str();
    }


    return ss.str();
}

// 整数レジスタ番号を受け取り、その情報を文字列で返す
std::string AssemblySimulator::getIRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign) const {
    std::stringstream ss;
    std::stringstream sin;
    std::stringstream ssreg;
    std::string regName;
    std::string prefix;
    if(!forGUI){
        // GUI用でなければレジスタ名も表示
        if(regN < REGISTERS_N){
            ssreg << "x" << std::setw(2) << std::setfill('0') << std::dec << regN;
            regName = ssreg.str();
        }else{
            regName = "pc ";
        }
        regName += " ";
    }else{
        if(regN < REGISTERS_N){
            return std::to_string(iRegisters[regN]);
        }else{
            return std::to_string(pc);
        }

    }

    int value = regN < REGISTERS_N ? iRegisters[regN] : pc;


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
                ss << regName  << std::setw(numSize) << std::internal << value;
            }else{
                ss << regName  << std::setw(numSize) << std::internal << value;
            }
            return ss.str();
            break;
    }

    ss << regName <<  prefix << std::setw(numSize) << std::setfill('0') << sin.str();

    return ss.str();

}

void AssemblySimulator::printRegisters(const NumberBase &base, const bool &sign, const bool& useFNotation) const {
    // レジスタの内容をすべて表示
    // GUI用には 1行目 pcのみ　2行目 x0~x31レジスタを空白文字による分割 3行目 f0~f31をhex表記で
    // pc
    std::cout << getIRegisterInfoUnit(REGISTERS_N, base, sign) << std::endl;

    if(forGUI){
        std::stringstream ss;
        for(int i = 0; i < REGISTERS_N; i++){
            ss << getIRegisterInfoUnit(i, NumberBase::DEC, true) << " ";
        }
        std::cout << ss.str() << std::endl;
        ss.str(" ");
        ss.clear(std::stringstream::goodbit);
        for(int i = 0; i < REGISTERS_N; i++){
            ss << getFRegisterInfoUnit(i, NumberBase::HEX, false, false) << " ";
        }
        std::cout << ss.str() << std::endl;

        return;
        

    }else{
        for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL; i++){
            std::string res;
            for(int j = 0; j < PRINT_REGISTERS_COL; j++){
                res += getIRegisterInfoUnit(i*PRINT_REGISTERS_COL + j, base, sign) + ", ";
            }
            std::cout << res << std::endl;    
        }
        for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL; i++){
            std::string res;
            for(int j = 0; j < PRINT_REGISTERS_COL; j++){
                res += getFRegisterInfoUnit(i*PRINT_REGISTERS_COL + j, base, sign, useFNotation) + ", ";
            }
            std::cout << res << std::endl;   
        }
    }

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
}

void AssemblySimulator::doNextBreak(){
    // 次のブレークポイントまで実行
    next(false, false); //最初は実行できる
    while(!end){
        int instInd = pc / INST_BYTE_N;
        if(breakPoints.find(instInd) != breakPoints.end()){
            if(forGUI){
                std::cout << GUI_STOP << std::endl;
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
    pc = before.pc;
    if(opcode != ""){
        instCount--;
        efficientOpCounter[before.opcodeInt] = efficientOpCounter[before.opcodeInt] -1;
        if(before.regInd >= 0){
            if(before.isInteger){
                iRegisters[before.regInd] = before.regValue;
            }else{
                MemoryUnit mu;
                mu.si = before.regValue;
                fRegisters[before.regInd] = mu;
            }
        }
        // メモリ，キャッシュ系を戻す
        if(before.useMem){
            if(before.changeCash){
                //キャッシュミスしてた
                cache[before.cashAddress] = before.cacheRow;
                if(before.writeMem){
                    // メモリをもとに戻す
                    writeMem(before.memAddress, MemAccess::WORD, before.memValue);
                    --cacheWMissN;
                }else{
                    --cacheRMissN;
                }

            }else{
                // キャッシュヒット
                if(before.writeMem){
                    // メモリをもとに戻す
                    writeMem(before.memAddress, MemAccess::WORD, before.memValue);
                    --cacheWHitN;
                }else{
                    --cacheRHitN;
                }

            }
        }


    }else{
        // 前の命令はコメントやラベルだった
        if(forGUI){
            std::cout << GUI_NO_CHANGE << std::endl;
            
        }
    }


}

void AssemblySimulator::printInstByRegInd(const int & lineN, const Instruction &instruction){
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
            std::cout << IMPLEMENT_ERROR << std::endl;
            return;
            

    }
    std::cout << ss.str() << std::endl;
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

void AssemblySimulator::deleteBreakPoint(const int &instInd){
    int i = breakPoints.erase(instInd);
    if(i == 0){
        if(forGUI){
            std::cout << GUI_WARNING << std::endl;
        }else{
            std::cout << BREAKPOINT_NOT_FOUND << std::endl;
        }
    }
}

// ブレークポイントを設置 instructionVectorのインデックス
void AssemblySimulator::setBreakPoint(const int &instInd){
    if(instInd >= 0 && instInd < static_cast<int>(parser.instructionVector.size())){
        breakPoints.insert(instInd);
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
    for(auto &e: breakPoints){
        printInstructionInSim(e, parser.instructionVector[e]);
    }

}

void AssemblySimulator::printDif(const BeforeData & before, const bool &back, const std::string &opcode)const{
    // 差分を表示 GUI用にbackのときも実装
    
    if(forGUI){
        // 変化のあったレジスタ名とその変化後の値を表示
        if(opcode != "nop"){
            if(before.pc != pc -4){
                if(back){
                    std::cout << "pc " << before.pc << std::endl;
                }else{
                    std::cout << "pc " << pc << std::endl;
                }
                if(before.regInd >= 0){
                    int change = 0;
                    if(back){
                        change = before.regValue;
                    }else{
                        change = iRegisters[before.regInd];
                    }
                    std::cout <<"x"<< std::setw(2) << std::setfill('0') <<   std::internal << before.regInd 
                        << " " << change <<  std::endl;
                }
                return;
            }else if(before.regInd >= 0){
                int32_t change = 0;
                std::string pref = "";
                if(before.isInteger){
                    pref = "x";
                    if(back){
                        change = before.regValue;
                    }else{
                        change = iRegisters[before.regInd];
                    }
                }else{
                    pref = "f";
                    if(back){
                        change = before.regValue;
                    }else{
                        change = fRegisters[before.regInd].si;
                    }
                }
                std::cout <<pref<< std::setw(2) << std::setfill('0') <<  std::internal << before.regInd 
                    << " " << change <<  std::endl;
                return;
            }else if(before.writeMem){
                // メモリの変更があったことを示すため，GUI_MEM_CHANGEをまず表示
                std::cout << GUI_MEM_CHANGE << std::endl;
                //アドレス
                std::cout  << before.memAddress << " ";
                uint32_t value;
                if(back){
                     value = before.memValue;
                }else{
                     value = readMem(before.memAddress, MemAccess::WORD);
                }
                std::cout << getSeparatedWordString(value) << std::endl;
            }else{
                std::cout << GUI_NO_CHANGE << std::endl;
                
            }
        }else{
             std::cout << GUI_NO_CHANGE << std::endl;
        }
    }else{
        std::cout << "  " << std::setfill(' ') ;
        bool isChanged = false;
        if(opcode != "nop"){
            if(before.pc != pc -4){
                // pcと同時にレジスタが変わることもあるので，returnはしない
                std::cout << "pc:" <<  std::setw(11) << std::internal <<before.pc << " -> " 
                    << std::setw(11) << std::internal << pc  << std::endl;
                isChanged = true;

            }else if(before.writeMem){
                uint32_t nowValue = readMem(before.memAddress, MemAccess::WORD);
                //アドレス
                std::cout <<  "0x" << std::setw(MEM_ADDRESS_HEX_LEN) << std::setfill('0') << std::hex << before.memAddress;
                // 旧値
                std::cout <<  ": 0x" << std::setw(WORD_BYTE_N) << std::setfill('0') << std::hex << before.memValue;
                std::cout << " -> ";
                std::cout <<  "0x" << std::setw(WORD_BYTE_N) << std::setfill('0') << std::hex << nowValue << std::endl;
                return;
            }
            if(before.regInd >= 0){
                if(before.isInteger){
                    std::string regInfo = getIRegisterInfoUnit(before.regInd, NumberBase::DEC, true);
                    std::cout << " " <<  regInfo.substr(0, 3) << " " << std::setw(11) <<   std::internal << std::dec<<
                    before.regValue << " -> " << regInfo.substr(3) << std::endl;
                    return;
                }else{
                    std::string regInfo = getFRegisterInfoUnit(before.regInd, NumberBase::DEC, true, true);
                    MemoryUnit mu;
                    mu.si = before.regValue;
                    std::cout << regInfo.substr(0, 3) << " " << std::setw(11) <<   std::internal << std::dec<<
                    mu.f << " -> " << regInfo.substr(3) << std::endl;
                    return;
                }
            }
        }
        if(!isChanged){
            std::cout << "--- No Change ---" << std::endl;
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
    }else if(regName == "fcsr"){
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
        
    }
    throw std::invalid_argument(linePair.first + ": " + std::to_string(linePair.second) + "行目:" + message);
}
void AssemblySimulator::launchWarning(const std::string &message)const{
    if(onWarning && (!forGUI)){
        auto linePair = parser.getFileNameAndLine(nowLine);

        std::cout << "Warning: " + linePair.first + ": " + std::to_string(linePair.second) + "行目:" + message << std::endl;

    }
}





void AssemblySimulator::printOpCounter() const{
    // 実行命令の統計をプリント
    bool useGUIMode = false;
    if(useGUIMode){
        std::cout << instCount << std::endl;
    }else{
        std::cout << "総実行命令数: " <<  std::to_string(instCount) << std::endl;
    }
    
    std::stringstream ss;
    int count = 0;

    if(USE_EFFICIENT){
        for(auto x:opcodeInfoMap){
            if(useGUIMode){
                // 各命令につき一行
                std::cout << x.first << "  " <<  efficientOpCounter.at(static_cast<uint8_t>((x.second)[5])) << std::endl;
                
            }else{
                ss << std::setw(PRINT_INST_NUM_SIZE)<< x.first <<  ": " << std::setw(PRINT_INFO_NUM_SIZE) <<
                    std::internal << efficientOpCounter.at(static_cast<uint8_t>((x.second)[5])) << ",     ";
                
                if(++count == PRINT_INST_COL){
                    count = 0;
                    std::cout << ss.str() << std::endl;
                    ss.str("");
                    ss.clear(std::stringstream::goodbit);
                }
            }
        }
    }else{
        for(auto x:opCounter){
            if(useGUIMode){
                // 各命令につき一行
                std::cout << x.first << " " << x.second << std::endl;
                
            }else{
                ss << std::setw(PRINT_INST_NUM_SIZE)<< x.first <<  ": " << std::setw(PRINT_INST_NUM_SIZE) <<
                    std::internal << x.second << ",     ";
                
                if(++count == PRINT_INST_COL){
                    count = 0;
                    std::cout << ss.str() << std::endl;
                    ss.str("");
                    ss.clear(std::stringstream::goodbit);
                }
            }
        }

    }
    
}

// キャッシュの情報を表示
void AssemblySimulator::printCacheSystem()const{
    int32_t usedCacheN = 0;
    for(auto e: cache){
        usedCacheN += e.valid ? 1 : 0;
    }
    float cacheUseRate = ((float) usedCacheN) / CASH_SIZE * 100;
    std::cout << CACHE_PRINT_USE_RATE << std::setprecision(3) << cacheUseRate << "%" << std::endl;
    std::cout << "読み込み: " << std::endl;
    int32_t accessN = cacheRHitN + cacheRMissN;
    std::cout << CACHE_PRINT_ACCESS << accessN << std::endl;
    std::cout << CACHE_PRINT_RATE << std::setprecision(3) <<
         ((float) cacheRHitN) / accessN  * 100 << "%" << std::endl;
    std::cout << "書き込み: " << std::endl;
    accessN = cacheWHitN + cacheWMissN;
    std::cout << CACHE_PRINT_ACCESS << accessN << std::endl;
    std::cout << CACHE_PRINT_RATE << std::setprecision(3) <<
         ((float) cacheWHitN) / accessN  * 100 << "%" << std::endl;

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
