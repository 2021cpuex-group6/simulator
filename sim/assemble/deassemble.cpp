#include "../sims/parser.hpp"
#include "../utils/utils.hpp"

#include <iostream>
static constexpr uint32_t OPCODE_MASK = 0x1f;
static constexpr uint32_t REG_MASK = 0x3f;
static constexpr uint32_t SHAMT_MASK = 0x1f;
static constexpr uint32_t RD_SHIFT_N = 5;
static constexpr uint32_t RS1_SHIFT_N = 14;
static constexpr uint32_t RS2_SHIFT_N = 20;
static constexpr uint32_t IMM_SHIFT_N = 20;
static constexpr uint32_t SHAMT_SHIFT_N = 20;
static constexpr uint32_t FUNCT_3_SHIFT_N = 11;
static constexpr uint32_t FUNCT_3_MASK = 0x7;
static constexpr uint32_t FUNCT_7_MASK = 0xfc000000;
static constexpr uint32_t UI_MASK = 0xfffff800;
static std::string  ERROR_TOP = "Error: ";
static std::string  BUG_ERROR = "バグです．報告してください";
static std::string  NOT_IMPLEMENTED = "未実装";
static std::string  INVALID_CODE = "不正なコードです．";

void printError(std::string  message){
    throw std::invalid_argument(ERROR_TOP + message);
}

// 即値をパース
int32_t IImmParse(const uint32_t &code ){
    int32_t ans = static_cast<int32_t>(code);
    ans = shiftRightArithmatic(ans, IMM_SHIFT_N);
    return ans;
}

int32_t BImmParse(const uint32_t &code){
    uint32_t part1 = shiftRightArithmatic(code & 0xfc000000, 18);
    uint32_t part2 = (code & 0x7e0) >> 3;
    uint32_t res = part1 | part2;

    int32_t ans = static_cast<int32_t>(res);
    return ans;
}

int32_t JImmParse(const uint32_t &code){
    uint32_t part1 = code & 0x80000000;
    uint32_t part2 = (code & 0x7fe00000) >> 20;
    uint32_t part3 = (code & 0x100000) >> 9;
    uint32_t part4 = (code & 0xff000);
    uint32_t res = part2 | part3 | part4;
    if(part1 != 0){
        res |= 0xfff00000;
    }
    int32_t ans = static_cast<int32_t>(res);
    return ans;
}

int32_t SImmParse(const uint32_t &code){
    uint32_t part1 = (code & 0xfc000000) >> 20;
    uint32_t part2 = (code & 0x7e0) >> 5;
    uint32_t res = part1 | part2;
    if((code & 0x80000000) != 0u){
        res |= 0xfffff000;
    }
    int32_t ans = static_cast<int32_t>(res);
    return ans;
}

Instruction RRegParse(const uint32_t &code){
    Instruction inst = {};
    inst.operandN = 3;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.regInd[2] = (code >> RS2_SHIFT_N) & REG_MASK;

    return inst;
}

Instruction IRegParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.immediate = IImmParse(code);

    return inst;
}

Instruction ISRegParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.immediate = (code >> SHAMT_SHIFT_N) & SHAMT_MASK;

    return inst;
}


Instruction BRegParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS2_SHIFT_N) & REG_MASK;
    inst.immediate = BImmParse(code);

    return inst;
}



// S命令はrs1がメモリアドレスを指すレジスタ，rs2が出力元となり，命令列と逆のため，
// わかりやすくするためにここで交換する
Instruction SRegParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RS2_SHIFT_N) & REG_MASK;
    inst.regInd[1] = (code >> RS1_SHIFT_N) & REG_MASK;
    inst.immediate = SImmParse(code);

    return inst;
}



