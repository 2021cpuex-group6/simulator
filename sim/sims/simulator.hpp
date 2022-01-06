#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "fpu.hpp"
#include "parser.hpp"
#include "mmio.hpp"
#include "../utils/utils.hpp"

#include <iostream>
#include <array>
#include <unordered_set>
#include <set>
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <cmath>

constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;

constexpr int PRINT_INST_COL = 2;
constexpr int PRINT_INST_NUM_SIZE = 6;
constexpr int PRINT_INFO_NUM_SIZE = 10;
constexpr int HISTORY_RESERVE_N = 1024;
constexpr int SHIFT_MASK5 = 0b11111;
constexpr long MEM_BYTE_N = 0x100000000; //メモリのバイト数 2^24
constexpr int MEM_ADDRESS_HEX_LEN = 8;
constexpr int OPKIND_MASK = 0x7;
constexpr int OPKIND_BIT_N = 3;
constexpr bool USE_EFFICIENT = true;
constexpr int CASH_SIZE = 0x1000; // キャッシュの総行数　２べきにすること
constexpr int CASH_OFFSET_N = 2; // メモリアドレスのうちのオフセット長．この2べきがキャッシュ一行のデータのバイト数
constexpr int32_t DATA_START = 0x100000; // データの始まるアドレス (2^20)

// MMIOのアドレス．
// この順でかつ3つのアドレスが連続していれば自由に変更可能．
constexpr int32_t MMIO_VALID = DATA_START - 3; // MMIOのvaildのアドレス
constexpr int32_t MMIO_RECV = DATA_START - 2; // MMIOの受信アドレス
constexpr int32_t MMIO_SEND = DATA_START - 1; // MMIOの送信アドレス


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
const std::string ILEGAL_MEM_WRITE = "このアドレスに書き込みはできません．";
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
const std::string GUI_SEND = "send";
enum class NumberBase{
    BIN = 2, 
    OCT = 8, 
    DEC = 10, 
    HEX = 16, 
    FLOAT = -1
};



enum class MemAccess{
    WORD = 4, 
    BYTE = 1
};


// キャッシュの一行に対応するデータ
struct CacheRow{
    uint32_t address; //面倒なのでアドレスをそのまま保存してる
    bool valid;

};


// 前回の状態に戻すのに必要なデータ
struct BeforeData{
    int pc;
    bool isInteger; // 書き込んだレジスタが整数用レジスタか
    int regInd;  //書き込んだレジスタ。書き込みナシなら-1
    int32_t regValue;
    bool writeMem; //メモリに書き込んだか
    uint32_t memAddress; // 書き込んだアドレス
    uint32_t memValue;
    uint8_t opcodeInt; // 高速化時の命令データ
    bool useMem; // メモリを使ったか (hit, miss数の復元に必要)
    bool changeCash; // キャッシュが変更されたか == ミスしたか
    uint32_t cashAddress; // 書き換えたキャッシュのアドレス
    CacheRow cacheRow; // 前のキャッシュデータ
    bool isMMIO; //MMIOを使ったか
    bool MMIOvalid; //valid bitを見ただけか
    bool MMIOsend; // sendか
    bool isNewAccess; // 新しくアクセスするアドレスにアクセスしたか(memCheck用)
    uint32_t newAccessAddress; // そのアドレス(wordAccessCheckMemのインデックスではないので4で割る)
};


// launchErrorで吐くエラー
class SimException : public std::runtime_error
{
    public:
    SimException(const std::string _Message): runtime_error(_Message){}
};

class AssemblySimulator{
    public:
        bool useBinary = false;
        bool onWarning = true;
        bool forGUI;
        int nowLine = 0;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍
        uint32_t fcsr; //浮動小数点演算の状態管理　いらないかも
        bool end; //終了フラグ
        const AssemblyParser &parser;
        long lastPC = 0;
        int iRegisters[REGISTERS_N];
        MemoryUnit fRegisters[REGISTERS_N];

        uint64_t instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計
        std::map<uint8_t, uint64_t> efficientOpCounter; // uint8_t ver
        std::unordered_set<int32_t> breakPoints; // ブレークポイントの集合　行数で管理（1始まり）

