#include "parser.hpp"
#include <vector>
#include <map>
#include <iostream>
#include <fstream>
#include <regex>
#include <cmath>




std::map<std::string, int> opCounter = {};
std::map<std::string, std::vector<int>>opcodeInfoMap = {
    // 命令の情報を持つ
    // ind
    //  0 ...受け取るオペコード数
    //  1 ...即値が何番目に入るか（入らなければ-1）
    //  2 ...ラベルが何番目に入るか（入らなければ-1）
    //  3 ...即値のビット数（なければ-1）
    //  4 ...命令種別

    {"nop",     {0, -1, -1, -1, INST_OTHERS}}, 
    {"add",     {3, -1, -1, -1, INST_REGONLY}}, 
    {"addi",    {3, 2, -1, 12, INST_REGIMM}}, 
    {"blt",     {3, -1, 2, -1, INST_CONTROL}}, 
    {"beq",     {3, -1, 2, -1, INST_CONTROL}}, 
    {"j",       {1, -1, 0, -1, INST_CONTROL}}
};


int getFileLen(const std::string& filePath){
    int ans = 0;
    std::ifstream file(filePath);
    std::string line;
    while(std::getline(file, line)){
        ans++;
    }
    return ans;
}

int getImmediate(const int& lineN, const int& immediateBitN, const std::string& intStr){
    // 即値を示す文字をintに変換
    // その際、即値が範囲内かも判定
    // 即値はすべて符号付
    int res;
    try{
        res = std::stoi(intStr);
    }catch (const std::invalid_argument& e){
        parseError(lineN, INVALID_IMMEDIATE_NOT_INT);
    }catch (const std::out_of_range& e){
        parseError(lineN, INVALID_IMMEDIATE_OUT_OF_RANGE);
    }
    int standard = std::pow(2, immediateBitN-1);
    if(res < -1 * standard || res > standard + 1){
        parseError(lineN, INVALID_IMMEDIATE_OUT_OF_RANGE);
    }
    return res;
}

void parseError(const int& lineN, const std::string& error){
    // エラーが起きた行数とともに知らせる
    throw std::invalid_argument(std::to_string(lineN) + "行目:" + error);
}


AssemblyParser::AssemblyParser(const std::string &filePath){
    int len = getFileLen(filePath);
    instructionVector.resize(len);
    parseFile(filePath);

}

void AssemblyParser::parseFile(const std::string& filePath){
    std::ifstream file(filePath);
    if(! file.is_open()){
        throw std::invalid_argument(FILE_NOTFOUND);
    }
    std::string line;

    const std::regex instRe(R"(^\s+(.*))");
    const std::regex labelRe(R"(^([0-9a-zA-Z_]+):\s*)");
    const std::regex commentRe(R"((.*)\s*#.*)");
    const std::regex spaceRe(R"(\s*)");


    
    std::smatch m;
    int lineN = 0;


    while(std::getline(file, line)){
        lineN++;
        // コメント除去
        if(std::regex_match(line, m, commentRe)){
            line = m[1].str();
        }

        if(std::regex_match(line, m, instRe)){
            // 命令
            instParse(lineN, m[1].str());
        }else if(std::regex_match(line, m, labelRe)){
            // ラベル
            labelMap.insert({m[1].str(), lineN});
            Instruction inst = {InstType::Label};
            instructionVector[lineN-1] = inst;
        }else if(std::regex_match(line, m, spaceRe)){
            Instruction inst = {InstType::Comment};
            instructionVector[lineN-1] = inst;
        }else{
            // 不正な行
            parseError(lineN, INVALID_LINE_MESSAGE);
        }

    }
}

void AssemblyParser::instParse(const int lineN, std::string instLine){
    // 命令部分をパース
    std::vector<std::string> instVec;
    std::regex instUnit(R"([a-z0-9]+)");
    std::smatch m;
    int count = -1;
    int labelInd = -1;
    int immediateInd = -1;
    int immediateBitN = -1;
    Instruction inst;
    inst.type = InstType::Inst;

    while (std::regex_search(instLine, m, instUnit)) {
        std::string res = m[0].str();
        if(count == -1){
            inst.opcode = res;
            try{
                std::vector<int> info = opcodeInfoMap.at(res);
                inst.operandN = info[0];
                immediateInd = info[1];
                labelInd = info[2];
                immediateBitN = info[3];
            }catch(const std::out_of_range& e){
                // 不正なオペコード
                parseError(lineN, INVALID_OPCODE_MESSAGE); 
            }
        }else{
            if(count == labelInd){
                inst.label = res;
            }else if(count == immediateInd){
                inst.immediate = getImmediate(lineN, immediateBitN,  res);
            }else if(count == MAX_OPERAND_N){
                parseError(lineN, INVALID_OPERAND_N);
            }
            inst.operand[count] = res;
        }    
        count ++;
        instLine = m.suffix();
    }
    if(count != inst.operandN) parseError(lineN, INVALID_OPERAND_N);

    instructionVector[lineN-1] = inst;

}



