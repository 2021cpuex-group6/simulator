start:
    lui x2 -1082130432 # x2 1 0111 1111 00 ...
    addi x6 x0 1
    addi x5 x0 21 # 2^21からなら使える？
    sll x6 x6 x5 
    sw x2 -4(x6)
    lw %f2 -4(%x6) # f2 -1
    lui x3  1082130432 # x3 0 1000 0001 00
    lui x4 -1059061760 # x4 1 1000 0001 11
    sw x3 0(%x6)
    lw %f3 0(x6)  # f3 4
    fadd f3 f2 f3 # f3 3
    lui x5 -1084227584  # x5 1 0111 1110 11
    lui x7 -1071467672 
    addi x7 x7 872 # x7 2.5422
    sw %x4 4(x6)
    sw %x5 8(x6)
    lw f4 4(x6)  # f4 -7
    lw f5 8(x6)  # f5 -0.875
    addi x6 x0 0 
    addi f7 x7 0  # f7 2.5422
    addi x7 x0 5
    itof f8 x7 # f8 5
    ftoi x8 f8
    add  x1 x8 x7 # x1 10
    lui  x1 1082130432
    fmul f2 f4 f3 #f2 -21
    addi x6 x0 1
    fadd f2 f2 x1 # f2 -18
    itof f1 x6
    fadd f4 f4 f2 
    fsub f4 f4 f1 # f4 -25
    fsub f9 x0 f4 # f9 25
    fsqrt f10 f9 # f10 5
    fdiv f11 f9 f10 # f11 5
    ftoi x5 f10 
    fadd f11 f11 f11 # f11 10
    fle x1 f11 f10
    fmul f12 f3 f11 # f12 30 
    feq x2 f11 f11 # x2 1
    itof f11 x2 # f11 1
    ftoi x4 f3 # x4 3
    ftoi x5 f4 # x5 -25
    add x11 x4 x2 # x11 4
    ftoi x6 f10 # x6 5
    sll x7 x2 x4 # x7 8
    sll x8 x2 x6 # x8 32
    itof f1 x7 # f1 8
    fsub f12 f12 f1 # f12 22
    addi x8 x8 -30 # x8 2
    add  x8 x8 x8  # x8 4
    fmul f12 f12 f11 # f12 22
    sll x9 x8 x4 # x9 32
    fle x10 f4 f12 # x10 1
    srl x12 x9 x8 # x12 2
    add x13 x9 x9 # x13 64
    add x13 x13 x12 # 66
    add x14 x7 x6 # x14 13
    add x13 x13 x5 # x13 41
    addi x14 x14 -6 # x14 7
    addi x1 x0 1
    addi x2 x0 20
    add x14 x13 x14 # x14 48 = '0'
    sll x1 x1 x2
    sb x14 -1(x1) # '0'を送信



    








