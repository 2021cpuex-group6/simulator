

min_caml_read_int: # x6にデータ
# シミュと実機との差をとって速度を調べる
load_int_size1:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_int_size1 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_int_size2:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_int_size2 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_int_size3:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_int_size3 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_int_size4:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_int_size4 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    jr 0(%x4)

.global	min_caml_start
start:
    addi x1 x0 10 # 受信するfloatの数 2^ x1
    addi x2 x0 10 # 送信するバイト数 2 ^ x2
    addi x3 x0 1
    sll x1 x3 x1
    sll x2 x3 x2
    addi %x6 %x0 0
    addi %x7 %x0 1
    addi %x8 %x0 20
    addi %x9 %x0 8
    sll %x7 %x7 %x8
    addi %x7 %x7 -3 #ロード可能かどうかのフラグが格納されているアドレス
    addi x3 x0 0
recvLoop:
    jal x4 min_caml_read_int
    addi x3 x3 1
    blt x3 x1 recvLoop
    addi x6 x0 97
    addi x3 x0 0
sendLoop:
    sb x6 2(x7)
    addi x3 x3 1
    blt x3 x2 sendLoop








