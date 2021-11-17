#include "sims/parser.hpp"
#include "sims/simulator.hpp"
#include "sims/interactive.hpp"
#include "sims/mmio.hpp"
#include <iostream>
#include <cmath>
#include <regex>

const std::string LACK_ARGUMENT = "引数にアセンブリファイルを入力してください";                                                                                                           
const std::string INVALID_CASH_WAY = "ウェイ数が不適切です．";    
const std::string OPTION_ALL = "-a";
const std::string OPTION_BIN = "-b";
const std::string OPTION_GUI = "-g";
const std::string OPTION_CASH = "-c";

int main(int argc, char* argv[]){
    // bool doAll = false; //対話型にせず全実行するか
    bool useBin = false; //バイナリを使うかアセンブリか
    bool forGUI = false; // GUI用の出力か
    int cacheWay = 1;
    std::vector<std::string> fileNames;

    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
        return -1;
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
        }else if(startsWith(arg, OPTION_CASH)){    
            cacheWay = std::stoi(arg.substr(2));
            if(!isPowerOf2(cacheWay, CASH_SIZE)){
                // ウェイ数が2べきではない
                std::cout << INVALID_CASH_WAY << std::endl;
            }
        }else{
            fileNames.emplace_back(arg);
        }
    }

    try{
        MMIO mmio;
        AssemblyParser parser(fileNames, useBin, forGUI);
        AssemblySimulator simulator(parser, useBin, forGUI, cacheWay, mmio);

        InteractiveShell shell(simulator, parser, forGUI);
        shell.start();
        mmio.outputPPM();
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