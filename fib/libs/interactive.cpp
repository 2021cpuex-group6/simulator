#include "utils.hpp"
#include "interactive.hpp"
#include <iostream>
#include <vector>

InteractiveShell::InteractiveShell(const AssemblySimulator & sim): simulator(sim){}

void InteractiveShell::start(){
    std::pair<Command, std::vector<int>> input;

    while(true){
        while (true){
            // 正しい入力が入るまでループ
            input = getInput();
            if(input.first != Command::Invalid){
                break;
            }
            std::cout << INVALID_COMMAND << std::endl;
        }

        switch(input.first){
            case Command::DoAll:
                simulator.launch();
                simulator.printRegisters(NumberBase::DEC, true);
                simulator.printOpCounter();
                break;
            case Command::DoNext:
                simulator.next();
                break;
            case Command::DoNextBreak:
                simulator.doNextBreak();
                break;
            
        }

    }



}

std::pair<Command, std::vector<int>> InteractiveShell::getInput(){
    // 入力を受け取り、それをパースする
    std::string inputString;
    std::cout << ">" ;
    if(!(std::cin >> inputString)){
            return {Command::Invalid, {}};
    }

    if(inputString == COMMAND_DO_ALL){
        return {Command::DoAll, {}};
    }else if(inputString == COMMAND_NEXT_BLOCK){
        return {Command::DoNextBreak, {}};
    }else if(inputString == COMMAND_NEXT){
        return {Command::DoNext, {}};
    }

    return {Command::Invalid, {}};
    

    
}

