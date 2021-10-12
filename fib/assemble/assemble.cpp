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
    } else if (style == RF){
        std::string op1, op2, op3;
        iss >> op1 >> op2 >> op3;
        int32_t rg1 = static_cast<int32_t>(fregister_to_binary(op1, line));
        int32_t rg2 = static_cast<int32_t>(fregister_to_binary(op2, line));
        int32_t rg3 = static_cast<int32_t>(fregister_to_binary(op3, line));
        output |= rounding_mode <<12;
        output |= (rg1 << 7) | (rg2 << 15) | (rg3 << 20);

    } else if (style == I) {
        std::string op1, op2;
        int32_t imm;
        iss >> op1 >> op2 >> imm;
        int32_t rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        int32_t rg2 = static_cast<int32_t>(register_to_binary(op2, line));
        imm = get_I_imm(imm, line);
        output |= (rg1 << 7) | (rg2 << 15) | imm;
    } else if(style == IL){
        std::string op1, op2;
        iss >> op1 >> op2 ;
        int32_t rg1;
        if(opecode == "flw"){
            rg1 = static_cast<int32_t>(fregister_to_binary(op1, line));
        }else{
            rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        }
        auto address = get_address_reg_imm(op2, line, true);
        output |= (rg1 << 7) | (address.second << 20) | (address.first);

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

    } else if(style == S){
        // x1 0(x1)のような書式
        std::string op1, op2;
        iss >> op1 >> op2 ;
        int32_t rg1;
        if(opecode == "fsw"){
            rg1 = static_cast<int32_t>(fregister_to_binary(op1, line));
        }else{
            rg1 = static_cast<int32_t>(register_to_binary(op1, line));
        }
        auto address = get_address_reg_imm(op2, line, false);
        output |= (rg1 << 15) | (address.second << 20) | (address.first);

    }else {
        output = NOP;
        std::cout << "nop" << std::endl;
        return output;
    }
    return output;
    
}

static int8_t register_to_binary(std::string reg_name, const int &line) {
    //　浮動小数点レジスタ名をデコード
    //  とりあえずf0~f31の名前にする
    int8_t output = 0;
    if(startsWith(reg_name, "f")){
        output = std::stoi(reg_name.substr(1));
    }else{
        // レジスタ名が不正
        assemble_error(INVALID_REGISTER, line);
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

static int32_t get_I_imm(int32_t input, const int &line){
    // I形式の即値をチェック、シフトする
    if(input < -1 * std::pow(2, 11) || input >= std::pow(2, 11)){
        assemble_error(OUT_OF_RANGE_IMM, line);
    }
    input &= 0xfff;
    return input << 20;
}

static int32_t get_S_imm(int32_t input, const int &line){
    // S形式の即値をチェック、シフトする
    if(input < -1 * std::pow(2, 11) || input >= std::pow(2, 11)){
        assemble_error(OUT_OF_RANGE_IMM, line);
    }
    int32_t ans = (input & 0xfe0) << 20;
    ans |= input & 0x1f << 7;
    return ans;
}

static std::pair<int32_t, int32_t> get_address_reg_imm(const std::string &input, const int & line, const bool & forI){
    // store, loadの第二引数（メモリアドレスのベースレジスタとオフセット）をパースする
    std::smatch m;
    if(std::regex_match(input, m, address_re)){
        // ラベル
        int32_t imm = std::stoi(m[1].str());
        if(forI){
            imm = get_I_imm(imm, line);
        }else {
            imm = get_S_imm(imm, line);
        }
        int32_t rg = static_cast<int32_t>(register_to_binary(m[2].str(), line));
        return {imm, rg};
        
    }else{
        assemble_error(INVALID_ADDRESSING, line);
    }
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
    output = 0b0010011;
    output |= (0b100 << 12);
    opecode_map.insert({"xori", {I, output}});
    output |= (0b110 << 12);
    opecode_map.insert({"ori", {I, output}});
    output |= (0b111 << 12);
    opecode_map.insert({"andi", {I, output}});
    output = 0b0000011;
    output |= (0b010 << 12);
    opecode_map.insert({"lw", {IL, output}});
    output = 0b0000011;
    output |= (0b100 << 12);
    opecode_map.insert({"lbu", {IL, output}});
    output = 0b0000111;
    output |= (0b010 << 12);
    opecode_map.insert({"flw", {IL, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0000000 << 25);
    opecode_map.insert({"add", {R, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0100000 << 25);
    opecode_map.insert({"sub", {R, output}});
    output = 0b0110011;
    output |= (0b100 << 12);
    opecode_map.insert({"xor", {R, output}});
    output |= (0b110 << 12);
    opecode_map.insert({"or", {R, output}});
    output |= (0b111 << 12);
    opecode_map.insert({"and", {R, output}});
    output = 0b0110011;
    output |= (0b001 << 12);
    opecode_map.insert({"sll", {R, output}});
    output = 0b0110011;
    output |= (0b010 << 12);
    opecode_map.insert({"slt", {R, output}});
    output |= (0b011 << 12);
    opecode_map.insert({"sltu", {R, output}});
    output = 0b0110011;
    output |= (0b101 << 12);
    opecode_map.insert({"srl", {R, output}});
    output |= (0b01 << 30);
    opecode_map.insert({"sra", {R, output}});
    output = 0b0110011;
    output |= (0b000 << 12);
    output |= (0b0000001 << 25);
    opecode_map.insert({"mul", {R, output}});
    output |= (0b100 << 12);
    opecode_map.insert({"div", {R, output}});
    output = 0b1010011;
    opecode_map.insert({"fadd", {RF, output}});
    output |= (0b0100<< 25);
    opecode_map.insert({"fsub", {RF, output}});
    output = 0b1010011;
    output |= (0b1000<< 25);
    opecode_map.insert({"fmul", {RF, output}});
    output |= (0b1100<< 25);
    opecode_map.insert({"fdiv", {RF, output}});
    // jはjalの書き込みレジスタx0版
    output = 0b1101111;
    opecode_map.insert({"j", {J, output}});
    opecode_map.insert({"jal", {J, output}});
    // jrもjalrの書き込みレジスタx0版
    output = 0b1100111;
    opecode_map.insert({"jalr", {I, output}});
    opecode_map.insert({"jr", {I, output}});
    output = 0b1100011;
    opecode_map.insert({"beq", {B, output}});
    output |= (0b001 << 12);
    opecode_map.insert({"bne", {B, output}});
    output = 0b1100011;
    output |= (0b100 << 12);
    opecode_map.insert({"blt", {B, output}});
    // output |= (0b1 << 12);
    // opecode_map.insert({"bge", {B, output}});
    output = 0b0100011;
    opecode_map.insert({"sb", {S, output}});
    output |= (0b010 << 12);
    opecode_map.insert({"sw", {S, output}});
    output = 0b0100111;
    output |= (0b010 << 12);
    opecode_map.insert({"fsw", {S, output}});
}