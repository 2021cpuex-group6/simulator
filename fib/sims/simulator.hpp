#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "parser.hpp"
#include <array>
#include <set>
constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;
constexpr int INST_BYTE_N = 4;
constexpr int PRINT_INST_COL = 2;
constexpr int PRINT_INST_NUM_SIZE = 6;
constexpr int HISTORY_RESERVE_N = 1024;

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

const std::string GUI_NO_HISTORY = "NoHis";
const std::string GUI_END = "End";
const std::string GUI_ALREADY_END = "AEnd";
const std::string GUI_STOP = "Stop";
const std::string GUI_WARNING = "Warning";
const std::string GUI_NO_CHANGE = "No";
const std::string GUI_ERROR = "Error";
enum class NumberBase{
    BIN = 2, 
    OCT = 8, 
    DEC = 10, 
    HEX = 16
};

// 前回の状態に戻すのに必要なデータ
struct BeforeData{
    std::string instruction;
    int pc;
    int regInd;  //書き込んだレジスタ。書き込みナシなら-1
    int regValue;
};


class AssemblySimulator{
    public:
        bool useBinary = false;
        bool forGUI = false;
        bool onWarning = true;
        std::array<int, REGISTERS_N> registers;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍
        bool end; //終了フラグ
        int instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計

        std::set<int> breakPoints; // ブレークポイントの集合　行数で管理（1始まり）
        int historyN;   // 現在保持している履歴の数
        int historyPoint; // 次に履歴を保存するインデックス
        std::array<BeforeData, HISTORY_RESERVE_N> beforeHistory; // もとに戻れるようにデータをとる
        const AssemblyParser parser;

        AssemblySimulator(const AssemblyParser& parser, const bool &useBin, const bool &forGUI);
        void printRegisters(const NumberBase&, const bool &sign) const;
        void printOpCounter()const;
        void next(bool, const bool&);
        void doNextBreak();
        void launch();
        void printInstruction(const int &, const Instruction &)const;
        void printBreakList()const;
        void printDif(const BeforeData &before, const bool &back)const;
        void setBreakPoint(const int &);
        void deleteBreakPoint(const int &);
        static int getRegInd(const std::string &regName);
        void writeReg(const int &, const int &);
        void reset();
        void addHistory(const BeforeData &);
        void back();
        BeforeData popHistory();

    // private:
        int getRegIndWithError(const std::string &regName)const;
        BeforeData doInst(const Instruction &);
        void launchError(const std::string &message)const;
        void launchWarning(const std::string &message)const;
        void doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1);
        BeforeData doControl(const std::string &opcode, const Instruction &instruction);
        void incrementPC();
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign) const ;
};

#endif