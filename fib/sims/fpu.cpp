#include <cstdint>
#include "../utils/utils.hpp"
#include "fpu.hpp"
#include <random>
#include <fstream>
#include <vector>
#include <iostream>
#include <bitset>
#include <math.h>

static const std::string PARAM_DIR = "params/";
static const std::string FSQRT_PARAM_A_FILE = "fsqrt_parama.txt";
static const std::string FSQRT_PARAM_B_FILE = "fsqrt_paramb.txt";
static const std::string PARAM_FILE_ERROR = "パラメータファイルが存在しません";
static const int WORD_BIT_N = 32;
static const uint32_t FLOAT_ONE = 0b00111111100000000000000000000000;

FPUUnit::FPUUnit(){
    initFsqrtParam();
}

// fsqrt のパラメータをロード
void FPUUnit::initFsqrtParam(){
    fsqrtParamA = {}; fsqrtParamB = {};
    std::ifstream ifs1(PARAM_DIR + FSQRT_PARAM_A_FILE);
    if(ifs1){
        std::string input;
        for(int i = 0; i < FSQRT_PARAM_LINE_N; i++){
            std::getline(ifs1, input);
            fsqrtParamA[i] = static_cast<uint32_t>(std::stoi(input, nullptr, 16));
        }
    }else{
        throw std::invalid_argument(PARAM_FILE_ERROR);
    }
    std::ifstream ifs2(PARAM_DIR + FSQRT_PARAM_B_FILE);
    if(ifs2){
        std::string input;
        for(int i = 0; i < FSQRT_PARAM_LINE_N; i++){
            std::getline(ifs2, input);
            fsqrtParamB[i] = static_cast<uint32_t>(std::stoi(input, nullptr, 16));
        }
    }else{
        throw std::invalid_argument(PARAM_FILE_ERROR);
    }

}


inline std::vector<uint32_t> separateFloat(const uint32_t &input){
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

uint32_t FPUUnit::fadd(const uint32_t & x1, const uint32_t& x2){
    return faddsub(x1, x2, false);
}
uint32_t FPUUnit::fsub(const uint32_t & x1, const uint32_t& x2){
    return faddsub(x1, x2, true);
}

uint32_t FPUUnit::fmul(const uint32_t & x1, const uint32_t& x2){
    // 浮動小数点の積

    // 0
    // 分解
    // 暗黙の1を追加
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);

    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];
    uint32_t s2 = shiftRightLogical(x2_[0], INT_BIT_N-1);
    uint32_t e2 = x2_[1] >> (INT_BIT_N - 9u);
    uint32_t m2 = x2_[2];

    uint32_t hx1 = shiftRightLogical(m1, 11) | 1u << 12;
    uint32_t lx1 = m1 & 0x7ff; 
    uint32_t hx2 = shiftRightLogical(m2, 11) | 1u << 12;
    uint32_t lx2 = m2 & 0x7ff; 

    // 1-1
    // 積を部分ごとに計算
    // lx1*lx2は切り捨て
    uint32_t hh = (hx1 * hx2) & 0x3ffffff;
    uint32_t hl = (hx1 * lx2) & 0xffffff;
    uint32_t lh = (lx1 * hx2) & 0xffffff;

    // 1-2
    // 指数部を加算
    // 129を足すと最上位ビットがない=アンダーフローとなる
    uint32_t ae = (e1 + e2 + 129u) & 0x1ff;

    // 1-3
    // yの符号
    uint32_t sy = s1 != s2 ? 1u : 0;

    // 1-a
    // 両方の指数部が0でないかどうか
    bool f1 = (e1 != 0) && (e2 != 0);

    // 2-1
    // 部分積を加算
    uint32_t shl = shiftRightLogical(hl, 11) & 0x3ffffff;
    uint32_t slh = shiftRightLogical(lh, 11) & 0x3ffffff;
    uint32_t am = (hh + shl + slh + 2) & 0x3ffffff;

    // 2-2
    // 指数部+1を計算
    uint32_t be = (ae + 1) & 0x1ff;

    // 3-1
    // 指数部選択
    uint32_t ey = ((ae & (1u << 8)) != 0) && f1 ? 
                        ((am & (1u << 25)) != 0 ? (be & 0xff) : (ae & 0xff))
                       :0;
    // 3-2
    // 仮数部を正規化
    uint32_t my = (am & (1u << 25)) != 0 ? (shiftRightLogical(am, 2)) : (shiftRightLogical(am, 1));
    my &= 0x7fffff;

    // 3-3
    // 返す
    return (sy << (INT_BIT_N-1)) | (ey << (INT_BIT_N-9)) | my;
}

