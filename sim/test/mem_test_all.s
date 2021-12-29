    lui x1 1048576
    lui x2 135266304
loop:
    sw x1 0(x1)
    addi x1 x1 4
    bne x1 x2 loop #218
    lui x1 1048576 # 0x21c
    addi x2 x2 -4
twist:
    addi x1 x1 4
    flw f3 0(x1)
    fsw f3 -4(x1) # 220
    bne x1 x2 twist
    lui x1 1048576 # 0x21c
check:
    lw x3 0(x1) # 220
    addi x3 x3 -4
    bne x3 x1 failed # 224
    addi x1 x1 4
    bne x1 x2 check
    j success
failed:
    addi x2 x0 114
    lui x3 1048576
    sb x2 -1(x3)
    sb x1 -1(x3)
    addi x4 x0 8
    srl x1 x1 x4
    sb x1 -1(x3)
    srl x1 x1 x4
    sb x1 -1(x3)
    srl x1 x1 x4
    sb x1 -1(x3)
    j end
success:
    addi x2 x0 102
    lui x1 1048576
    sb x2 -1(x1)
    j end
end:
    j end
    addi x0 x0 0
    addi x0 x0 0