#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "fpu.hpp"
#include "parser.hpp"
#include "../utils/utils.hpp"
#include <iostream>
#include <array>
#include <set>
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <cmath>

constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;
constexpr int INST_BYTE_N = 4;
constexpr int WORD_BYTE_N = 4;
constexpr int PRINT_INST_COL = 2;
constexpr int PRINT_INST_NUM_SIZE = 6;
constexpr int HISTORY_RESERVE_N = 1024;
constexpr int SHIFT_MASK5 = 0b11111;
constexpr int MEM_BYTE_N = 0x1000000; //メモリのバイト数 2^24
constexpr int MEM_ADDRESS_HEX_LEN = 8;
constexpr int OPKIND_MASK = 0x7;
constexpr int OPKIND_BIT_N = 3;
static const std::string ILEGAL_INNER_OPCODE = "不正な内部オペコードです(実装ミス)";
const std::string BREAKPOINT_NOT_FOUND = "ブレークポイントが見つかりませんでした";
const std::string FILE_END = "終了しました";
const std::string ALREADY_ENDED = "すでに終了しています";
const std::string INVALID_REGISTER = "レジスタ名が不正です";
const std::string ZERO_REG_WRITE_ERROR = "x0レジスタに書き込むことはできません";
const std::string ZERO_REG_WRITE_WARNING = "x0レジスタに入力しています";
const std::string PC_NOT_ALIGNED_WRITE = "Warning: アラインに合わないpcの値が入力されています";
const std::string NOT_FOUND_LABEL = "ラベルが見つかりません";
const std::string OUT_OF_RANGE_BREAKPOINT = "ファイルの行数の範囲外のためブレークポイントは設置できません";
const std::string NO_HISTORY = "もう履歴はありません";
const std::string OUT_OF_RANGE_MEMORY = "メモリの範囲外を参照しようとしています";
const std::string MIXED_REGISTER_ERROR = "この命令で浮動小数点レジスタと整数レジスタは同時に使えません";
const std::string ILEGAL_WORD_ACCESS = "メモリのワードアクセスは4バイトアラインされた位置のみにできます";
const std::string ILEGAL_BASE_REGISTER = "浮動小数点レジスタ，pcはベースレジスタにできません.";
const std::string ILEGAL_LOADSTORE_INSTRUCTION = "適切なロード・ストア命令を使ってください.";
const std::string ILEGAL_CONTROL_REGISTER = "制御命令に浮動小数点レジスタはは使えません";
const std::string ILEGAL_REGISTER_KIND = "適切なレジスタを使ってください";
const std::string IMPLEMENT_ERROR = "バグです。報告してください";

const std::string IREG_PREFIX = "%x";
const std::string FREG_PREFIX = "%f";
const std::string GUI_NO_HISTORY = "NoHis";
const std::string GUI_END = "End";
const std::string GUI_ALREADY_END = "AEnd";
const std::string GUI_STOP = "Stop";
const std::string GUI_WARNING = "Warning";
const std::string GUI_NO_CHANGE = "No";
const std::string GUI_MEM_CHANGE = "mem";
const std::string GUI_ERROR = "Error";
enum class NumberBase{
    BIN = 2, 
    OCT = 8, 
    DEC = 10, 
    HEX = 16, 
    FLOAT = -1
};

union MemoryUnit{ // メモリの1ワードに対応するユニット
    float f;
    uint32_t i;
    int32_t si;
    uint8_t b[WORD_BYTE_N];
    int8_t sb[WORD_BYTE_N];
    MemoryUnit(){}

    MemoryUnit(const float & value){
        f = value;
    }
    MemoryUnit(const uint32_t & value){
        i = value;
    }
    MemoryUnit(const int32_t & value){
        si = value;
    }
};

enum class MemAccess{
    WORD = 4, 
    BYTE = 1
};

// 前回の状態に戻すのに必要なデータ
struct BeforeData{
    std::string instruction;
    int pc;
    bool isInteger; // 書き込んだレジスタが整数用レジスタか
    int regInd;  //書き込んだレジスタ。書き込みナシなら-1
    int32_t regValue;
    bool writeMem; //メモリに書き込んだか
    uint32_t memAddress; // 書き込んだアドレス
    uint32_t memValue;
    uint8_t opcodeInt; // 高速化時の命令データ
};



class AssemblySimulator{
    public:
        bool useEfficient = false; // 高速化verを使うか
        bool useBinary = false;
        bool onWarning = true;
        bool forGUI;
        int nowLine = 0;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍
        uint32_t fcsr; //浮動小数点演算の状態管理　いらないかも
        bool end; //終了フラグ
        const AssemblyParser &parser;
        int iRegisters[REGISTERS_N];
        MemoryUnit fRegisters[REGISTERS_N];

