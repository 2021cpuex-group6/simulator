#pragma once
#include <regex>
#include <fstream>
#include <map>

const std::string ASSEMBLER_MODE_BYTE = "--byte";
const std::string ASSEMBLER_MODE_WORD = "--word";
const std::string ASSEMBLER_MODE_BINARY = "-b";
const std::string ASSEMBLY_BYTE_EXT = ".outb";
const std::string ASSEMBLY_WORD_EXT = ".outw";
const std::string ASSEMBLY_BINARY_EXT = ".out";


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

enum out_mode{
    BINARY, 
    BYTE, 
    WORD
};

struct output_flags_t {
    bool output_log;
    out_mode output_mode;
    output_flags_t() {
        output_log = false;
        output_mode = out_mode::BYTE;
        return;
    };
};




void assembler_main(std::ofstream& ofs, std::istream& ifs, struct output_flags_t output_flags);
void init_opcode_map();
void init_label_map();
void check_labels_many_files(const std::vector<std::string> &files,
         std::map<std::string, int> &label_map);
std::int32_t assemble_op(const std::string & op, const int& line, const int addr, const std::map<std::string, int> &label_dict);