#include "utils.hpp"
#include <algorithm>

static constexpr int  SHIFT_MASK_5 = 0b11111; 
static constexpr int SHIFT_MASK31 = 0x7fffffff;
static constexpr int INT_BIT_N = 32;

bool startsWith(const std::string &strA, const std::string &strB){
    // strAがstrBから始まるかを返す
    return strA.size() >= strB.size() && 
            std::equal(std::begin(strB), std::end(strB), std::begin(strA));
}

int32_t shiftRightLogical(const int32_t &input, const int & shiftN){
    // input をshiftNの下位5bitを符号なし整数とみて右論理シフト
    unsigned int shiftN = input & SHIFT_MASK_5;
    if(shiftN != 0){
        int32_t ans = input >> shiftN;
        // SHIFT_MASK31はMSBが0
        ans &= SHIFT_MASK31 >> (shiftN-1);
        return ans;
    }
}
int32_t shiftRightArithmatic(const int32_t &input, const int & shiftN){
    // input をshiftNの下位5bitを符号なし整数とみて右算術シフト
    unsigned int shiftN = input & SHIFT_MASK_5;
    int32_t ans = input >> shiftN;
    // SHIFT_MASK31はMSBが0
    if(input < 0){
        //負数のシフトだったらMSBのほうに1を追加
        ans |= (~0) << (INT_BIT_N-shiftN);
    }
    ans &= SHIFT_MASK31 >> (shiftN-1);
    return ans;
}