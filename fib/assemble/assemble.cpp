#include <fstream>
#include <iostream>
#include <string>
#include <sstream>
#include <map>
#include <tuple>
#include <regex>
#include "../utils/utils.hpp"

constexpr bool ELIMINATE_NOP = false; // NOP命令を飛ばすか
constexpr int START_ADDRESS = 0; //ファイルのはじめの命令が配置されるアドレス
constexpr int INSTRUCTION_BYTE_N = 4;
constexpr int32_t NOP = 0x13;
const std::string INVALID_REGISTER = "不正なレジスタ名です";
const std::string DOUBLE_LABEL = "ラベルが重複しています";

const std::regex label_re(R"(^([0-9a-zA-Z_]+)\s*:\s*)");

enum op_style {
    R,
    I,
    S,
    B,
    U,
    J
};

std::map<std::string, int> label_map; // ラベル情報を保持
std::map<std::string, std::tuple<op_style, int32_t>> opcode_map; //各命令の情報を保持


static int8_t register_to_binary(std::string reg_name, const int &line);
static std::int32_t assemble_op(const std::string &op, const int &line, const int& addr);
static void assemble_error(const std::string &message, const int & line);



bool assembler_main(std::ofstream& ofs, std::istream& ifs) {
    // 一行ずつアセンブル
    int line_count = 1;             // 読み込んだファイルの行数
    int addr_count = START_ADDRESS; // 出力する命令のアドレス
    while(!ifs.eof()) {
        std::string op;
        std::getline(ifs,op);
        const int32_t & binary_op  = assemble_op(op, line_count, addr_count);

        int32_t byte;
        if(binary_op != NOP || ELIMINATE_NOP){
            // 通常の命令かNOPを出力する設定の時
            for (int i = 0; i < INSTRUCTION_BYTE_N; i++) {
                // 1バイトずつ出力
                byte = (binary_op >> (8*(3-i))) & 0xff;
                ofs << std::hex << byte << std::endl;
                std::cout << (unsigned int)byte << std::endl;
            }
        }else{
            // 出力しない場合、行数だけインクリメントし、命令アドレスは動かさない
            line_count ++;
            std::cout << op << " " << std::hex << binary_op << std::endl;
            continue;
            
        }
        line_count ++;
        addr_count += INSTRUCTION_BYTE_N;
        std::cout << op << " " << std::hex << binary_op << std::endl;

    }
    return true;
}


static std::int32_t assemble_op(const std::string & op, const int& line, const int &addr) {
    // 一行をパースし、命令の数値表現を返す
    int32_t output = 0;
    std::istringstream iss(op);
    std::string opecode;
    iss >> opecode;
    enum op_style style;
    try{
        // mapからオペコードの情報を取得
        const auto & opcode_data = opcode_map.at(opecode);
        style = std::get<op_style>(opcode_data);
        output = std::get<int32_t>(opcode_data);
    }catch (const std::out_of_range & e){
        // 登録外
        std::smatch m;
        if(std::regex_match(op, m, label_re)){
            // ラベル
            auto pib =  label_map.insert({m[1].str(), addr});
            if(! pib.second){
                // ラベルの重複
                assemble_error(DOUBLE_LABEL, line);
        }
        output = 0x00000013;
        std::cout << "nop" << std::endl;
        return output;
    }

    if (style == R) {
        std::string op1, op2, op3;
        iss >> op1 >> op2 >> op3;
        int32_t rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        int32_t rg2 = static_cast<int32_t>(register_to_binary(op2, line));
        int32_t rg3 = static_cast<int32_t>(register_to_binary(op3, line));
        output |= (rg1 << 7) | (rg2 << 15) | (rg3 << 20);
    } else if (style == I) {
        std::string op1, op2;
        int32_t imm;
        iss >> op1 >> op2 >> imm;
        int32_t rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        int32_t rg2 = static_cast<int32_t>(register_to_binary(op2, line));
        imm &= 0xfff;
        output |= (rg1 << 7) | (rg2 << 15) | (imm << 20);
    } else if(style == J){
    } else if(style == B){
    } else {
        output = NOP;
        std::cout << "nop" << std::endl;
        return output;
    }
    return output;
    }
}

static int8_t register_to_binary(std::string reg_name, const int &line) {
    //　レジスタ名をデコード
    //  とりあえずpc, x0~x31の名前にする
    int8_t output = 0;
    if(startsWith(reg_name, "x")){
        output = std::stoi(reg_name.substr(1));
    }else if(reg_name == "zero"){
        output = 0;
    }else{
        // レジスタ名が不正
        assemble_error(INVALID_REGISTER, line);
    }

    return output;
}

static void assemble_error(const std::string &message, const int & line){
    // アセンブル中に発生したエラーを表示
    throw std::invalid_argument(std::to_string(line) + "行目:" + message);
}

void init_opcode_map(){
    // opcode_mapに値を設定して使えるようにする。
    // アセンブルする前に必ず実行すること。
    int32_t output = 0;
    output = 0b0010011;
    output |= (0b000 << 12);
    opcode_map.insert({"addi", {I, output}});
    output = 0b0010011;
    output |= (0b010 << 12);
    opcode_map.insert({"slti", {I, output}});
    output = 0b0010011;
    output |= (0b011 << 12);
    opcode_map.insert({"sltiu", {I, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0000000 << 25);
    opcode_map.insert({"add", {R, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0100000 << 25);
    opcode_map.insert({"sub", {R, output}});
    // jはjalの書き込みレジスタx0版
    output = 0b1101111;
    opcode_map.insert({"j", {J, output}});
    opcode_map.insert({"jal", {J, output}});
    output = 0b1100011;
    opcode_map.insert({"beq", {B, output}});
    output |= (0b001 << 12);
    opcode_map.insert({"bne", {B, output}});
    output = 0b1100011;
    output |= (0b100 << 12);
    opcode_map.insert({"blt", {B, output}});
    output |= (0b1 << 12);
    opcode_map.insert({"bge", {B, output}});
}