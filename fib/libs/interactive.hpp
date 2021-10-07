#ifndef INTERACTIVE_H
#define INTERACTIVE_H

#include "simulator.hpp"
#include <vector>

const std::string INVALID_COMMAND = "コマンドの書式が不正です";
const std::string INVALID_REG_NAME = "レジスタ名が不正です";
const std::string NOT_SELECTED_REGISTER = "レジスタを指定してください";
const std::string NOT_SPECIFIED_WRITE_VALUE = "書き込む値を指定してください";
const std::string NOT_IMPLEMENTED_UNSIGNED = "unsignedでの書き込みは未実装です";


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
    BreakDelete,  
    RegRead, 
    RegWrite, 
    Back, 
    Reset,  // 初期状態へ
    CountRead, //統計データを見る
    Invalid
};


class InteractiveShell
{


private:
    /* data */
    static std::pair<int, int> getRROptionInput(std::string);
    static int getRRRegisterInput(std::string);
    std::pair<Command, std::vector<int>> getRRInput(const std::string &) const;
    std::pair<Command, std::vector<int>> getRWInput(const std::string &) const;
public:
    AssemblySimulator simulator;
    AssemblyParser parser;

    InteractiveShell(const AssemblySimulator& sim, const AssemblyParser& pars);
    void start();
    std::pair<Command, std::vector<int>> getInput()const;


};



#endif