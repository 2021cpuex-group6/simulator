#include "sims/parser.hpp"
#include "sims/simulator.hpp"
#include "sims/interactive.hpp"
#include "sims/mmio.hpp"
#include <iostream>
#include <cmath>
#include <regex>

const std::string LACK_ARGUMENT = "引数にアセンブリファイルを入力してください";                                                                                                           
const std::string INVALID_CASH_WAY = "ウェイ数が不適切です．";    
const std::string OPTION_ALL = "-a";
const std::string OPTION_BIN = "-b";
const std::string OPTION_GUI = "-g";
const std::string OPTION_CASH = "-c";
const std::string OPTION_SEARCH_P = "-sp";
const std::string OPTION_DEBUG = "--debug";
const std::string OPTION_TIME = "--time";
const std::string OPTION_DATA = "-d";
const std::string OPTION_PARAM = "-p";

constexpr char PARAM_DELIM = '_';

const std::string RECV_DATA_FILE = "data/contest.sld";

// パラメータ探索
void searchParameters(AssemblyParser &parser, const bool &useBin, MMIO &mmio){
    // パラメタの下限
    constexpr uint32_t offsetMin = 2; 
    constexpr uint32_t tagMin = 14;
    // 最適値が入る
    uint32_t optWay[2] = {0, 0};
    uint32_t optTag[2] = {tagMin, tagMin};
    uint32_t optOffset[2] = {0, 0};
    uint64_t optHitN[2] = {707395530, 176263670};

    uint32_t wayListN = 1;
    uint32_t wayList[wayListN] = {2};

    bool first = true;
    uint64_t accessN[2] = {0, 0};
    for(uint32_t way: wayList){
        uint32_t tag = way == 1 ? tagMin : tagMin + 1;
        for(uint32_t offset = offsetMin; offset < (REGISTER_BIT_N - tag - 1); offset++){
            std::cout << "tag数: " << tag << "way数: " << way << " offset数: " << offset << std::endl;
            
            AssemblySimulator simulator(parser, useBin, false, mmio, way, offset, tag);
            simulator.launch(false);
            if(first){
                first = false;
                accessN[Cache::READ] = simulator.cache.hitN[Cache::READ] + simulator.cache.initMissN[Cache::READ] + simulator.cache.otherMissN[Cache::READ];
                accessN[Cache::WRITE] = simulator.cache.hitN[Cache::WRITE] + simulator.cache.initMissN[Cache::WRITE] + simulator.cache.otherMissN[Cache::WRITE];
            }
            for(int i = 0; i < Cache::TYPES_N; i++){
                uint32_t hitN = (simulator.cache.hitN[i]);
                if(optHitN[i] < hitN){
                    // 最適値更新
                    optWay[i] = way;
                    optTag[i] = tag;
                    optOffset[i] = offset;
                    optHitN[i] = hitN;

                    std::cout << (i == Cache::READ ? "読み" : "書き") << "最適値更新" << std::endl;
                    std::cout << "  " << hitN << std::endl;

                }

            }
            
        }
    }

    std::cout << "--最適値--" << std::endl;
    for(int i = 0; i < Cache::TYPES_N; i++){
        std::cout << (i == Cache::READ ? "読み" : "書き") << std::endl;
        double rate = (double) optHitN[i] / (double) accessN[i];
        std::cout <<" " << rate << std::endl;
        std::cout << " tag数: " << optTag[i] << " way数: " << optWay[i] << " offset数: " << optOffset[i] << std::endl;
    }
}