        int historyN;   // 現在保持している履歴の数
        int historyPoint; // 次に履歴を保存するインデックス
        std::array<BeforeData, HISTORY_RESERVE_N> beforeHistory; // もとに戻れるようにデータをとる
        std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N> *dram;
        int64_t wordAccessCheckN;      // ワードアクセスされた箇所の総数
        std::array<bool, MEM_BYTE_N / WORD_BYTE_N> *wordAccessCheckMem;  //どこにアクセスされたか

        FPUUnit fpu;
        std::map<uint8_t, std::string> inverseOpMap; // uint8_tのopcodeから文字列へ変換

        CacheRow cache[CASH_SIZE]; // キャッシュ
        int32_t cacheWay; //ウェイ数
        int32_t cacheIndexN; // キャッシュのインデックス数 (CASH_SIZE / cacheWay)
        uint64_t cacheRHitN; // 読み出し時キャッシュヒット数
        uint64_t cacheWHitN; // 書き込み時キャッシュヒット数
        uint64_t cacheRMissN; //　読み出し時キャッシュミス数
        uint64_t cacheWMissN; //　書き込み時キャッシュミス数

        MMIO mmio;
        
        AssemblySimulator(const AssemblyParser& parser, const bool &useBin,
             const bool &forGUI, const int &cacheWay, const MMIO &mmio);
        ~AssemblySimulator();
        void printRegisters(const NumberBase&, const bool &sign, const bool& useFnotation) const;
        void printOpCounter()const;
        void printCacheSystem()const;
        void next(bool, const bool&);
        void doNextBreak();
        void launch(const bool &);
        void launchFast(const bool &);
        static void printInstByRegInd(const int & lineN, const Instruction &instruction);
        static void printInstruction(const int &, const Instruction &);
        void printInstructionInSim(const int &, const Instruction &)const;
        void printBreakList()const;
        void printDif(const BeforeData &before, const bool &back, const std::string &opcode)const;
        std::pair<bool, int32_t> translateBreakInd(const int &)const;
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
        inline void writeCashBeforeData(const bool &forWrite, const uint32_t& address, BeforeData &beforeData);
        inline uint32_t readMem(const uint32_t& address, const MemAccess &memAccess)const;
        inline uint32_t readMemWithCacheCheck(const uint32_t& address, const MemAccess &memAccess, BeforeData &beforeData);
        inline void writeMem(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value);
        inline void writeMemWithCacheCheck(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value, BeforeData &beforeData);
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
        inline bool wordAccessCheck(const uint32_t &address);

        int getIRegIndWithError(const std::string &regName)const;
        int getFRegIndWithError(const std::string &regName)const;
        std::pair<int, bool> getRegIndWithError(const std::string &regName)const;
        void launchError(const std::string &message)const;
        void launchWarning(const std::string &message)const;
        inline void incrementPC();
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &isInteger) const ;
        std::string getIRegisterInfoUnit(const int&, const NumberBase&, const bool &sign) const ;
        std::string getFRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &useFNotaion) const ;
        std::string getMemWordString(const uint32_t &address)const;
        void printMem(const uint32_t &address, const uint32_t &wordN, const int &lineN)const;
        std::string getSeparatedWordString(const uint32_t &value)const;
        double calculateTime();
        void printCalculatedTime();
        void printAccessedAddress(); // アクセスされたアドレスを全表示
};

// 以下，inline関数

void AssemblySimulator::incrementPC(){
    // pcのインクリメントと、ファイル末端に到達したかのチェックを行う
    pc += INST_BYTE_N;
    if(pc == lastPC){
        // 末端に到着
        end = true;
        if(forGUI){
            std::cout << GUI_END << std::endl;
        }else{
            std::cout << FILE_END << std::endl;
        }
    }
}

