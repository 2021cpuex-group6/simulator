#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "parser.hpp"
#include <array>
#include <set>
constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;
constexpr int INST_BYTE_N = 4;
constexpr int WORD_BYTE_N = 4;
constexpr int PRINT_INST_COL = 2;
constexpr int PRINT_INST_NUM_SIZE = 6;
constexpr int HISTORY_RESERVE_N = 1024;
constexpr int SHIFT_MASK5 = 0b11111;
constexpr int MEM_BYTE_N = 0x1000000; //メモリのバイト数 2^12
constexpr int MEM_ADDRESS_HEX_LEN = 8;

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
    HEX = 16
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
};


class AssemblySimulator{
    public:
        bool useBinary = false;
        bool onWarning = true;
        bool forGUI;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍
        uint32_t fcsr; //浮動小数点演算の状態管理　いらないかも
        bool end; //終了フラグ
        const AssemblyParser &parser;
        std::array<int, REGISTERS_N> iRegisters;
        std::array<MemoryUnit, REGISTERS_N> fRegisters;

        int instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計
        std::set<int> breakPoints; // ブレークポイントの集合　行数で管理（1始まり）

        int historyN;   // 現在保持している履歴の数
        int historyPoint; // 次に履歴を保存するインデックス
        std::array<BeforeData, HISTORY_RESERVE_N> beforeHistory; // もとに戻れるようにデータをとる
        std::array<MemoryUnit, MEM_BYTE_N / WORD_BYTE_N> *dram;  
        
        AssemblySimulator(const AssemblyParser& parser, const bool &useBin, const bool &forGUI);
        ~AssemblySimulator();
        void printRegisters(const NumberBase&, const bool &sign, const bool& useFnotation) const;
        void printOpCounter()const;
        void next(bool, const bool&);
        void doNextBreak();
        void launch();
        void printInstruction(const int &, const Instruction &)const;
        void printBreakList()const;
        void printDif(const BeforeData &before, const bool &back)const;
        void setBreakPoint(const int &);
        void deleteBreakPoint(const int &);
        static std::pair<int, bool> getRegInd(const std::string &regName);
        void writeReg(const int &, const int32_t &, const bool &);
        void reset();
        void addHistory(const BeforeData &);
        void back();
        uint32_t readMem(const uint32_t& address, const MemAccess &memAccess)const;
        void writeMem(const uint32_t& address, const MemAccess &MemAccess, const uint32_t value);
        BeforeData popHistory();

    // private:
        int getIRegIndWithError(const std::string &regName)const;
        int getFRegIndWithError(const std::string &regName)const;
        std::pair<int, bool> getRegIndWithError(const std::string &regName)const;
        BeforeData doInst(const Instruction &);
        void launchError(const std::string &message)const;
        void launchWarning(const std::string &message)const;
        void doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1);
        void doFALU(const std::string &opcode, const int &targetR, const uint32_t &source0, const uint32_t &source1);
        BeforeData doLoad(const std::string &opcode, const Instruction &instruction);
        BeforeData doStore(const std::string &opcode, const Instruction &instruction);
        BeforeData doControl(const std::string &opcode, const Instruction &instruction);
        void incrementPC();
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &isInteger) const ;
        std::string getIRegisterInfoUnit(const int&, const NumberBase&, const bool &sign) const ;
        std::string getFRegisterInfoUnit(const int&, const NumberBase&, const bool &sign, const bool &useFNotaion) const ;
        std::string getMemWordString(const uint32_t &address)const;
        void printMem(const uint32_t &address, const uint32_t &wordN, const int &lineN)const;
        std::string getSeparatedWordString(const uint32_t &value)const;
};

#endif