uint32_t FPUUnit::fdiv(const uint32_t & x1, const uint32_t& x2){
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);

    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];
    uint32_t s2 = shiftRightLogical(x2_[0], INT_BIT_N-1);
    uint32_t e2 = x2_[1] >> (INT_BIT_N - 9u);
    uint32_t m2 = x2_[2];

    // 仮数部の大きさを比較
    bool flg1 = (m1 < m2);

    // 1を用いてx1の仮数のシフト量を決定
    uint32_t sft = flg1 ? 24u : 23u;

    // シフト

    uint64_t sm = (0x800000 | static_cast<uint64_t>(m1)) << sft;

    // 除算
    // 遅そう
    uint32_t mya = sm / (0x800000 | m2);

    // 指数部を2パターン計算
    // fmul同様のアンダーフロー検出
    // x1が0かも判定
    uint32_t ey1 = (e1 + 383u - e2) & 0x1ff;
    uint32_t ey2 = (ey1 - 1u) & 0x1ff;
    bool flg2 = e1 != 0;

    // 指数部を選択
    uint8_t ey = ((ey1 & 0x100) != 0) && flg2 ? ( flg1 ? ey2 & 0xff : ey1 & 0xff)
                                                : 0;

    // 符号はXOR
    uint32_t sy = (s1 != s2) ? 1 : 0;

    // 返す

    return (sy << (INT_BIT_N-1)) | (ey << (INT_BIT_N - 9)) | (mya & 0x7fffff);

}

// 平方根
uint32_t FPUUnit::fsqrt(const uint32_t & x)const{
    uint32_t address = (shiftRightLogical(x, 14)) & 0x3ff;
    uint32_t a = fsqrtParamA[address];
    uint32_t b = fsqrtParamB[address];
    uint32_t bx = ((x & 0x3fff) * b) & 0x7ffffff;
    uint32_t sbx  = shiftRightLogical(bx, 13);
    uint32_t y_m = (a + sbx) & 0x7fffff;
    uint32_t aex = ((shiftRightLogical(x, 23) & 0xff) + 127) & 0x1ff;
    uint32_t y_e = (x & 0x7fc00000) != 0 ? shiftRightLogical(aex, 1) : 0;
    return (x & 0x80000000) | (y_e << 23) | y_m;
}

