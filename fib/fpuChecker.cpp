#include "sims/fpu.hpp"

int main(){
    fadd(0b00101110011011111100000111011001, 0b11000101001101010111011110101000);
    addSubRandomCheck(1000000, true);
    addSubRandomCheck(1000000, false);

}
