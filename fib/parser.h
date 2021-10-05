#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <map>
struct Instruction{
    int type; // 0 instruction, 1 label, 2 comment
    int oplandN;
    int opcode;
    std::string opland[3];
    std::string label;
};

std::map<std::string, int> opCounter = {};

#endif