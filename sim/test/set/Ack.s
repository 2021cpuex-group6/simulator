# アッカーマン関数
# Main:以下のコメントしたところを書き換えることで引数などを変えられる
# m = x1(f1), n = x2(f2)
# x11 にスタックとして使えるアドレス(下に伸びる)　デフォルトは 2^20
# 最終的にx1に答えが出力される

#参考 m=3, n = 4で答え125
#     総命令数113501, ワードアクセスされた箇所数 249

# 以下開発用メモ
# x10 戻りアドレス
# x11 スタックのアドレス
# x12, f12 1固定
Ack: 
    ftoi x1 f1
    ftoi x2 f2
loop:
    beq x1 x0 ans
    bne x2 x0 sub2
sub1: # Ack(m-1, 1)
    fsub f1 f1 f12
    fadd f2 f0 f12
    # 戻りアドレスだけスタックへ
    sw x10 0(x11)
    addi x11 x11 4
    jal x10 Ack
    addi x11 x11 -4
    lw x10 0(x11)
    jr 0(x10)
sub2: # Ack(m-1, Ack(m, n-1))
    #Ack(m, n-1)
    fsub f2 f2 f12
    # m, 戻りアドレスをスタックへ
    fsw f1 4(x11)
    sw x10 0(x11)
    addi x11 x11 8
    jal x10 Ack # f1に答えが入っているので注意
    addi x11 x11 -4 # 戻りアドレスはスタックにしまったままで

    # Ack(m-1, f1)
    fadd f2 f0 f1
    flw f1 0(x11)
    fsub f1 f1 f12
    jal x10 Ack # これで答えが入る

    addi x11 x11 -4
    lw x10 0(x11)
    jr 0(x10)
ans:
    fadd f1 f2 f12
    jr 0(x10)


.global	min_caml_start
Main: 
    addi x12 x0 1
    itof f12 x12
    addi x1 x0 3     # ここにm
    addi x2 x0 4     # ここにn
    itof f1 x1
    itof f2 x2
    addi x13 x0 20  # 
    addi x11 x0 1   # 
    sll x11 x11 x13 # x11にスタックアドレス
    jal x10 Ack
    ftoi x1 f1