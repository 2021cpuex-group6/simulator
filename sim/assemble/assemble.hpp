#pragma once
#include <regex>
#include <fstream>
#include <map>


enum op_style {
    R,
    R2, //R形式の浮動小数点命令でレジスタを2つ使うもの
    I,
    IS, // シフト系の即値
    IL, //I形式の中でload系の命令
    S,
    B,
    U,
    J
};

struct output_flags_t {
    bool output_log;
    bool output_as_binary;
    output_flags_t() {
        output_log = false;
        output_as_binary = false;
        return;
    };
};




void assembler_main(std::ofstream& ofs, std::istream& ifs, struct output_flags_t output_flags);
void init_opcode_map();
void init_label_map();
void check_labels_many_files(const std::vector<std::string> &files, std::map<std::string, int> &label_map);
std::int32_t assemble_op(const std::string & op, const int& line, const int addr, const std::map<std::string, int> &label_dict);