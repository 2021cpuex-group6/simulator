#ifndef MMIO_H
#define MMIO_H
#include <vector>
#include <string>

class MMIO{
    public:
        MMIO();
        std::pair<char, bool> recv();
        void send(const char&);
        void outputPPM();

    private:
        int nowInd = 0;
        std::vector<char> recvData; //(simulator目線で)受け取るデータ
        std::vector<char> sendData; //( .. )送るデータ

        void initRecvData();

};
#endif