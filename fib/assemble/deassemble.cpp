#include "../sims/parser.hpp"

#include <iostream>
static constexpr uint32_t OPCODE_MASK = 0x7f;
static constexpr uint32_t REG_MASK = 0x1f;
static constexpr uint32_t RD_SHIFT_N = 7;
static constexpr uint32_t RS1_SHIFT_N = 15;
static constexpr uint32_t RS2_SHIFT_N = 20;
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

Instruction &reg3Parse(const uint32_t &code){
    Instruction inst = {};
    inst.operandN = 3;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.regInd[2] = (code >> RS2_SHIFT_N) & REG_MASK;

    return inst;
}


// 整数レジスタを使うR形式命令をパース
Instruction &intRparse(const uint32_t &code){
    Instruction &inst = reg3Parse(code);
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

// 符号なしintをアセンブリに戻す
// lineN, opcode, labelには入れない
Instruction deassemble(uint32_t  code){
    uint8_t opcode = static_cast<uint8_t>(code & OPCODE_MASK);
    switch(opcode){
        case 0b0110011:
            intRparse(code);
            break;

        default:
            printError(NOT_IMPLEMENTED);

    }

}