// メモリにアクセスする際に，cash系のbeforeDataを書き込み，キャッシュデータを書き込む
void AssemblySimulator::writeCashBeforeData(const bool &forWrite, const uint32_t& address, BeforeData &beforeData){
    beforeData.useMem = true;
    uint32_t index = shiftRightLogical(address, CASH_OFFSET_N) & (cacheIndexN - 1);
    uint32_t cashAddress = index * cacheWay;
    for(int i  = 0; i < cacheWay; ++i){
        // 常に先頭から見て先頭から埋めるので，validじゃないものが現れた時点で後ろもvalidじゃない
        CacheRow nowRow = cache[cashAddress];
        if(!nowRow.valid ){
            beforeData.cacheRow = cache[cashAddress];
            beforeData.cashAddress = cashAddress;
            beforeData.changeCash = true;
            if(forWrite){
                ++cacheWMissN;
            }else{
                ++cacheRMissN;
            }
            CacheRow newRow = {address, true};
            cache[cashAddress] = newRow;
            return;
        }
        if(nowRow.address == address){
            // ヒット
            if(forWrite){
                ++cacheWHitN;
            }else{
                ++cacheRHitN;
            }
            beforeData.changeCash = false;
            return;
        }
        ++cashAddress;
    }
    // キャッシュが競合
    // とりあえず先頭を取り出すことにする
    cashAddress -= cacheWay;
    
    beforeData.cacheRow = cache[cashAddress];
    beforeData.cashAddress = cashAddress;
    beforeData.changeCash = true;
    if(forWrite){
        ++cacheWMissN;
    }else{
        ++cacheRMissN;
    }
    CacheRow newRow = {address, true};
    cache[cashAddress] = newRow;
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

// キャッシュのチェック，書き込みもする
// BeforeDataの書き込みも行う
// 返り値はメモリの値とヒットしたかのboolのpair
uint32_t AssemblySimulator::readMemWithCacheCheck(const uint32_t& address, const MemAccess &memAccess, BeforeData &beforeData){
    uint32_t ans = readMem(address, memAccess);
    writeCashBeforeData(false, address, beforeData);
    return ans;
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

// キャッシュへの書き込み，BeforeDataへの書き込みも行う
void AssemblySimulator::writeMemWithCacheCheck(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value, BeforeData &beforeData){
    writeMem(address, MemAccess, value);
    writeCashBeforeData(true, address, beforeData);
}


// ターゲットレジスタのインデックス、入力２つを受け取り、演算、レジスタへの書き込みを行う
// PCの更新はここでは行わない
// opcodeはすでにシフトされ，functの部分のみ
// R, I形式ともに使えるようにfunctはそろえている
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
        case 0b11111:
            // nop
            ans = iRegisters[targetR];break;
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
            ans = fpu.floor(source0);
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
    BeforeData ans = {pc,true, -1, -1, false, 0, 0, instruction.opcodeInt};
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
    return ans;
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
        BeforeData ans = {pc,false, -1, -1, false, 0, 0, instruction.opcodeInt};
        incrementPC();
        return ans;
    }
}


BeforeData AssemblySimulator::efficientDoLoad(const uint8_t &opcode, const Instruction &instruction){
    // ロード命令を実行
    uint32_t address = instruction.immediate;
    address += static_cast<uint32_t>(iRegisters[instruction.regInd[1]]);

    bool loadInteger = (opcode & 0b100) == 0u;
    int32_t loadRegInd = instruction.regInd[0];
    int32_t beforeValue = loadInteger ? iRegisters[loadRegInd] : fRegisters[loadRegInd].si;
    BeforeData before = { pc, loadInteger, loadRegInd, beforeValue, false, 0u, 0u, instruction.opcodeInt};
    
    if(loadInteger){
        if(opcode & 0b1){
            // lw
            before.isNewAccess = wordAccessCheck(address);
            before.newAccessAddress = address;
            uint32_t value = readMemWithCacheCheck(address, MemAccess::WORD, before);
            writeReg(loadRegInd, value, true);
        }else{
            // lbu
            if(address == MMIO_RECV){
                // MMIOとして扱う
                before.isMMIO = true;
                before.MMIOvalid = false;
                before.MMIOsend = false;
                int32_t val = 0;
                if(mmio.valid) val = 0xff & static_cast<int32_t>(mmio.recv());
                writeReg(loadRegInd, val, true);
            }else if(address == MMIO_VALID){
                before.isMMIO = true;
                before.MMIOvalid = true;
                int32_t val = mmio.valid ? 1 : 0;
                writeReg(loadRegInd, val, true);
            }else{
                uint32_t value = readMemWithCacheCheck(address, MemAccess::BYTE, before);
                writeReg(loadRegInd, value, true);
            }
        }
    }else{
        before.isNewAccess = wordAccessCheck(address);
        before.newAccessAddress = address;
        uint32_t value = readMemWithCacheCheck(address, MemAccess::WORD, before);
        fRegisters[loadRegInd] = MemoryUnit(value);

    }

    return before;
}



