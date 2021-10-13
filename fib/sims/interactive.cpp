#include "../utils/utils.hpp"
#include "interactive.hpp"
#include <iostream>
#include <vector>
#include <regex>

InteractiveShell::InteractiveShell(const AssemblySimulator & sim, const AssemblyParser& parse, const bool &  forGUI): simulator(sim), parser(parse), forGUI(forGUI){}

void InteractiveShell::start(){
    std::pair<Command, std::vector<int>> input;

    bool continueFlag = true;
    while(continueFlag){
        while (true){
            // 正しい入力が入るまでループ
            input = getInput();
            if(input.first != Command::Invalid){
                break;
            }
            if(forGUI){
                printGUIError(INVALID_COMMAND);
            }else{
                std::cout << INVALID_COMMAND << std::endl;
            }
        }

        switch(input.first){
            case Command::DoAll:
                simulator.launch();
                if(!forGUI){
                    simulator.printRegisters(NumberBase::DEC, true);
                    simulator.printOpCounter();
                }
                break;
            case Command::DoNext:
                simulator.next(true, true);
                if(input.second[0] == 1){
                    switch(input.second[1]){
                        case static_cast<int>(NumberBase::HEX):
                            simulator.printRegisters(NumberBase::HEX, input.second[2] == 1);
                            break;
                        case static_cast<int>(NumberBase::DEC):
                            simulator.printRegisters(NumberBase::DEC, input.second[2] == 1);
                            break;
                        case static_cast<int>(NumberBase::BIN):
                            simulator.printRegisters(NumberBase::BIN, input.second[2] == 1);
                            break;
                        case static_cast<int>(NumberBase::OCT):
                            simulator.printRegisters(NumberBase::OCT, input.second[2] == 1);
                            break;
                    }
                }
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
            case Command::RegWrite:
                simulator.writeReg(input.second[0], input.second[1]);
                break;
            case Command::BreakDelete:
                simulator.deleteBreakPoint(input.second[0]);
                break;
            case Command::Info:
                simulator.printOpCounter();
                break;
            case Command::Reset:
                simulator.reset();
                break;
            case Command::Back:
                simulator.back();
                break;
            case Command::Quit:
                continueFlag = false;
                break;


        }

    }



}

std::pair<Command, std::vector<int>> InteractiveShell::getInput()const{
    // 入力を受け取り、それをパースする
    std::string inputString;
    if(!forGUI) std::cout << ">>>>>" ;
    if(!(std::getline(std::cin, inputString))){
            return {Command::Invalid, {}};
    }

    if(inputString == COMMAND_DO_ALL){
        return {Command::DoAll, {}};
    }else if(inputString == COMMAND_NEXT_BLOCK){
        return {Command::DoNextBreak, {}};
    }else if(inputString == COMMAND_BREAK_LIST){
        return {Command::BreakList, {}};
    }else if(inputString == COMMAND_BACK){
        return {Command::Back, {}};
    }else if(inputString == COMMAND_INFO){
        return {Command::Info, {}};
    }else if(inputString == COMMAND_RESET){
        return {Command::Reset, {}};
    }else if(inputString == COMMAND_NEXT){
        return {Command::DoNext, {0}};
    }else if(inputString == COMMAND_QUIT){
        return {Command::Quit, {}};
    }else{
        if(startsWith(inputString, COMMAND_NEXT)){
            std::istringstream stream(inputString.substr(2));
            std::string option;
            stream >> option;
            if(option == "-rh"){
                return {Command::DoNext, {1, static_cast<int>(NumberBase::HEX), 1}};
            }else if(option == "-ro"){
                return {Command::DoNext, {1, static_cast<int>(NumberBase::OCT), 1}};
            }else if(option == "-rb"){
                return {Command::DoNext, {1, static_cast<int>(NumberBase::BIN), 1}};
            }else if(option == "-ru"){
                return {Command::DoNext, {1, static_cast<int>(NumberBase::DEC), 0}};
            }else if(option == "-r"){
                return {Command::DoNext, {1, static_cast<int>(NumberBase::DEC), 1}};
            }else {
                return {Command::DoNext, {0}};
            }
        } else if(startsWith(inputString, COMMAND_BREAK_SET)){
            try{
                int line = std::stoi(inputString.substr(2));
                return {Command::BreakSet, {line}};
            }catch(const std::invalid_argument &e){
                return{Command::Invalid, {}};
            }
        }else if(startsWith(inputString, COMMAND_REG_READ)){
            return getRRInput(inputString);
        }else if(startsWith(inputString, COMMAND_REG_WRITE)){
            return getRWInput(inputString);
        }else if(startsWith(inputString, COMMAND_BREAK_DELETE)){
            return getBDInput(inputString);
        }
    }

    return {Command::Invalid, {}};
    

    
}


