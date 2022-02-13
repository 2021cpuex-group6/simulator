    lui x1 1048576
    lui x5 1064960
# store -> load at same addr
    sw x1 0(x1)
    lw x2 0(x1)
    bne x1 x2 failed
# store -> load at same line
    addi x2 x1 111
    sw x1 0(x1)
    sw x2 0(x5)
    lw x3 0(x1)
    lw x4 0(x5)
    bne x1 x3 failed
    bne x2 x4 failed
# forward back
    sw x2 4(x5)
    lw x4 4(x5)
    sw x1 4(x1)
    lw x5 4(x5)
    bne x4 x5 failed
    bne x2 x5 failed
    j passed
failed:
    addi x31 x0 1
    j failed
passed:
    addi x32 x0 1
    j passed
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