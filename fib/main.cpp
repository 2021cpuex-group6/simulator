#include "sims/parser.hpp"
#include "sims/simulator.hpp"
#include "sims/interactive.hpp"
#include <iostream>
#include <cmath>
#include <regex>

const std::string LACK_ARGUMENT = "引数にアセンブリファイルを入力してください";                                                                                                           
const std::string OPTION_ALL = "-a";
const std::string OPTION_BIN = "-b";
const std::string OPTION_GUI = "-g";

int main(int argc, char* argv[]){
    // bool doAll = false; //対話型にせず全実行するか
    bool useBin = false; //バイナリを使うかアセンブリか
    bool forGUI = false; // GUI用の出力か
    std::vector<std::string> fileNames;

    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
    }
    int optionN = 1;
    while(optionN < argc){
        std::string arg = argv[optionN++];
        if(arg == OPTION_ALL){
            // doAll = true;
        }else if(arg == OPTION_BIN){
            useBin = true;
        }else if(arg == OPTION_GUI){
            forGUI = true;                
        }else{
            fileNames.emplace_back(arg);
        }
    }

    try{
        AssemblyParser parser(fileNames, useBin, forGUI);
        AssemblySimulator simulator(parser, useBin, forGUI);

        InteractiveShell shell(simulator, parser, forGUI);
        shell.start();
    }catch(const std::exception &e){
        if(forGUI){
            std::cout << GUI_ERROR << std::endl;
            std::cout << e.what() << std::endl;
        }else{
            std::cout << e.what() << std::endl;
        }
    }
    // simulator.launch();
    // simulator.printRegisters(NumberBase::DEC, true);
    // simulator.printOpCounter();

}