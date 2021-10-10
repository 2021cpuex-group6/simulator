#include "utils.hpp"
#include <algorithm>


bool startsWith(const std::string &strA, const std::string &strB){
    // strAがstrBから始まるかを返す
    return strA.size() >= strB.size() && 
            std::equal(std::begin(strB), std::end(strB), std::begin(strA));
}
