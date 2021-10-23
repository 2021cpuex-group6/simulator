#include <iostream>
#include <cmath>
#include <limits>
#include <vector>
static constexpr std::int32_t MASK_BITS = ~(1 << 31);
typedef union
{
    uint32_t u32;
    float f32;
}Float32;
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


bool isNormalized(const float & input){
    // 入力された値が正規化数か調べる
    Float32 float32;
    float32.f32 = input;
    uint32_t exp = (float32.u32 >> 23u) & 0xff;
    if(exp == 0u){
        // 仮数が全部0なら正規化数
        return (float32.u32 & 0x7ffu) == 0;
    }else if(exp == 0xffu){
        return false;
    }
    return true;

}

typedef union Test{
    float testf;
    uint8_t testu[4];
};
int main(int c){
    std::vector<float> tests = {5};
    tests.emplace_back(std::numeric_limits<float>::infinity());
    tests.emplace_back(std::numeric_limits<float>::denorm_min());
    tests.emplace_back(0);
    tests.emplace_back(0.321);
    Float32 f;
    f.f32 = 0.5;
    f.f32 = 128;
    f.f32 = -1.75;

    for(const auto &e: tests){
        std::cout << e << std::endl;
        
        std::cout << isNormalized(e) << std::endl;
        
    }
    Test a;
    a.testf = std::numeric_limits<float>::infinity();
    std::cout << a.testf << std::endl;
    

}