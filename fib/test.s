# テスト用
start:
    addi x1 x0 0 # x1 = 0
    addi x4 x0 4 # x4 = 4
    addi x2 x0 520  # x2 = 512 + 8 10 00001000
    addi x3 x0 -1 # x3 = -1
    sw x2 8(x1) # 8... 10 00001000
    sw x3 -4(x4) # 0... 11111...
    lw x4 4(x4) # x4 = 520
    lw x1 0(x1) # x1 = -1
    addi x1 x0 10
    addi x2 x0 11
    mul x3 x1 x2  # x3 = 110
    addi x6 x0 20 
    sub x2 x2 x6 # x2 = -9
    mul x4 x2 x1 # x4 = -90
    div x3 x3 x1 # x3 = 11
    div x3 x3 x2 # x3 = -1
    addi x4 x0 17
    div x3 x4 x2 # x3 = -1
