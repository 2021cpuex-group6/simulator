#include "parser.hpp"
#include "../assemble/deassemble.hpp"
#include "../assemble/assemble.hpp"
#include <vector>
#include <map>
#include <iostream>
#include <fstream>
#include <regex>
#include <cmath>


static const std::string SOME_BINARY_FILES = "バイナリファイルは複数入力できません.";
static const std::string INVALID_BINARY = "バイナリファイルは4バイトの倍数のサイズである必要があります.";
static const std::string IMPLEMENT_ERROR = "実装エラー：バグ報告してください．";
static constexpr int START_LINE = 0;
static constexpr int INST_BYTE_N = 4;
static constexpr bool USE_REAL_BINARY = true; // 本当のバイナリファイルを使う


std::map<std::string, std::vector<int>>opcodeInfoMap = {
    // 命令の情報を持つ
    // ind
    //  0 ...受け取るオペコード数 (4(x2)のような場合はまとめて一つとする)
    //  1 ...即値が何番目に入るか（入らなければ-1）
    //  2 ...ラベルが何番目に入るか（入らなければ-1）
    //  3 ...即値のビット数（なければ-1）
    //  4 ...命令種別
    //  5 ...opcodeInt
    //  6 ...命令の後にストールがいくつ入るか (0~)

    {"nop",     {0, -1, -1, -1, INST_OTHERS,  0b11111001, 0}}, 
    {"add",     {3, -1, -1, -1, INST_REGONLY, 0b0000000, 0}}, 
    {"sub",     {3, -1, -1, -1, INST_REGONLY, 0b0100000, 0}},
    // {"mul",     {3, -1, -1, -1, INST_REGONLY}},
    // {"div",     {3, -1, -1, -1, INST_REGONLY}},
    {"and",     {3, -1, -1, -1, INST_REGONLY, 0b00001000, 0}}, 
    {"slt",     {3, -1, -1, -1, INST_REGONLY, 0b01000000, 0}},
    {"sltu",    {3, -1, -1, -1, INST_REGONLY, 0b01001000, 0}}, 
    {"sll",     {3, -1, -1, -1, INST_REGONLY, 0b10000000, 0}}, 
    {"sra",     {3, -1, -1, -1, INST_REGONLY, 0b10011000, 0}}, 
    {"srl",     {3, -1, -1, -1, INST_REGONLY, 0b10010000, 0}}, 
    {"or",      {3, -1, -1, -1, INST_REGONLY, 0b00010000, 0}}, 
    {"xor",     {3, -1, -1, -1, INST_REGONLY, 0b00011000, 0}},
    {"fadd",     {3, -1, -1, -1, INST_REGONLY, 0b0000110, 2}}, 
    {"fsub",     {3, -1, -1, -1, INST_REGONLY, 0b0100110, 2}}, 
    {"fmul",     {3, -1, -1, -1, INST_REGONLY, 0b0001110, 1}}, 
    {"fdiv",     {3, -1, -1, -1, INST_REGONLY, 0b0010110, 3}}, 
    {"fmv",     {2, -1, -1, -1, INST_2REGF, 0b11001110, 0}}, 
    {"itof",     {2, -1, -1, -1, INST_2REGF, 0b00010111, 1}}, 
    {"ftoi",     {2, -1, -1, -1, INST_2REGF, 0b00001111, 0}}, 
    {"fle",     {3, -1, -1, -1, INST_2REGF,   0b0101111, 0}}, 
    {"floor",     {2, -1, -1, -1, INST_2REGF, 0b11000110, 5}}, 
    {"fsqrt",     {2, -1, -1, -1, INST_2REGF, 0b10000110, 1}}, 
    {"addi",    {3, 2, -1, 12, INST_REGIMM, 0b00000001, 0}}, 
    {"andi",    {3, 2, -1, 12, INST_REGIMM, 0b00001001, 0}}, 
    {"ori",    {3, 2, -1, 12, INST_REGIMM, 0b00010001, 0}}, 
    {"xori",    {3, 2, -1, 12, INST_REGIMM, 0b00011001, 0}}, 
    {"blt",     {3, -1, 2, -1, INST_CONTROL, 0b00001010, 0}}, 
    {"beq",     {3, -1, 2, -1, INST_CONTROL, 0b00010010, 0}}, 
    {"bne",     {3, -1, 2, -1, INST_CONTROL, 0b00100010, 0}}, 
    {"j",       {1, -1, 0, -1, INST_CONTROL, 0b00000011, 0}},
    {"jal",      {2, -1, 1, -1, INST_CONTROL, 0b00010011, 0}}, 
    {"jr",       {1, 0, -1, 12, INST_CONTROL, 0b00001011, 0}}, 
    {"jalr",     {2, 1, -1, 12, INST_CONTROL, 0b00011011, 0}}, 
    {"lw",       {2, 1, -1, 12, INST_LOAD, 0b00001100, 0}}, 
    {"lbu",       {2, 1, -1, 12, INST_LOAD, 0b00010100, 0}},
    {"flw",       {2, 1, -1, 12, INST_LOAD, 0b00100100, 0}},
    {"sw",       {2, 1, -1, 12, INST_STORE,  0b00000101, 0}},
    {"sb",       {2, 1, -1, 12, INST_STORE,  0b00010101, 0}},
    {"fsw",       {2, 1, -1, 12, INST_STORE, 0b00001101, 0}},
    {"lui",       {2, 1, -1, 21, INST_REGIMM,  0b00011111, 0}}
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

// opcodeInfoMapのopcodeIntをキーとして命令名を値として持つmapを作る
std::map<uint8_t, std::string> AssemblyParser::getInverseOpMap(){
    std::map<uint8_t, std::string> ans = {};
    for(auto e: opcodeInfoMap){
        // if(e.first != "nop"){
        ans.insert({static_cast<uint8_t>(e.second[5]), e.first});
        // }
    }
    return ans;
}

int AssemblyParser::getImmediate(const int& lineN, const int& immediateBitN, const std::string& intStr)const {
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

// 総行数を入力して，その行があるファイル名とそのファイル内での行数を返す
std::pair<std::string, int> AssemblyParser::getFileNameAndLine(const int &lineN)const{
    int nowLine = 0;
    for(int i = 0; i < static_cast<int>(filePaths.size()); i++){
        int next = nowLine + startLines[i];
        if(next >= lineN){
            int ansLine = lineN - nowLine;
            if(i == 0) ansLine --;
            return {filePaths[i], ansLine};
        }
        nowLine = next;
    }
    // parseErrorから呼ばれる関数なので，parseErrorは使えない
    throw std::invalid_argument(IMPLEMENT_ERROR);
}

void AssemblyParser::parseError(const int& lineN, const std::string& error)const{
    // エラーが起きた行数とともに知らせる
    auto pair = getFileNameAndLine(lineN);
    if(forGUI){
        std::cout << GUI_ERROR_TOP << std::endl;
    }
    throw std::invalid_argument(pair.first + " " + std::to_string(pair.second) + "行目:" + error);
}


AssemblyParser::AssemblyParser(const std::vector<std::string> &filePaths, const bool &useBinary,
         const bool& forGUI): filePaths(filePaths), forGUI(forGUI), useBin(useBinary){

    int allLen = 0;
    if(useBin && USE_REAL_BINARY){
        // ファイルは1つだけ
        std::ifstream ifs(filePaths[0], std::ios::binary);
        if(!ifs) parseError(-1, FILE_NOTFOUND);
        ifs.seekg(0, std::ios_base::end);
        size_t size = ifs.tellg();
        ifs.seekg(0, std::ios_base::beg);
        allLen = size;
        startLines.emplace_back(allLen / INST_BYTE_N);
        lineIndMap.emplace_back(NOT_INST_LINE_IND); // とりあえず一つ要素を入れておく(デストラクタでのエラー予防)
    }else{
        for(const std::string path: filePaths){
            int fileLen = getFileLen(path);
            if(allLen == 0){
                if(useBin){
                    lineIndMap.emplace_back(NOT_INST_LINE_IND);
                }else{
                    fileLen += START_LINE; // 最初のファイル（に対応する行）にはnop文(or j文)が追加で入っている
                }
            } 
                
            allLen += fileLen;
            startLines.emplace_back(fileLen);
        }
    }
    if(useBin){
        instructionVector.resize(allLen / INST_BYTE_N);
        if(filePaths.size() != 1u){
            parseError(0, SOME_BINARY_FILES);
        }
        try{
            deassembleFile(filePaths[0]);
        }catch(const std::invalid_argument &e){
            if(forGUI){
                parseError(-1, e.what());
            }else{
                throw e;
            }
        }
    }else{
        init_opcode_map();
        check_labels_many_files(filePaths, labelMap);
        // invLabelMapを作る
        for(const auto item: labelMap){
            invLabelMap.insert(std::make_pair(item.second, item.first));
        }

        instructionVector.resize(allLen);
        lineIndMap.resize(allLen);
        parseFiles(filePaths);
    }

}

void AssemblyParser::parseFiles(const std::vector<std::string> &filePaths){
    int startLine = START_LINE;
    int nowInstN = 1;
    // エントリポイント用にnop命令を先頭に入れる
    int32_t binary_op;
    if(labelMap.find(ENTRY_POINT_LABEL) != labelMap.end()){
        binary_op  = assemble_op("j " + ENTRY_POINT_LABEL, -1, 0, labelMap);
    }else{
        binary_op  = assemble_op("nop", -1, 0, labelMap);
    }
    instructionVector[0] = deassemble(1, binary_op);
    lineIndMap[0] = 0; // 勝手に挿入される一行は0行目とする

    for(const std::string path: filePaths){
        auto parseRes = parseFile(path, startLine, nowInstN);
        startLine = parseRes.first;
        nowInstN = parseRes.second;

    }
    instructionVector.resize(nowInstN); //命令の終わりで終了するようにする

}

// 各ファイルをパースする段階
// 今までの総ライン数，総命令数を入力として受け取り，パース後，現在の総ライン数，総命令数を返す
std::pair<int, int> AssemblyParser::parseFile(const std::string& filePath, const int &startLine, const int &instN){
    std::ifstream file(filePath);
    if(! file.is_open()){
        throw std::invalid_argument(FILE_NOTFOUND);
    }
    std::string line;

    const std::regex instRe(R"(^\s+([a-zA-Z0-9\-].*))");
    const std::regex labelRe(R"(^([0-9a-zA-Z_\.]+)\s*:\s*)");
    const std::regex commentRe(R"((.*)\s*#.*)");
    const std::regex spaceRe(R"(\s*)");
    const std::regex metaCommandRe(R"(\.global\s*([a-zA-Z0-9_\-]*)\s*)");
    
    std::smatch m;
    int lineN = startLine;
    int nowInstN = instN;

    while(std::getline(file, line)){
        lineN++;
        // コメント除去
        if(std::regex_match(line, m, commentRe)){
            line = m[1].str();
        }

        if(std::regex_match(line, m, instRe)){
            // 命令
            // instParse(lineN, nowInstN++,  m[1].str());
            uint32_t op = assemble_op(m[1].str(), lineN, nowInstN * INST_BYTE_N, labelMap);
            try{
                instructionVector[nowInstN] = deassemble(lineN, op);
            }catch(const std::invalid_argument &e){
                if(forGUI){
                    parseError(-1, e.what());
                }else{
                    throw e;
                }
            }
            lineIndMap[lineN-1] = nowInstN;
            ++nowInstN;
        }else if(std::regex_match(line, m, labelRe) || std::regex_match(line, m, spaceRe) || std::regex_match(line, m, metaCommandRe)){
            lineIndMap[lineN-1] = NOT_INST_LINE_IND;
        }else{
            // 不正な行
            parseError(lineN, INVALID_LINE_MESSAGE);
        }

    }
    return {lineN, nowInstN};
}

// ファイルをデアセンブル
void AssemblyParser::deassembleFile(const std::string &filePath){
    int lineN = 1;
    if(USE_REAL_BINARY){
        // ビッグエンディアンで書き出されたデータを読み込む
        std::ifstream ifs(filePath, std::ios::binary);
        if(!ifs) parseError(0, FILE_NOTFOUND);
        ifs.seekg(0, std::ios_base::end);
        size_t size = ifs.tellg();
        ifs.seekg(0, std::ios_base::beg);
        if(size % INST_BYTE_N != 0) parseError(0, INVALID_BINARY);
        size /= INST_BYTE_N;
        uint32_t res = 0;
        char byte = 0;
        for (size_t i = 0; i < size; i++)
        {
            res = 0;
            for (size_t j = 0; j < INST_BYTE_N; j++)
            {
                ifs.read(&byte, 1);
                res |= (0xff &  static_cast<uint32_t>(byte)) << 8*(INST_BYTE_N -1-j);
            }
            Instruction inst = deassemble(lineN, res);
            instructionVector[lineN-1] = inst;
            lineN++;
        }
    }else{
        std::ifstream ifs(filePath);
        if(ifs){
            std::string line;
            while(!ifs.eof()){
                uint32_t res = 0;
                for (int i = 0; i < INST_BYTE_N; i++)
                {
                    std::getline(ifs, line);
                    if(line == "") break;
                    res |= (std::stoi(line, nullptr, 16)) << (INST_BYTE_N -1-i)*8;
                }
                if(res == 0) break;
                Instruction inst = deassemble(lineN, res);
                instructionVector[lineN-1] = inst;
                lineN++;
            }
            instructionVector.resize(lineN-1);
        }else{
            parseError(0, FILE_NOTFOUND);
        }
    }
}


void AssemblyParser::instParse(const int &lineN, const int &instN, std::string instLine){
    // 命令部分をパース
    std::vector<std::string> instVec;
    std::regex instUnit(R"([a-z0-9\-\(\)\.%]+)");
    std::smatch m;
    int count = -1;
    int labelInd = -1;
    int immediateInd = -1;
    int immediateBitN = -1;
    int instKind = -1;
    Instruction inst;
    inst.lineN = lineN;

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
                instKind = info[4];
            }catch(const std::out_of_range& e){
                // 不正なオペコード
                parseError(lineN, INVALID_OPCODE_MESSAGE); 
            }
        }else{
            if(count == labelInd){
                inst.label = res;
            }else if(count == immediateInd){
                if(instKind == INST_CONTROL || instKind == INST_LOAD || instKind == INST_STORE){
                    // 即値とレジスタで4(x02)のようになっているとき
                    // 即値＋レジスタの形は命令の最後にしか現れないので、
                    // レジスタ名、即値の順でinst.operandに追加
                    // レジスタ名の追加は以下でまとめて行われるので、即値のみここで追加する
                    auto address = parseOffsetAndRegister(res, lineN);
                    res = address.first;
                    inst.operand[count+1] = std::to_string(address.second);
                    inst.immediate = address.second;
                }else{
                    inst.immediate = getImmediate(lineN, immediateBitN,  res);
                }
            }else if(count == MAX_OPERAND_N){
                parseError(lineN, INVALID_OPERAND_N);
            }
            inst.operand[count] = res;
        }    
        count ++;
        instLine = m.suffix();
    }
    if(count != inst.operandN) parseError(lineN, INVALID_OPERAND_N);

    instructionVector[instN] = inst;

}

