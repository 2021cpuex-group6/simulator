#include "simulator.hpp"
#include <iostream>
#include <sstream>
#include <bitset>
#include <iomanip>


AssemblySimulator::AssemblySimulator(const AssemblyParser& parser): parser(parser), registers({0}), pc(0){}

void AssemblySimulator::printRegisters(){
    // レジスタの内容を表示
    
}

std::string AssemblySimulator::getRegisterInfoUnit(const int &regN, const NunmberBase &base, const bool &sign){
    // レジスタ番号を受け取り、その情報を文字列で返す
    std::stringstream ss;
    std::stringstream sin;
    std::stringstream ssreg;
    std::string regName;
    std::string prefix;

    if(regN < REGISTERS_N){
        ssreg << "x" << std::setw(2) << std::setfill('0') << std::dec << regN;
        regName = ssreg.str();
    }else{
        regName = "pc";
    }
    regName += " ";

    unsigned int  numSize = 0;
    switch (base){
        case NunmberBase::BIN :
            prefix = "0b";
            numSize = 32;
            sin << std::bitset<REGISTER_BIT_N>(registers[regN]);
            break;
        case NunmberBase::OCT :
            prefix = "0o";
            numSize = 11;
            sin << std::oct << registers[regN];
            break;
        case NunmberBase::HEX :
            prefix = "0x";
            numSize = 8;
            sin << std::hex << registers[regN];
            break;
        default :
            prefix = "";
            numSize = 10;
            if (sign){
                ss << regName  << std::setw(numSize) << std::internal << registers[regN];
            }else{
                ss << regName  << std::setw(numSize) << std::internal << (unsigned int) registers[regN];
            }

            
            return ss.str();
            break;
    }

    ss << regName <<  prefix << std::setw(numSize) << std::setfill('0') << sin.str();

    return ss.str();

}




