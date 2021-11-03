#include "../sims/parser.hpp"
#include "../utils/utils.hpp"

#include <iostream>
static constexpr uint32_t OPCODE_MASK = 0x7f;
static constexpr uint32_t REG_MASK = 0x1f;
static constexpr uint32_t RD_SHIFT_N = 7;
static constexpr uint32_t RS1_SHIFT_N = 15;
static constexpr uint32_t RS2_SHIFT_N = 20;
static constexpr uint32_t IMM_SHIFT_N = 20;
static constexpr uint32_t FUNCT_3_SHIFT_N = 12;
static constexpr uint32_t FUNCT_3_MASK = 0x7;
static constexpr uint32_t FUNCT_7_MASK = 0xfe000000;
static std::string  ERROR_TOP = "Error: ";
static std::string  BUG_ERROR = "バグです．報告してください";
static std::string  NOT_IMPLEMENTED = "未実装";
static std::string  INVALID_CODE = "不正なコードです．";

void printError(std::string  message){
    std::cout << ERROR_TOP << message << std::endl;
}

// 即値をパース
int32_t &immParse(const uint32_t &code ){
    int32_t ans = static_cast<int32_t>(code);
    ans = shiftRightArithmatic(ans, IMM_SHIFT_N);
    return ans;
}

Instruction &RRegParse(const uint32_t &code){
    Instruction inst = {};
    inst.operandN = 3;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.regInd[2] = (code >> RS2_SHIFT_N) & REG_MASK;

    return inst;
}

Instruction &IRegParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.immediate = immParse(code);

    return inst;
}



// 整数レジスタを使うR形式命令をパース
Instruction &intRParse(const uint32_t &code){
    Instruction &inst = RRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    uint32_t funct7 = code & FUNCT_7_MASK;
    switch(funct7){
        case 0x40000000:
            // sra, sub
            switch(funct3){
                case 0:
                    inst.opcode = "sub"; break;
                case 0b101:
                    inst.opcode = "sra"; break;
                default:
                    printError("intRparse: " + INVALID_CODE);
            }
            break;
        case 0x02000000:
            switch(funct3){
                case 0:
                    inst.opcode = "mul"; break;
                case 0b100:
                    inst.opcode = "div"; break;
                default:
                    printError("intRparse: " + INVALID_CODE);
            }
            break;
        case 0x0:
            switch(funct3){
                case 0:
                    if(inst.regInd[0] == 0){
                        inst.opcode = "nop";
                    }else{
                        inst.opcode = "add";
                    }
                    break;
                case 0b111:
                    inst.opcode = "and"; break;
                case 0b110:
                    inst.opcode = "or"; break;
                case 0b100:
                    inst.opcode = "xor"; break;
                case 0b001:
                    inst.opcode = "sll"; break;
                case 0b101:
                    inst.opcode = "srl"; break;
                case 0b010:
                    inst.opcode = "slt"; break;
                case 0b011:
                    inst.opcode = "sltu"; break;
                default:
                    printError("intRparse: " + INVALID_CODE);
            }
            break;
        default:
            printError("intRparse: " + INVALID_CODE);
    }
    return inst;
}

// 整数の即値演算系I形式をパース
Instruction &intIParse(const uint32_t & code){
    Instruction &inst = IRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    switch(funct3){
        case 0b0:
            inst.opcode = "addi"; break;
        case 0b111:
            inst.opcode = "andi"; break;
        case 0b110:
            inst.opcode = "ori"; break;
        case 0b100:
            inst.opcode = "xori"; break;
        default:
            printError("intIParse: " + INVALID_CODE);
    }
    return inst;
}

// 符号なしintをアセンブリに戻す
// lineN, opcode, labelには入れない
Instruction &deassemble(const uint32_t &code){
    uint8_t opcode = static_cast<uint8_t>(code & OPCODE_MASK);
    switch(opcode){
        case 0b0110011:
            intRParse(code);
            break;
        case 0b0010011:

        default:
            printError(NOT_IMPLEMENTED);

    }

}
