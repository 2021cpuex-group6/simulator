#include "sims/fpu.hpp"

int main(){
    // fadd(0b00101110011011111100000111011001, 0b11000101001101010111011110101000);
    // randomOperationCheck(1000000, CheckedOperation::ADD);
    // randomOperationCheck(1000000, CheckedOperation::SUB);
    FPU fpu = FPU();
    fpu.randomOperationCheck(  10000000, CheckedOperation::FLOOR);
    // fpu.randomOperationCheck(100000, CheckedOperation::FLE);
    // fpu.randomOperationCheck(100000, CheckedOperation::FLT);
    // fpu.randomOperationCheck(100000, CheckedOperation::FLOOR);

}
