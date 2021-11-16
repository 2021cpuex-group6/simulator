    addi x1 x0 18
    addi x2 x0 1;
    sll x2 x2 x1; # x2 0x4000
    sw x0 0(x0)
    sw x0 4(x0)
    sw x0 0(x2)
    lw x1 0(x0)
    lw x1 4(x0)