        int instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計
        std::map<uint8_t, int> efficientOpCounter; // uint8_t ver
        std::set<int> breakPoints; // ブレークポイントの集合　行数で管理（1始まり）

        int historyN;   // 現在保持している履歴の数
        int historyPoint; // 次に履歴を保存するインデックス
        std::array<BeforeData, HISTORY_RESERVE_N> beforeHistory; // もとに戻れるようにデータをとる
        std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N> *dram;  

        FPUUnit fpu;
        std::map<uint8_t, std::string> inverseOpMap; // uint8_tのopcodeから文字列へ変換
        
        AssemblySimulator(const AssemblyParser& parser, const bool &useBin, const bool &forGUI);
        ~AssemblySimulator();
        void printRegisters(const NumberBase&, const bool &sign, const bool& useFnotation) const;
        void printOpCounter()const;
        void next(bool, const bool&);
        void doNextBreak();
        void launch(const bool &);
        static void printInstByRegInd(const int & lineN, const Instruction &instruction);
        static void printInstruction(const int &, const Instruction &);
        void printInstructionInSim(const int &, const Instruction &)const;
        void printBreakList()const;
        void printDif(const BeforeData &before, const bool &back)const;
        void setBreakPoint(const int &);
        void deleteBreakPoint(const int &);
        static std::pair<int, bool> getRegInd(const std::string &regName);
        inline void writeReg(const int &regInd, const int32_t &value, const bool& isInteger){
            if(regInd < REGISTERS_N){
                if(regInd == 0 && !forGUI){
                        // 0レジスタへの書き込み
                        // std::cout << ZERO_REG_WRITE_ERROR << std::endl;
                        return;
                }
                if(isInteger){
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
        void reset();
        void addHistory(const BeforeData &);
        void back();
        inline uint32_t readMem(const uint32_t& address, const MemAccess &memAccess)const;
        inline void writeMem(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value);
        BeforeData popHistory();

    // private:
        inline BeforeData efficientDoInst(const Instruction &);
        inline void efficientDoALU(const uint8_t &op, const int &targetR, const int &source0, const int &source1);
        inline void efficientDoFALU(const uint8_t &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1);
        inline BeforeData efficientDoControl(const uint8_t &opcode, const Instruction &instruction);
        inline BeforeData efficientDoJump(const uint8_t &opcode, const Instruction &instruction);
        inline BeforeData efficientDoLoad(const uint8_t &opcode, const Instruction &instruction);
        inline BeforeData efficientDoStore(const uint8_t &opcode, const Instruction &instruction);
        inline BeforeData efficientDoMix(const uint8_t &opcode, const Instruction &instruction);

        int getIRegIndWithError(const std::string &regName)const;
        int getFRegIndWithError(const std::string &regName)const;
        std::pair<int, bool> getRegIndWithError(const std::string &regName)const;
        BeforeData doInst(const Instruction &);
        void launchError(const std::string &message)const;
        void launchWarning(const std::string &message)const;
        void doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1);
        void doFALU(const std::string &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1);
        BeforeData do2RegInst(const std::string &opcode, const Instruction &instruction);
        BeforeData doLoad(const std::string &opcode, const Instruction &instruction);
        BeforeData doStore(const std::string &opcode, const Instruction &instruction);
        BeforeData doControl(const std::string &opcode, const Instruction &instruction);
        inline void incrementPC();
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &isInteger) const ;
        std::string getIRegisterInfoUnit(const int&, const NumberBase&, const bool &sign) const ;
        std::string getFRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &useFNotaion) const ;
        std::string getMemWordString(const uint32_t &address)const;
        void printMem(const uint32_t &address, const uint32_t &wordN, const int &lineN)const;
        std::string getSeparatedWordString(const uint32_t &value)const;
};

// 以下，inline関数

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


// ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う
// PCの更新はここでは行わない
// opcodeはすでにシフトされ，functの部分のみ
// R, I形式ともに使えるようにfunctは疎を得ている
void AssemblySimulator::efficientDoALU(const uint8_t &opcode, const int &targetR, const int &source0, const int &source1){
    int ans = 0;
    switch(opcode){
        case 0b00000:
            ans = source0 + source1;break;
        case 0b00001:
            ans = source0 & source1; break;
        case 0b00010:
            ans = source0 | source1; break;
        case 0b00011:
            ans = source0 ^ source1; break;
        case 0b00100:
            ans = source0 - source1; break;
        case 0b01000:
            ans = source0 < source1 ? 1u: 0; break;
        case 0b01001:
            ans = static_cast<uint32_t>(source0) < static_cast<uint32_t>(source1) ? 1u : 0; break;
        default:
            // 残りはシフト演算
            // RISC-Vではsource1の下位5ビットを（符号なし整数ととらえて？）シフトする 
            uint32_t shiftN = source1 & 0b11111;
            switch(opcode){
                case 0b10000:
                    ans = source0 << shiftN; break;
                case 0b10010:
                    ans = shiftRightLogical(source0, shiftN); break;
                case 0b10011:
                    ans = shiftRightArithmatic(source0, shiftN); break;
                default:
                    launchError(ILEGAL_INNER_OPCODE);
            }
    }
    writeReg(targetR, ans, true);
}

void AssemblySimulator::efficientDoFALU(const uint8_t &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1){
    uint32_t ans = 0;
    float ansF;
    MemoryUnit mu;
    switch(opcode){
        case 0b00:
            ans = fpu.fadd(source0, source1); break;
        case 0b00001:
            ans = fpu.fmul(source0, source1); break;   
        case 0b00010:
            ans = fpu.fdiv(source0, source1); break;
        case 0b00100:
            ans = fpu.fsub(source0, source1); break;
        case 0b10000:
            ans = fpu.fsqrt(source0); break;
        case 0b11000:
            mu.i = (source0);
            ansF = std::floor(mu.f);
            mu.f = ansF;
            ans = mu.i;
            break;
        case 0b11001:
            ans = source0; break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }

    fRegisters[targetR] = MemoryUnit(ans);
}

// 制御系の命令で，ジャンプするときの処理
BeforeData AssemblySimulator::efficientDoJump(const uint8_t &opcode, const Instruction &instruction){
    BeforeData ans = {"", pc,true, -1, -1, false, 0, 0, instruction.opcodeInt};
    if((opcode & 0b10)){
        // レジスタへの書き込み (jal, jalr)
        int writeRegInd = instruction.regInd[0];
        ans.regInd = writeRegInd;
        ans.regValue = iRegisters[writeRegInd];
        writeReg(writeRegInd, pc+INST_BYTE_N, true);
    }
    int nextPC = instruction.immediate;
    if((opcode & 0b1)){
        // レジスタを使う (jalr, jr)
        // 即値とレジスタの値を足して最下位ビットを0にした値がジャンプ先
        // しかしこのシミュレータは4バイトの固定長命令を使うことを暗に仮定しているので、もう1ビットも0にする
        if(opcode & 0b10){
            // jalr
            nextPC += iRegisters[instruction.regInd[1]];
        }else{
            nextPC += iRegisters[instruction.regInd[0]];
        }
        nextPC &= (~0) << 2;
        pc = nextPC;

    }else{
        // 即値ジャンプ
        pc += instruction.immediate;
    }
    return std::move(ans);
}

// 制御系の命令実行
// 次命令がpc+4かは不明なのでここでpcの更新をする
BeforeData AssemblySimulator::efficientDoControl(const uint8_t &opcode, const Instruction &instruction){
    int reg0 = iRegisters[instruction.regInd[0]];
    int reg1 = iRegisters[instruction.regInd[1]];
    bool jumpFlag;
    switch(opcode){
        case 0b001:
            jumpFlag = reg0 < reg1; break;
        case 0b010:
            jumpFlag = reg0 == reg1; break;
        case 0b100:
            jumpFlag = reg0 != reg1; break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }
    if(jumpFlag){
        // j命令と同じ
        return efficientDoJump(0b0000, instruction);
    }else{
        BeforeData ans = {"", pc,false, -1, -1, false, 0, 0, instruction.opcodeInt};
        incrementPC();
        return std::move(ans);
    }
}


BeforeData AssemblySimulator::efficientDoLoad(const uint8_t &opcode, const Instruction &instruction){
    // ロード命令を実行
    uint32_t address = instruction.immediate;
    address += iRegisters[instruction.regInd[1]];

    bool loadInteger = (opcode & 0b100) == 0u;
    int32_t loadRegInd = instruction.regInd[0];
    int32_t beforeValue = loadInteger ? iRegisters[loadRegInd] : fRegisters[loadRegInd].si;
    BeforeData before = {"", pc, loadInteger, loadRegInd, beforeValue, false, 0u, 0u, instruction.opcodeInt};
    
    if(loadInteger){
        if(opcode & 0b1){
            // lw
            uint32_t value = readMem(address, MemAccess::WORD);
            writeReg(loadRegInd, value, true);
        }else{
            // lbu
            uint32_t value = readMem(address, MemAccess::BYTE);
            writeReg(loadRegInd, ((~0xff) &iRegisters[loadRegInd]) | value, true);
        }
    }else{
        uint32_t value = readMem(address, MemAccess::WORD);
        fRegisters[loadRegInd] = MemoryUnit(value);
    }

    return std::move(before);
}



