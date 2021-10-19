#include <cstdint>
#include "../utils/utils.hpp"

#include <vector>

std::vector<uint32_t> separateFloat(const uint32_t &input){
    // inputに入った32ビットfloatを符号，指数部，仮数部に分離する
    uint32_t sign = input  & (0b1 << (INT_BIT_N-1));
    uint32_t exp = input & (0b11111111 << (INT_BIT_N - 9));
    uint32_t mantissa = input & (shiftRightLogical(~0, 9));
    return {sign, exp, mantissa};
}

uint32_t fadd(const uint32_t & x1, const uint32_t& x2){
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);

    uint32_t tm1 = x1_[2] | (0b1 << 23);
    uint32_t tm2 = x2_[2] | (0b1 << 23);

    bool f1 = ((x1_[1] << 23) | x1_[2]) > ((x2_[1] << 23) | x2_[2]);

    uint32_t de1 = x1_[1] - x2_[1];
    uint32_t de2 = x2_[1] - x1_[1];
    uint32_t de = (x1_[1] > x2_[1]) ? de1 : de2;
    uint32_t sm1 = 

}

