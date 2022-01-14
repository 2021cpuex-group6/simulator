#include "mmio.hpp"
#include "../utils/utils.hpp"

#include <vector>
#include <fstream>
#include <sstream>
#include <iostream>
#include <iomanip>

const std::string NO_INPUT_FILE = "data/contest.sldファイルが存在しません．";
const std::string RECV_DATA_FILE = "data/contest.sld";
const std::string OUTPUT_FILE = "data/output.ppm";
const std::string SEND_PRINT = "送信数: ";
const std::string RECEIVE_PRINT = "受信数: ";
constexpr int ABOUT_RAW_SLD_SIZE = 100;
constexpr int ABOUT_INPUT_SIZE = ABOUT_RAW_SLD_SIZE * sizeof(int32_t); // 大体のサイズ
constexpr int ABOUT_OUTPUT_SIZE = 3 + 128 * 128 * (3*3 + 3);
constexpr int SLD_ENV_FLOAT_N = 9;
constexpr int SLD_OBJ_INT_N = 4;
constexpr int SLD_OBJ_FLOAT_N = 12;
constexpr int SLD_OBJ_END = -1;


static constexpr int PPM_INT_W = 3;
static constexpr bool CLEAR_ZERO = true;
static constexpr double BAUD_RATE = 576000;
static constexpr int BYTE_BIT_N = 8;

// 時間予測用
constexpr double recvTime = 1 / BAUD_RATE;
constexpr double sendTime = 1 / BAUD_RATE;

MMIO::MMIO(){
    initRecvData();    
    sendData.reserve(ABOUT_OUTPUT_SIZE);
}

// countの位置の文字列をfloatとして呼んで格納し，インクリメント
MemoryUnit MMIO::readFloat(const std::vector<std::string>&rawSld, int &count){
    MemoryUnit mu;
    mu.f = std::stof(rawSld[count++]);
    for(int i = sizeof(int32_t)-1; i >= 0; --i){
        // とりあえずビッグエンディアンで受け取って構成すればもとに戻るように
        recvData.emplace_back(mu.sb[i]);
    }
    return mu;
}

// countの位置の文字列をintとして呼んで格納し，インクリメント
MemoryUnit MMIO::readInt(const std::vector<std::string>&rawSld, int &count){
    MemoryUnit mu;
    mu.si = std::stoi(rawSld[count++]);
    for(int i = sizeof(int32_t)-1; i >= 0; --i){
        // とりあえずビッグエンディアンで受け取って構成すればもとに戻るように
        recvData.emplace_back(mu.sb[i]);
    }
    return mu;
}

// sldファイルを全部読んで文字列のvectorに保存
// sldファイルは小さいからこの実装でも大丈夫そう(reader.pyと同じ実装)
std::vector<std::string> MMIO::makeSldRaw(std::ifstream &ifs){
    std::vector<std::string> ans;
    ans.reserve(ABOUT_RAW_SLD_SIZE);

    std::string line, s;
    while(!ifs.eof()){
        std::getline(ifs, line);
        std::istringstream iss(line);
        while(iss >> s) ans.emplace_back(s);
    }
    return ans;
}

void MMIO::readSldEnv(const std::vector<std::string>& rawSld, int &count){
    for (size_t i = 0; i < SLD_ENV_FLOAT_N; i++)
    {
        readFloat(rawSld, count);
    }
}

void MMIO::readSldObjects(const std::vector<std::string>& rawSld, int &count){
    while(readInt(rawSld, count).si != SLD_OBJ_END){
        int isRot; // readIntの最後の数
        for (size_t i = 0; i < SLD_OBJ_INT_N-1; i++)
        {
            isRot = readInt(rawSld, count).si;
        }
        for (size_t i = 0; i < SLD_OBJ_FLOAT_N ; i++)
        {
            readFloat(rawSld, count);
        }
        if(isRot != 0){
            for (size_t i = 0; i < 3 ; i++)
            {
                readFloat(rawSld, count);
            }
        }
    }
}
void MMIO::readSldAndNetwork(const std::vector<std::string>&rawSld, int &count){
    while(readInt(rawSld, count).si != SLD_OBJ_END){
        while(readInt(rawSld, count).si != SLD_OBJ_END);
    }
}
void MMIO::readSldOrNetwork(const std::vector<std::string>&rawSld, int &count){
    readSldAndNetwork(rawSld, count);
}


// SLDファイルの読み込み
void MMIO::readSld(std::ifstream & iss){
    std::vector<std::string> rawSld = makeSldRaw(iss);
    int count = 0;
    readSldEnv(rawSld, count);
    readSldObjects(rawSld, count);
    readSldAndNetwork(rawSld, count);
    readSldOrNetwork(rawSld, count);
}


// recvDataの初期化
// RECV_DATA_FILEを読み込んで，vectorに格納する
void MMIO::initRecvData(){
    recvData.reserve(ABOUT_INPUT_SIZE);
    std::ifstream ifs(RECV_DATA_FILE);
    if(!ifs){
        throw std::invalid_argument(NO_INPUT_FILE);
    }
    readSld(ifs);
    ifs.close();
    recvData.shrink_to_fit();

}

// MMIOでデータを受け取る
// 返り値は結果と，まだデータが残っているか
char MMIO::recv(){
    uint32_t ans = recvData[nowInd++];
    valid = nowInd < static_cast<int>(recvData.size());
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
        if(CLEAR_ZERO){
            std::string allString(sendData.data());
            std::stringstream allSs(allString);
            
            std::string line;
            std::getline(allSs, line);
            ofs << line << std::endl; // 最初の１行はそのまま
            while(std::getline(allSs, line)){
                std::stringstream inSs(line);
                bool flag = false;
                while(!inSs.eof()){
                    std::string intStr;
                    inSs >> intStr;
                    int width = flag ? PPM_INT_W + 1 : PPM_INT_W;
                    flag = true;
                    ofs << std::setw(width) << std::stoi(intStr);
                }
                ofs << std::endl;
            }

        }else{
            ofs.write(&(sendData[0]), sendData.size());
        }
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

// mmioでどれだけ送受信したかを表示
void MMIO::printInfo()const{
    std::cout << RECEIVE_PRINT << std::setw(4) << nowInd << " / " << std::setw(3) << recvData.size() << std::endl;
    std::cout << SEND_PRINT << std::setw(4) << sendData.size() << std::endl;

};

// 現在の送信済みデータを表示
void MMIO::printSended(const bool &forGUI)const{
    if(forGUI){
        // 何行送るかを先に表示
        int count = 1;
        for(const char &c: sendData){
            if(c == '\n') ++count;
        }
        std::cout << count << std::endl;
    }
    for(const char &c: sendData){
        std::cout.put(c);
    }
    std::cout  << std::endl;
    
};

// 時間予測
double MMIO::calculateTime(){
    double ans = 0;
    // 受信時間
    ans += nowInd * recvTime * BYTE_BIT_N;
    ans += sendData.size() * sendTime * BYTE_BIT_N; 

    return ans;
}