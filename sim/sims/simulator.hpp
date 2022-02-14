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
#include <algorithm>

constexpr int REGISTERS_N = 64;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;
constexpr int WORD_BIT_N = 2;

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
constexpr int32_t DATA_START = 0x100000; // データの始まるアドレス (2^20)
constexpr int EXPECT_MISS_PENALTY = 2;
constexpr int MAX_STALL_N = 3;

// MMIOのアドレス．
// この順でかつ3つのアドレスが連続していれば自由に変更可能．
constexpr int32_t MMIO_VALID = DATA_START - 3; // MMIOのvaildのアドレス
constexpr int32_t MMIO_RECV = DATA_START - 2; // MMIOの受信アドレス
constexpr int32_t MMIO_SEND = DATA_START - 1; // MMIOの送信アドレス

//キャッシュの定数
constexpr int CACHE_MAX_SIZE = 0x40000; // キャッシュの最大行数　これ以下の2べきの数でキャッシュの行数を決められる

// 浮動小数点テーブル
constexpr uint32_t FLOAT_TABLE_START = 0x200000;
constexpr uint32_t FLOAT_TABLE_RANGE = 256;
constexpr uint32_t FLOAT_TABLE_END = FLOAT_TABLE_START + FLOAT_TABLE_RANGE;
constexpr uint32_t FLOAT_TABLE_MASK = 0b11111100;

// デバッグ用
static const std::string PROF_FOLDER = "prof/";
static const std::string PROF_DATA = "programData";
static const std::string PROF_PARAM_EXT = ".param";


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
const std::string FOUND_DIF = "差異を検出しました．";
const std::string FOUND_BEFORE = "元ファイル該当箇所";
const std::string FOUND_AFTER = "現ファイル該当箇所";

const std::string DIF_EXTENSION = ".dif";
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
    uint32_t tag; //tagを保存
    bool valid;
    bool used; // 擬似LRU用

};


// 前回の状態に戻すのに必要なデータ
struct BeforeData{
    int pc;
    int regInd;  //書き込んだレジスタ。書き込みナシなら-1
    int32_t regValue;
    bool writeMem; //メモリに書き込んだか
    uint32_t memAddress; // 書き込んだアドレス
    uint32_t memValue;
    uint8_t opcodeInt; // 高速化時の命令データ
    bool useMem; // メモリを使ったか (hit, miss数の復元に必要)
    bool changeCache; // キャッシュが変更されたか == ミスしたか
    uint32_t cacheAddress; // 書き換えたキャッシュのアドレス
    CacheRow cacheRow; // 前のキャッシュデータ
    bool isMMIO; //MMIOを使ったか
    bool MMIOvalid; //valid bitを見ただけか
    bool MMIOsend; // sendか
    bool isNewAccess; // 新しくアクセスするアドレスにアクセスしたか(memCheck用)
    uint32_t newAccessAddress; // そのアドレス(wordAccessCheckMemのインデックスではないので4で割る)
    bool clearLRU; // LRU用のusedbitをクリアしたか
    bool jumpToLabel; // ラベルにジャンプしたか
    // bool isHazard; //　ハザードが発生したか
    // bool hazardForIntReg; // ハザードが整数レジスタで起きたか 
    // int loadRegInd; // ハザードが起きたレジスタのインデックス
};

// キャッシュのクラス
class Cache{
    public:


    static constexpr int READ = 0;
    static constexpr int WRITE = 1;
    static constexpr int TYPES_N = 2;

    CacheRow cache[CACHE_MAX_SIZE]; // キャッシュ
    uint32_t cacheWay; //ウェイ数
    uint32_t offsetLen; // メモリアドレスのうちのオフセット長．この2べきがキャッシュ一行のデータのバイト数
    uint32_t tagLen;    // タグ長
    uint32_t indexLen;  // インデックス長
    uint32_t cacheIndexN; // キャッシュのインデックス数 (cacheSize / cacheWay)

    int32_t cacheSize; // 実際に使われるcacheの行数
                        // キャッシュの総行数(インデックス数*ウェイ数)　２べきにすること

    uint64_t hitN[TYPES_N];
    uint64_t initMissN[TYPES_N];
    uint64_t otherMissN[TYPES_N];

