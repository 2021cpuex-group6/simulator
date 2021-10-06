#include "parser.hpp"
#include "simulator.hpp"
#include <iostream>
#include <cmath>

const std::string LACK_ARGUMENT = "引数にアセンブリファイルを入力してください";

int main(int argc, char* argv[]){
    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
    }
    AssemblyParser parser("fib.s");
    AssemblySimulator simulator(parser);
    simulator.launch();
    simulator.printRegisters(NumberBase::DEC, true);

}