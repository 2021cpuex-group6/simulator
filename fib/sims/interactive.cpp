#include "../utils/utils.hpp"
#include "interactive.hpp"
#include <iostream>
#include <sstream>
#include <vector>
#include <regex>


static const std::string INVALID_COMMAND = "コマンドの書式が不正です";
static const std::string INVALID_REG_NAME = "レジスタ名が不正です";
static const std::string NOT_SELECTED_REGISTER = "レジスタを指定してください";
static const std::string NOT_SPECIFIED_WRITE_VALUE = "書き込む値を指定してください";
static const std::string NOT_IMPLEMENTED_UNSIGNED = "unsignedでの書き込みは未実装です";
static const std::string NOT_SPECIFIED_LINE_N = "行数を指定してください";
static const std::string OUT_OF_RANGE_INT = "入力がintの範囲外です";
static const std::string OUT_OF_RANGE = "値が範囲外です";

InteractiveShell::InteractiveShell(AssemblySimulator & sim, AssemblyParser& parse, const bool &  forGUI):  forGUI(forGUI), simulator(sim), parser(parse){}

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
            interactiveErrorWithGUI(INVALID_COMMAND);
        }

        switch(input.first){
            case Command::DoAll:
                simulator.launch();
                if(!forGUI){
                    simulator.printRegisters(NumberBase::DEC, true, true);
                    simulator.printOpCounter();
                }
                break;
            case Command::DoNext:
                simulator.next(false, true);
                if(input.second[0] == 1){
                    bool useFNotation = true;
                    switch(input.second[1]){
                        case static_cast<int>(NumberBase::HEX):
                            simulator.printRegisters(NumberBase::HEX, input.second[2] == 1, useFNotation);
                            break;
                        case static_cast<int>(NumberBase::DEC):
                            simulator.printRegisters(NumberBase::DEC, input.second[2] == 1, useFNotation);
                            break;
                        case static_cast<int>(NumberBase::BIN):
                            simulator.printRegisters(NumberBase::BIN, input.second[2] == 1, useFNotation);
                            break;
                        case static_cast<int>(NumberBase::OCT):
                            simulator.printRegisters(NumberBase::OCT, input.second[2] == 1, useFNotation);
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
                    simulator.printRegisters(static_cast<NumberBase>(input.second[2]), 
                                                                            input.second[3] == 1, true);
                }else{
                    std::cout << simulator.getRegisterInfoUnit(input.second[0],
                                                                 static_cast<NumberBase>(input.second[2]), 
                                                                            input.second[3] == 1, input.second[1] == 1) << std::endl;
                }
                break;
            case Command::MemRead:
                if(input.second[0] + WORD_BYTE_N * input.second[1] >= MEM_BYTE_N || 
                    input.second[0] < 0){
                    // 範囲外までアクセス
                    interactiveErrorWithGUI(OUT_OF_RANGE_MEMORY);
                }else if(input.second[1] < 0){
                    interactiveErrorWithGUI(INVALID_COMMAND);
                }else{
                    int lineN = forGUI ? MEM_PRINT_LINE_GUI : MEM_PRINT_LINE_CLI;
                    simulator.printMem(input.second[0], input.second[1], lineN);
                }
                break;
            case Command::RegWrite:
                simulator.writeReg(input.second[0], input.second[2], input.second[1] == 1);
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
            default:
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
        }else if(startsWith(inputString, COMMAND_MEM_READ)){
            return getMRInput(inputString);
        }
    }

    return {Command::Invalid, {}};
    

    
}


std::pair<int, int> InteractiveShell::getRROptionInput(std::string input)const{
    // レジスタ系のコマンドのオプション部分を読み取る
    const std::regex optionRe(R"(-[bodhuf])");
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
        }else if(res == "-f"){
            optionB = static_cast<int>(NumberBase::FLOAT);
        }
        input = m.suffix();
    }
    return {optionB, optionS};
}

std::pair<int, bool> InteractiveShell::getRRRegisterInput(std::string input)const{
    // レジスタ系のコマンドのレジスタ部分を読み取る
    // 指定がない場合は-1を返す
    const std::regex regRe(R"(\s+([a-z0-9]+))");
    std::smatch m;
    input = input.substr(2);
    if(std::regex_search(input, m, regRe)){
        std::string res = m[1].str();
        auto indPair = AssemblySimulator::getRegInd(res);

        if(indPair.first < 0){
            interactiveErrorWithGUI(INVALID_REG_NAME);
        }
        return indPair;
    }
    return {-1, false};
}

