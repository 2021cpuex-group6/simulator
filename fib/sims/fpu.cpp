#include <cstdint>
#include "../utils/utils.hpp"
#include "fpu.hpp"
#include <random>
#include <vector>
#include <iostream>
#include <bitset>
#include <math.h>

std::vector<uint32_t> separateFloat(const uint32_t &input){
    // inputに入った32ビットfloatを符号，指数部，仮数部に分離する
    uint32_t sign = input  & (0b1 << (INT_BIT_N-1));
    uint32_t exp = input & (0b11111111 << (INT_BIT_N - 9));
    uint32_t mantissa = input & (shiftRightLogical(~0u, 9));
    return {sign, exp, mantissa};
}



uint32_t faddsub(const uint32_t & x1, const uint32_t& x2, const bool &isSub){
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);

    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];
    uint32_t s2 = shiftRightLogical(x2_[0], INT_BIT_N-1);
    s2 = (s2 == 1u) ^ isSub ? 1u: 0;
    uint32_t e2 = x2_[1] >> (INT_BIT_N - 9u);
    uint32_t m2 = x2_[2];

    

    uint32_t tm1 = m1 | (0b1 << 23);
    uint32_t tm2 = m2 | (0b1 << 23);

    bool f1 = ((e1 << 23) | m1) > ((e2 << 23) | m2);

    uint32_t de1 = 0b11111111 & (e1 - e2);
    uint32_t de2 = 0b11111111 & (e2 - e1);
    uint32_t de = (e1 > e2) ? de1 : de2;
    uint32_t stm1 = shiftRightLogical(tm1, de);
    uint32_t stm2 = shiftRightLogical(tm2, de);
    uint32_t sm1 = (e1 != 0) ? stm1 : 0;
    uint32_t sm2 = (e2 != 0) ? stm2 : 0;

    uint32_t bm = f1 ? tm1 : tm2;
    uint32_t sm = f1 ? sm2 : sm1;
    uint32_t be = f1 ? e1 : e2;
    uint32_t bs = f1 ? s1 : s2;
    
    bool f2 = (s1 != s2);
    uint32_t add = shiftRightLogical(~0u, 7) & (bm + sm);
    uint32_t sub = shiftRightLogical(~0u, 7) & (bm - sm);
    uint32_t res = f2 ? sub : add;

    uint32_t nz = 25;
    uint32_t nz_mask = 0b1 << 24;
    for(int i = 0; i < 25; i++){
        if(res & nz_mask){
            nz = i;
            break;
        }
        nz_mask >>= 1;
    }

    uint32_t ie = 0b111111111 & (be + 1);
    uint32_t smy = shiftRightLogical(~0u, 7) & (res << nz);
    uint32_t my = (shiftRightLogical(~0u, 8) & smy) >> 1;
    uint32_t se = ie - nz;
    uint32_t sy = ((se & (0b1 << 9)) !=0 || nz == 25u) ? 0 : (se & 0b11111111);

    return (bs << (INT_BIT_N-1)) | (sy << (INT_BIT_N -9)) | my;
    
}

uint32_t fadd(const uint32_t & x1, const uint32_t& x2){
    return faddsub(x1, x2, false);
}
uint32_t fsub(const uint32_t & x1, const uint32_t& x2){
    return faddsub(x1, x2, true);
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

bool addSubCheck(const uint32_t& input1, const uint32_t& input2,
                    const bool& isSub){
    // 加算の結果が合うかを調べる
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1, in2;
    in1.u32 = input1;
    in2.u32 = input2;

    float ans;
    if(isSub){
        ans = in1.f32 - in2.f32;
    }else{
        ans = in1.f32 + in2.f32;
    }
    if(!isNormalized(ans)){
        return true;
    }
    uint32_t myAns = faddsub(in1.u32, in2.u32, isSub);
    Float32 myAns_;
    myAns_.u32 = myAns;
    float dif = fabs(myAns_.f32 - ans);
    float factor = pow(2, -23);
    float standard = fmax(fmax(fabs(in1.f32) * factor, fabs(in2.f32) * factor), fmax(fabs(ans) * factor, pow(2, -126)));

    return dif < standard;
}

int printAddSubCheck(const Float32 &f1, const Float32 &f2, const bool &isSub){
    // add, subの結果が正しいか調べ、print
    // -1 ... 誤差大
    // 1  ... 基準を満たす
    // 0  ... 対象外
    if(isNormalized(f1.f32) && isNormalized(f2.f32)){
            if(!addSubCheck(f1.u32, f2.u32, isSub)){
                Float32 myAns, trueAns;
                myAns.u32 = faddsub(f1.u32, f2.u32, isSub);
                trueAns.f32 = f1.f32 + f2.f32;
                std::cout << f1.f32 << " " << f2.f32 << " " << trueAns.f32
                    << " " << myAns.f32  << std::endl;
                std::cout << std::bitset<32>(f1.u32) << " " 
                    << std::bitset<32>(f2.u32) << std::endl;
                std::cout << std::bitset<32>(trueAns.u32) << std::endl;
                std::cout << std::bitset<32>(myAns.u32) <<  std::endl;
                return -1;
            }
            return 1;
    }
    return 0;

}

void addSubRandomCheck(const int iterN, const bool &isSub){
    // ランダムでadd, subの実装とc++の結果を比べる
    std::random_device rnd;
    int checkedN = 0;
    int wrongN = 0;
    
    for(int i=0; i < iterN; i++){
        Float32 f1, f2;
        if(i < 20){
            f1.u32 = 0;
        }else if(i < 150){
            f1.u32 = rnd();
            f1.u32 |= 0x7c000000;
        }else if(i < 250){
            f1.u32 = rnd();
            f1.u32 &= 0x02ffffff;
        }else if(i < 350){
            f1.u32 = rnd();
            f1.u32 &= 0x01ffffff;
        }else{
            f1.u32 = rnd();
        }
        if(i % 10 == 0){
            f2.u32 = f1.u32;
        }else if (i % 15 == 0){
            f2.f32 = f1.f32 * -1;
        }else{
            f2.u32 = rnd();
        }
        int res = printAddSubCheck(f1, f2, isSub);
        if(res != 0){
            checkedN++;
            wrongN += res < 0 ? 1 : 0;
        }
        
    }
    std::cout << "checkedN: " << checkedN << std::endl;
    std::cout << "wrongN: " << wrongN << std::endl;


}
