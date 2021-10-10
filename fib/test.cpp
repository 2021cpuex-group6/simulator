#include <iostream>
#include <cmath>
static constexpr std::int32_t MASK_BITS = ~(1 << 31);
static int32_t get_J_imm(int32_t  input){
    // J形式の即値を並び変える
    // すでに1ビット省略しているので、19ビットの入力
    int32_t ans = (input << 13 ) & ~MASK_BITS; //20
    ans |= (input & 0x3ff) << 21; //10-1
    ans |= (input & 0x400) << 10; //11
    ans |= (input & 0x7f800) << 1; // 19-12
    return ans;
}

static int32_t get_B_imm(int32_t  input){
    // B形式の即値を並び変える
    // すでに1ビット省略しているので、12ビットの入力
    int32_t ans = (input << 20 ) & (~MASK_BITS); //12
    ans |= (input & 0x3f0) << 21; //10-5
    ans |= (input & 0xf) << 8; //4-1
    ans |= (input & 0x400) >> 3; // 11
    return ans;
}
int main(){
    int32_t test = 0b1010111101010111011;
    std::cout << get_J_imm(test) << std::endl;
    std::cout << get_B_imm(test) << std::endl;
}
