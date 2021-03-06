#ifndef UTILS_H
#define UTILS_H

#include "utils.hpp"
#include <algorithm>
#include <string>

static constexpr int  SHIFT_MASK_5 = 0b11111; 
static constexpr int SHIFT_MASK31 = 0x7fffffff;
static constexpr int INT_BIT_N = 32;
constexpr int INST_BYTE_N = 4;
constexpr int WORD_BYTE_N = 4;
constexpr double  HZ = 50000000;
union MemoryUnit{ // メモリの1ワードに対応するユニット
    float f;
    uint32_t i;
    int32_t si;
    uint8_t b[WORD_BYTE_N];
    int8_t sb[WORD_BYTE_N];
    MemoryUnit(){}

    MemoryUnit(const float & value){
        f = value;
    }
    MemoryUnit(const uint32_t & value){
        i = value;
    }
    MemoryUnit(const int32_t & value){
        si = value;
    }
};


inline bool startsWith(const std::string &strA, const std::string &strB){
    // strAがstrBから始まるかを返す
    return strA.size() >= strB.size() && 
            std::equal(std::begin(strB), std::end(strB), std::begin(strA));
}

inline int32_t shiftRightLogical(const int32_t &input, const unsigned int & shiftN){
    if(shiftN != 0){
        if(shiftN >= INT_BIT_N){
            //32ビット以上のシフトは0にならないので自分で実装しないといけない()
            return 0;
        }
        int32_t ans = input >> shiftN;
        // SHIFT_MASK31はMSBが0
        ans &= SHIFT_MASK31 >> (shiftN-1);
        return ans;
    }
    return input;
}
inline int32_t shiftRightArithmatic(const int32_t &input, const unsigned int & shiftN){
    if(shiftN >= INT_BIT_N){
        return input < 0 ? ~0 : 0;
    }
    int32_t ans = input >> shiftN;
    // SHIFT_MASK31はMSBが0
    ans &= SHIFT_MASK31 >> (shiftN-1);
    if(input < 0){
        //負数のシフトだったらMSBのほうに1を追加
        ans |= (~0) << (INT_BIT_N-shiftN);
    }
    return ans;
}

bool isPowerOf2(int32_t value, const int32_t limit);

#endif