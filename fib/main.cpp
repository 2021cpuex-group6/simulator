#include "libs/parser.hpp"
#include "libs/simulator.hpp"
#include "libs/interactive.hpp"
#include <iostream>
#include <cmath>

const std::string LACK_ARGUMENT = "引数にアセンブリファイルを入力してください";

int main(int argc, char* argv[]){
    bool doAll = false; //対話型にせず全実行するか
    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
    }else if(argc == 3){
        std::string option = argv[2];
        if(option == "-a"){
            doAll = true;
        }
    }
    std::string fileName = argv[1];
    AssemblyParser parser(fileName);
    AssemblySimulator simulator(parser);

    InteractiveShell shell(simulator);
    shell.start();
    // simulator.launch();
    // simulator.printRegisters(NumberBase::DEC, true);
    // simulator.printOpCounter();

}