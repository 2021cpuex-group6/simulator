#include "simulator.hpp"
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <set>


AssemblySimulator::AssemblySimulator(const AssemblyParser& parser, const bool &useBin, const bool &forGUI): parser(parser), registers({0}), pc(0),
         end(false), instCount(0), opCounter({}), breakPoints({}), historyN(0), historyPoint(0), beforeHistory({}), forGUI(forGUI){
    // opcounterをすべて0に
    for(const auto & item : opcodeInfoMap){
        opCounter.insert({item.first, 0});
    }
        
}

void AssemblySimulator::reset(){
    // 内部状態をリセットし、起動時と同じ状態にする
    pc = 0;
    end = false;
    instCount = 0;
    for(auto &e: opCounter){
        opCounter[e.first] = 0;
    }
    registers.fill(0);
    breakPoints.clear();
    historyN = 0;
    historyPoint = 0;
    beforeHistory.fill({});
}


std::string AssemblySimulator::getRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign) const {
    // レジスタ番号を受け取り、その情報を文字列で返す
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
            return std::to_string(registers[regN]);
        }else{
            return std::to_string(pc);
        }

    }


    unsigned int  numSize = 0;
    switch (base){
        case NumberBase::BIN :
            prefix = "0b";
            numSize = 32;
            sin << std::bitset<REGISTER_BIT_N>(registers[regN]);
            break;
        case NumberBase::OCT :
            prefix = "0o";
            numSize = 11;
            sin << std::oct << registers[regN];
            break;
        case NumberBase::HEX :
            prefix = "0x";
            numSize = 8;
            sin << std::hex << registers[regN];
            break;
        default :
            prefix = "";
            numSize = 10;
            if (sign){
                ss << regName  << std::setw(numSize) << std::internal << registers[regN];
            }else{
                ss << regName  << std::setw(numSize) << std::internal << (unsigned int) registers[regN];
            }
            return ss.str();
            break;
    }

    ss << regName <<  prefix << std::setw(numSize) << std::setfill('0') << sin.str();

    return ss.str();

}

void AssemblySimulator::printRegisters(const NumberBase &base, const bool &sign) const {
    // レジスタの内容をすべて表示
    // GUI用には 1行目 pcのみ　2行目 x0~x31レジスタを空白文字による分割で
    // pc
    std::cout << getRegisterInfoUnit(REGISTERS_N, base, sign) << std::endl;

    if(forGUI){
        std::stringstream ss;
        for(int i = 0; i < REGISTERS_N; i++){
            ss << getRegisterInfoUnit(i, NumberBase::DEC, true) << " ";
        }
        std::cout << ss.str() << std::endl;
        return;
        

    }else{
        for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL; i++){
            std::string res;
            for(int j = 0; j < PRINT_REGISTERS_COL; j++){
                res += getRegisterInfoUnit(i*PRINT_REGISTERS_COL + j, base, sign) + ", ";
            }
            std::cout << res << std::endl;   
        }
    }

}

