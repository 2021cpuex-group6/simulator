#pragma once
#include <fstream>

bool assembler_main(std::ofstream& ofs, std::istream& ifs);
void init_opcode_map();