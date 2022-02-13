    addi x3 x0 66
    addi x4 x0 67
    addi x5 x0 68
    addi x6 x0 4
    lui x1 1048576 # 0x10_0000
    addi x2 x1 1024 # lui x2 135266304 # 0x810_0000
label1: # uart_send test
    sb x3 -1(x1)
    sb x4 -1(x1)
    sb x5 -1(x1)
label2: # store program test
    sw x6 512(x0)
    sw x6 516(x0)
    sw x6 520(x0)
    add x7 x1 x0
label3: # store data x7: addr
    sw x7 0(x7)
    addi x7 x7 4
    bne x7 x2 label3 # until x7 == x2-4 repeat storing
    add x7 x1 x0
label4:
    lw x8 0(x7)
    bne x8 x7 failed
    addi x7 x7 4
    bne x7 x2 label4
    j passed
failed:
    addi x31 x0 85
    sb x31 -1(x1)
    j end
passed:
    addi x31 x0 84
    sb x31 -1(x1)
    addi x32 x0 1
    j end
end:
    j end
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
