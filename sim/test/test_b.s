start:
    addi x1 x0 1
    addi x2 x0 2
    addi x3 x0 3
    addi x4 x0 4
    addi x5 x0 5
    blt x5 x3 start
    blt x3 x5 label4
    addi x0 x0 0
label2:
    beq x5 x3 start
    beq x3 x3 label5
    addi x6 x5 x1
label3:
    bne x3 x3 start
    bne x3 x5 label2
    addi x6 x5 x1
label4:
    bne x3 x3 start
    bne x3 x5 label3
    addi x6 x5 x1
label5:
    jal x7 label6
    addi x6 x5 x1
label6:
    jalr x8 12(x7)
    addi x6 x5 x1
label7:
    addi x4 x4 1024
    addi x4 x4 1024
    addi x4 x4 1024
    sw x3 4(x4)
    sb x5 7(x4)
    lw x9 4(x4)
    lbu x10 7(x4)
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0
    addi x0 x0 0