BeforeData AssemblySimulator::efficientDoStore(const uint8_t &opcode, const Instruction &instruction){
    uint32_t address = instruction.immediate;
    address += iRegisters[instruction.regInd[1]];

    uint32_t beforeAddress = (address/4)*4; // 4バイトアラインする
    BeforeData before = {"", pc, false, -1, -1, true, beforeAddress, readMem(beforeAddress, MemAccess::WORD), instruction.opcodeInt};

    int regInd = instruction.regInd[0];
    uint32_t value = (opcode & 0b1) == 0 ? iRegisters[regInd] : fRegisters[regInd].i;
    writeMem(address, MemAccess::WORD, value);
    return std::move(before);
}

// 書き込み，読み込みをするレジスタの種類が違う命令
BeforeData AssemblySimulator::efficientDoMix(const uint8_t &opcode, const Instruction &instruction){
    int targetReg = instruction.regInd[0];
    BeforeData ans = {"", pc, false, targetReg, 0u, false, 0u, 0u, instruction.opcodeInt};

    if(opcode & 0b1){
        // 書き込み先は整数レジスタ
        ans.isInteger = true;
        ans.regValue = iRegisters[targetReg];
        if(opcode & 0b100){
            // flt
        }else{
            // ftoi
            int32_t value = std::round(fRegisters[instruction.regInd[1]].f);
            writeReg(targetReg, value, true);
        }
        return std::move(ans);
    }else{
        // itof
        ans.isInteger = false;
        ans.regValue = fRegisters[targetReg].si;
        uint32_t ansInt = fpu.itof(static_cast<uint32_t>(iRegisters[instruction.regInd[1]]));
        writeReg(targetReg, ansInt, false);
        return std::move(ans);
    }

}

// 高速化した命令処理
BeforeData AssemblySimulator::efficientDoInst(const Instruction &instruction){
    uint8_t opcode = instruction.opcodeInt;
    ++instCount;
    efficientOpCounter[opcode] = efficientOpCounter[opcode] + 1;

    uint8_t opKind = opcode & OPKIND_MASK;
    uint8_t opFunct = opcode >> OPKIND_BIT_N;
    BeforeData ans = {};
    ans.opcodeInt = opcode;
    ans.pc = pc;
    int targetR, source0, source1;
    uint32_t sourceU0, sourceU1;
    switch(opKind){
        case 0b000:
            // 整数R (レジスタ3つ)
            // 演算命令
            // ここで前のデータを保存
            targetR = instruction.regInd[0];
            ans.isInteger = true;
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = iRegisters[targetR];
            source0 = iRegisters[instruction.regInd[1]];
            source1 = iRegisters[instruction.regInd[2]];
            efficientDoALU(opFunct, targetR, source0, source1);
            break;
        case 0b001:
            // 整数I
            targetR = instruction.regInd[0];
            ans.isInteger = true;
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = iRegisters[targetR];
            source0 = iRegisters[instruction.regInd[1]];
            source1 = instruction.immediate;
            efficientDoALU(opFunct, targetR, source0, source1);
            break;
        case 0b010:
            // 制御B
            return efficientDoControl(opFunct, instruction);
        case 0b011:
            // 制御J, I
            return efficientDoJump(opFunct, instruction);
        case 0b100:
            // メモリI
            ans = efficientDoLoad(opFunct, instruction); break;
        case 0b101:
            // メモリS
            ans = efficientDoStore(opFunct, instruction); break;
        case 0b110:
            // 浮動R
            targetR = instruction.regInd[0];
            // ここで前のデータを保存
            ans.instruction = opcode;
            ans.pc = pc;
            ans.isInteger = false;
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = fRegisters[targetR].si;
            sourceU0 = fRegisters[instruction.regInd[1]].i;
            if(opFunct & 0b10000){
                // fsqrtなど，入力が１つ
                sourceU1 = 0;
            }else{
                sourceU1 = fRegisters[instruction.regInd[2]].i;
            }
            efficientDoFALU(opFunct, targetR, sourceU0, sourceU1);
            break;
        case 0b111:
            // 混合
            ans = efficientDoMix(opFunct, instruction);
            break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }

    incrementPC();
    return std::move(ans);
}

#endif