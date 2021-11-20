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
constexpr uint32_t NOT_INST_LINE_IND = 0xffffffff; //lineIndMapで命令行以外の行に挿入される

static const std::regex offsetRe(R"(\s*([\-0-9]+)\(\s*([a-z0-9%]+)\s*\)\s*)");


const int MAX_OPERAND_N = 3;

enum class InstType{
    Inst, 
    Label, 
    Comment, 
    // MetaCommand // .global で始まるコメント
};

struct Instruction{
    int lineN; // pc/4でインデックス付けするため，元のファイルでの行数情報を確保
    int operandN; // デアセンブラではregIndの数
    std::string opcode;
    std::string operand[MAX_OPERAND_N];
    int regInd[MAX_OPERAND_N];
    int immediate;
    std::string label;
    uint8_t opcodeInt; // 高速化のため，opcodeをuint8_t
};
constexpr int INST_REGONLY = 0;
constexpr int INST_2REGF = 1;
constexpr int INST_REGIMM = 2;
constexpr int INST_LOAD = 3;
constexpr int INST_STORE = 4;
constexpr int INST_CONTROL = 5;
constexpr int INST_OTHERS = 6;
extern std::map<std::string, std::vector<int>> opcodeInfoMap;


class AssemblyParser{
    public:
        std::vector<std::string> filePaths;
        std::vector<Instruction> instructionVector;
        std::vector<uint32_t> lineIndMap; // ファイルの行数をinstructionVectorのインデックスに変更 バイナリファイルを使わない時のみ使う
        std::map<std::string, int> labelMap; //値は次の命令のinstructionVectorでのインデックス
        AssemblyParser(const std::vector<std::string> &filePaths, const bool &useBin, const bool &forGUI);
        std::pair<std::string, int> getFileNameAndLine(const int &lineN)const;
        static std::map<uint8_t, std::string > getInverseOpMap();
    private:
        std::vector<int> startLines; // 各ファイルが何行目から始まるのかを記す
        bool forGUI;
        bool useBin;
        void parseFiles(const std::vector<std::string> &filePaths);
        void deassembleFile(const std::string &filePath);
        std::pair<int, int> parseFile(const std::string &filePath,
             const int &startLine, const int &instN);
        void parseBinFile(const std::string &filePath);
        void instParse(const int &lineN, const int &instN, std::string instLine);
        void metaCommandParse(const int &lineN, const int &instN, const std::string &instLine);
        std::pair<std::string , int> parseOffsetAndRegister(const std::string & input, const int &lineN)const;
        void parseError(const int &, const std::string&)const;
        int getImmediate(const int& lineN, const int& immediateBitN, const std::string& intStr)const;
        
};
#endif