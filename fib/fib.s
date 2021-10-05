# x1が引数、x2-x5が一時的に使われ、x1に出力
    addi x5 x0 1
    addi x3 zero 3
    blt  x1 x3   ret
    addi x3 zero 1
    addi x4 zero 1
    addi x2 zero 3
loop: 
    add x5 x3 x4
    addi x3 x4 0
    addi x4 x5 0
    beq  x2 x1 ret
    addi x2 x2 1
    j    loop
ret:
# これで完了
    addi x1 x5 0

