#include "sims/fpu.hpp"

int main(){
    // fadd(0b00101110011011111100000111011001, 0b11000101001101010111011110101000);
    // randomOperationCheck(1000000, CheckedOperation::ADD);
    // randomOperationCheck(1000000, CheckedOperation::SUB);
    FPUUnit fpu = FPUUnit();
    fpu.randomOperationCheck(1000, CheckedOperation::FTOI);
    fpu.randomOperationCheck(1000, CheckedOperation::ITOF);

}