    Cache(const uint32_t &cacheWay, const uint32_t &offsetLen,
         const uint32_t &tagLen);
    void reset();
    inline bool clearLRUIfNecessary(const uint32_t &address);
    inline void writeCashBeforeData(const bool &forWrite,
         const uint32_t& address, BeforeData &beforeData, 
         const std::array<bool, MEM_BYTE_N / WORD_BYTE_N> *wordAccessCheckMem);
    void printCacheSystem()const;
    void backCache(const BeforeData &beforeData);
    double calcStallN(const int &)const;
    void outputCacheInfo(std::ostream &stream)const;
    void inputCacheInfo(std::istream &stream);

    private:
    uint32_t indexMask;  // タグ長, オフセット長の長さに基づいて作られるマスク
    uint32_t indexTagMask; // インデックスとタグ部分をちょうど含むマスク
    
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
        bool end; //終了フラグ
        const AssemblyParser &parser;
        long lastPC = 0;
        MemoryUnit registers[REGISTERS_N];

        uint64_t instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計
        std::map<uint8_t, uint64_t> efficientOpCounter; // uint8_t ver
        uint64_t expectMissN; // 分岐予測失敗数(jも含む)
        uint64_t hazardStallN; // ハザードによるストールが起きた回数
        std::unordered_set<int32_t> breakPoints; // ブレークポイントの集合　行数で管理（1始まり）

        int historyN;   // 現在保持している履歴の数
        int historyPoint; // 次に履歴を保存するインデックス
        std::array<BeforeData, HISTORY_RESERVE_N> beforeHistory; // もとに戻れるようにデータをとる
        std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N> *dram;
        int64_t wordAccessCheckN;      // ワードアクセスされた箇所の総数
        std::array<bool, MEM_BYTE_N / WORD_BYTE_N> *wordAccessCheckMem;  //どこにアクセスされたか
        std::array<uint64_t, FLOAT_TABLE_RANGE / WORD_BYTE_N> floatTableAccessMem; // 浮動小数点テーブルでのアクセス回数を保持

        FPU fpu;
        std::map<uint8_t, std::string> inverseOpMap; // uint8_tのopcodeから文字列へ変換

        MMIO mmio;
        Cache cache;

        std::map<uint32_t, uint64_t> jumpedLabelCount; // キーのアドレスにjal, branchで飛んだ回数を記録
        
        AssemblySimulator(const AssemblyParser& parser, const bool &useBin,
             const bool &forGUI, const MMIO &mmio, const uint32_t &cacheWay, const uint32_t &offsetLen,
             const uint32_t &tagLen);
        ~AssemblySimulator();
        void printRegisters(const NumberBase&, const bool &sign, const bool& useFnotation) const;
        void printOpCounterWithParam(std::ostream &stream, const bool &GUIMode)const;
        void printOpCounter()const;
        void next(bool, const bool&);
        void doNextBreak();
        void launch(const bool &);
        void launchFast(const bool &);
        static void flowInstByRegInd(const int & lineN, const Instruction &instruction, std::ostream &stream);
        static void printInstByRegInd(const int & lineN, const Instruction &instruction);
        static void printInstruction(const int &, const Instruction &);
        void printInstructionInSim(const int &, const Instruction &)const;
        void printBreakList()const;
        void printDif(const BeforeData &before, const bool &back, const std::string &opcode)const;
        void flowDif(const BeforeData &before, const bool &back, const std::string &opcode,  std::ostream &stream)const;
        std::pair<bool, int32_t> translateBreakInd(const int &)const;
        void setBreakPoint(const int &);
        void deleteBreakPoint(const int &);
        static std::pair<int, bool> getRegInd(const std::string &regName);
        inline void writeReg(const int &regInd, const int32_t &value){
            if(regInd < REGISTERS_N){
                if(regInd == 0 && !forGUI){
                        // 0レジスタへの書き込み
                        // std::cout << ZERO_REG_WRITE_ERROR << std::endl;
                        return;
                }
                registers[regInd] = MemoryUnit(value);
            }else{
                if(value % INST_BYTE_N != 0  && !forGUI){
                    // アラインに合わない値が入力されているので注意
                    std::cout << PC_NOT_ALIGNED_WRITE << std::endl;
                }
                pc = value;
            }
        }
        void reset();
        void addHistory(const BeforeData &);
        void back();
        
        inline uint32_t readMem(const uint32_t& address, const MemAccess &memAccess)const;
        inline uint32_t readMemWithCacheCheck(const uint32_t& address, const MemAccess &memAccess, BeforeData &beforeData);
        inline void writeMem(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value);
        inline void writeMemWithCacheCheck(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value, BeforeData &beforeData);
        BeforeData popHistory();
        void checkDif();
        void makeDif(const std::string &path);
        void printFloatTableAccessRanking(const unsigned int &printN);

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
        inline int checkHazard(const int &regInd1, const int &regInd2);