void AssemblySimulator::writeReg(const int &regInd, const int &value){
    if(regInd < REGISTERS_N){
        if(regInd == 0 && !forGUI){
            // 0レジスタへの書き込み
            std::cout << ZERO_REG_WRITE_ERROR << std::endl;
            return;
        }
        registers[regInd] = value;
    }else{
        if(value % INST_BYTE_N != 0  && !forGUI){
            // アラインに合わない値が入力されているので注意
            std::cout << PC_NOT_ALIGNED_WRITE << std::endl;
        }
        pc = value;
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
    int line;
    next(false, false); // 最初の一回は実行可能
    while(!end){
        line = pc / INST_BYTE_N + 1;
        if(breakPoints.find(line) != breakPoints.end()){
            if(forGUI){
                std::cout << GUI_STOP << std::endl;
            }else{
                std::cout << "Stopped: " << std::endl;
                printInstruction(line, parser.instructionVector[line-1]);
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

        int line = pc/INST_BYTE_N;
        Instruction inst = parser.instructionVector[line];
        if(inst.type == InstType::Inst){
            jumpComment = false;
            beforeData = doInst(inst);
            if(printInst && !forGUI){
                printInstruction(line+1, inst);
                printDif(beforeData);
            }else if(printInst){
                printDif(beforeData);
            }
        }else{
            line ++;;
            beforeData.instruction = "";
            beforeData.pc = pc;
            if(!jumpComment && printInst){
                if(forGUI){
                    std::cout << GUI_NO_CHANGE << std::endl;
                }else{
                    std::cout << "--- No Change ---" << std::endl;
                }
            }

            incrementPC();
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

void AssemblySimulator::back(){
    // ひとつ前に戻る
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
    end = false;
    pc = before.pc;
    if(before.instruction != ""){
        instCount--;
        opCounter[before.instruction] = opCounter[before.instruction] -1;
        if(before.regInd >= 0){
            registers[before.regInd] = before.regValue;
        }
    }else{
        // 前の命令はコメントやラベルだった
    }


}

void AssemblySimulator::printInstruction(const int & lineN, const Instruction &instruction)const{
    // 受け取った命令を画面表示
    std::stringstream ss;
    ss << std::setw(PRINT_INST_NUM_SIZE) << std::to_string(lineN) << ":";
    switch (instruction.type){
        case InstType::Inst:
            ss <<  std::setw(PRINT_INST_NUM_SIZE) << instruction.opcode;
            for(int i = 0; i < instruction.operandN; i++){
                ss << std::setw(PRINT_INST_NUM_SIZE) << instruction.operand[i];
            }
            std::cout << ss.str() << std::endl;
            break;
        case InstType::Label:
            ss << " " + instruction.label + ": ";
            std::cout << ss.str() << std::endl;
            break;
        case InstType::Comment:
            ss << " ** Comment **";
            std::cout << ss.str() << std::endl;
            break;
            
    }
    
}

void AssemblySimulator::deleteBreakPoint(const int &lineN){
    int i = breakPoints.erase(lineN);
    if(i == 0){
        if(forGUI){
            std::cout << GUI_WARNING << std::endl;
        }else{
            std::cout << BREAKPOINT_NOT_FOUND << std::endl;
        }
    }
}

void AssemblySimulator::setBreakPoint(const int &lineN){
    // ブレークポイントを設置
    if(lineN > 0 && lineN < parser.instructionVector.size()){
        breakPoints.insert(lineN);
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
        printInstruction(e, parser.instructionVector[e-1]);
    }

}

void AssemblySimulator::printDif(const BeforeData & before)const{
    // 差分を表示
    if(forGUI){
        // 変化のあったレジスタ名とその変化後の値を表示
        if(before.instruction != "nop"){
            if(before.pc != pc -4){
                std::cout << "pc " << pc << std::endl;
                return;
            }else if(before.regInd >= 0){
                std::cout <<"x"<< std::setw(2) << std::setfill('0') <<  std::internal << before.regInd 
                    << " " << registers[before.regInd] <<  std::endl;
                return;
            }else{
                std::cout << GUI_NO_CHANGE << std::endl;
                
            }
        }else{
             std::cout << GUI_NO_CHANGE << std::endl;
        }
    }else{
        std::cout << "  ";
        if(before.instruction != "nop"){
            if(before.pc != pc -4){
                std::cout << "pc:" <<  std::setw(11) << std::internal <<before.pc << " -> " 
                    << std::setw(11) << std::internal << pc  << std::endl;
                    return;
            }else if(before.regInd >= 0){
                std::string regInfo = getRegisterInfoUnit(before.regInd, NumberBase::DEC, true);
                std::cout << regInfo.substr(0, 3) << std::setw(11) << std::internal << 
                before.regValue << " -> " << regInfo.substr(3) << std::endl;
                return;
            }
        }
        std::cout << "--- No Change ---" << std::endl;
        
        
    }
    return;

}

BeforeData AssemblySimulator::doInst(const Instruction &instruction){
    // 命令を処理
    std::string opcode = instruction.opcode;
    instCount++;
    opCounter[opcode] = opCounter[opcode] + 1;

    if(opcode == "nop"){
        BeforeData ans = {"nop", pc, -1};
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
            

        }else if(opKind == INST_OTHERS){

        }else{
            // 演算命令
            int targetR = getRegIndWithError(instruction.operand[0]);
            // ここで前のデータを保存
            ans.instruction = opcode;
            ans.pc = pc;
            ans.regInd = targetR;
            ans.regValue = registers[targetR];
            if(targetR == 0){
                // x0レジスタへの書き込み
                launchWarning(ZERO_REG_WRITE_ERROR);
            }else{
                int source0 = registers[getRegIndWithError(instruction.operand[1])];
                int source1 = 0;
                if(opKind == INST_REGONLY){
                    source1 = registers[getRegIndWithError(instruction.operand[2])];
                }else{
                    source1 = instruction.immediate;
                }
                doALU(opcode, targetR, source0, source1);
            }
        }
        incrementPC();
        return ans;
    }



}
int AssemblySimulator::getRegInd(const std::string &regName){
    if(regName == "pc"){
        return REGISTERS_N;
    }else if(regName == "zero"){
        return 0;
    }else{
        try{
            return std::stoi(regName.substr(1));
        }catch(const std::invalid_argument & e){
            // レジスタ名が不正
            return -1;
        }catch(const std::out_of_range & e){
            // レジスタ名が不正
            return -1;
        }
    }
}


int AssemblySimulator::getRegIndWithError(const std::string &regName)const{
    int ind = getRegInd(regName);
    if(ind < 0){
        launchError(INVALID_REGISTER);
        return -1;

    }
    return ind;
}




void AssemblySimulator::launchError(const std::string &message)const{
    if(forGUI){
        // GUI用にエラー通知
        std::cout << GUI_ERROR << std::endl;
        std::cout << pc/4 + 1 << std::endl;
        std::cout << message << std::endl;
        
    }
    throw std::invalid_argument(std::to_string(pc/4 + 1) + "行目:" + message);
}
void AssemblySimulator::launchWarning(const std::string &message)const{
    if(onWarning && forGUI){
        std::cout << "Warning: " +  std::to_string(pc/4 + 1) + "行目:" + message << std::endl;

    }
}

void AssemblySimulator::doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1){
    // ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う
    // PCの更新はここでは行わない
    if(opcode == "add" || opcode == "addi"){
        // オーバーフローは考慮しない（仕様通り？）
        registers[targetR] = source0 + source1;
    }else if(opcode == "sub"){
        registers[targetR] = source0 - source1;
    }else if(opcode == "mul"){
        registers[targetR] = source0 * source1;
    }else if(opcode == "div"){
        registers[targetR] = source0 / source1;
    }

}

BeforeData AssemblySimulator::doControl(const std::string &opcode, const Instruction &instruction){
    // 制御系の命令実行
    // 次命令がpc+4かは不明なのでここでpcの更新をする
    std::vector<int> opInfo = opcodeInfoMap[opcode];
    bool jumpFlag = false;
    if(opInfo[0] == 3){
        int reg0 = registers[getRegIndWithError(instruction.operand[0])];
        int reg1 = registers[getRegIndWithError(instruction.operand[1])];
        if(opcode == "blt"){
            jumpFlag = reg0 < reg1;
        }else if(opcode == "beq"){
            jumpFlag = reg0 == reg1;
        }
    }else{
        jumpFlag = true;
    }

    if(jumpFlag){
        try{
            BeforeData ans = {opcode, pc, -1};
            int nextLine = parser.labelMap.at(instruction.label);
            pc = nextLine * INST_BYTE_N;
            return ans;
        }catch(const std::out_of_range &e){
            launchError(NOT_FOUND_LABEL);
            return{};
        }

    }else{
        BeforeData ans = {opcode, pc, -1};
        incrementPC();
        return ans;
    }

}


void AssemblySimulator::incrementPC(){
    // pcのインクリメントと、ファイル末端に到達したかのチェックを行う
    pc += 4;
    if(pc == parser.instructionVector.size() * 4){
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