// 整数レジスタを使うR形式命令をパース
Instruction intRParse(const uint32_t &code){
    Instruction inst = RRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    uint32_t funct7 = code & FUNCT_7_MASK;
    switch(funct7){
        case 0x04000000:
            // sltu, srl
            switch(funct3){
                case 011:
                    inst.opcode = "slt"; break;
                case 0b101:
                    inst.opcode = "srl"; break;
                default:
                    printError("intRparse: " + INVALID_CODE);
            }
            break;
        case 0x0:
            switch(funct3){
                case 0:
                    inst.opcode = "add";
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
                    inst.opcode = "sra"; break;
                case 0b010:
                    inst.opcode = "sub"; break;
                case 0b011:
                    inst.opcode = "slt"; break;
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
// シフトもここに含む
Instruction intIParse(const uint32_t & code){
    Instruction inst;
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    uint32_t funct7 = shiftRightLogical(code & FUNCT_7_MASK, 25);
    // まず，シフト系かどうかを調べる
    if((funct3 & 0b11) == 0b01){
        // シフト系
        inst = ISRegParse(code);
        switch(funct3){
            case 0b001:
                inst.opcode = "slli"; break;
            case 0b101:
                if(funct7 == 0b10){
                    inst.opcode = "srli"; break;
                }else if(funct7 == 0b0){
                    inst.opcode = "srai"; break;
                }else{
                    printError("intIParse: " + INVALID_CODE);    
                }
            default:
                printError("intIParse: " + INVALID_CODE);
        }
    }else{
        inst = IRegParse(code);
        switch(funct3){
            case 0b0:
                if(inst.regInd[0] == 0){
                    inst.opcode = "nop";
                }else{
                    inst.opcode = "addi";
                }
                break;
            case 0b111:
                inst.opcode = "andi"; break;
            case 0b110:
                inst.opcode = "ori"; break;
            case 0b100:
                inst.opcode = "xori"; break;
            default:
                printError("intIParse: " + INVALID_CODE);
        }
    }
    return inst;
}

// ジャンプ系I形式をパース
Instruction JIParse(const uint32_t & code){
    Instruction inst = IRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    if(funct3 != 0u){
        printError("JIParse: " + INVALID_CODE);
    }
    if(inst.regInd[0] != 0u){
        inst.opcode = "jalr";
    }else{
        inst.operandN = 1;
        inst.regInd[0] = inst.regInd[1];
        inst.regInd[1] = 0;
        inst.opcode = "jr";
    }
    return inst;
}

// ロード系I形式をパース
Instruction LIParse(const uint32_t & code){
    Instruction inst = IRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    switch(funct3){
        case 0b010:
            inst.opcode = "lw"; break;
        case 0b100:
            inst.opcode = "lbu"; break;
        default:
            printError("LIParse: " + INVALID_CODE);
    }
    return inst;
}


Instruction BParse(const uint32_t &code){
    Instruction inst = BRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    switch(funct3){
        case 0b100:
            inst.opcode = "blt"; break;
        case 0b000:
            inst.opcode = "beq"; break;
        case 0b001:
            inst.opcode = "bne"; break;
        case 0b110:
            inst.opcode = "bge"; break;
        default:
            printError("BParse: " + INVALID_CODE);
    }
    return inst;
}

Instruction JParse(const uint32_t &code ){
    Instruction inst = {};
    inst.operandN = 2;
    inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
    inst.immediate = JImmParse(code);
    if(inst.regInd[0]== 0){
        inst.opcode = "j";
    }else{
        inst.opcode = "jal";
    }

    return inst;
}

Instruction SParse(const uint32_t &code){
    Instruction inst = SRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    switch(funct3){
        case 0b010:
            inst.opcode = "sw"; break;
        case 0b100:
            inst.opcode = "sb"; break;
        default:
            printError("SParse: " + INVALID_CODE);
    }
    return inst;
}

Instruction FRParse(const uint32_t &code){
    Instruction inst = RRegParse(code);
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    uint32_t funct7 = shiftRightLogical(code & FUNCT_7_MASK, 26);
    if(funct3 != 0u){
        printError("FRParse: " + INVALID_CODE);
    }
    switch(funct7){
        case 0u:
            inst.opcode = "fadd"; break;
        case 0x02:
            inst.opcode = "fsub"; break;
        case 0x04:
            inst.opcode = "fmul"; break;
        case 0x06:
            inst.opcode = "fdiv"; break;
        case 0x28:
            inst.opcode = "fle"; break;
        case 0x38:
            inst.opcode = "feq"; break;
        default:
            inst.operandN = 2;
            if(inst.regInd[2] != 0u){
                printError("FRParse: " + INVALID_CODE);
            }
            switch(funct7){
                case 0x16:
                    inst.opcode = "fsqrt"; break;
                case 0xa:
                    inst.opcode = "floor"; break;
                case 0x34:
                    inst.opcode = "itof"; break;
                case 0x3c:
                    inst.opcode = "ftoi"; break;
                default:
                    printError("FRParse: " + INVALID_CODE);
            }
    }

    return inst;
}

// 符号なしintをアセンブリに戻す
// lineN, opcode, labelには入れない
Instruction deassemble(const uint32_t &lineN, uint32_t code){
    uint32_t opcode = (code & OPCODE_MASK);
    Instruction inst;
    uint8_t funct3 = (code >> FUNCT_3_SHIFT_N) & FUNCT_3_MASK;
    switch(opcode){
        case 0b01100:
            inst =  intRParse(code);
            break;
        case 0b00100:
            inst =  intIParse(code);
            break;
        case 0b11000:
            inst = BParse(code);
            break;
        case 0b11011:
            inst = JParse(code);
            break;
        case 0b11001:
            inst = JIParse(code);
            break;
        case 0b00000:
            inst = LIParse(code);
            break;
        case 0b01000:
            inst = SParse(code);
            break;
        case 0b10100:
            inst = FRParse(code);
            break;
        case 0b01101:
            inst = {};
            inst.operandN = 1;
            inst.regInd[0] = (code >> RD_SHIFT_N) & REG_MASK;
            inst.immediate = code & UI_MASK;
            inst.opcode = "lui";
            break;
        default:
            printError(NOT_IMPLEMENTED);
    }
    inst.lineN = lineN;
    try{
        inst.opcodeInt = static_cast<uint8_t>(opcodeInfoMap.at(inst.opcode)[5]);
    }catch(const std::out_of_range &e){
        // 不正なopecode
        printError(NOT_IMPLEMENTED);
    }
    return inst;

}
