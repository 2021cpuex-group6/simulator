#pragma once
#include <regex>
#include <fstream>
#include <map>

static constexpr bool ELIMINATE_NOP = false; // NOP命令を飛ばすか
static constexpr int START_ADDRESS = 0; //ファイルのはじめの命令が配置されるアドレス
static constexpr int INSTRUCTION_BYTE_N = 4;
static constexpr int32_t NOP = 0x13;
static constexpr int32_t MASK_BITS = ~(1 << 31); // 右シフトが不定にならないように最上位以外1
static const std::string INVALID_REGISTER = "不正なレジスタ名です";
static const std::string DOUBLE_LABEL = "ラベルが重複しています";
static const std::string LABEL_NOT_FOUND = "ラベルが見つかりませんでした";
static const std::string LABEL_TOO_FAR = "遷移先のラベルが遠すぎます。実装を見直してください。";
static const std::regex label_re(R"(^([0-9a-zA-Z_]+)\s*:\s*(#.*)*)");
enum op_style {
    R,
    I,
    S,
    B,
    U,
    J
};

static std::map<std::string, int> label_map; // ラベル情報を保持
static std::map<std::string, std::tuple<op_style, int32_t>> opecode_map; //各命令の情報を保持
static int32_t get_J_imm(int32_t);
static int32_t get_B_imm(int32_t);

static int8_t register_to_binary(std::string reg_name, const int &line);
static std::int32_t assemble_op(const std::string &op, const int &line, const int& addr);
static void assemble_error(const std::string &message, const int & line);
static int32_t get_relative_address_with_check(const std::string &label,
                                const int & now_addr, const int & max_bit, const int &line);
static void check_labels(std::istream& ifs);


bool assembler_main(std::ofstream& ofs, std::istream& ifs);
void init_opcode_map();