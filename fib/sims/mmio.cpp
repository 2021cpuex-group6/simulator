#include "mmio.hpp"
#include "../utils/utils.hpp"

#include <vector>
#include <fstream>
#include <sstream>
#include <iostream>

const std::string NO_INPUT_FILE = "ファイルが存在しません";
const std::string RECV_DATA_FILE = "data/contest.sld";
constexpr int ALMOST_INPUT_SIZE = 100; // 大体のサイズ

MMIO::MMIO(){
    initRecvData();
    std::cout << "test" << std::endl;
    
}

// recvDataの初期化
// RECV_DATA_FILEを読み込んで，vectorに格納する
void MMIO::initRecvData(){
    recvData.reserve(ALMOST_INPUT_SIZE);
    std::ifstream ifs(RECV_DATA_FILE);
    if(!ifs){
        throw std::invalid_argument(NO_INPUT_FILE);
    }
    std::string line, s;
    MemoryUnit mu;
    while(!ifs.eof()){
        std::getline(ifs, line);
        std::istringstream iss(line);
        while(iss >> s){
            if(s.find('.') != std::string::npos){
                // floatで処理
                mu.f = std::stof(s);
            }else{
                // intで処理
                mu.si = std::stoi(s);
            }
            recvData.emplace_back(mu.i);
        }
    }
    recvData.shrink_to_fit();

}