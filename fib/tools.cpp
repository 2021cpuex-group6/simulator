#include <iostream>
#include <string>
#include <iomanip>
#include <sstream>

typedef union{
    float f;
    uint32_t i;
    int32_t si;
    uint8_t bytes[4];
}Value32;

static const std::string EXPLAINT_1 = "変換したい値を入力してください (終了はquit, オプション指定可能)";
static const std::string EXPLAINT_2 = "整数レジスタへ書き込む命令に使うレジスタ番号2つを入力してください: (デフォルト: 生成しない)";
static const std::string INVALID_VALUE = "不適切な値です";
static const std::string PROMPT = ">>> ";

static constexpr int REG_N = 32;

void printValue(const Value32 &value){
    std::cout << "float: " << value.f << std::endl;
    std::cout << "int__: " << value.si << std::endl;
    std::cout << "hex__: " << std::setw(8) << std::setfill('0')  << std::hex << value.i << std::endl;
    std::cout << "bytes: ";
    for(int i = 0; i < 4 ; i++){
        std::cout << " " << std::dec << static_cast<int32_t>(value.bytes[i]);

    }
    std::cout << "  ※ Big endian " << std::endl;
    
    std::cout << std::endl;
    
}


void printInst(const Value32 &value, const int &ind1, const int &ind2){
    std::cout << "  addi x" << ind1 << " x0 8" << std::endl;
    std::cout << "  addi x" << ind2 << " x0 0" << std::endl;
    for(int i = 0; i < 4; i++){
        std::cout << "  ori  x" << ind2 << " x" << ind2 << " " << static_cast<int32_t>(value.bytes[3-i]) << std::endl;
        if(i == 3) break;
        std::cout << "  sll  x" << ind2 << " x" << ind2 << " x" << ind1 << std::endl;
    }
    std::cout << "  sw   x" << ind2 << " 0(x0)" << std::endl;
    std::cout << "  flw  f1 0(x0)" << std::endl;
    
    

    
}

int main(){
    std::cout << EXPLAINT_1 << std::endl;
    while(true){
        std::cout << PROMPT;
        std::string  input;
        std::getline(std::cin, input);
        if(input == "quit"){
            return 0;
        }
        try{
            std::string s1, s2;
            std::istringstream iss0(input);
            iss0 >> s1 >> s2;
            Value32 value;
            if(s2 != ""){
                if(s2 == "-b"){ value.si = stoi(s1, nullptr, 2);}
                else if(s2 == "-o"){value.si = stoi(s1, nullptr, 8);}
                else if(s2 == "-h"){value.si = stoi(s1, nullptr, 16);}
                else {value.si = stoi(s1, nullptr, 10);}
            }else{
                float f = std::stof(input);
                value.f = f;
            }

            printValue(value);
            std::cout << EXPLAINT_2 << std::endl;
            std::cout << PROMPT;
            std::getline(std::cin, input);
            std::istringstream iss(input);
            if(input == "quit") return 0;
            if(input != ""){
                iss >> s1 >> s2;
                int ind1 = stoi(s1);
                int ind2 = stoi(s2);
                if(0 < ind1 && ind1 < REG_N && 0 < ind2 && ind2 < REG_N){
                    printInst(value, ind1, ind2);
                }
            }
        }catch(const std::invalid_argument &e){
            std::cout << INVALID_VALUE << std::endl;
            
        }catch(const std::out_of_range & e){
            std::cout << INVALID_VALUE << std::endl;
        }
    }

    

}