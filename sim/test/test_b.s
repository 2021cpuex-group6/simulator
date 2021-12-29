start:
    addi x1 x0 65
    addi x2 x0 2
    addi x3 x0 3
    addi x4 x0 4
    addi x5 x0 5
    blt x5 x3 theend
    blt x3 x5 label4
    addi x0 x0 0
    j theend
label2:
    beq x5 x3 theend
    beq x3 x3 label5
    addi x6 x5 x1
    j theend
label3:
    bne x3 x3 theend
    bne x3 x5 label2
    addi x6 x5 x1
    j theend
label4:
    bne x3 x3 theend
    bne x3 x5 label3
    addi x6 x5 x1
    j theend
label5:
    jal x7 label6
    addi x6 x5 x1
    j theend
label6:
    jalr x8 20(x7)
    addi x6 x5 x1
    j theend
label7:
    addi x7 x1 12
    lui x8 1048576
    sb x7 -1(x8)
end:
    j end
    addi x0 x0 0
    addi x0 x0 0
theend:
    addi x7 x1 5
    lui x8 1048576
    sb x7 -1(x8)
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