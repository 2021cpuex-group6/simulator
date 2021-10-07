#include "simulator.hpp"
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <set>


AssemblySimulator::AssemblySimulator(const AssemblyParser& parser): parser(parser), registers({0}), pc(0),
         end(false), instCount(0), opCounter({}), breakPoints({}){
    // opcounterをすべて0に
    for(const auto & item : opcodeInfoMap){
        opCounter.insert({item.first, 0});
    }
        
}


std::string AssemblySimulator::getRegisterInfoUnit(const int &regN, const NumberBase &base, const bool &sign) const {
    // レジスタ番号を受け取り、その情報を文字列で返す
    std::stringstream ss;
    std::stringstream sin;
    std::stringstream ssreg;
    std::string regName;
    std::string prefix;

    if(regN < REGISTERS_N){
        ssreg << "x" << std::setw(2) << std::setfill('0') << std::dec << regN;
        regName = ssreg.str();
    }else{
        regName = "pc ";
    }
    regName += " ";

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
    // pc
    std::cout << getRegisterInfoUnit(REGISTERS_N, base, sign) << std::endl;

    for(int i = 0; i < REGISTERS_N / PRINT_REGISTERS_COL; i++){
        std::string res;
        for(int j = 0; j < PRINT_REGISTERS_COL; j++){
            res += getRegisterInfoUnit(i*PRINT_REGISTERS_COL + j, base, sign) + ", ";
        }
        std::cout << res << std::endl;   
    }
}

void AssemblySimulator::writeReg(const int &regInd, const int &value){
    if(regInd < REGISTERS_N){
        if(regInd == 0){
            // 0レジスタへの書き込み
            std::cout << ZERO_REG_WRITE_ERROR << std::endl;
        }
        registers[regInd] = value;
    }else{
        if(value % INST_BYTE_N != 0){
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
        std::cout << ALREADY_ENDED << std::endl;
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
            std::cout << "Stopped: " << std::endl;
            printInstruction(line, parser.instructionVector[line-1]);
            break;
        }
        next(false, false);
    }

}

void AssemblySimulator::next(const bool& jumpComment, const bool& printInst){
    // 現在PCで示している命令を実行する
    // jumpComment ... コメント、ラベルは飛ばして次の命令も実行する
    // printInst   ... 命令の内容を表示
    do{
        if(end){
            // すでに終わっている
            std::cout << ALREADY_ENDED << std::endl;
            return;
        }

        int line = pc/INST_BYTE_N;
        Instruction inst = parser.instructionVector[line];
        if(inst.type == InstType::Inst){
            doInst(inst);
            if(printInst){
                printInstruction(line+1, inst);
            }

            return;
        }else{
            line ++;;

            incrementPC();
        }
    }while(jumpComment);

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

void AssemblySimulator::setBreakPoint(const int &lineN){
    // ブレークポイントを設置
    if(lineN > 0 and lineN < parser.instructionVector.size()){
        breakPoints.insert(lineN);
    }else{
        // 範囲外のため設置不可
        std::cout << OUT_OF_RANGE_BREAKPOINT << std::endl;   
    }
}


void AssemblySimulator::printBreakList()const{
    // ブレークポイントの命令を表示
    for(auto &e: breakPoints){
        printInstruction(e, parser.instructionVector[e-1]);
    }

}
void AssemblySimulator::doInst(const Instruction &instruction){
    // 命令を処理
    std::string opcode = instruction.opcode;
    instCount++;
    opCounter[opcode] = opCounter[opcode] + 1;

    if(opcode == "nop"){
        pc += INST_BYTE_N;
        return;
    }
    std::vector<int> opInfo = opcodeInfoMap[opcode];
    int opKind = opInfo[4];
    if(opKind == INST_CONTROL){
        doControl(opcode, instruction);
        return;

    }else{
        if(opKind == INST_MEM){
            

        }else if(opKind == INST_OTHERS){

        }else{
            // 演算命令
            int targetR = getRegIndWithError(instruction.operand[0]);
            if(targetR == 0){
                // x0レジスタへの書き込み
                launchError(ZERO_REG_WRITE_ERROR);
            }
            int source0 = registers[getRegIndWithError(instruction.operand[1])];
            int source1 = 0;
            if(opKind == INST_REGONLY){
                source1 = registers[getRegIndWithError(instruction.operand[2])];
            }else{
                source1 = instruction.immediate;
            }
            doALU(opcode, targetR, source0, source1);
        }
        incrementPC();
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
    throw std::invalid_argument(std::to_string(pc/4 + 1) + "行目:" + message);
}

void AssemblySimulator::doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1){
    // ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う
    // PCの更新はここでは行わない
    if(opcode == "add" || opcode == "addi"){
        // オーバーフローは考慮しない（仕様通り？）
        registers[targetR] = source0 + source1;
    }

}

void AssemblySimulator::doControl(const std::string &opcode, const Instruction &instruction){
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
            int nextLine = parser.labelMap.at(instruction.label);
            pc = nextLine * INST_BYTE_N;
        }catch(const std::out_of_range &e){
            launchError(NOT_FOUND_LABEL);
        }

    }else{
        incrementPC();
    }

}


void AssemblySimulator::incrementPC(){
    // pcのインクリメントと、ファイル末端に到達したかのチェックを行う
    pc += 4;
    if(pc == parser.instructionVector.size() * 4){
        // 末端に到着
        end = true;
        std::cout << FILE_END << std::endl;
    }
}

void AssemblySimulator::printOpCounter() const{
    // 実行命令の統計をプリント
    std::cout << "総実行命令数: " <<  std::to_string(instCount) << std::endl;
    
    std::stringstream ss;
    int count = 0;

    for(auto x:opCounter){
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