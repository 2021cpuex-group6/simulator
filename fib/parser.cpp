#include "parser.hpp"
#include <vector>
#include <map>
#include <iostream>
#include <fstream>
#include <regex>


std::map<std::string, int> opCounter = {};

int getFileLen(std::string filePath){
    int ans = 0;
    std::ifstream file(filePath);
    std::string line;
    while(std::getline(file, line)){
        ans++;
    }
    return ans;
}

AssemblyParser::AssemblyParser(std::string filePath){
    int len = getFileLen(filePath);
    instructionVector.resize(len);
    parseFile(filePath);

}

void AssemblyParser::parseFile(std::string filePath){
    std::ifstream file(filePath);
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

        }else if(std::regex_match(line, m, labelRe)){
            // ラベル
            labelMap.insert({m[1].str(), lineN});
        }else if(std::regex_match(line, m, spaceRe)){
            Instruction inst;
            inst.type = 2;
            inst.oplandN=0;
            inst.opcode = 0;
            instructionVector[lineN-1] = inst;
        }

    }
}

