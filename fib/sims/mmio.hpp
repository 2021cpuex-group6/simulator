#ifndef MMIO_H
#define MMIO_H
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
        void printSended()const;

    private:
        int nowInd = 0;
        std::vector<char> recvData; //(simulator目線で)受け取るデータ
        std::vector<char> sendData; //( .. )送るデータ

        void initRecvData();

};
#endif