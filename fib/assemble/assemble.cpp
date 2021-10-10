#include <fstream>
#include <iostream>
#include <string>
#include <sstream>
#include <map>
#include <tuple>
#include <regex>
#include <cmath>
#include "../utils/utils.hpp"
#include "assemble.hpp"


bool assembler_main(std::ofstream& ofs, std::istream& ifs) {
    // 一行ずつアセンブル
    check_labels(ifs);
    int line_count = 1;             // 読み込んだファイルの行数
    int addr_count = START_ADDRESS; // 出力する命令のアドレス
    while(!ifs.eof()) {
        std::string op;
        std::getline(ifs,op);
        const int32_t & binary_op  = assemble_op(op, line_count, addr_count);

        int32_t byte;
        if(binary_op != NOP || !ELIMINATE_NOP){
            // 通常の命令かNOPを出力する設定の時
            for (int i = 0; i < INSTRUCTION_BYTE_N; i++) {
                // 1バイトずつ出力
                byte = (binary_op >> (8*(3-i))) & 0xff;
                ofs << std::hex << byte << std::endl;
                std::cout << std::hex << (unsigned int)byte << std::endl;
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


static std::int32_t assemble_op(const std::string & op, const int& line, const int addr) {
    // 一行をパースし、命令の数値表現を返す
    int32_t output = 0;
    std::istringstream iss(op);
    std::string opecode;
    iss >> opecode;
    enum op_style style;
    try{
        // mapからオペコードの情報を取得
        const auto & opecode_data = opecode_map.at(opecode);
        style = std::get<op_style>(opecode_data);
        output = std::get<int32_t>(opecode_data);
    }catch (const std::out_of_range & e){
        // 登録外
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
        std::string op1, op2;
        if(opecode == "j"){
            iss >> op1;
            int32_t label_addr = get_relative_address_with_check(op1, addr, 21, line);
            label_addr = get_J_imm(label_addr);
            output |= label_addr;
        }else if(opecode == "jal"){
            iss >> op1 >> op2;
            int32_t rg1 = static_cast<int32_t>(register_to_binary(op1, line));
            int32_t label_addr = get_relative_address_with_check(op2, addr, 21, line);
            label_addr = get_J_imm(label_addr);
            output |= label_addr | (rg1 << 7);
        }
    } else if(style == B){
        std::string op1, op2, op3;
        iss >> op1 >> op2 >> op3;
        int32_t rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        int32_t rg2 = static_cast<int32_t>(register_to_binary(op2, line));
        int32_t label_addr = get_relative_address_with_check(op3, addr, 13, line);
        label_addr = get_B_imm(label_addr);
        output |= label_addr | (rg1 << 15) | (rg2 << 20);

    } else {
        output = NOP;
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

static void check_labels(std::istream& ifs){
    // 初めにファイルを全探索してラベルを探す
    // そのあと、ファイルポインタをもとにもどす
    int line_count = 1;
    int addr_count = START_ADDRESS;
    while(!ifs.eof()) {
        std::string op;
        std::getline(ifs,op);

        std::istringstream iss(op);
        std::string opecode;
        iss >> opecode;
        try{
            // mapからオペコードの情報を取得
            const auto & opecode_data = opecode_map.at(opecode);
        }catch (const std::out_of_range & e){
            // NOPのとき
            std::smatch m;
            if(std::regex_match(op, m, label_re)){
                // ラベル
                auto pib =  label_map.insert({m[1].str(), addr_count});
                if(! pib.second){
                    // ラベルの重複
                    assemble_error(DOUBLE_LABEL, line_count);
                }
            }
            if( ELIMINATE_NOP){
                // 出力しない場合、行数だけインクリメントし、命令アドレスは動かさない
                line_count ++;
                continue;
            }
        }
        line_count ++;
        addr_count += INSTRUCTION_BYTE_N;
    }
    ifs.clear();
    ifs.seekg(0, std::ios_base::beg);
}

static int32_t get_relative_address_with_check(const std::string &label, 
                        const int & now_addr, const int & max_bit, const int & line){
    // ラベル名から相対アドレスを手に入れる。(1ビット右シフト済)
    // その際、既定の範囲内かも調べ、そうでなかったらエラーを出す
    int32_t address;
    try{
        address = label_map.at(label);
    }catch(const std::out_of_range &e){
        assemble_error(LABEL_NOT_FOUND, line);
    }
    address -= now_addr;
    if(address < -1 * std::pow(2, max_bit-1) || address >= std::pow(2, max_bit-1)){
        // 範囲外だった
        assemble_error(LABEL_TOO_FAR, line);
    }
    int32_t mask = (MASK_BITS>>(32-max_bit)); // 負数の右シフトが不定だったので、この実装になった

    return (address >> 1) & mask;


}

static int32_t get_J_imm(int32_t  input){
    // J形式の即値を並び変える
    // すでに1ビット省略しているので、20ビットの入力
    int32_t ans = (input << 12 ) & (~MASK_BITS); //20
    ans |= (input & 0x3ff) << 21; //10-1
    ans |= (input & 0x400) << 10; //11
    ans |= (input & 0x7f800) << 1; // 19-12
    return ans;
}

static int32_t get_B_imm(int32_t  input){
    // B形式の即値を並び変える
    // すでに1ビット省略しているので、12ビットの入力
    int32_t ans = (input << 20 ) & (~MASK_BITS); //12
    ans |= (input & 0x3f0) << 21; //10-5
    ans |= (input & 0xf) << 8; //4-1
    ans |= (input & 0x400) >> 3; // 11
    return ans;
}

void init_opcode_map(){
    // opecode_mapに値を設定して使えるようにする。
    // アセンブルする前に必ず実行すること。
    int32_t output = 0;
    output = 0b0010011;
    output |= (0b000 << 12);
    opecode_map.insert({"addi", {I, output}});
    output = 0b0010011;
    output |= (0b010 << 12);
    opecode_map.insert({"slti", {I, output}});
    output = 0b0010011;
    output |= (0b011 << 12);
    opecode_map.insert({"sltiu", {I, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0000000 << 25);
    opecode_map.insert({"add", {R, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0100000 << 25);
    opecode_map.insert({"sub", {R, output}});
    // jはjalの書き込みレジスタx0版
    output = 0b1101111;
    opecode_map.insert({"j", {J, output}});
    opecode_map.insert({"jal", {J, output}});
    output = 0b1100011;
    opecode_map.insert({"beq", {B, output}});
    output |= (0b001 << 12);
    opecode_map.insert({"bne", {B, output}});
    output = 0b1100011;
    output |= (0b100 << 12);
    opecode_map.insert({"blt", {B, output}});
    output |= (0b1 << 12);
    opecode_map.insert({"bge", {B, output}});
}