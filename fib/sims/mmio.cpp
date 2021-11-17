#include "mmio.hpp"
#include "../utils/utils.hpp"

#include <vector>
#include <fstream>
#include <sstream>
#include <iostream>

const std::string NO_INPUT_FILE = "ファイルが存在しません";
const std::string RECV_DATA_FILE = "data/contest.sld";
const std::string OUTPUT_FILE = "data/output.ppm";
constexpr int ABOUT_INPUT_SIZE = 100 * sizeof(int32_t); // 大体のサイズ
constexpr int ABOUT_OUTPUT_SIZE = 3 + 128 * 128 * (3*3 + 3);

MMIO::MMIO(){
    initRecvData();    
    sendData.reserve(ABOUT_OUTPUT_SIZE);
}

// recvDataの初期化
// RECV_DATA_FILEを読み込んで，vectorに格納する
void MMIO::initRecvData(){
    recvData.reserve(ABOUT_INPUT_SIZE);
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
            for(int i = 0; i < sizeof(int32_t); ++i){
                // とりあえずリトルエンディアンで受け取って構成すればもとに戻るように
                recvData.emplace_back(mu.sb[i]);
            }
        }
    }
    ifs.close();
    recvData.shrink_to_fit();

}

// MMIOでデータを受け取る
// 返り値は結果と，まだデータが残っているか
char MMIO::recv(){
    uint32_t ans = recvData[nowInd++];
    valid = nowInd < recvData.size();
    return ans;
}

// MMIOでデータを送る
void MMIO::send(const char &value){
    sendData.emplace_back(value);

}

// PPMファイルとして出力
void MMIO::outputPPM()const{
    if(sendData.size() > 0){
        std::ofstream ofs(OUTPUT_FILE);
        ofs.write(&(sendData[0]), sendData.size());
        ofs.close();
    }
}

// 状態を一つ巻き戻す
// isSend == trueなら，send命令をひとつ前に戻す
void MMIO::back(bool isSend){
    if(!isSend){
        --nowInd;
    }else{
        sendData.pop_back();
    }
}

// 状態を初期化
void MMIO::reset(){
    nowInd = 0;
    valid = true;
    sendData.clear();
}

char MMIO::getLast()const{
    return sendData[sendData.size()-1];
}