#include "utils.hpp"
#include "interactive.hpp"
#include <iostream>
#include <vector>

InteractiveShell::InteractiveShell(const AssemblySimulator & sim, const AssemblyParser& parse): simulator(sim), parser(parse){}

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
                simulator.next(true, true);
                break;
            case Command::DoNextBreak:
                simulator.doNextBreak();
                break;
            case Command::BreakList:
                simulator.printBreakList();
                break;
            case Command::BreakSet:
                simulator.setBreakPoint(input.second[0]);
                break;
            case Command::RegRead:
                simulator.printRegisters(NumberBase::DEC, true);
                break;
        }

    }



}

std::pair<Command, std::vector<int>> InteractiveShell::getInput(){
    // 入力を受け取り、それをパースする
    std::string inputString;
    std::cout << ">" ;
    if(!(std::getline(std::cin, inputString))){
            return {Command::Invalid, {}};
    }

    if(inputString == COMMAND_DO_ALL){
        return {Command::DoAll, {}};
    }else if(inputString == COMMAND_NEXT_BLOCK){
        return {Command::DoNextBreak, {}};
    }else if(inputString == COMMAND_NEXT){
        return {Command::DoNext, {}};
    }else if(inputString == COMMAND_BREAK_LIST){
        return {Command::BreakList, {}};
    }else if(inputString == COMMAND_BACK){
        return {Command::Back, {}};
    }else{
        if(startsWith(inputString, COMMAND_BREAK_SET)){
            try{
                int line = std::stoi(inputString.substr(2));
                return {Command::BreakSet, {line}};
            }catch(const std::invalid_argument &e){
                return{Command::Invalid, {}};
            }
        }else if(startsWith(inputString, COMMAND_REG_READ)){
            // 工事中　とりあえず全部見るモードのみ
            return {Command::RegRead, {}};
        }
    }

    return {Command::Invalid, {}};
    

    
}

