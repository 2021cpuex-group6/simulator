#ifndef UTILS_H
#define UTILS_H

#include <string>

bool startsWith(const std::string &, const std::string &);

int32_t shiftRightLogical(const int32_t &input, const int & shiftN);
int32_t shiftRightArithmatic(const int32_t &input, const int & shiftN);
#endif