// 解が2つあるとき，c++の実装と一致しないので，それでも基準を満たすかを検証
// 返り値
//  int ... verilogの実装の返り値
//  bool ... c++の実装と異なる可能性がある場合（解が2つある場合） true
std::pair<uint32_t, bool> FPUUnit::itofDebug(const uint32_t & x, const bool &forDebug){
    uint32_t it = 0x7fffffff & (~x);
    uint32_t ita = 0x7fffffff & (it + 1);
    uint64_t ml = (x & 0x80000000) != 0 ? (static_cast<uint64_t>(ita) << 24) : (static_cast<uint64_t>(x) << 24);

    uint32_t sft = 0;
    uint64_t mask = 0x40000000000000; // 54ビット目のみ1
    for(int i = 0; i < WORD_BIT_N -1 ; i++ ){
        if((mask & ml) != 0){
          sft = (30 - i);
          break;
        } 
        mask = mask >> 1;
        if(i == WORD_BIT_N - 2){
            sft = 0b11111;
        }
    }
    uint32_t ms = (ml >> sft) & 0x1ffffff;
    uint32_t ma = shiftRightLogical(ms, 1) + (ms & 0x1);
    uint32_t m = (ma & 0x1000000) ? shiftRightLogical(ma, 1) : (ma & 0x7fffff);
    uint32_t ea = 0xff & (127u + sft + shiftRightLogical(ma, 24));
    uint32_t e = 0xff & ((sft == 0b11111u) ? 0 : ea);
    uint32_t s = x & 0x80000000;
    uint32_t ans = s | (e << (WORD_BIT_N - 9)) | m;
    if(forDebug){
        // 変わる可能性があるのは，sftされた分を切り出すと0で，かつms[0]が1のとき（その整数と+-1でしか有効な浮動小数点数が存在しないとき?）
        if(sft != 0b11111){
            uint32_t shifted_mask =  shiftRightLogical(0x2fffffff, 30 - sft);
            if((ml & shifted_mask)  == 0){
                return {ans, (ms & 0x1) != 0};
            }
        }else{
            // ans = 0
        }
    }
    return {ans, false};
}

// 整数レジスタの値に一番近い浮動小数点値を浮動小数点レジスタへ
// 最適化のため，上のコードのコピペとなっている．
uint32_t FPUUnit::itof(const uint32_t & x){
    uint32_t it = 0x7fffffff & (~x);
    uint32_t ita = 0x7fffffff & (it + 1);
    uint64_t ml = (x & 0x80000000) != 0 ? (static_cast<uint64_t>(ita) << 24) : (static_cast<uint64_t>(x) << 24);

    uint32_t sft = 0;
    uint64_t mask = 0x40000000000000; // 54ビット目のみ1
    for(int i = 0; i < WORD_BIT_N -1 ; i++ ){
        if((mask & ml) != 0){
          sft = (30 - i);
          break;
        } 
        mask = mask >> 1;
        if(i == WORD_BIT_N - 2){
            sft = 0b11111;
        }
    }
    uint32_t ms = (ml >> sft) & 0x1ffffff;
    uint32_t ma = shiftRightLogical(ms, 1) + (ms & 0x1);
    uint32_t m = (ma & 0x1000000) ? shiftRightLogical(ma, 1) : (ma & 0x7fffff);
    uint32_t ea = 0xff & (127u + sft + shiftRightLogical(ma, 24));
    uint32_t e = 0xff & ((sft == 0b11111u) ? 0 : ea);
    uint32_t s = x & 0x80000000;
    uint32_t ans = s | (e << (WORD_BIT_N - 9)) | m;
    return ans;
}

// 浮動小数点レジスタからなるべく近い値を保持したまま整数レジスタへ
int32_t FPUUnit::ftoi(const uint32_t & x){
    auto x1_ =  separateFloat(x);
    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];

    uint32_t sft = (157 - e1) & 0x1f;
    bool flg = (e1 < 126u) || (157u < e1);
    uint32_t ml = 0x80000000 | (m1 << 8);
    uint32_t ms = shiftRightLogical(ml, sft);
    uint32_t ma = 0x7fffffff & (shiftRightLogical(ms, 1) + (0x1 & ms));
    uint32_t mata = 0x7fffffff & ((~ma) + 1) ;
    
    uint32_t ans =  flg ? 0u : (0x1 == s1 ? (0x80000000 | mata) : ma);
    return static_cast<int32_t>(ans);
}

