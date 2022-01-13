#論理演算でaddを再現
adder:
    addi x1 x0 231  # 足す数
    addi x2 x0 -122 ＃足される数 x3は繰り上がり
    addi x4 x0 1 # マスク
    addi x5 x0 1 
loop:
    and x6 x1 x4 # x6, x7はマスクしたものが入る
    and x7 x2 x4
    and x8 x6 x7
    xor x9 x6 x7
    xor x10 x9 x3 # x10 s
    or x12 x12 x10
    and x11 x9 x3
    or x11 x11 x8 # x11 c
    sll x3 x11 x5 # cを繰り上げ
    sll x4 x4 x5
    bne x4 x0 loop
ans:
    add x1 x12 x0




