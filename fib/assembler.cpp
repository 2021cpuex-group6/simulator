#include <iostream>
#include <filesystem>
#include <fstream>
#include <string>
#include "assemble/assemble.hpp"

namespace fs = std::filesystem;

int main() {
    
    init_opcode_map();

    std::string output_log_yn;
    bool output_log;
    std::cout << "Output log [Y/n] : ";
    std::cin >> output_log_yn;
    output_log = output_log_yn == "Y" || output_log_yn == "y";

    
    std::string directory_path;
    std::cout << "Please enter input directory path (default: ./test/) : ";
    std::getline(std::cin, directory_path);
    if (directory_path == "") {
        directory_path = "./test/";
    }
    std::string file_path, target_path;
    for (const fs::directory_entry& x : fs::directory_iterator(directory_path)) {
        file_path = x.path().string();
        target_path = file_path + ".out";
        if (file_path.size() < 3 || file_path.find(".s", file_path.size() - 2) == std::string::npos)
            continue;
        std::cout << "assembling " << x.path() << " ..." << std::endl;
        std::ifstream ifs(file_path);
        if (!ifs) {
            std::cout << "Cannot open input file "+file_path << std::endl;
            return 0;
        }
        std::ofstream ofs(target_path);
        if (!ofs) {
            std::cout << "Cannot open output file" << std::endl;
        }
        try {
            init_label_map();
            assembler_main(ofs, ifs, output_log);
        } catch (const std::invalid_argument& e) {
            std::cout << e.what() << std::endl;
        }
    }
    return 0;
}