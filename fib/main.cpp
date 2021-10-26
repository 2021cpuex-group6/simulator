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
    bool doAll = false; //対話型にせず全実行するか
    bool useBin = false; //バイナリを使うかアセンブリか
    bool forGUI = false; // GUI用の出力か

    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
    }else if(argc >= 3){
        int optionN = argc - 2;
        while(optionN>0){
            std::string option = argv[2+(--optionN)];
            if(option == OPTION_ALL){
                doAll = true;
            }else if(option == OPTION_BIN){
                useBin = true;
            }else if(option == OPTION_GUI){
                forGUI = true;                
            }
        }
    }
    std::string fileName = argv[1];

    AssemblyParser parser(fileName, useBin, forGUI);
    AssemblySimulator simulator(parser, useBin, forGUI);

    InteractiveShell shell(simulator, parser, forGUI);
    shell.start();
    delete simulator.dram;
    // simulator.launch();
    // simulator.printRegisters(NumberBase::DEC, true);
    // simulator.printOpCounter();

}