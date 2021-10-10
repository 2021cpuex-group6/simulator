#include <fstream>
#include <iostream>
#include <string>
#include <sstream>
#include "../utils/utils.hpp"

constexpr int INSTRUCTION_BYTE_N = 4;
const std::string INVALID_REGISTER = "不正なレジスタ名です";

enum op_style {
    R,
    I,
    S,
    B,
    U,
    J
};

static int8_t register_to_binary(std::string reg_name, const int &line);
static int32_t assemble_op(const std::string &op, const int &line);
static void assemble_error(const std::string &message, const int & line);

bool assembler_main(std::ofstream& ofs, std::istream& ifs) {
    // 一行ずつアセンブル
    int lineCount = 0;
    while(!ifs.eof()) {
        lineCount ++;
        std::string op;
        std::getline(ifs,op);
        int32_t binary_op = assemble_op(op, lineCount);
        int32_t byte;
        for (int i = 0; i < INSTRUCTION_BYTE_N; i++) {
            // 1バイトずつ出力
            byte = (binary_op >> (8*(3-i))) & 0xff;
            ofs << std::hex << byte << std::endl;
            std::cout << (unsigned int)byte << std::endl;
        }
        std::cout << op << " " << std::hex << binary_op << std::endl;
    }
    return true;
}


static int32_t assemble_op(const std::string & op, const int& line) {

    int32_t output = 0;
    std::istringstream iss(op);
    std::string opecode;
    iss >> opecode;
    enum op_style style;
    if (opecode == "addi") {
        style = I;
        output |= 0b0010011;
        output |= (0b000 << 12);
    } else if (opecode == "slti") {
        style = I;
        output |= 0b0010011;
        output |= (0b010 << 12);
    } else if (opecode == "sltiu") {
        style = I;
        output |= 0b0010011;
        output |= (0b011 << 12);
    } else if (opecode == "add") {
        style = R;
        output |= 0b0110011;
        output |= (0b000 << 12);
        output |= (0b0000000 << 25);
    } else if (opecode == "sub") {
        style = R;
        output |= 0b0110011;
        output |= (0b000 << 12);
        output |= (0b0100000 << 25);
    } else {
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
    } else {
        output = 0x00000013;
        std::cout << "nop" << std::endl;
        return output;
    }
    return output;
}

static int8_t register_to_binary(std::string reg_name, const int &line) {
    //　レジスタ名をデコード
    //  とりあえずpc, x0~x31の名前にする
    int8_t output = 0;
    if(startsWith(reg_name, "x")){
        output = std::stoi(reg_name.substr(1));
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
