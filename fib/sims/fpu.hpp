#ifndef FPU_H
#define FPU_H
#include <cstdint>

typedef union
{
    uint32_t u32;
    float f32;
}Float32;

enum class CheckResult{
    OUT_OF_RANGE, //対象外
    INVALID, // 誤差大
    CLEAR //基準を満たす
};

enum class CheckedOperation{
    ADD, 
    SUB, 
    MUL,
    DIV
};

uint32_t fadd(const uint32_t & x1, const uint32_t& x2);
uint32_t fsub(const uint32_t & x1, const uint32_t& x2);
uint32_t fmul(const uint32_t & x1, const uint32_t& x2);
uint32_t fdiv(const uint32_t & x1, const uint32_t& x2);
bool isNormalized(const float & input);
void randomOperationCheck(const int iterN, const CheckedOperation &op);


#endif