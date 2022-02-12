#ifndef MMIO_H
#define MMIO_H
#include "../utils/utils.hpp"
#include <vector>
#include <string>

class MMIO{
    public:
        std::string dataPath;
        MMIO(const std::string &dataPath);
        MMIO();
        bool valid = true; // 読みだせるか
        char recv();
        void send(const char&, const uint64_t & instructionN);
        void back(bool);
        void reset();
        void outputPPM()const;
        char getLast()const;
        void printInfo()const;
        void printSended(const bool &)const;
        std::vector<std::string> makeSldRaw(std::ifstream &);
        MemoryUnit readFloat(const std::vector<std::string>&, int &);
        MemoryUnit readInt(const std::vector<std::string>&, int &);
        void readSldEnv(const std::vector<std::string>&, int &);
        void readSldObjects(const std::vector<std::string>&, int &);
        void readSldAndNetwork(const std::vector<std::string>&, int &);
        void readSldOrNetwork(const std::vector<std::string>&, int &);
        void readSld(std::ifstream &);

        void outputMMIOInfo(std::ostream &stream);
        void inputMMIOInfo(std::istream &stream);

        double calculateTime();


    private:
        int nowInd = 0;
        int sendNum = 0;
        uint64_t sendWaitTimeSum = 0; // 短い間隔で何度もsbしたために発生した待ち時間
        std::vector<char> recvData; //(simulator目線で)受け取るデータ
        std::vector<char> sendData; //( .. )送るデータ

        // 仮想的に考えるsendキュー．全部シミュレートするのは面倒なので，入っている数，
        // 先頭と最後の番号のみ記憶する近似で計算する
        int queueNowN = 0;  // 現在キューに入っている数
        uint64_t queueTopN = 0; // キューの先頭の番号
        uint64_t queueLastN = 0; // キューの最後尾の番号

        void initRecvData();

};
#endif