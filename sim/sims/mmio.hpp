#ifndef MMIO_H
#define MMIO_H
#include "../utils/utils.hpp"
#include <vector>
#include <string>

class MMIO{
    public:
        MMIO();
        bool valid = true; // 読みだせるか
        char recv();
        void send(const char&);
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

        double calculateTime();


    private:
        int nowInd = 0;
        std::vector<char> recvData; //(simulator目線で)受け取るデータ
        std::vector<char> sendData; //( .. )送るデータ

        void initRecvData();

};
#endif