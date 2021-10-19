#include "utils.hpp"
#include <algorithm>



bool startsWith(const std::string &strA, const std::string &strB){
    // strAがstrBから始まるかを返す
    return strA.size() >= strB.size() && 
            std::equal(std::begin(strB), std::end(strB), std::begin(strA));
}

int32_t shiftRightLogical(const int32_t &input, const unsigned int & shiftN){
    // input をshiftNの下位5bitを符号なし整数とみて右論理シフト
    if(shiftN != 0){
        int32_t ans = input >> shiftN;
        // SHIFT_MASK31はMSBが0
        ans &= SHIFT_MASK31 >> (shiftN-1);
        return ans;
    }
}
int32_t shiftRightArithmatic(const int32_t &input, const unsigned int & shiftN){
    // input をshiftNの下位5bitを符号なし整数とみて右算術シフト
    int32_t ans = input >> shiftN;
    // SHIFT_MASK31はMSBが0
    if(input < 0){
        //負数のシフトだったらMSBのほうに1を追加
        ans |= (~0) << (INT_BIT_N-shiftN);
    }
    ans &= SHIFT_MASK31 >> (shiftN-1);
    return ans;
}