BeforeData AssemblySimulator::efficientDoStore(const uint8_t &opcode, const Instruction &instruction){
    uint32_t address = instruction.immediate;
    address += static_cast<uint32_t>(iRegisters[instruction.regInd[1]]);

    uint32_t beforeAddress = (address/4)*4; // 4バイトアラインする
    BeforeData before = {pc, false, -1, -1, true, beforeAddress, readMem(beforeAddress, MemAccess::WORD), instruction.opcodeInt};

    int regInd = instruction.regInd[0];
    uint32_t value = (opcode & 0b1) == 0 ? iRegisters[regInd] : fRegisters[regInd].i;
    MemAccess memAccess = MemAccess::WORD;
    if(opcode & 0b10){
        // sbの時
        value &= 0xff;
        memAccess = MemAccess::BYTE;        
        before.changeCash = false;
        if(address == MMIO_SEND){
            // MMIOとして扱う
            before.writeMem = false;
            before.isMMIO = true;
            before.MMIOvalid = false;
            before.MMIOsend = true;
            mmio.send(static_cast<char>(value));
            return before;
        }else if(address >= MMIO_RECV && address < MMIO_SEND ){
            launchError(ILEGAL_MEM_WRITE);
        }
    }else if((address > (MMIO_VALID - WORD_BYTE_N))&& address <= MMIO_SEND){
        launchError(ILEGAL_MEM_WRITE);
    }else{
        before.isNewAccess = wordAccessCheck(address);
        before.newAccessAddress = address;
    }
    writeMemWithCacheCheck(address, memAccess, value, before);
    return before;
}

// 書き込み，読み込みをするレジスタの種類が違う命令
BeforeData AssemblySimulator::efficientDoMix(const uint8_t &opcode, const Instruction &instruction){
    int targetReg = instruction.regInd[0];
    BeforeData ans = {pc, false, targetReg, 0u, false, 0u, 0u, instruction.opcodeInt};

    if(opcode & 0b1){
        // 書き込み先は整数レジスタ
        ans.isInteger = true;
        ans.regValue = iRegisters[targetReg];
        if(opcode & 0b100){
            // fle
            writeReg(targetReg, fpu.fle(fRegisters[instruction.regInd[1]].i, fRegisters[instruction.regInd[2]].i), true);
        }else{
            if(opcode & 0b10){
                //lui

                iRegisters[targetReg] = instruction.immediate & (~0xfff);

            }else{
                // ftoi
                int32_t value = fpu.ftoi(fRegisters[instruction.regInd[1]].i);
                writeReg(targetReg, value, true);
            }
        }
        return ans;
    }else{
        // itof
        ans.isInteger = false;
        ans.regValue = fRegisters[targetReg].si;
        uint32_t ansInt = fpu.itof(static_cast<uint32_t>(iRegisters[instruction.regInd[1]]));
        writeReg(targetReg, ansInt, false);
        return ans;
    }

}

// 高速化した命令処理
BeforeData AssemblySimulator::efficientDoInst(const Instruction &instruction){
    uint8_t opcode = instruction.opcodeInt;
    // efficientOpCounter[opcode] = efficientOpCounter[opcode] + 1;

    const uint8_t opKind = opcode & OPKIND_MASK;
    const uint8_t opFunct = opcode >> OPKIND_BIT_N;
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
            ans =  efficientDoControl(opFunct, instruction);
            ++instCount;
            return ans;
        case 0b011:
            // 制御J, I
            ans =  efficientDoJump(opFunct, instruction);
            ++instCount;
            return ans;
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

    ++instCount;
    incrementPC();
    return ans;
}

// ワードアクセスする際にどこにアクセスしたかを記録しておく
bool AssemblySimulator::wordAccessCheck(const uint32_t &address){
    uint32_t ind = address / WORD_BYTE_N;
    if(!(*wordAccessCheckMem)[ind]){
        (*wordAccessCheckMem)[ind] = true;
        ++wordAccessCheckN;
        return true;
    }
    return false;
}

#endif