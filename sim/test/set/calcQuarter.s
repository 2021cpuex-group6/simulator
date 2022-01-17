# 初項, 公比-1/3の等比級数の和
calcQuater: # x4に-0.25が入る
    addi x1 x0 3
    addi x2 x0 -1 
    itof f1 x1
    itof f2 x2
    fdiv f3 f2 f1
    fadd f4 f3 f0 
    fadd f5 f3 f0 # f5, f4, f3 -1/3
    addi x3 x0 10
    addi x4 x0 0
loop:
    fmul f5 f5 f3
    fadd f4 f5 f4
    addi x4 x4 1
    blt x4 x3 loop