        int getIRegIndWithError(const std::string &regName)const;
        int getFRegIndWithError(const std::string &regName)const;
        std::pair<int, bool> getRegIndWithError(const std::string &regName)const;
        void launchError(const std::string &message)const;
        void launchWarning(const std::string &message)const;
        inline void incrementPC();
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &useFNotation) const ;
        std::string getMemWordString(const uint32_t &address)const;
        void printMem(const uint32_t &address, const uint32_t &wordN, const int &lineN)const;
        std::string getSeparatedWordString(const uint32_t &value)const;
        double calculateTime();
        void printCalculatedTime();
        void printAccessedAddress(); // アクセスされたアドレスを全表示
        void printJumpLabelRanking(const unsigned int &printN); // ジャンプしたアドレスを回数順に表示
        void outputProfile();
        void inputProfileFromFiles(std::string &dataPath, std::string &paramPath);
        void inputProfile();
};

// 以下，inline関数
// LRUbitが全部立っていたらクリア
// address は直前に埋めたアドレス
bool Cache::clearLRUIfNecessary(const uint32_t &address){
    uint32_t cacheAddress = (address / cacheWay) * cacheWay;
    for(uint32_t i  = 0; i < cacheWay; ++i){
        CacheRow nowRow = cache[cacheAddress];
        if(!nowRow.used) return false;
    }
    // 全部usedbitが立っているのでクリア
    for(uint32_t i  = 0; i < cacheWay; ++i){
        cache[cacheAddress].used = false;
    }
    cache[address].used = true;
    return true;
}
// メモリにアクセスする際に，cash系のbeforeDataを書き込み，キャッシュデータを書き込む
void Cache::writeCashBeforeData(const bool &forWrite, const uint32_t& address,
     BeforeData &beforeData, const std::array<bool, MEM_BYTE_N / WORD_BYTE_N> *wordAccessCheckMem){
    int type = forWrite ? WRITE : READ;
    beforeData.useMem = true;
    uint32_t index = shiftRightLogical(address, offsetLen);
    index &= indexMask;
    uint32_t cacheAddress = index * cacheWay;

    bool foundLRU = false; //置き換えの対象を見つけたか
    uint32_t cacheLRUAddress = cacheAddress; // 競合時置き換えの対象となるアドレス

    uint32_t tag = shiftRightLogical(address, REGISTER_BIT_N - tagLen); // タグ　これがあっていればヒット
    for(uint32_t i  = 0; i < cacheWay; ++i){
        // 常に先頭から見て先頭から埋めるので，validじゃないものが現れた時点で後ろもvalidじゃない
        CacheRow nowRow = cache[cacheAddress];
        if(!nowRow.valid ){
            beforeData.cacheRow = cache[cacheAddress];
            beforeData.cacheAddress = cacheAddress;
            beforeData.changeCache = true;

            // wordAccessCheckを前にしておくのでこれが使える
            ++initMissN[type];
            
            CacheRow newRow = {tag, true, true};
            cache[cacheAddress] = newRow;
            beforeData.clearLRU = clearLRUIfNecessary(index);
            return;
        }
        if(nowRow.tag == tag){
            // ヒット
            ++hitN[type];
            cache[cacheAddress].used = true;
            beforeData.changeCache = false;
            beforeData.clearLRU = clearLRUIfNecessary(index);
            return;
        }
        if(!foundLRU && !nowRow.used){
            foundLRU = true;
            cacheLRUAddress = cacheAddress;
        }
        ++cacheAddress;
    }
    // キャッシュが競合
    // 擬似LRUに基づくアドレスへ
    cacheAddress = cacheLRUAddress;
    
    beforeData.cacheRow = cache[cacheAddress];
    beforeData.cacheAddress = cacheAddress;
    beforeData.changeCache = true;

    bool isNewAccess = true;
    // 初期参照ミスの定義による
    // 各ワードごとに初期参照かを考えるのであれば以下
    // isNewAccess = beforeData.isNewAccess
    // キャッシュブロックごとに初期参照かを考える場合
    uint32_t wordAccessCheckAddress = 
        shiftRightLogical(address & indexTagMask, WORD_BIT_N);
    uint32_t checkN = (1 << (offsetLen-WORD_BIT_N));
    for(uint32_t i = 0; i < checkN; i++){
        if((*wordAccessCheckMem)[wordAccessCheckAddress]){
            isNewAccess = false;
            break;
        }
    }

    if(isNewAccess){
        ++initMissN[type];
    }else{
        ++otherMissN[type];
    }

    CacheRow newRow = {tag, true, true};
    cache[cacheAddress] = newRow;
    beforeData.clearLRU = clearLRUIfNecessary(index);
    return;
}



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
    if(memAccess == MemAccess::WORD){
        beforeData.isNewAccess = wordAccessCheck(address); // cashの書き込みでここのデータを使うので，書き込みはその前に
        beforeData.newAccessAddress = address;
    }
    cache.writeCashBeforeData(false, address, beforeData, wordAccessCheckMem);
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
    if(MemAccess == MemAccess::WORD){
        beforeData.isNewAccess = wordAccessCheck(address);
        beforeData.newAccessAddress = address;
    }
    cache.writeCashBeforeData(true, address, beforeData, wordAccessCheckMem);
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
            ans = registers[targetR].si;break;
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
    writeReg(targetR, ans);
}

