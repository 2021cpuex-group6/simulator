#include "assemble/deassemble.hpp"
#include "sims/simulator.hpp"

#include <string>
#include <iostream>
#include <fstream>

static const std::string ERROR = "エラー";
static const std::string FIRST_EXPLAINT = "ファイル入力→f, 対話型→i (デフォルト: f)";
static const std::string EXPLAINT = "デアセンブルしたいコードをuint32(hex)で入力してください";
static const std::string FILE_EXPLAINT = "デアセンブルしたいファイルのパスを入力してください（デフォルト: test/test.s.out）";
static const std::string INVALID_BINARY = "バイナリファイルは4の倍数のサイズである必要があります.";
static const std::string PROMPT = ">>>";
static const std::string DEFAULT_PATH = "./test/test.s.out";
static const std::string FILE_INPUT = "f";
static const std::string INTERACTIVE_INPUT = "i";
static constexpr bool USE_REAL_BINARY = true;


void interactive(){
    std::cout << EXPLAINT  << std::endl;
    std::string input;
    while(true){
        std::cout << PROMPT;
        std::getline(std::cin, input);
        try{
            uint32_t ans = std::stoi(input, nullptr, 16);
            Instruction inst = deassemble(0, ans);
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
    int lineN = 1;
    if(USE_REAL_BINARY){
        // 新しいバージョンのバイナリ
        std::ifstream ifs(input, std::ios::binary);
        if(!ifs) return;
        ifs.seekg(0, std::ios_base::end);
        size_t size = ifs.tellg();
        ifs.seekg(0, std::ios_base::beg);
        if(size % INST_BYTE_N != 0){
            std::cout << INVALID_BINARY  << std::endl;
            return;
        }
        size /= INST_BYTE_N;
        uint32_t res = 0;
        char byte = 0;
        for (size_t i = 0; i < size; i++)
        {
            res = 0;
            for (size_t j = 0; j < INST_BYTE_N; j++)
            {
                ifs.read(&byte, 1);
                res |= (0xff &  static_cast<u_int32_t>(byte)) << 8*(INST_BYTE_N -1-j);
            }
            Instruction inst = deassemble(lineN, res);
            AssemblySimulator::printInstByRegInd(0, inst);
        }

    }else{
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
                Instruction inst = deassemble(lineN++, res);
                AssemblySimulator::printInstByRegInd(0, inst);
            }
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