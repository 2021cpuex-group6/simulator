#include "assemble/deassemble.hpp"
#include "sims/simulator.hpp"

#include <iostream>

static const std::string ERROR = "エラー";
static const std::string EXPLAINT = "デアセンブルしたいコードをuint32(hex)で入力してください";
static const std::string PROMPT = ">>>";

int main(){
    
    std::string input;
    std::cout << EXPLAINT  << std::endl;
    
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