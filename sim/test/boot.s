    addi x1 x0 0
    addi x2 x0 0
    addi x3 x0 0
    addi x4 x0 0
    addi x5 x0 0
    addi x6 x0 0
    addi x7 x0 0
    addi x8 x0 0
    addi x9 x0 0
    addi x10 x0 0
    addi x11 x0 0
    addi x12 x0 0
    addi x13 x0 0
    addi x14 x0 0
    addi x15 x0 0
    addi x6 x0 153  # send data
    lui  x7 1048576  # 0x10_0000
    sb   x6 -1(x7)    # send 144
    addi x6 x0 4 # for loop count
    addi x8 x0 24   # shift 
load_size: # x6 counter, x7 mmio base addr, x8 shift size
    lbu x10 -3(x7)   # check valid
    beq x10 x0 load_size
    addi  x6 x6 -1
    lbu x10 -2(x7)
    sll x10 x10 x8
    add x9 x10 x9
    addi x8 x8 -8
    bne x6 x0 load_size
    addi x6 x0 512
    addi x10 x0 4
    addi x11 x0 24
load_inst: # x6 instruction place, x7 mmio base addr, x9 has size, x10 loop counter, x11 shift x12 inst
    lbu x8 -3(x7)
    beq x8 x0 load_inst
    lbu x8 -2(x7)
    sll x8 x8 x11
    addi x10 x10 -1
    addi x11 x11 -8
    add x12 x12 x8
    bne x0 x10 load_inst
    sw x12 0(x6)
    addi x12 x0 0
    addi x6 x6 4
    addi x9 x9 -4
    addi x10 x0 4
    addi x11 x0 24
    bne x9 x0 load_inst
    addi x6 x0 170
    sb x6 -1(x7)
    jr 512(x0)
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