void AssemblySimulator::efficientDoFALU(const uint8_t &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1){
    uint32_t ans = 0;
    MemoryUnit mu;
    MemoryUnit mu0, mu1;
    switch(opcode){
        case 0b00:
            ans = fpu.fadd(source0, source1); break;
        case 0b00001:
            ans = fpu.fmul(source0, source1); break;   
        case 0b00010:
            ans = fpu.fdiv(source0, source1); break;
        case 0b00100:
            ans = fpu.fsub(source0, source1); break;
        case 0b01000:
            ans = fpu.fle(source0, source1); break;
        case 0b01001:
            ans = fpu.feq(source0, source1); break;
        case 0b10000:
            ans = fpu.fsqrt(source0); break;
        case 0b10100:
            ans = fpu.floor2(source0);
            break;
        case 0b10010:
            ans = fpu.itof(source0); break;
        case 0b10001:
            ans = fpu.ftoi(source0); break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }

    registers[targetR] = MemoryUnit(ans);
}


// 制御系の命令で，ジャンプするときの処理
BeforeData AssemblySimulator::efficientDoJump(const uint8_t &opcode, const Instruction &instruction){
    BeforeData ans = {pc, -1, -1, false, 0, 0, instruction.opcodeInt};
    if((opcode & 0b10)){
        // レジスタへの書き込み (jal, jalr)
        int writeRegInd = instruction.regInd[0];
        ans.regInd = writeRegInd;
        ans.regValue = registers[writeRegInd].si;
        writeReg(writeRegInd, pc+INST_BYTE_N);
    }
    int nextPC = instruction.immediate;
    if((opcode & 0b1)){
        // レジスタを使う (jalr, jr)
        // 即値とレジスタの値を足して最下位ビットを0にした値がジャンプ先
        // しかしこのシミュレータは4バイトの固定長命令を使うことを暗に仮定しているので、もう1ビットも0にする
        // レジスタから読み込むのでWARハザードを起こす可能性あり
        if(opcode & 0b10){
            // jalr
            nextPC += registers[instruction.regInd[1]].si;
            checkHazard(-1,instruction.regInd[1]);
        }else{
            nextPC += registers[instruction.regInd[0]].si;
            checkHazard(instruction.regInd[0], -1);
        }
        nextPC &= (~0) << 2;
        pc = nextPC;

    }else{
        // 即値ジャンプ
        uint32_t jumpAddress = static_cast<uint32_t>(instruction.immediate + pc);
        auto count = jumpedLabelCount.find(jumpAddress);
        if(count != jumpedLabelCount.end()){
            // もう何度かjump済
            jumpedLabelCount[jumpAddress] = count->second + 1;
        }else{
            jumpedLabelCount[jumpAddress] = 1;
        }
        ans.jumpToLabel = true;
        pc += instruction.immediate;
    }
    if(ans.pc + INST_BYTE_N != pc){
        // 分岐予測失敗
        ++expectMissN;
    }
    return ans;
}

// 制御系の命令実行
// 次命令がpc+4かは不明なのでここでpcの更新をする
BeforeData AssemblySimulator::efficientDoControl(const uint8_t &opcode, const Instruction &instruction){
    int reg0 = registers[instruction.regInd[0]].si;
    int reg1 = registers[instruction.regInd[1]].si;
    checkHazard(instruction.regInd[0], instruction.regInd[1]);
    bool jumpFlag;
    switch(opcode){
        case 0b001:
            jumpFlag = reg0 < reg1; break;
        case 0b010:
            jumpFlag = reg0 == reg1; break;
        case 0b100:
            jumpFlag = reg0 != reg1; break;
        case 0b1000:
            jumpFlag = reg0 >= reg1; break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }
    if(jumpFlag){
        // j命令と同じ
        return efficientDoJump(0b0000, instruction);
    }else{
        BeforeData ans = {pc, -1, -1, false, 0, 0, instruction.opcodeInt};
        incrementPC();
        return ans;
    }
}


