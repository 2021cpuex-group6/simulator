#pragma once
#include <regex>
#include <fstream>
#include <map>


enum op_style {
    R,
    RF, //R形式の中で浮動小数点命令
    RF2, //R形式の浮動小数点命令でレジスタを2つ使うもの
    MIX, //浮動小数レジスタと整数レジスタ両方使うもの
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
void check_labels_many_files(const std::vector<std::string> &files, std::map<std::string, int> &label_map);