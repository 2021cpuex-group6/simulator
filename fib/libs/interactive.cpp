#include "utils.hpp"
#include "interactive.hpp"
#include <iostream>
#include <vector>
#include <regex>

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
                if(input.second[0] == -1){
                    simulator.printRegisters(static_cast<NumberBase>(input.second[1]), 
                                                                            input.second[2] == 1);
                }else{
                    std::cout << simulator.getRegisterInfoUnit(input.second[0],
                                                                 static_cast<NumberBase>(input.second[1]), 
                                                                            input.second[2] == 1) << std::endl;
                    
                }
                break;
        }

    }



}

std::pair<Command, std::vector<int>> InteractiveShell::getInput()const{
    // 入力を受け取り、それをパースする
    std::string inputString;
    std::cout << ">>>>>" ;
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
            return getRRInput(inputString);
        }
    }

    return {Command::Invalid, {}};
    

    
}

std::pair<Command, std::vector<int>> InteractiveShell::getRRInput(const std::string &inputString) const{
    // rr コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 指定されたレジスタのインデックス（指定なしなら全レジスタを示す-1）
    //  1 ... x進数表記の指定　（指定なしなら10進数）
    //  2 ... 符号付か符号なしか (指定なしなら符号付)
    const std::regex optionRe(R"(-[bodhu])");
    const std::regex regRe(R"(\s+([a-z0-9]+))");

    std::smatch m;
    int optionB = static_cast<int>(NumberBase::DEC);
    int optionS = 1;
    int regInd = -1;

    std::string inputCopy = inputString;

    while(std::regex_search(inputCopy, m, optionRe)){
        std::string res = m[0].str();
        if(res == "-b"){
            optionB = static_cast<int>(NumberBase::BIN);
        }else if(res == "-o"){
            optionB = static_cast<int>(NumberBase::OCT);
        }else if(res == "-d"){
            optionB = static_cast<int>(NumberBase::DEC);
        }else if(res == "-h"){
            optionB = static_cast<int>(NumberBase::HEX);
        }else if(res == "-u"){
            optionS = 0;
        }
        inputCopy = m.suffix();
    }
    inputCopy = inputString.substr(2);
    if(std::regex_search(inputCopy, m, regRe)){
        std::string res = m[1].str();
        regInd = AssemblySimulator::getRegInd(res);
        if(regInd < 0){
            std::cout << INVALID_REG_NAME << std::endl;
        }
    }
    return{Command::RegRead, {regInd, optionB, optionS}};

}
