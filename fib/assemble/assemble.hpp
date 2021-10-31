#pragma once
#include <regex>
#include <fstream>
#include <map>


enum op_style {
    R,
    RF, //R形式の中で浮動小数点命令
    I,
    IL, //I形式の中でload系の命令
    S,
    B,
    U,
    J
};




void assembler_main(std::ofstream& ofs, std::istream& ifs, bool output_log);
void init_opcode_map();
void init_label_map();