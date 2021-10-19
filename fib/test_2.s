start:
    addi x1 x0 45 # 00101101
    addi x2 x0 75 #  1001011
    and x3 x2 x1 # 1001
    or x4 x2 x1 # 1101111 = 111
    xor x5 x2 x1 # 1100110 = 102
    andi x3 x2 75 # 1001
    addi x1 x0 -1
    addi x2 x0 14
    slt x3 x1 x2 # 1
    sltu x4 x1 x2 # 0
    