BeforeData AssemblySimulator::efficientDoLoad(const uint8_t &opcode, const Instruction &instruction){
    // ロード命令を実行
    uint32_t address = instruction.immediate;
    address +=registers[instruction.regInd[1]].i;
    checkHazard( -1, instruction.regInd[1]); // アドレスの値を読むときにハザードの可能性

    int32_t loadRegInd = instruction.regInd[0];
    int32_t beforeValue = registers[loadRegInd].si;
    BeforeData before = { pc, loadRegInd, beforeValue, false, 0u, 0u, instruction.opcodeInt};

    if(opcode & 0b1){
        // lw
        uint32_t value = readMemWithCacheCheck(address, MemAccess::WORD, before);
        writeReg(loadRegInd, value);
    }else{
        // lbu
        if(address == MMIO_RECV){
            // MMIOとして扱う
            before.isMMIO = true;
            before.MMIOvalid = false;
            before.MMIOsend = false;
            int32_t val = 0;
            if(mmio.valid) val = 0xff & static_cast<int32_t>(mmio.recv());
            writeReg(loadRegInd, ((~0xff) &registers[loadRegInd].i) |val);
        }else if(address == MMIO_VALID){
            before.isMMIO = true;
            before.MMIOvalid = true;
            int32_t val = mmio.valid ? 1 : 0;
            writeReg(loadRegInd, ((~0xff) & registers[loadRegInd].i) |val);
        }else{
            uint32_t value = readMemWithCacheCheck(address, MemAccess::BYTE, before);
            writeReg(loadRegInd, ((~0xff) & registers[loadRegInd].i) | value);
        }
    }
    

    return before;
}



BeforeData AssemblySimulator::efficientDoStore(const uint8_t &opcode, const Instruction &instruction){
    uint32_t address = instruction.immediate;
    address += registers[instruction.regInd[1]].i;

    uint32_t beforeAddress = (address/4)*4; // 4バイトアラインする
    BeforeData before = {pc, -1, -1, true, beforeAddress, readMem(beforeAddress, MemAccess::WORD), instruction.opcodeInt};

    int regInd = instruction.regInd[0];
    uint32_t value = registers[regInd].i;
    checkHazard(regInd , instruction.regInd[1]);
    MemAccess memAccess = MemAccess::WORD;
    if(opcode & 0b10){
        // sbの時
        value &= 0xff;
        memAccess = MemAccess::BYTE;        
        before.changeCache = false;
        if(address == MMIO_SEND){
            // MMIOとして扱う
            before.writeMem = false;
            before.isMMIO = true;
            before.MMIOvalid = false;
            before.MMIOsend = true;
            mmio.send(static_cast<char>(value), instCount);
            return before;
        }else if(address >= MMIO_RECV && address < MMIO_SEND ){
            launchError(ILEGAL_MEM_WRITE);
        }
    }else if((address > (MMIO_VALID - WORD_BYTE_N))&& address <= MMIO_SEND){
        launchError(ILEGAL_MEM_WRITE);
    }else{

    }
    writeMemWithCacheCheck(address, memAccess, value, before);
    return before;
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
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = registers[targetR].i;
            source0 = registers[instruction.regInd[1]].si;
            source1 = registers[instruction.regInd[2]].si;
            efficientDoALU(opFunct, targetR, source0, source1);
            checkHazard(instruction.regInd[1], instruction.regInd[2]);
            break;
        case 0b001:
            // 整数I
            targetR = instruction.regInd[0];
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = registers[targetR].si;
            source0 = registers[instruction.regInd[1]].si;
            source1 = instruction.immediate;
            efficientDoALU(opFunct, targetR, source0, source1);
            checkHazard(instruction.regInd[1], -1);
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
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = registers[targetR].si;
            sourceU0 = registers[instruction.regInd[1]].i;
            if(opFunct & 0b10000){
                // fsqrtなど，入力が１つ
                sourceU1 = 0;
                checkHazard(instruction.regInd[1], -1);
            }else{
                sourceU1 = registers[instruction.regInd[2]].i;
                checkHazard(instruction.regInd[1], instruction.regInd[2]);
            }
            
            efficientDoFALU(opFunct, targetR, sourceU0, sourceU1);
            break;
        case 0b111:
            // U
            targetR = instruction.regInd[0];
            ans.pc = pc;
            ans.writeMem = false;
            ans.regInd = targetR;
            ans.regValue = registers[targetR].si;
            registers[targetR].i = instruction.immediate & (~0x7ff);
            break;
        default:
            launchError(ILEGAL_INNER_OPCODE);
    }

    ++instCount;
    incrementPC();
    return ans;
}

