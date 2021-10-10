#include <iostream>
#include <fstream>
#include <string>
#include "assemble/assemble.hpp"

int main() {
    std::string file_path;
    std::string target_path;
    std::cout << "Hello World!" << std::endl;
    std::cout << "Please enter input file path (default: ./assemble.txt) : ";
    std::getline(std::cin, file_path);
    if (file_path == "") {
        file_path = "./assemble.txt";
    }
    std::cout << "Please enter output file path (default: ./code) : ";
    std::getline(std::cin, target_path);
    if (target_path == "") {
        target_path = "./code";
    }

    std::ifstream ifs(file_path);
    if (!ifs) {
        std::cout << "Cannot open input file "+file_path << std::endl;
        return 0;
    }
    std::ofstream ofs(target_path);
    if (!ofs) {
        std::cout << "Cannot open output file" << std::endl;
    }


    if(!assembler_main(ofs, ifs)) {
        std::cout << "Failed to assemble";
    }
    return 0;
}