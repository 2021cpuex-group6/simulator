#ifndef PARSER_H
#define PARSER_H

#include <string>
#include <map>
#include <vector>

struct Instruction{
    int type; // 0 instruction, 1 label, 2 comment
    int oplandN;
    int opcode;
    std::string opland[3];
    std::string label;
};

extern std::map<std::string, int> opCounter;

class AssemblyParser{
    public:
        std::vector<Instruction> instructionVector;
        std::map<std::string, int> labelMap;
        AssemblyParser(std::string);
    private:
        void parseFile(std::string filePath);
        
};

#endif