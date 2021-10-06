#ifndef INTERACTIVE_H
#define INTERACTIVE_H

#include "simulator.hpp"
#include <vector>

const std::string INVALID_COMMAND = "コマンドの書式が不正です";

const std::string COMMAND_DO_ALL = "a";
const std::string COMMAND_NEXT_BLOCK = "nb";
const std::string COMMAND_NEXT = "n";
const std::string COMMAND_BREAK_SET = "bs";
const std::string COMMAND_BREAK_LIST = "bl";
const std::string COMMAND_REG_READ = "rr";
const std::string COMMAND_REG_WRITE = "rw";
const std::string COMMAND_BACK = "ba";

enum class Command{
    DoAll, 
    DoNextBreak, 
    DoNext, 
    BreakSet, 
    BreakList, 
    RegRead, 
    RegWrite, 
    Back, 
    Invalid
};


class InteractiveShell
{


private:
    /* data */
public:
    AssemblySimulator simulator;

    InteractiveShell(const AssemblySimulator& sim);
    void start();
    std::pair<Command, std::vector<int>> getInput();

};



#endif