#ifndef FPU_H
#define FPU_H
#include <cstdint>
#include <array>

static constexpr int FSQRT_PARAM_LINE_N = 1024;

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
    ADD = 0, 
    SUB = 1, 
    MUL = 2,
    DIV = 3,
    SQRT = 4, //ここ以下はレジスタ1つしか使わない 
    FTOI = 5, 
    ITOF = 6
};
class FPUUnit{
    public:
        FPUUnit();
        static uint32_t fadd(const uint32_t & x1, const uint32_t& x2);
        static uint32_t fsub(const uint32_t & x1, const uint32_t& x2);
        static uint32_t fmul(const uint32_t & x1, const uint32_t& x2);
        static uint32_t fdiv(const uint32_t & x1, const uint32_t& x2);
        static std::pair<uint32_t, bool> itofDebug(const uint32_t & x, const bool &);
        static uint32_t itof(const uint32_t & x);
        static int32_t ftoi(const uint32_t & x);
        uint32_t fsqrt(const uint32_t &x)const;
        bool sqrtCheck(const uint32_t &)const;
        CheckResult printOperationCheck(const Float32 &f1, const Float32 &f2, const CheckedOperation & op)const;
        void randomOperationCheck(const int iterN, const CheckedOperation &op)const;
    private:
        std::array<uint32_t, FSQRT_PARAM_LINE_N> fsqrtParamA;
        std::array<uint32_t, FSQRT_PARAM_LINE_N> fsqrtParamB;
        void initFsqrtParam();

};
bool isNormalized(const float & input);
void randomOperationCheck(const int iterN, const CheckedOperation &op);


#endif