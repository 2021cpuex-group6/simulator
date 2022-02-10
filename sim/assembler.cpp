#include <iostream>
#include <filesystem>
#include <fstream>
#include <string>
#include "assemble/assemble.hpp"

namespace fs = std::filesystem;

int main(int argc, char* argv[]) {
    struct output_flags_t output_flags;

    for (int i = 0; i < argc; i++) {
        if (strcmp(ASSEMBLER_MODE_BINARY.c_str(), argv[i]) == 0) {
            output_flags.output_mode = out_mode::BINARY;
            std::cout << "Output file as binary" << std::endl;
        }else if(strcmp(ASSEMBLER_MODE_WORD.c_str(), argv[i]) == 0) {
            output_flags.output_mode = out_mode::WORD;
            std::cout << "Output a word per line" << std::endl;
        }else if((strcmp(ASSEMBLER_MODE_BYTE.c_str(), argv[i]) == 0)){
            output_flags.output_mode = out_mode::BYTE;
            std::cout << "Output a byte per line" << std::endl;
        }
    }
    
    init_opcode_map();

    std::string output_log_yn;
    std::cout << "Output log [Y/n] : ";
    std::getline(std::cin, output_log_yn);
    output_flags.output_log = output_log_yn == "Y" || output_log_yn == "y";

    
    std::string directory_path;
    std::cout << "Please enter input directory path (default: ./test/) : ";
    std::getline(std::cin, directory_path);
    std::cout << std::endl;
    if (directory_path == "") {
        directory_path = "./test/";
    }
    std::string file_path, target_path;
    for (const fs::directory_entry& x : fs::directory_iterator(directory_path)) {
        file_path = x.path().string();
        std::string extension = ASSEMBLY_BYTE_EXT;
        switch(output_flags.output_mode){
            case out_mode::BINARY:
                extension = ASSEMBLY_BINARY_EXT;
                break;
            case out_mode::WORD:
                extension = ASSEMBLY_WORD_EXT;
                break;
            default:
                extension = ASSEMBLY_BYTE_EXT;
        }
        target_path = file_path + extension;
        if (file_path.size() < 3 || file_path.find(".s", file_path.size() - 2) == std::string::npos)
            continue;
        std::cout << "assembling " << x.path() << " ..." << std::endl;
        std::ifstream ifs(file_path);
        if (!ifs) {
            std::cout << "Cannot open input file "+file_path << std::endl;
            return 0;
        }

        std::ofstream ofs;
        if (output_flags.output_mode) {
            ofs = std::ofstream(target_path, std::ios::out | std::ios::binary);
        }
        else {
            ofs = std::ofstream(target_path, std::ios::out);
        }
        if (!ofs) {
            std::cout << "Cannot open output file" << std::endl;
        }
        try {
            init_label_map();
            assembler_main(ofs, ifs, output_flags);
        } catch (const std::invalid_argument& e) {
            std::cout << e.what() << std::endl;
        }
    }
    return 0;
}