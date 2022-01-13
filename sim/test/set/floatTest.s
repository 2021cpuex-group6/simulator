# 最終的にx3に8が入っていればどれかで間違ってる

Fail: # ここが実行されないように
    addi x3 x0 8
    j end

.global	min_caml_start
testFle: # 最後にx3に8が入っていなければOK
    addi x1 x0 121
    addi x2 x0 83
    addi x3 x0 320
    itof f1 x1 
    itof f2 x2
    itof f3 x3
    fmul f1 f1 f3
    fmul f1 f1 f3
    fmul f2 f2 f3
    fmul f2 f2 f3 # f1 ~ f2 * 1.5
    addi x1 x0 -60
    addi x2 x0 121
    itof f3 x1
    itof f4 x2
    fdiv f3 f4 f3 # f3 ~ -2
    addi x1 x0 20
    addi x2 x0 0
loop1:
    addi x2 x2 1
    blt x1 x2 ans
    fle x3 f2 f1 
    beq x3 x0 fail
    fdiv f1 f1 f3
    fle x3 f1 f2
    beq x3 x0 fail
    fdiv f2 f2 f3
    fle x3 f1 f2
    beq x3 x0 fail
    fdiv f1 f1 f3
    fle x3 f2 f1
    beq x3 x0 fail
    fdiv f2 f2 f3
    fle x3 f1 f2
    beq x3 x0 loop1
fail:
    addi x3 x0 8
    j Fail
ans:
    addi x1 x0 2

testSra: # x3に8が入っていなければOK
    addi x1 x0 821
    addi x2 x0 -921
    addi x3 x0 1
    addi x4 x0 2
    addi x5 x0 5
    sll x1 x1 x5
    sll x2 x2 x5
    itof f1 x1
    itof f2 x2
    itof f4 x4
    addi x6 x0 17
    addi x7 x0 0
    addi x8 x0 14
loop2:
    addi x7 x7 1
    beq x7 x6 ans2
    sra x1 x1 x3
    sra x2 x2 x3
    fdiv f1 f1 f4
    fdiv f2 f2 f4
    floor f1 f1
    floor f2 f2
    ftoi x4 f1
    blt x8 x7 jump1 
    addi x4 x4 1 # float演算の微妙な誤差を修正
jump1:
    ftoi x5 f2
    beq x1 x4 eq1
    j fail2 
eq1:
    beq x2 x5 loop2
fail2:
    addi x3 x0 8
    j Fail
ans2:
    addi x1 x0 2


end:
    add9 x1 x0 2


