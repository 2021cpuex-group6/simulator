#include "utils.hpp"
#include "interactive.hpp"
#include <iostream>

InteractiveShell::InteractiveShell(const AssemblySimulator & sim): simulator(sim){}

void InteractiveShell::start(){

}

std::pair<Command, std::vector<int>> InteractiveShell::getInput(){
    // 入力を受け取り、それをパースする
    std::string inputString;
    std::cout << ">" << std::endl;
    if(!(std::cin >> inputString)){
            return {Command::Invalid, {}};
    }

    if(startsWith(inputString, COMMAND_DO_ALL)){

    }

    return {Command::Invalid, {}};
    

    
}