int32_t FPUUnit::flt(const uint32_t &x1, const uint32_t &x2){
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);
    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];
    uint32_t s2 = shiftRightLogical(x2_[0], INT_BIT_N-1);
    uint32_t e2 = x2_[1] >> (INT_BIT_N - 9u);
    uint32_t m2 = x2_[2];

    bool nz1 = !(e1 == 0u);
    bool nz2 = !(e2 == 0u);

    bool elt = e1 < e2;
    bool eeq = e1 == e2;
    bool egt = !(elt || eeq);

    bool mlt = m1 < m2;
    bool mgt = m1 > m2;

    bool sp1 = s1 != 0;
    bool sp2 = s2 != 0;

    bool flg = (!nz1 &&  nz2 && !sp2) ||
		      ( nz1 && !nz2 &&  sp1) ||
		      ( nz1 &&  nz2 && (( sp1 && !sp2) ||
		                      ( sp1 &&  sp2 && (egt || (eeq && mgt))) ||
                                (!sp1 && !sp2 && (elt || (eeq && mlt)))));
    return flg ? 1 : 0;

}

int32_t FPUUnit::fle(const uint32_t &x1, const uint32_t &x2){
    auto x1_ =  separateFloat(x1);
    auto x2_ =  separateFloat(x2);
    uint32_t s1 = shiftRightLogical(x1_[0], INT_BIT_N-1);
    uint32_t e1 = x1_[1] >> (INT_BIT_N - 9u);
    uint32_t m1 = x1_[2];
    uint32_t s2 = shiftRightLogical(x2_[0], INT_BIT_N-1);
    uint32_t e2 = x2_[1] >> (INT_BIT_N - 9u);
    uint32_t m2 = x2_[2];

    bool nz1 = !(e1 == 0u);
    bool nz2 = !(e2 == 0u);

    bool seq = s1 == s2;

    bool elt = e1 < e2;
    bool eeq = e1 == e2;
    bool egt = !(elt || eeq);

    bool mlt = m1 < m2;
    bool meq = m1 == m2;
    bool mgt = !(meq || mlt);

    bool sp1 = s1 != 0;
    bool sp2 = s2 != 0;

    bool flg =(!nz1 && !nz2) || (seq & eeq && meq) ||
              (!nz1 &&  nz2 && !sp2) ||
		      ( nz1 && !nz2 &&  sp1) ||
		      ( nz1 &&  nz2 && (( sp1 && !sp2) ||
		                      ( sp1 &&  sp2 && (egt || (eeq && mgt))) ||
                                (!sp1 && !sp2 && (elt || (eeq && mlt)))));
    return flg ? 1 : 0;

}

uint32_t FPUUnit::floor(const uint32_t &x1){
    bool flg1 = ((x1 >> 23) & 0xff) > 149u;

    uint32_t f1 = itof(ftoi(x1));
    uint32_t f2 = fsub(f1, FLOAT_ONE);
    int32_t flg2 = flt(x1, f1);

    return flg1 ? x1 : (flg2 ? f2 : f1);

}

