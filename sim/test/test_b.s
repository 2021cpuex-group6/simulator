start:
    addi x1 x0 1 # 4
    addi x2 x0 2 # 8
    addi x3 x0 3 # c
    addi x4 x0 4 # 10
    addi x5 x0 5 # 14
    blt x5 x3 start # 18
    blt x3 x5 label4 # 1c
    addi x0 x0 0 # 20
label2:
    beq x5 x3 start
    beq x3 x3 label5
    addi x6 x5 x1
label3:
    bne x3 x3 start # 30
    bne x3 x5 label2 # 34
    addi x6 x5 x1 # 38
label4:
    bne x3 x3 start # 3c
    bne x3 x5 label3 # 40
    addi x6 x5 x1
label5:
    jal x7 label6
    addi x6 x5 x1
label6:
    jalr x8 12(x7) # 50
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