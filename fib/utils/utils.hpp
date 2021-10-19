#ifndef UTILS_H
#define UTILS_H

#include <string>

static constexpr int  SHIFT_MASK_5 = 0b11111; 
static constexpr int SHIFT_MASK31 = 0x7fffffff;
static constexpr int INT_BIT_N = 32;

bool startsWith(const std::string &, const std::string &);

int32_t shiftRightLogical(const int32_t &input, const unsigned int & shiftN);
int32_t shiftRightArithmatic(const int32_t &input, const unsigned int & shiftN);
#endif