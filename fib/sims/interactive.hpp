#ifndef INTERACTIVE_H
#define INTERACTIVE_H

#include "simulator.hpp"
#include <vector>

constexpr int MEM_PRINT_LINE_CLI = 4;
constexpr int MEM_PRINT_LINE_GUI = 8;


const std::string COMMAND_DO_ALL = "a";
const std::string COMMAND_NEXT_BLOCK = "nb";
const std::string COMMAND_NEXT = "n";
const std::string COMMAND_BREAK_SET = "bs";
const std::string COMMAND_BREAK_LIST = "bl";
const std::string COMMAND_BREAK_DELETE = "bd";
const std::string COMMAND_CACHE = "c";
const std::string COMMAND_REG_READ = "rr";
const std::string COMMAND_REG_WRITE = "rw";
const std::string COMMAND_BACK = "ba";
const std::string COMMAND_RESET = "re";
const std::string COMMAND_INFO = "i";
const std::string COMMAND_QUIT = "quit";
const std::string COMMAND_MEM_READ = "mr";
// const std::string GUI_ERROR = "Error";

enum class Command{
    DoAll, 
    DoNextBreak, 
    DoNext, 
    BreakSet, 
    BreakList,
    BreakDelete,  
    CacheInfo,
    RegRead, 
    RegWrite, 
    Back, 
    Reset,  // 初期状態へ
    Info, //統計データを見る
    MemRead,
    Quit,
    Invalid
};


class InteractiveShell
{


private:
    /* data */
    bool forGUI;
    std::pair<int, int> getRROptionInput(std::string)const;
    std::pair<int, bool> getRRRegisterInput(std::string)const;
    std::pair<Command, std::vector<int>> getRRInput(const std::string &) const;
    std::pair<Command, std::vector<int>> getRWInput(const std::string &) const;
    std::pair<Command, std::vector<int>> getBDInput(const std::string &) const;
    std::pair<Command, std::vector<int>> getMRInput(const std::string &) const;
    void printGUIError(const std::string &message)const;
    void interactiveErrorWithGUI(const std::string &message)const;
public:
    AssemblySimulator &simulator;
    AssemblyParser &parser;

    InteractiveShell(AssemblySimulator& sim, AssemblyParser& pars, const bool &forGUI);
    void start();
    std::pair<Command, std::vector<int>> getInput()const;


};



#endif