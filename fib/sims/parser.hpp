#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <map>
#include <vector>
#include <regex>
#include <array>

const std::string INVALID_LINE_MESSAGE = "不正な行です";
const std::string INVALID_OPCODE_MESSAGE = "不正な命令です";
const std::string INVALID_IMMEDIATE_NOT_INT = "即値が入る場所に数以外が入っています";
const std::string INVALID_IMMEDIATE_OUT_OF_RANGE = "即値が範囲外です";
const std::string INVALID_OPERAND_N = "オペランドの数が合いません";
const std::string INVALID_OPERAND_FORMAT = "オペランドの形式が不正です";
const std::string FILE_NOTFOUND = "ファイルが見つかりませんでした";
const std::string DOUBLE_LABEL = "ラベルが重複しています";
const std::string TOP_NOT_COMMENT = "エントリポイントを用いる際，ファイルのはじめはコメントにしてください．";
const std::string ENTRY_POINT = "min_caml_start";
const std::string GUI_ERROR_TOP = "Error";
const std::string ENTRY_POINT_LABEL = "+ENTRY";

static const std::regex offsetRe(R"(\s*([\-0-9]+)\(\s*([a-z0-9%]+)\s*\)\s*)");


const int MAX_OPERAND_N = 3;

enum class InstType{
    Inst, 
    Label, 
    Comment, 
    // MetaCommand // .global で始まるコメント
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
constexpr int INST_LOAD = 2;
constexpr int INST_STORE = 3;
constexpr int INST_CONTROL = 4;
constexpr int INST_OTHERS = 5;
extern std::map<std::string, std::vector<int>> opcodeInfoMap;


class AssemblyParser{
    public:
        std::vector<std::string> filePaths;
        std::vector<Instruction> instructionVector;
        std::map<std::string, int> labelMap;
        AssemblyParser(const std::vector<std::string> &filePaths, const bool &useBin, const bool &forGUI);
        std::pair<std::string, int> getFileNameAndLine(const int &lineN)const;
    private:
        std::vector<int> startLines; // 各ファイルが何行目から始まるのかを記す
        bool forGUI;
        bool useBin;
        void parseFiles(const std::vector<std::string> &filePaths);
        int parseFile(const std::string &filePath, const int &startLine);
        void parseBinFile(const std::string &filePath);
        void instParse(const int &lineN, std::string instLine);
        void metaCommandParse(const int &lineN, const std::string &instLine);
        std::pair<std::string , int> parseOffsetAndRegister(const std::string & input, const int &lineN)const;
        void parseError(const int &, const std::string&)const;
        int getImmediate(const int& lineN, const int& immediateBitN, const std::string& intStr)const;
        
};
#endif