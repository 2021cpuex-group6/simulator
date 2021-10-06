#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <map>
#include <vector>

const std::string INVALID_LINE_MESSAGE = "不正な行です";
const std::string INVALID_OPCODE_MESSAGE = "不正な命令です";
const std::string INVALID_IMMEDIATE_NOT_INT = "即値が入る場所に数以外が入っています";
const std::string INVALID_IMMEDIATE_OUT_OF_RANGE = "即値が範囲外です";
const std::string INVALID_OPERAND_N = "オペランドの数が合いません";
const std::string FILE_NOTFOUND = "ファイルが見つかりませんでした";
const std::string DOUBLE_LABEL = "ラベルが重複しています";

const int MAX_OPERAND_N = 3;

enum class InstType{
    Inst, 
    Label, 
    Comment
};

struct Instruction{
    InstType type; // 0 instruction, 1 label, 2 comment
    int operandN;
    std::string opcode;
    std::string operand[MAX_OPERAND_N];
    int immediate;
    std::string label;
};
constexpr int INST_REGONLY = 0;
constexpr int INST_REGIMM = 1;
constexpr int INST_MEM = 2;
constexpr int INST_CONTROL = 3;
constexpr int INST_OTHERS = 4;
extern std::map<std::string, std::vector<int>> opcodeInfoMap;

extern std::map<std::string, int> opCounter;

class AssemblyParser{
    public:
        std::vector<Instruction> instructionVector;
        std::map<std::string, int> labelMap;
        AssemblyParser(const std::string &filePath);
    private:
        void parseFile(const std::string &filePath);
        void instParse(const int lineN, std::string instLine);
        
};

void parseError(const int &, const std::string&);


#endif