std::pair<Command, std::vector<int>> InteractiveShell::getRWInput(const std::string &inputString) const{
    // rr コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 指定されたレジスタのインデックス（指定なしならエラー）
    //  1 ... 整数レジスタに書き込むなら1浮動小数点なら0
    //  2 ... 書き込むint
    std::istringstream stream(inputString);

    int writeValue = 0;
    int regInd = -1;

    auto optionPair = getRROptionInput(inputString);
    if(optionPair.second == 0){
        // unsignedは未対応
        interactiveErrorWithGUI(NOT_IMPLEMENTED_UNSIGNED);
        return {Command::Invalid, {}};
    }
    auto indPair = getRRRegisterInput(inputString);
    regInd = indPair.first;
    if(regInd < 0){
        // レジスタ指定なし
        interactiveErrorWithGUI(NOT_SELECTED_REGISTER);
        return {Command::Invalid, {}};
    }
    std::string  command,reg,value;
    stream >> command >> reg>> value;

    const std::regex numRe(R"(\s*([0-9a-f\.]+))");
    std::smatch m;
    if(std::regex_search(value, m, numRe)){
        std::string res = m[1].str();
        try{
            if(optionPair.first == static_cast<int>(NumberBase::FLOAT)){
                MemoryUnit mu(std::stof(res));
                writeValue = mu.si;
            }else{
                writeValue = std::stoi(res, 0, optionPair.first);
            }

        }catch(const std::invalid_argument & e){
            interactiveErrorWithGUI(INVALID_COMMAND);
        }catch(const std::out_of_range &e){
            interactiveErrorWithGUI(OUT_OF_RANGE);
        }
    }else{
        // 書き込む値の指定なし
        interactiveErrorWithGUI(NOT_SPECIFIED_WRITE_VALUE);
        return {Command::Invalid, {}};
    }

    int whichReg = indPair.second ? 1 : 0;

    return {Command::RegWrite, {regInd, whichReg, writeValue}};


}

std::pair<Command, std::vector<int>> InteractiveShell::getRRInput(const std::string &inputString) const{
    // rr コマンドの引数などを処理する
    // 返り値のsecondは、
    //  0 ... 指定されたレジスタのインデックス（指定なしなら全レジスタを示す-1）
    //  1 ... 整数レジスタなら1, 浮動小数点レジスタは0
    //  2 ... x進数表記の指定　（指定なしなら10進数）
    //  3 ... 符号付か符号なしか (指定なしなら符号付)


    auto indPair = getRRRegisterInput(inputString);
    auto optionPair = getRROptionInput(inputString);
    
    int whichReg = indPair.second ? 1 : 0;
    return{Command::RegRead, {indPair.first, whichReg, optionPair.first, optionPair.second}};

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
            interactiveErrorWithGUI(OUT_OF_RANGE_INT);
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

std::pair<Command, std::vector<int>> InteractiveShell::getMRInput(const std::string &inputString) const{
    // メモリ表示命令のコマンドのパース
    // 返り値(vec)
    // 0 ... メモリアドレス
    // 1 ... ワードサイズ
    std::istringstream stream(inputString.substr(3));
    std::string str ;
    std::vector<int> ans;
    try{
        int inputN = 0;
        while(stream >> str){
            int base = 10;
            if(startsWith(str, "0x")) base = 16;
            else if(startsWith(str, "0b")) base = 2;
            else if(startsWith(str, "0o")) base = 8;
            ans.emplace_back(std::stoi(str, nullptr, base));
            inputN++;
        }
        if(inputN == 1) ans.emplace_back(1);
        return {Command::MemRead, ans};

    }catch(const std::invalid_argument &e){
        interactiveErrorWithGUI(INVALID_COMMAND);
        return {Command::Invalid, {}};
    }catch(const std::out_of_range &e){
        interactiveErrorWithGUI(OUT_OF_RANGE_INT);
        return {Command::Invalid, {}};
    }



}

void InteractiveShell::printGUIError(const std::string &message)const{
    // GUIからのコマンドが間違っていた時のエラー表示
    std::cout << GUI_ERROR << std::endl;
    std::cout << -1 << std::endl;
    std::cout << message << std::endl;

}

void InteractiveShell::interactiveErrorWithGUI(const std::string &message)const{
    // GUIの場合とCLIの場合で場合分けしてエラー表示
    if(forGUI){
        printGUIError(message);
    }else{
        std::cout << message << std::endl;
    }
};

