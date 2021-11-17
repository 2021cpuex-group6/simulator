#ifndef MMIO_H
#define MMIO_H
#include <vector>
#include <string>


class MMIO{
    public:
        MMIO();

    private:
        std::vector<uint32_t> recvData;

};
#endif