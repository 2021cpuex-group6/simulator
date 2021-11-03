#include "assemble/deassemble.hpp"
#include "sims/simulator.hpp"

#include <string>
#include <iostream>
#include <fstream>

static const std::string ERROR = "エラー";
static const std::string FIRST_EXPLAINT = "ファイル入力→f, 対話型→i (デフォルト: f)";
static const std::string EXPLAINT = "デアセンブルしたいコードをuint32(hex)で入力してください";
static const std::string FILE_EXPLAINT = "デアセンブルしたいファイルのパスを入力してください（デフォルト: test/test.s.out）";
static const std::string PROMPT = ">>>";
static const std::string DEFAULT_PATH = "./test/test.s.out";
static const std::string FILE_INPUT = "f";
static const std::string INTERACTIVE_INPUT = "i";


void interactive(){
    std::cout << EXPLAINT  << std::endl;
    std::string input;
    while(true){
        std::cout << PROMPT;
        std::getline(std::cin, input);
        try{
            uint32_t ans = std::stoi(input, nullptr, 16);
            Instruction inst = deassemble(ans);
            AssemblySimulator::printInstruction(0, inst);
        }catch(const std::invalid_argument &e){
            std::cout << ERROR << std::endl;
        }catch(const std::out_of_range &e){
            std::cout << ERROR << std::endl;
        }
    }
}

void fileInput(){
    std::cout << FILE_EXPLAINT << std::endl;
    std::string input;
    std::cout << PROMPT;
    std::getline(std::cin, input);    
    if(input == "") input = DEFAULT_PATH;
    std::ifstream ifs(input);
    if(ifs){
        std::string line;
        while(!ifs.eof()){
            uint32_t res = 0;
            for (int i = 0; i < INST_BYTE_N; i++)
            {
                std::getline(ifs, line);
                if(line == "") break;
                res |= (std::stoi(line, nullptr, 16)) << (INST_BYTE_N -1-i)*8;
            }
            if(res == 0) break;
            Instruction inst = deassemble(res);
            AssemblySimulator::printInstByRegInd(0, inst);
        }
    }

}

int main(){
    
    std::string input;
    std::cout << FIRST_EXPLAINT << std::endl;
    while(true){
        std::cout << PROMPT;
        std::getline(std::cin, input);
        if(input == INTERACTIVE_INPUT){
            interactive();
        }else if(input == FILE_INPUT || input == ""){
            fileInput();
            break;
        }
    }

}