std::pair<int, int> InteractiveShell::getRROptionInput(std::string input)const{
    // レジスタ系のコマンドのオプション部分を読み取る
    const std::regex optionRe(R"(-[bodhu])");
    std::smatch m;
    int optionB = static_cast<int>(NumberBase::DEC);
    int optionS = 1;

    while(std::regex_search(input, m, optionRe)){
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
        input = m.suffix();
    }
    return {optionB, optionS};
}

int InteractiveShell::getRRRegisterInput(std::string input)const{
    // レジスタ系のコマンドのレジスタ部分を読み取る
    // 指定がない場合は-1を返す
    const std::regex regRe(R"(\s+([a-z0-9]+))");
    std::smatch m;
    input = input.substr(2);
    int regInd = -1;
    if(std::regex_search(input, m, regRe)){
        std::string res = m[1].str();
        regInd = AssemblySimulator::getRegInd(res);
        if(regInd < 0){
            if(forGUI){
                printGUIError(INVALID_REG_NAME);
            }else{
                std::cout << INVALID_REG_NAME << std::endl;
            }
        }
    }
    return regInd;
}

std::pair<Command, std::vector<int>> InteractiveShell::getRWInput(const std::string &inputString) const{
    // rr コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 指定されたレジスタのインデックス（指定なしならエラー）
    //  1 ... 書き込むint
    int writeValue = 0;
    int regInd = -1;

    auto optionPair = getRROptionInput(inputString);
    if(optionPair.second == 0){
        // unsignedは未対応
        if(forGUI){
            printGUIError(NOT_IMPLEMENTED_UNSIGNED);
        }else{
            std::cout << NOT_IMPLEMENTED_UNSIGNED << std::endl;
        }
        return {Command::Invalid, {}};
    }
    regInd = getRRRegisterInput(inputString);
    if(regInd < 0){
        // レジスタ指定なし
        if(forGUI){
            printGUIError(NOT_SELECTED_REGISTER);
        }else{
            std::cout << NOT_SELECTED_REGISTER << std::endl;
        }
        return {Command::Invalid, {}};
    }

    const std::regex numRe(R"(\s+([0-9a-f]+))");
    std::smatch m;
    if(std::regex_search(inputString, m, numRe)){
        std::string res = m[1].str();
        writeValue = std::stoi(res, 0, optionPair.first);
    }else{
        // 書き込む値の指定なし
        if(forGUI){
            printGUIError(NOT_SPECIFIED_WRITE_VALUE);
        }else{
            std::cout <<  NOT_SPECIFIED_WRITE_VALUE << std::endl;
        }
        return {Command::Invalid, {}};
    }

    return {Command::RegWrite, {regInd, writeValue}};


}

std::pair<Command, std::vector<int>> InteractiveShell::getRRInput(const std::string &inputString) const{
    // rr コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 指定されたレジスタのインデックス（指定なしなら全レジスタを示す-1）
    //  1 ... x進数表記の指定　（指定なしなら10進数）
    //  2 ... 符号付か符号なしか (指定なしなら符号付)


    int regInd = getRRRegisterInput(inputString);
    auto optionPair = getRROptionInput(inputString);
    
    return{Command::RegRead, {regInd, optionPair.first, optionPair.second}};

}


std::pair<Command, std::vector<int>> InteractiveShell::getBDInput(const std::string &inputString) const{
    // bd コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 削除する行
    int writeValue = 0;

    const std::regex numRe(R"(\s+([0-9]+))");
    std::smatch m;
    if(std::regex_search(inputString, m, numRe)){
        std::string res = m[1].str();
        try{
            writeValue = std::stoi(res);
        }catch(const std::out_of_range & e){
            if(forGUI){
                printGUIError(OUT_OF_RANGE_INT);
            }else{
                std::cout << OUT_OF_RANGE_INT << std::endl;
            }
            return {Command::Invalid, {}};
        }
    }else{
        // 書き込む値の指定なし
        if(forGUI){
            printGUIError(NOT_SPECIFIED_LINE_N);
        }else{
            std::cout <<  NOT_SPECIFIED_LINE_N << std::endl;
        }
        return {Command::Invalid, {}};
    }

    return {Command::BreakDelete, {writeValue}};


}

void InteractiveShell::printGUIError(const std::string &message)const{
    // GUIからのコマンドが間違っていた時のエラー表示
    std::cout << GUI_ERROR << std::endl;
    std::cout << -1 << std::endl;
    std::cout << message << std::endl;

}

