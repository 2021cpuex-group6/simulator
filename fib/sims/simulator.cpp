#include "simulator.hpp"
#include "../utils/utils.hpp"
#include "fpu.hpp"
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <set>


AssemblySimulator::AssemblySimulator(const AssemblyParser& parser, const bool &useBin, const bool &forGUI):forGUI(forGUI), pc(0), fcsr(0), end(false),
          parser(parser), iRegisters({0}), fRegisters({MemoryUnit(0)}),
          instCount(0), opCounter({}), breakPoints({}), historyN(0), historyPoint(0), beforeHistory({}){
    dram = new std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N>;
    MemoryUnit mu;
    mu.i = 0;
    (*dram).fill(mu);
    // opcounterをすべて0に
    for(const auto & item : opcodeInfoMap){
        opCounter.insert({item.first, 0});
    }
}

        
AssemblySimulator::~AssemblySimulator(){
    delete dram;
    
}

void AssemblySimulator::reset(){
    // 内部状態をリセットし、起動時と同じ状態にする
    pc = 0;
    end = false;
    instCount = 0;
    for(auto &e: opCounter){
        opCounter[e.first] = 0;
    }
    iRegisters.fill(0);
    MemoryUnit mu;
    mu.i = 0;
    fRegisters.fill(mu);
    breakPoints.clear();
    historyN = 0;
    historyPoint = 0;
    beforeHistory.fill({});
    (*dram).fill({0});
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
        ss << regName << " " << std::to_string(fRegisters[regN].f);
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
                numSize = 10;
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
            numSize = 10;
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

void AssemblySimulator::writeReg(const int &regInd, const int32_t &value, const bool& isInteger){
    if(regInd < REGISTERS_N){
        if(isInteger){
            if(regInd == 0 && !forGUI){
                // 0レジスタへの書き込み
                std::cout << ZERO_REG_WRITE_ERROR << std::endl;
                return;
            }
            iRegisters[regInd] = value;

        }else{
            fRegisters[regInd] = MemoryUnit(value);
        }
    }else{
        if(isInteger){
            if(value % INST_BYTE_N != 0  && !forGUI){
                // アラインに合わない値が入力されているので注意
                std::cout << PC_NOT_ALIGNED_WRITE << std::endl;
            }
            pc = value;
        }else{
            fcsr = static_cast<uint32_t>(value);
        }
    }
}

void AssemblySimulator::launch(){
    // 終了まで実行する
    if(end){
        // すでに終わっている
        if(forGUI){
            std::cout << GUI_ALREADY_END << std::endl;
            
        }else{
            std::cout << ALREADY_ENDED << std::endl;
        }
        return;
    }
    while(!end){
        next(false, false);
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
                printInstruction(inst.lineN, inst);
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

        BeforeData beforeData = {};

        int instInd = pc/INST_BYTE_N;
        Instruction inst = parser.instructionVector[instInd];
        nowLine = inst.lineN;
        jumpComment = false;
        beforeData = doInst(inst);
        if(printInst && !forGUI){
            printInstruction(inst.lineN, inst);
            printDif(beforeData, false);
        }else if(printInst){
            printDif(beforeData, false);
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
    try{
        before = popHistory();
    }catch (const std::out_of_range & e){
        if(forGUI){
            std::cout << GUI_NO_HISTORY << std::endl;
        }else{
            std::cout << NO_HISTORY << std::endl;
        }
        return;        
    }
    if(before.instruction != "" &&  forGUI){
        printDif(before, true);
    }
    end = false;
    pc = before.pc;
    if(before.instruction != ""){
        instCount--;
        opCounter[before.instruction] = opCounter[before.instruction] -1;
        if(before.regInd >= 0){
            if(before.isInteger){
                iRegisters[before.regInd] = before.regValue;
            }else{
                MemoryUnit mu;
                mu.si = before.regValue;
                fRegisters[before.regInd] = mu;
            }
        }
        if(before.writeMem){
            // メモリをもとに戻す
            writeMem(before.memAddress, MemAccess::WORD, before.memValue);
        }

    }else{
        // 前の命令はコメントやラベルだった
        if(forGUI){
            std::cout << GUI_NO_CHANGE << std::endl;
            
        }
    }


}

void AssemblySimulator::printInstruction(const int & lineN, const Instruction &instruction)const{
    // 受け取った命令を画面表示
    std::stringstream ss;
    auto indPair = parser.getFileNameAndLine(lineN);
    ss << std::setw(PRINT_INST_NUM_SIZE) << std::to_string(indPair.second) << ":";
    ss <<  std::setw(PRINT_INST_NUM_SIZE) << instruction.opcode;
    for(int i = 0; i < instruction.operandN; i++){
        ss << std::setw(PRINT_INST_NUM_SIZE) << " " +  instruction.operand[i];
    }
    std::cout << ss.str() << std::endl;
    
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
        printInstruction(e, parser.instructionVector[e]);
    }

}

void AssemblySimulator::printDif(const BeforeData & before, const bool &back)const{
    // 差分を表示 GUI用にbackのときも実装
    if(forGUI){
        // 変化のあったレジスタ名とその変化後の値を表示
        if(before.instruction != "nop"){
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
        if(before.instruction != "nop"){
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


// 命令を処理
BeforeData AssemblySimulator::doInst(const Instruction &instruction){
    std::string opcode = instruction.opcode;
    instCount++;
    opCounter[opcode] = opCounter[opcode] + 1;

    if(opcode == "nop"){
        BeforeData ans = {"nop", pc, false, -1, -1, false};
        pc += INST_BYTE_N;
        return ans;
    }
    std::vector<int> opInfo = opcodeInfoMap[opcode];
    int opKind = opInfo[4];
    if(opKind == INST_CONTROL){
        return doControl(opcode, instruction);

    }else{
        BeforeData ans = {};
        if(opKind == INST_LOAD){
            ans = doLoad(opcode, instruction);
        }else if(opKind == INST_STORE){
            ans = doStore(opcode, instruction);
        }else if(opKind == INST_OTHERS){

        }else{
            // 演算命令
            auto indPair =getRegIndWithError(instruction.operand[0]); 
            int targetR = indPair.first;
            // ここで前のデータを保存
            ans.instruction = opcode;
            ans.pc = pc;
            ans.isInteger = indPair.second;
            ans.writeMem = false;
            ans.regInd = targetR;

            if(ans.isInteger){
                // 整数演算のとき
                ans.regValue = iRegisters[targetR];
                if(targetR == 0){
                    // x0レジスタへの書き込み
                    launchWarning(ZERO_REG_WRITE_ERROR);
                }else{
                    auto ind0Pair = getRegIndWithError(instruction.operand[1]);
                    bool ind1IsInt = false;
                    int source0 = iRegisters[ind0Pair.first];
                    int source1 = 0;
                    if(opKind == INST_REGONLY){
                        auto ind1Pair = getRegIndWithError(instruction.operand[2]);
                        source1 = iRegisters[ind1Pair.first];
                        ind1IsInt = ind1Pair.second;
                    }else{
                        source1 = instruction.immediate;
                        ind1IsInt = true;
                    }
                    if(!(ind0Pair.second && ind1IsInt)){
                        launchError(MIXED_REGISTER_ERROR);
                    }
                    doALU(opcode, targetR, source0, source1);
                }
            }else{
                // 浮動小数点数
                ans.regValue = fRegisters[targetR].si;
                auto ind0Pair = getRegIndWithError(instruction.operand[1]);
                auto ind1Pair = getRegIndWithError(instruction.operand[2]);
                if(ind0Pair.second || ind1Pair.second){
                    // 整数レジスタが混じってる
                    launchError(MIXED_REGISTER_ERROR);
                }
                uint32_t source0 = fRegisters[ind0Pair.first].i;
                uint32_t source1 = fRegisters[ind1Pair.first].i;
                doFALU(opcode, targetR, source0, source1);

            }
        }
        incrementPC();
        return ans;
    }
}

// ストア命令を実行
BeforeData AssemblySimulator::doStore(const std::string &opcode, const Instruction &instruction){
    uint32_t address = instruction.immediate;
    auto indPair = getRegIndWithError(instruction.operand[1]);
    if(indPair.first == REGISTERS_N || !indPair.second ){
        launchError(ILEGAL_BASE_REGISTER);
    }
    address += iRegisters[indPair.first];

    indPair = getRegIndWithError(instruction.operand[0]);
    uint32_t beforeAddress = (address/4)*4;
    BeforeData before = {opcode, pc, false, -1, -1, true, beforeAddress, readMem(beforeAddress, MemAccess::WORD)};

    uint32_t value = indPair.second ? iRegisters[indPair.first] : fRegisters[indPair.first].i;
    if(opcode == "fsw"){
        if(indPair.second){
            launchError(ILEGAL_LOADSTORE_INSTRUCTION);
        }
        writeMem(address, MemAccess::WORD, value);
    }else{
        if(!indPair.second){
            launchError(ILEGAL_LOADSTORE_INSTRUCTION);
        }
        if(opcode == "sw"){
            writeMem(address, MemAccess::WORD, value);
        }else if(opcode == "sb"){
            writeMem(address, MemAccess::BYTE, (~0xff) & value);
        }

    }
    return before;
}

BeforeData AssemblySimulator::doLoad(const std::string &opcode, const Instruction &instruction){
    // ロード命令を実行
    uint32_t address = instruction.immediate;
    auto indPair = getRegIndWithError(instruction.operand[1]);
    if(indPair.first == REGISTERS_N || !indPair.second ){
        launchError(ILEGAL_BASE_REGISTER);
    }
    address += iRegisters[indPair.first];

    indPair = getRegIndWithError(instruction.operand[0]);
    int32_t beforeValue = indPair.second ? iRegisters[indPair.first] : fRegisters[indPair.first].si;
    BeforeData before = {opcode, pc, indPair.second, indPair.first, beforeValue, false};
    
    if(opcode == "flw"){
        if(indPair.second){
            // 浮動小数点のレジスタにlw, lbuなどを使っている
            launchError(ILEGAL_LOADSTORE_INSTRUCTION);
        }
        uint32_t value = readMem(address, MemAccess::WORD);
        fRegisters[indPair.first] = MemoryUnit(value);
    }else{
        if(!indPair.second){
            launchError(ILEGAL_LOADSTORE_INSTRUCTION);
        }

        if(opcode == "lw"){
            uint32_t value = readMem(address, MemAccess::WORD);
            iRegisters[indPair.first] = value;
        }else if(opcode == "lbu"){
            uint32_t value = readMem(address, MemAccess::BYTE);
            iRegisters[indPair.first] = ((~0xff) &iRegisters[indPair.first]) | value;
        }

    }

    return before;
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

// ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う(浮動小数点版)
// PCの更新はここでは行わない
void AssemblySimulator::doFALU(const std::string &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1){
    uint32_t ans = 0;
    if(opcode == "fadd"){
        ans = fadd(source0, source1);
    }else if(opcode == "fsub"){
        ans = fsub(source0, source1);
    }else if(opcode == "fmul"){
        ans = fmul(source0, source1);
    }
    fRegisters[targetR] = MemoryUnit(ans);
}

// ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う
// PCの更新はここでは行わない
void AssemblySimulator::doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1){
    int ans = 0;
    if(opcode == "add" || opcode == "addi"){
        // オーバーフローは考慮しない（仕様通り？）
        ans = source0 + source1;
    }else if(opcode == "sub"){
        ans = source0 - source1;
    }else if(opcode == "mul"){
        ans = source0 * source1;
    }else if(opcode == "div"){
        ans = source0 / source1;
    }else if(opcode == "and" || opcode == "andi"){
        ans = source0 & source1;
    }else if(opcode == "or" || opcode == "ori"){
        ans = source0 | source1;
    }else if(opcode == "xor" || opcode == "xori"){
        ans = source0 ^ source1;
    }else if(opcode == "slt"){
        ans = source0 < source1 ? 1 : 0;
    }else if(opcode == "sltu"){
        ans = ((unsigned int) source0) < ((unsigned int) source1) ? 1 : 0; 
    // 以下、シフト演算
    // RISC-Vではsource1の下位5ビットを（符号なし整数ととらえて？）シフトする 
    // C, C++では負数の右シフトが算術シフトか論理シフトかは実装依存()なので、無理やり合わせる
    }else{
        unsigned int shiftN = source1 & 0b11111;
        if(opcode == "sll"){
            ans = source0 << shiftN;
        }else if(opcode == "srl"){
            ans = shiftRightLogical(source0, shiftN);
        }else if(opcode == "sra"){
            ans = shiftRightArithmatic(source0, shiftN);
        }
    }
    iRegisters[targetR] = ans;

}

BeforeData AssemblySimulator::doControl(const std::string &opcode, const Instruction &instruction){
    // 制御系の命令実行
    // 次命令がpc+4かは不明なのでここでpcの更新をする
    std::vector<int> opInfo = opcodeInfoMap[opcode];
    bool jumpFlag = false;
    if(opInfo[0] == 3){
        auto ind0Pair = getRegIndWithError(instruction.operand[0]);
        auto ind1Pair = getRegIndWithError(instruction.operand[1]);
        if(!(ind0Pair.second && ind1Pair.second)){
            launchError(ILEGAL_CONTROL_REGISTER);
        }
        int reg0 = iRegisters[ind0Pair.first];
        int reg1 = iRegisters[ind1Pair.first];
        if(opcode == "blt"){
            jumpFlag = reg0 < reg1;
        }else if(opcode == "beq"){
            jumpFlag = reg0 == reg1;
        }else if(opcode == "bne"){
            jumpFlag = reg0 != reg1;
        }
    }else{
        jumpFlag = true;
    }

    if(jumpFlag){
        try{
            BeforeData ans = {opcode, pc,true, -1, -1, false};
            if(opcode == "jal" || opcode == "jalr"){
                // レジスタへの書き込み
                auto dPair = getRegIndWithError(instruction.operand[0]);
                if(!dPair.second){
                    launchError(ILEGAL_CONTROL_REGISTER);
                }
                int regd = dPair.first;
                if(regd != 0){
                    ans.regInd = regd;
                    ans.regValue = iRegisters[regd];
                    writeReg(regd, pc+INST_BYTE_N, true);
                }

            }
            if(opcode =="jr" || opcode == "jalr"){
                // 即値とレジスタの値を足して最下位ビットを0にした値がジャンプ先
                // しかしこのシミュレータは4バイトの固定長命令を使うことを暗に仮定しているので、もう1ビットも0にする
                int nextPC = instruction.immediate;
                if(opcode == "jr"){
                    auto indPair = getRegIndWithError(instruction.operand[0]);
                    if(!indPair.second){
                        launchError(ILEGAL_CONTROL_REGISTER);
                    }
                    nextPC += iRegisters[indPair.first];
                }else{
                    auto indPair = getRegIndWithError(instruction.operand[1]);
                    if(!indPair.second){
                        launchError(ILEGAL_CONTROL_REGISTER);
                    }
                    nextPC += iRegisters[indPair.first];
                }
                nextPC &= (~0) << 2;
                pc = nextPC;

            }else{
                int nextPC = parser.labelMap.at(instruction.label) * INST_BYTE_N;
                pc = nextPC;
            }
            return ans;
        }catch(const std::out_of_range &e){
            launchError(NOT_FOUND_LABEL);
            return{};
        }

    }else{
        BeforeData ans = {opcode, pc,false, -1, -1, false};
        incrementPC();
        return ans;
    }

}


void AssemblySimulator::incrementPC(){
    // pcのインクリメントと、ファイル末端に到達したかのチェックを行う
    pc += INST_BYTE_N;
    if(pc == static_cast<long>(parser.instructionVector.size()) * INST_BYTE_N){
        // 末端に到着
        end = true;
        if(forGUI){
            std::cout << GUI_END << std::endl;
        }else{
            std::cout << FILE_END << std::endl;
        }
    }
}

void AssemblySimulator::printOpCounter() const{
    // 実行命令の統計をプリント
    if(forGUI){
        std::cout << instCount << std::endl;
    }else{
        std::cout << "総実行命令数: " <<  std::to_string(instCount) << std::endl;
    }
    
    std::stringstream ss;
    int count = 0;

    for(auto x:opCounter){
        if(forGUI){
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

uint32_t AssemblySimulator::readMem(const uint32_t& address, const MemAccess &memAccess)const{
    // メモリ読み込み
    if(address > MEM_BYTE_N || address + static_cast<unsigned int>(memAccess) > MEM_BYTE_N){
        //範囲外
        launchError(OUT_OF_RANGE_MEMORY);
    }
    uint32_t mainAddress = address / WORD_BYTE_N;
    uint32_t subAddress = address % WORD_BYTE_N;
    switch(memAccess){
        case MemAccess::WORD:
            if(subAddress != 0) launchError(ILEGAL_WORD_ACCESS);
            return (*dram)[mainAddress].i;
            break;
        case MemAccess::BYTE:
            return static_cast<uint32_t>((*dram)[mainAddress].b[subAddress]);
            break;
        default:
            launchError(IMPLEMENT_ERROR);
            return -1;
            break;
    }

}
void AssemblySimulator::writeMem(const uint32_t& address, const MemAccess &memAccess, const uint32_t value){
    // メモリ書き込み
    if(address > MEM_BYTE_N || address + static_cast<unsigned int>(memAccess) > MEM_BYTE_N){
        //範囲外
        launchError(OUT_OF_RANGE_MEMORY);
    }

    uint32_t mainAddress = address / WORD_BYTE_N;
    uint32_t subAddress = address % WORD_BYTE_N;
    switch(memAccess){
        case MemAccess::WORD:
            if(subAddress != 0) launchError(ILEGAL_WORD_ACCESS);
            (*dram)[mainAddress].i = value;
            break;
        case MemAccess::BYTE:
            (*dram)[mainAddress].b[subAddress] = static_cast<uint8_t>(value);
            break;
        default:
            launchError(IMPLEMENT_ERROR);
            break;
    }
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