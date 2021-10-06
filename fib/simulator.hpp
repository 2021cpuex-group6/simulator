#ifndef SIMULATOR_H
#define SIMULATOR_H

#include "parser.hpp"
#include <array>

constexpr int REGISTERS_N = 32;
constexpr int PRINT_REGISTERS_COL = 4;
constexpr size_t REGISTER_BIT_N = 32;

enum class NunmberBase{
    BIN = 2, 
    OCT = 8, 
    DEC = 10, 
    HEX = 16
};

class AssemblySimulator{
    public:
        std::array<int, REGISTERS_N> registers;
        int pc; //pcはメモリアドレスを表すので、アセンブリファイルの行数-1の4倍

        const AssemblyParser parser;
        AssemblySimulator(const AssemblyParser& parser);
        void printRegisters(const NunmberBase&, const bool &sign);
        void launch();
    
    // private:
        std::string getRegisterInfoUnit(const int&, const NunmberBase&, const bool &sign);
};

#endif