bool isNormalized(const float & input){
    // 入力された値が正規化数か調べる
    Float32 float32;
    float32.f32 = input;
    uint32_t exp = (float32.u32 >> 23u) & 0xff;
    if(exp == 0u){
        // 仮数が全部0なら正規化数
        return (float32.u32 & 0x7fffffu) == 0;
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

bool mulCheck(const uint32_t& input1, const uint32_t& input2){
    // 積の結果が合うかを調べる
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1, in2;
    in1.u32 = input1;
    in2.u32 = input2;

    float ans = in1.f32 * in2.f32;
    if(!isNormalized(ans)){
        return true;
    }
    uint32_t myAns = FPUUnit::fmul(in1.u32, in2.u32);
    Float32 myAns_;
    myAns_.u32 = myAns;
    float dif = fabs(myAns_.f32 - ans);
    float factor = pow(2, -22);
    float standard = fmax(fabs(ans) * factor, pow(2, -126));

    return dif < standard;
}

bool divCheck(const uint32_t& input1, const uint32_t& input2){
    // 商の結果が合うかを調べる
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1, in2;
    in1.u32 = input1;
    in2.u32 = input2;

    float ans = in1.f32 / in2.f32;
    if(!isNormalized(ans)){
        return true;
    }
    uint32_t myAns = FPUUnit::fdiv(in1.u32, in2.u32);
    Float32 myAns_;
    myAns_.u32 = myAns;
    float dif = fabs(myAns_.f32 - ans);
    float factor = pow(2, -20);
    float standard = fmax(fabs(ans) * factor, pow(2, -126));

    return dif < standard;
}

bool itofCheck(const uint32_t& input1){
    float ans = static_cast<int32_t>(input1);
    auto myAns = FPUUnit::itofDebug(input1, true);
    Float32 myAns_;
    myAns_.u32 = myAns.first;
    if(ans != myAns_.f32 && myAns.second){
        // 違っていて，かつ解が2つ許されるとき
        // c++の実装では最下位ビットが0になるのでそれに合わせる;
        myAns_.u32 = myAns.first & 0xfffffffe;
        return myAns_.f32 == ans;
    }
    return true;
}

bool ftoiCheck(const uint32_t& input1){
    Float32 in1;
    in1.u32 = input1;
    if(in1.f32 < (1 -pow(2, 31)) || (pow(2, 31) -1) < in1.f32) return true;
    int32_t ans = std::round(in1.f32);
    int32_t myAns = FPUUnit::ftoi(in1.f32);

    return ans == myAns;
}

bool FPUUnit::sqrtCheck(const uint32_t& input1)const{
    // 平方根の結果が合うかを調べる
    // // 入力が負なら問答無用でtrue
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1;
    in1.u32 = input1;
    if(in1.f32 < 0) return true;
    float ans = sqrt(in1.f32);
    if(!isNormalized(ans)){
        return true;
    }
    uint32_t myAns = fsqrt(in1.u32);
    Float32 myAns_;
    myAns_.u32 = myAns;
    float dif = fabs(myAns_.f32 - ans);
    float factor = pow(2, -20);
    float standard = fmax(fabs(ans) * factor, pow(2, -126));

    return dif < standard;
}

bool flteCheck(const uint32_t& input1, const uint32_t& input2, const bool &isFlt){
    // flt, fleの結果が合うかを調べる
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1, in2;
    in1.u32 = input1;
    in2.u32 = input2;

    bool ans, myAns;
    if(isFlt){
        myAns = FPUUnit::flt(in1.u32, in2.u32) != 0;
        ans = in1.f32 < in2.f32;
    }else{
        myAns = FPUUnit::fle(in1.u32, in2.u32) != 0;
        ans = in1.f32 <= in2.f32;
    }
    return myAns == ans;
}

bool floorCheck(const uint32_t& input1){
    // 平方根の結果が合うかを調べる
    // // 入力が負なら問答無用でtrue
    // c++の実装の結果で答えが非正規化数になるものは結果によらずtrue
    Float32 in1;
    in1.u32 = input1;
    float ans = std::floor(in1.f32);
    Float32 myAns_;
    myAns_.u32 =  FPUUnit::floor(input1);;

    return ans == myAns_.f32;
}

CheckResult FPUUnit::printOperationCheck(const Float32 &f1, const Float32 &f2,
                                             const CheckedOperation & op)const{
    // add, subの結果が正しいか調べ、print
    if(isNormalized(f1.f32) && isNormalized(f2.f32)){
        bool res = false;
        Float32 myAns, trueAns;
        myAns.u32 = 0;
        trueAns.u32 = 0;
        switch(op){
            case CheckedOperation::FLT:
                res = flteCheck(f1.u32, f2.u32, true);
                myAns.u32 = flt(f1.u32, f2.u32);
                trueAns.f32 = f1.f32 < f2.f32;
                break;
            case CheckedOperation::FLE:
                res = flteCheck(f1.u32, f2.u32, false);
                myAns.u32 = fle(f1.u32, f2.u32);
                trueAns.f32 = f1.f32 <= f2.f32;
                break;
            case CheckedOperation::ADD:
                res = addSubCheck(f1.u32, f2.u32, false);
                myAns.u32 = faddsub(f1.u32, f2.u32, false);
                trueAns.f32 = f1.f32 + f2.f32;
                break;
            case CheckedOperation::SUB:
                res = addSubCheck(f1.u32, f2.u32, true);
                myAns.u32 = faddsub(f1.u32, f2.u32, true);
                trueAns.f32 = f1.f32 - f2.f32;
                break;
            case CheckedOperation::MUL:
                res = mulCheck(f1.u32, f2.u32);
                myAns.u32 = FPUUnit::fmul(f1.u32, f2.u32);
                trueAns.f32 = f1.f32 * f2.f32;
                break;
            case CheckedOperation::DIV:
                res = divCheck(f1.u32, f2.u32);
                myAns.u32 = FPUUnit::fdiv(f1.u32, f2.u32);
                trueAns.f32 = f1.f32 / f2.f32;
                break;
            case CheckedOperation::SQRT:
                res = sqrtCheck(f1.u32);
                myAns.u32 = FPUUnit::fsqrt(f1.u32);
                trueAns.f32 = sqrt(f1.f32);
                break;
            case CheckedOperation::FTOI:
                res = ftoiCheck(f1.u32);
                myAns.u32 = static_cast<int32_t>(FPUUnit::ftoi(f1.u32));
                trueAns.u32 = std::round(f1.f32);
                break;
            case CheckedOperation::ITOF:
                res = itofCheck(f1.u32);
                myAns.u32 = FPUUnit::itof(f1.u32);
                trueAns.f32 = static_cast<int32_t>(f1.u32);
                break;
            case CheckedOperation::FLOOR:
                res = floorCheck(f1.u32);
                myAns.u32 = FPUUnit::floor(f1.u32);
                trueAns.f32 = std::floor(f1.f32);
                break;
            default:
                break;
        }
        if(!res){
            std::cout << f1.f32 << " " << f2.f32 << " " << trueAns.f32
                << " " << myAns.f32  << std::endl;
            std::cout << std::bitset<32>(f1.u32) << " " 
                << std::bitset<32>(f2.u32) << std::endl;
            std::cout << std::bitset<32>(trueAns.u32) << std::endl;
            std::cout << std::bitset<32>(myAns.u32) <<  std::endl;
            return CheckResult::INVALID;
        }
        return CheckResult::CLEAR;
    }
    return CheckResult::OUT_OF_RANGE;

}


void FPUUnit::randomOperationCheck(const int iterN, const CheckedOperation &op)const{
    // ランダムでadd, subの実装とc++の結果を比べる
    std::random_device rnd;
    int checkedN = 0;
    int wrongN = 0;
    
    for(int i=0; i < iterN; i++){
        Float32 f1, f2;
        CheckResult res;
        if(static_cast<int>(op) < static_cast<int>(CheckedOperation::SQRT)){
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
        }else{
            f1.u32 = rnd();
            if(op == CheckedOperation::SQRT){
                f1.u32 = f1.u32 & 0x7fffffff;
            }else if(op == CheckedOperation::FTOI){
                // 浮動小数点数を2^31 -1 ~ -2^31 + 1の間に(なるべく)入るようにする
                if(f1.u32 & 0x80000000){
                    f1.u32 &= 0x9fffffff;
                }else{
                    f1.u32 |= 0x60000000;
                }
            }
            f2.u32 = 0;
        }
        res = printOperationCheck(f1, f2, op);
        switch (res){
            case CheckResult::INVALID:
                wrongN++;
            case CheckResult::CLEAR:
                checkedN++;
            default:
                break;
        }
    }
    std::cout << "checkedN: " << checkedN << std::endl;
    std::cout << "wrongN: " << wrongN << std::endl;


}