// 与えたパラメータでの性能をチェックする
void checkParam(AssemblyParser &parser, const bool &useBin, MMIO &mmio){
// パラメタの下限
    constexpr uint32_t offsetMin = 4; 
    constexpr uint32_t tagMin = 14;
    // 最適値が入る

    int paramN = 2;
    uint32_t tags[paramN] = {tagMin, tagMin, tagMin + 1, tagMin + 1};
    uint32_t ways[paramN] = {1, 1};
    uint32_t offsets[paramN] = {8, 10};

    bool first = true;
    uint64_t accessN[2] = {0, 0};
    for(int i = 0; i < paramN; i++){
        std::cout << "tag数: " << tags[i] << " way数: " << ways[i] << " offset数: " << offsets[i] << std::endl;
        
        AssemblySimulator simulator(parser, useBin, false, mmio, ways[i], offsets[i], tags[i]);
        simulator.launch(false);
        if(first){
            first = false;
            accessN[Cache::READ] = simulator.cache.hitN[Cache::READ] + simulator.cache.initMissN[Cache::READ] + simulator.cache.otherMissN[Cache::READ];
            accessN[Cache::WRITE] = simulator.cache.hitN[Cache::WRITE] + simulator.cache.initMissN[Cache::WRITE] + simulator.cache.otherMissN[Cache::WRITE];
        }
        for(int j = 0; j < Cache::TYPES_N; j++){
            uint32_t hitN = (simulator.cache.hitN[j]);
            std::cout << (j == Cache::READ ? " 読み" : " 書き") << std::endl;
            std::cout << " ヒット数:" << hitN << ", ミス率: " << (accessN[j] - hitN) / (double)accessN[j] * 100 << "%" << std::endl;

        }
    }
}

int main(int argc, char* argv[]){
    // bool doAll = false; //対話型にせず全実行するか
    bool useBin = false; //バイナリを使うかアセンブリか
    bool forGUI = false; // GUI用の出力か
    bool searchParam = false; // パラメタ探索モードか
    bool forDebug = false;
    std::vector<std::string> fileNames;
    std::string dataPath = RECV_DATA_FILE;

    if(argc < 2){
        std::cout << LACK_ARGUMENT << std::endl;
        return -1;
    }
    uint32_t cacheWay = 1;
    uint32_t offsetLen = 8;
    uint32_t tagLen = 14;
    int optionN = 1;
    while(optionN < argc){
        std::string arg = argv[optionN++];
        if(arg == OPTION_ALL){
            // doAll = true;
        }else if(arg == OPTION_BIN){
            useBin = true;
        }else if(arg == OPTION_GUI){
            forGUI = true;          
        }else if(arg == OPTION_DEBUG){
            forDebug = true;    
        }else if(startsWith(arg, OPTION_DATA)){
            // データファイルの指定
            dataPath = arg.substr(OPTION_DATA.length()+1);
        }else if(startsWith(arg, OPTION_PARAM)){
            std::stringstream ss(arg.substr(OPTION_PARAM.length() + 1));
            std::string param;
            std::getline(ss,param, PARAM_DELIM);
            cacheWay = std::stoul(param);
            if(!isPowerOf2(cacheWay, CACHE_MAX_SIZE)){
                // ウェイ数が2べきではない
                std::cout << INVALID_CASH_WAY << std::endl;
                return -1;
            }
            std::getline(ss,param, PARAM_DELIM);
            offsetLen = std::stoul(param);
            std::getline(ss,param, PARAM_DELIM);
            tagLen = std::stoul(param);
        }else if(arg == OPTION_SEARCH_P){
            searchParam = true;
        }else{
            fileNames.emplace_back(arg);
        }
    }

    

    try{
        MMIO mmio(dataPath);
        AssemblyParser parser(fileNames, useBin, forGUI);
        if(searchParam){
            searchParameters(parser, useBin, mmio);
        }else{
            AssemblySimulator simulator(parser, useBin, forGUI, mmio, cacheWay, offsetLen, tagLen);
            InteractiveShell shell(simulator, parser, forGUI, forDebug);
            shell.start();
            simulator.mmio.outputPPM();
            if(forGUI) std::cout << "Exited" << std::endl;
        }
    }catch(const std::exception &e){
        if(forGUI){
            std::cout << GUI_ERROR << std::endl;
            std::cout << e.what() << std::endl;
        }else{
            std::cout << e.what() << std::endl;
        }
    }
    // simulator.launch();
    // simulator.printRegisters(NumberBase::DEC, true);
    // simulator.printOpCounter();

}