// ワードアクセスする際にどこにアクセスしたかを記録しておく
// 浮動小数点テーブルへのアクセスかもここでチェック
// キャッシュで初期参照ミスかを調べるので，キャッシュへの記録の前にこれを行うこと
bool AssemblySimulator::wordAccessCheck(const uint32_t &address){
    if(FLOAT_TABLE_START <= address && address < FLOAT_TABLE_END){
        // 浮動小数点テーブルへのアクセス
        uint32_t floatInd = (address & FLOAT_TABLE_MASK) >> 2;
        floatTableAccessMem[floatInd] = floatTableAccessMem[floatInd] + 1;
        
    }
    uint32_t ind = address / WORD_BYTE_N;
    if(!(*wordAccessCheckMem)[ind]){
        (*wordAccessCheckMem)[ind] = true;
        ++wordAccessCheckN;
        return true;
    }
    return false;
}

// WARハザードが発生するかを調べる
// regIndが一つで十分なときは片方に-1をいれればよい
// loadの次にExのみになるならこれでよい(flwのときisIntに注意)
// bool AssemblySimulator::checkHazard(const bool & isInt, const int &regInd1, const int &regInd2){
//     BeforeData before = beforeHistory[(historyPoint-1 + HISTORY_RESERVE_N) % HISTORY_RESERVE_N];
//     bool hazard = false;
//     if((before.useMem && (!before.writeMem)) || (before.isMMIO && !before.MMIOsend)){
//         // 前がloadかMMIORecvか
//         if(isInt == before.isInteger){
//             // 使ったレジスタのタイプが同じ
//             hazard = regInd1 == before.regInd || regInd2 == before.regInd;
//             if(hazard) ++hazardStallN;
//         }        
//     }
//     return hazard;
// };

// 2ndのデータハザード検出
// 3つ前まで考えればOK
// 返り値はいくつのストールが発生するか
int AssemblySimulator::checkHazard(const int &regInd1, const int &regInd2){
    // 1つ前から見ていく → 厳しい条件から調べるので，一番ストールが長いものが出たらそこで打ち切ってよい
    int maxStall = 0; // すべての条件のうち，最も長いものが採用される
    for(int i = 1; i <= MAX_STALL_N; i++){
        int stallN = (MAX_STALL_N - i + 1);
        BeforeData before = beforeHistory[(historyPoint-i + HISTORY_RESERVE_N) % HISTORY_RESERVE_N];
        if(before.regInd > 0){
            if(before.regInd == regInd1 || before.regInd == regInd2){
                // かぶった
                // 前の命令別に場合分け
                uint8_t opcodeType = before.opcodeInt & 0b111;
                if(opcodeType == 0b0100){  
                    // メモリ 3つ前ならMA2からフォワーディングできる
                    maxStall = std::max(stallN -1, maxStall);
                    if(i > 1) goto LOOP_END; // この場合はこれ以上長いものが出ることはない
                }else if(opcodeType == 0b110){
                    // 浮動小数
                    switch((before.opcodeInt & 0b11111000 >> 3)){
                        case 0b10001:
                        case 0b01000:
                        case 0b01001:
                            // ftoi, fle, feq
                            // 2つ前までOK
                            maxStall = std::max(maxStall, stallN-2);
                            break;
                        case 0b00001:
                        case 0b10000:
                        case 0b10010:
                            // fmul, fsq, itof
                            // 1つ前まで
                            maxStall = std::max(maxStall, stallN-1);
                            if(i > 1) goto LOOP_END; // この場合はこれ以上長いものが出ることはない
                            break;
                        default:
                            // それ以外
                            // これ以上厳しい条件は出ないのでここで返してしまう
                            maxStall = std::max(maxStall, stallN);
                            goto LOOP_END;
                            
                    }
                }
                // 以上．ALUは前の命令からフォワーディング可
            }
        }
    }
    LOOP_END:
        hazardStallN += maxStall;
        return maxStall;
};


#endif