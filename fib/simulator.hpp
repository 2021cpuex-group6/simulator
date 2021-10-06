#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "parser.hpp"
#include <array>

constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;
constexpr int INST_BYTE_N = 4;
constexpr int PRINT_INST_COL = 2;
constexpr int PRINT_INST_NUM_SIZE = 6;


const std::string FILE_END = "終了しました";
const std::string ALREADY_ENDED = "すでに終了しています";
const std::string INVALID_REGISTER = "レジスタ名が不正です";
const std::string ZERO_REG_WRITE_ERROR = "x0レジスタに書き込むことはできません";
const std::string NOT_FOUND_LABEL = "ラベルが見つかりません";
enum class NumberBase{
    BIN = 2, 
    OCT = 8, 
    DEC = 10, 
    HEX = 16
};

class AssemblySimulator{
    public:
        std::array<int, REGISTERS_N> registers;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍
        bool end; //終了フラグ
        int instCount; // 実行命令数
        std::map<std::string, int> opCounter; //実行命令の統計

        const AssemblyParser parser;
        AssemblySimulator(const AssemblyParser& parser);
        void printRegisters(const NumberBase&, const bool &sign) const;
        void printOpCounter()const;
        void next();
        void launch();


        void doInst(const Instruction &);
        int getRegInd(const std::string &regName);
        void launchError(const std::string &message);
        void doALU(const std::string &opcode, const int &targetR, const int &source0, const int &source1);
        void doControl(const std::string &opcode, const Instruction &instruction);
        void incrementPC();
    // private:
        std::string getRegisterInfoUnit(const int&, const NumberBase&, const bool &sign) const ;
};

#endif