void AssemblyParser::metaCommandParse(const int &lineN, const int &instN, const std::string &instLine){
    // .globalから始まるコメント，コマンドをパース
    Instruction inst;
    if(instLine == ENTRY_POINT){
        // この次から始まるようにジャンプ命令を先頭に入れる
        Instruction topInst;
        topInst.lineN = 1;
        topInst.opcode = "j";
        std::vector<int> info = opcodeInfoMap.at(topInst.opcode);
        topInst.operandN = info[0];
        topInst.operand[0] = ENTRY_POINT_LABEL;
        topInst.label = ENTRY_POINT_LABEL;
        instructionVector[0] = topInst;

        auto pib =  labelMap.insert({ENTRY_POINT_LABEL, instN});
        if(! pib.second){
            // ラベルの重複
            parseError(lineN, DOUBLE_LABEL);
        }


    }
}


std::pair<std::string , int> AssemblyParser::parseOffsetAndRegister(const std::string &input, const int &lineN)const{
    // 即値＋レジスタの形をパース
    std::smatch m;
    if(std::regex_match(input, m, offsetRe)){
        // ラベル
        int imm = std::stoi(m[1].str());
        std::string reg = m[2].str();
        return {reg, imm};
    }else{
        parseError(lineN, INVALID_OPERAND_FORMAT);
        return{"", -1};
    }
}