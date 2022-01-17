start:
    addi x1 x0 1000
    addi x2 x0 16
    sll x1 x1 x2
    addi x2 x0 -1
loop:  # 1000 * 10 
    addi x2 x2 1
    addi x3 x0 4
    addi x4 x3 1
    sll x3 x3 x2
    addi x3 x3 0
    addi x4 x0 1
    addi x5 x0 20
    sll  x4 x4 x5 # 0x10000
    addi x6 x0 96 
    blt x2 x1 loop
    sb x6 -1(x4)
