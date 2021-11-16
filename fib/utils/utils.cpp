#include <string>

// 入力が正であり，かつlimit以下の2べきの数か調べる
bool isPowerOf2(int32_t value, const int32_t limit){
    if(value <= 0){
        return false;
    }
    uint32_t input = static_cast<uint32_t>(value);
    uint32_t std = 1u;
    while(std <= static_cast<uint32_t>(limit)){
        if(input == std)return true;
        std <<= 1;
    }
    return false;
}
