.global min_caml_start
min_caml_start:	
	lui	%x29 2097152
	lui	%x6 1124073472
	sw	%x6 204(%x29)
	lui	%x6 1063675494
	addi	%x6 %x6 1638
	sw	%x6 200(%x29)
	lui	%x6 1125515264
	sw	%x6 196(%x29)
	lui	%x6 -1021968384
	sw	%x6 192(%x29)
	lui	%x6 1036831949
	addi	%x6 %x6 1229
	sw	%x6 188(%x29)
	lui	%x6 -1073741824
	sw	%x6 184(%x29)
	lui	%x6 998244352
	sw	%x6 180(%x29)
	lui	%x6 1287568416
	addi	%x6 %x6 1056
	sw	%x6 176(%x29)
	lui	%x6 1315859240
	addi	%x6 %x6 808
	sw	%x6 172(%x29)
	lui	%x6 1101004800
	sw	%x6 168(%x29)
	lui	%x6 1028443341
	addi	%x6 %x6 1229
	sw	%x6 164(%x29)
	lui	%x6 1048576000
	sw	%x6 160(%x29)
	lui	%x6 1092616192
	sw	%x6 156(%x29)
	lui	%x6 1050253722
	addi	%x6 %x6 410
	sw	%x6 152(%x29)
	lui	%x6 1132396544
	sw	%x6 148(%x29)
	lui	%x6 1041865114
	addi	%x6 %x6 410
	sw	%x6 144(%x29)
	lui	%x6 1078530011
	addi	%x6 %x6 2011
	sw	%x6 140(%x29)
	lui	%x6 1106247680
	sw	%x6 136(%x29)
	lui	%x6 1097859072
	sw	%x6 132(%x29)
	lui	%x6 953267991
	addi	%x6 %x6 1815
	sw	%x6 128(%x29)
	lui	%x6 -1110651699
	addi	%x6 %x6 1229
	sw	%x6 124(%x29)
	lui	%x6 1008981770
	addi	%x6 %x6 1802
	sw	%x6 120(%x29)
	lui	%x6 -1102263091
	addi	%x6 %x6 1229
	sw	%x6 116(%x29)
	lui	%x6 -1018691584
	sw	%x6 112(%x29)
	lui	%x6 1128792064
	sw	%x6 108(%x29)
	lui	%x6 1016003125
	addi	%x6 %x6 565
	sw	%x6 104(%x29)
	lui	%x6 1054867456
	sw	%x6 100(%x29)
	lui	%x6 1031137221
	addi	%x6 %x6 1989
	sw	%x6 96(%x29)
	lui	%x6 1035458158
	addi	%x6 %x6 1646
	sw	%x6 92(%x29)
	lui	%x6 1038323256
	addi	%x6 %x6 1592
	sw	%x6 88(%x29)
	lui	%x6 1041385765
	addi	%x6 %x6 293
	sw	%x6 84(%x29)
	lui	%x6 1045220557
	addi	%x6 %x6 1229
	sw	%x6 80(%x29)
	lui	%x6 1051372202
	addi	%x6 %x6 682
	sw	%x6 76(%x29)
	lui	%x6 1075576832
	sw	%x6 72(%x29)
	lui	%x6 1095307227
	addi	%x6 %x6 2011
	sw	%x6 68(%x29)
	lui	%x6 1061752795
	addi	%x6 %x6 2011
	sw	%x6 64(%x29)
	lui	%x6 1070141403
	addi	%x6 %x6 2011
	sw	%x6 60(%x29)
	lui	%x6 1078530011
	addi	%x6 %x6 2011
	sw	%x6 56(%x29)
	lui	%x6 0
	sw	%x6 52(%x29)
	lui	%x6 -1082130432
	sw	%x6 48(%x29)
	lui	%x6 1078530011
	addi	%x6 %x6 2011
	sw	%x6 44(%x29)
	lui	%x6 961373366
	addi	%x6 %x6 1206
	sw	%x6 40(%x29)
	lui	%x6 1007191654
	addi	%x6 %x6 1638
	sw	%x6 36(%x29)
	lui	%x6 1042983596
	addi	%x6 %x6 684
	sw	%x6 32(%x29)
	lui	%x6 984842502
	addi	%x6 %x6 262
	sw	%x6 28(%x29)
	lui	%x6 1026205577
	addi	%x6 %x6 1929
	sw	%x6 24(%x29)
	lui	%x6 1056964608
	sw	%x6 20(%x29)
	lui	%x6 1065353216
	sw	%x6 16(%x29)
	lui	%x6 1061752795
	addi	%x6 %x6 2011
	sw	%x6 12(%x29)
	lui	%x6 1070141403
	addi	%x6 %x6 2011
	sw	%x6 8(%x29)
	lui	%x6 1073741824
	sw	%x6 4(%x29)
	lui	%x6 1086918619
	addi	%x6 %x6 2011
	sw	%x6 0(%x29)
	j	min_caml_start2
min_caml_read_int:
    addi %x6 %x0 0
    addi %x7 %x0 1
    addi %x8 %x0 20
    addi %x9 %x0 8
    sll %x7 %x7 %x8
    addi %x7 %x7 -3 #ロード可能かどうかのフラグが格納されているアドレス
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
    jr 0(%x1)
min_caml_read_float:
    addi %x6 %x0 0
    addi %x7 %x0 1
    addi %x8 %x0 20
    addi %x9 %x0 8
    sll %x7 %x7 %x8
    addi %x7 %x7 -3 # ロード可能かどうかのフラグが格納されているアドレス
load_float_size1:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_float_size1 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_float_size2:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_float_size2 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_float_size3:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_float_size3 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sll %x6 %x6 %x9 # 左に8ビットシフト
load_float_size4:
    lbu %x8 0(%x7) # フラグを読む
    beq %x8 %x0 load_float_size4 # フラグがゼロだったら読み直し
    lbu %x8 1(%x7) # 1だったらデータを1バイト読む
    add %x6 %x6 %x8
    sw %x6 -4(%x2)
    lw %f1 -4(%x2)
    jr 0(%x1)
min_caml_print_char:
    addi %x7 %x0 1 # x7 <- 1
    addi %x8 %x0 20 # x8 <- 20
    sll %x7 %x7 %x8 # x7 <- 0x100000
    addi %x7 %x7 -3 #ロード可能かどうかのフラグが格納されているアドレス x7 <- 0x100000 - 3
    sb %x6 2(%x7) # データを1バイト書く
    jr 0(%x1)
min_caml_float_of_int:
    itof %f1 %x6
    jr 0(%x1)
min_caml_int_of_float:
    ftoi %x6 %f1
    jr 0(%x1)
min_caml_sra:
    sra %x6 %x6 %x7
    jr 0(%x1)
min_caml_sll:
    sll %x6 %x6 %x7
    jr 0(%x1)
min_caml_create_array:
    add %x8 %x0 %x3 # 先頭アドレスを%x8に入れる
    bne %x6 %x0 create_array_loop # %x6がゼロでないなら戻る
    add %x6 %x0 %x8 # %x6がゼロなら先頭アドレスを%x6に入れる
    jr 0(%x1)
create_array_loop:
    sw %x7 0(%x3) # %x7を書き込む
    addi %x3 %x3 4 # reg_hpを進める
    addi %x6 %x6 -1 # %x6をデクリメント
    bne %x6 %x0 create_array_loop # %x6がゼロでないなら戻る
    add %x6 %x0 %x8 # %x6がゼロなら先頭アドレスを%x6に入れる
    jr 0(%x1)
min_caml_create_float_array:
    add %x8 %x0 %x3 # 先頭アドレスを%x8に入れる
    bne %x6 %x0 create_float_array_loop # %x6がゼロでないなら戻る
    add %x6 %x0 %x8 # %x6がゼロなら先頭アドレスを%x6に入れる
    jr 0(%x1)
create_float_array_loop:
    sw %f1 0(%x3) # %x7を書き込む
    addi %x3 %x3 4 # reg_hpを進める
    addi %x6 %x6 -1 # %x6をデクリメント
    bne %x6 %x0 create_float_array_loop # %x6がゼロでないなら戻る
    add %x6 %x0 %x8 # %x6がゼロなら先頭アドレスを%x6に入れる
    jr 0(%x1)
reduction_g.6780:	#- 908
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20039	# 4 
	jr	0(%x1)	# 6 
fle_else.20039:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20040	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20041	# 4 
	jr	0(%x1)	# 6 
fle_else.20041:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20042	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20043	# 4 
	jr	0(%x1)	# 6 
fle_else.20043:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20044	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20045	# 4 
	jr	0(%x1)	# 6 
fle_else.20045:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20046	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20046:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20044:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20047	# 4 
	jr	0(%x1)	# 6 
fle_else.20047:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20048	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20048:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20042:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20049	# 4 
	jr	0(%x1)	# 6 
fle_else.20049:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20050	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20051	# 4 
	jr	0(%x1)	# 6 
fle_else.20051:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20052	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20052:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20050:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20053	# 4 
	jr	0(%x1)	# 6 
fle_else.20053:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20054	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20054:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20040:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20055	# 4 
	jr	0(%x1)	# 6 
fle_else.20055:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20056	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20057	# 4 
	jr	0(%x1)	# 6 
fle_else.20057:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20058	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20059	# 4 
	jr	0(%x1)	# 6 
fle_else.20059:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20060	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20060:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20058:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20061	# 4 
	jr	0(%x1)	# 6 
fle_else.20061:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20062	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20062:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20056:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20063	# 4 
	jr	0(%x1)	# 6 
fle_else.20063:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20064	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20065	# 4 
	jr	0(%x1)	# 6 
fle_else.20065:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20066	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20066:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20064:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20067	# 4 
	jr	0(%x1)	# 6 
fle_else.20067:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20068	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20068:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
reduction_g.6780.11156:	#- 1632
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20069	# 4 
	jr	0(%x1)	# 6 
fle_else.20069:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20070	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20071	# 4 
	jr	0(%x1)	# 6 
fle_else.20071:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20072	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20073	# 4 
	jr	0(%x1)	# 6 
fle_else.20073:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20074	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20075	# 4 
	jr	0(%x1)	# 6 
fle_else.20075:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20076	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20076:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20074:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20077	# 4 
	jr	0(%x1)	# 6 
fle_else.20077:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20078	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20078:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20072:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20079	# 4 
	jr	0(%x1)	# 6 
fle_else.20079:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20080	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20081	# 4 
	jr	0(%x1)	# 6 
fle_else.20081:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20082	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20082:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20080:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20083	# 4 
	jr	0(%x1)	# 6 
fle_else.20083:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20084	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20084:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20070:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20085	# 4 
	jr	0(%x1)	# 6 
fle_else.20085:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20086	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20087	# 4 
	jr	0(%x1)	# 6 
fle_else.20087:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20088	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20089	# 4 
	jr	0(%x1)	# 6 
fle_else.20089:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20090	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20090:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20088:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20091	# 4 
	jr	0(%x1)	# 6 
fle_else.20091:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20092	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20092:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20086:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20093	# 4 
	jr	0(%x1)	# 6 
fle_else.20093:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20094	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20095	# 4 
	jr	0(%x1)	# 6 
fle_else.20095:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20096	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20096:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20094:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20097	# 4 
	jr	0(%x1)	# 6 
fle_else.20097:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20098	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20098:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
reduction_f.6715:	#- 2356
	fle	%x5 %f2 %f1	# 8 
	bne	%x5 %x0 fle_else.20099	# 8 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20100	# 4 
	jr	0(%x1)	# 6 
fle_else.20100:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20101	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20102	# 4 
	jr	0(%x1)	# 6 
fle_else.20102:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20103	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20104	# 4 
	jr	0(%x1)	# 6 
fle_else.20104:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20105	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20105:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20103:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20106	# 4 
	jr	0(%x1)	# 6 
fle_else.20106:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20107	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20107:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20101:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20108	# 4 
	jr	0(%x1)	# 6 
fle_else.20108:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20109	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20110	# 4 
	jr	0(%x1)	# 6 
fle_else.20110:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20111	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20111:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20109:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20112	# 4 
	jr	0(%x1)	# 6 
fle_else.20112:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20113	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20113:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780	# 5 
fle_else.20099:	# 8 
	lw	%f3 4(%x29)	# 8 
	fmul	%f2 %f3 %f2	# 8 
	fle	%x5 %f2 %f1	# 8 
	bne	%x5 %x0 fle_else.20114	# 8 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20115	# 4 
	jr	0(%x1)	# 6 
fle_else.20115:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20116	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20117	# 4 
	jr	0(%x1)	# 6 
fle_else.20117:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20118	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20119	# 4 
	jr	0(%x1)	# 6 
fle_else.20119:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20120	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20120:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20118:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20121	# 4 
	jr	0(%x1)	# 6 
fle_else.20121:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20122	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20122:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20116:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20123	# 4 
	jr	0(%x1)	# 6 
fle_else.20123:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20124	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20125	# 4 
	jr	0(%x1)	# 6 
fle_else.20125:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20126	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20126:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20124:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20127	# 4 
	jr	0(%x1)	# 6 
fle_else.20127:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20128	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20128:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11156	# 5 
fle_else.20114:	# 8 
	lw	%f3 4(%x29)	# 8 
	fmul	%f2 %f3 %f2	# 8 
	j	reduction_f.6715	# 8 
sin_g.6731:	#- 3072
	lw	%f3 8(%x29)	# 30 
	fle	%x5 %f3 %f1	# 30 
	bne	%x5 %x0 fle_else.20129	# 30 
	lw	%f3 12(%x29)	# 27 
	fle	%x5 %f1 %f3	# 27 
	bne	%x5 %x0 fle_else.20130	# 27 
	lw	%f3 8(%x29)	# 27 
	fsub	%f1 %f3 %f1	# 27 
	fmul	%f1 %f1 %f1	# 15 
	fmul	%f3 %f1 %f1	# 16 
	fmul	%f4 %f3 %f1	# 17 
	lw	%f5 16(%x29)	# 18 
	lw	%f6 20(%x29)	# 18 
	fmul	%f1 %f6 %f1	# 18 
	fsub	%f1 %f5 %f1	# 18 
	lw	%f5 24(%x29)	# 18 
	fmul	%f3 %f5 %f3	# 18 
	fadd	%f1 %f1 %f3	# 18 
	lw	%f3 28(%x29)	# 18 
	fmul	%f3 %f3 %f4	# 18 
	fsub	%f1 %f1 %f3	# 18 
	fmul	%f1 %f2 %f1	# 18 
	jr	0(%x1)	# 18 
fle_else.20130:	# 27 
	fmul	%f3 %f1 %f1	# 21 
	fmul	%f4 %f3 %f1	# 22 
	fmul	%f5 %f4 %f3	# 23 
	fmul	%f3 %f5 %f3	# 24 
	lw	%f6 32(%x29)	# 25 
	fmul	%f4 %f6 %f4	# 25 
	fsub	%f1 %f1 %f4	# 25 
	lw	%f4 36(%x29)	# 25 
	fmul	%f4 %f4 %f5	# 25 
	fadd	%f1 %f1 %f4	# 25 
	lw	%f4 40(%x29)	# 25 
	fmul	%f3 %f4 %f3	# 25 
	fsub	%f1 %f1 %f3	# 25 
	fmul	%f1 %f2 %f1	# 25 
	jr	0(%x1)	# 25 
fle_else.20129:	# 30 
	lw	%f3 44(%x29)	# 30 
	fsub	%f1 %f3 %f1	# 30 
	lw	%f3 12(%x29)	# 27 
	fle	%x5 %f1 %f3	# 27 
	bne	%x5 %x0 fle_else.20131	# 27 
	lw	%f3 8(%x29)	# 27 
	fsub	%f1 %f3 %f1	# 27 
	fmul	%f1 %f1 %f1	# 15 
	fmul	%f3 %f1 %f1	# 16 
	fmul	%f4 %f3 %f1	# 17 
	lw	%f5 16(%x29)	# 18 
	lw	%f6 20(%x29)	# 18 
	fmul	%f1 %f6 %f1	# 18 
	fsub	%f1 %f5 %f1	# 18 
	lw	%f5 24(%x29)	# 18 
	fmul	%f3 %f5 %f3	# 18 
	fadd	%f1 %f1 %f3	# 18 
	lw	%f3 28(%x29)	# 18 
	fmul	%f3 %f3 %f4	# 18 
	fsub	%f1 %f1 %f3	# 18 
	fmul	%f1 %f2 %f1	# 18 
	jr	0(%x1)	# 18 
fle_else.20131:	# 27 
	fmul	%f3 %f1 %f1	# 21 
	fmul	%f4 %f3 %f1	# 22 
	fmul	%f5 %f4 %f3	# 23 
	fmul	%f3 %f5 %f3	# 24 
	lw	%f6 32(%x29)	# 25 
	fmul	%f4 %f6 %f4	# 25 
	fsub	%f1 %f1 %f4	# 25 
	lw	%f4 36(%x29)	# 25 
	fmul	%f4 %f4 %f5	# 25 
	fadd	%f1 %f1 %f4	# 25 
	lw	%f4 40(%x29)	# 25 
	fmul	%f3 %f4 %f3	# 25 
	fsub	%f1 %f1 %f3	# 25 
	fmul	%f1 %f2 %f1	# 25 
	jr	0(%x1)	# 25 
sin_f.6718:	#- 3372
	lw	%f3 44(%x29)	# 33 
	fle	%x5 %f3 %f1	# 33 
	bne	%x5 %x0 fle_else.20132	# 33 
	j	sin_g.6731	# 34 
fle_else.20132:	# 33 
	lw	%f3 44(%x29)	# 33 
	fsub	%f1 %f1 %f3	# 33 
	lw	%f3 48(%x29)	# 33 
	fmul	%f2 %f3 %f2	# 33 
	j	sin_g.6731	# 33 
reduction_g.6780.11102:	#- 3408
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20133	# 4 
	jr	0(%x1)	# 6 
fle_else.20133:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20134	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20135	# 4 
	jr	0(%x1)	# 6 
fle_else.20135:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20136	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20137	# 4 
	jr	0(%x1)	# 6 
fle_else.20137:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20138	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20139	# 4 
	jr	0(%x1)	# 6 
fle_else.20139:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20140	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20140:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20138:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20141	# 4 
	jr	0(%x1)	# 6 
fle_else.20141:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20142	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20142:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20136:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20143	# 4 
	jr	0(%x1)	# 6 
fle_else.20143:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20144	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20145	# 4 
	jr	0(%x1)	# 6 
fle_else.20145:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20146	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20146:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20144:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20147	# 4 
	jr	0(%x1)	# 6 
fle_else.20147:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20148	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20148:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20134:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20149	# 4 
	jr	0(%x1)	# 6 
fle_else.20149:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20150	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20151	# 4 
	jr	0(%x1)	# 6 
fle_else.20151:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20152	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20153	# 4 
	jr	0(%x1)	# 6 
fle_else.20153:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20154	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20154:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20152:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20155	# 4 
	jr	0(%x1)	# 6 
fle_else.20155:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20156	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20156:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20150:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20157	# 4 
	jr	0(%x1)	# 6 
fle_else.20157:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20158	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20159	# 4 
	jr	0(%x1)	# 6 
fle_else.20159:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20160	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20160:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20158:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20161	# 4 
	jr	0(%x1)	# 6 
fle_else.20161:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20162	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
fle_else.20162:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11102	# 5 
reduction_g.6780.11113:	#- 4132
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20163	# 4 
	jr	0(%x1)	# 6 
fle_else.20163:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20164	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20165	# 4 
	jr	0(%x1)	# 6 
fle_else.20165:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20166	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20167	# 4 
	jr	0(%x1)	# 6 
fle_else.20167:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20168	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20169	# 4 
	jr	0(%x1)	# 6 
fle_else.20169:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20170	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20170:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20168:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20171	# 4 
	jr	0(%x1)	# 6 
fle_else.20171:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20172	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20172:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20166:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20173	# 4 
	jr	0(%x1)	# 6 
fle_else.20173:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20174	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20175	# 4 
	jr	0(%x1)	# 6 
fle_else.20175:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20176	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20176:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20174:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20177	# 4 
	jr	0(%x1)	# 6 
fle_else.20177:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20178	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20178:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20164:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20179	# 4 
	jr	0(%x1)	# 6 
fle_else.20179:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20180	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20181	# 4 
	jr	0(%x1)	# 6 
fle_else.20181:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20182	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20183	# 4 
	jr	0(%x1)	# 6 
fle_else.20183:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20184	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20184:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20182:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20185	# 4 
	jr	0(%x1)	# 6 
fle_else.20185:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20186	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20186:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20180:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20187	# 4 
	jr	0(%x1)	# 6 
fle_else.20187:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20188	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20189	# 4 
	jr	0(%x1)	# 6 
fle_else.20189:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20190	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20190:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20188:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle_else.20191	# 4 
	jr	0(%x1)	# 6 
fle_else.20191:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle_else.20192	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
fle_else.20192:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f3 4(%x29)	# 5 
	fdiv	%f2 %f2 %f3	# 5 
	j	reduction_g.6780.11113	# 5 
sin.2718:	#- 4856
	lw	%f2 52(%x29)	# 36 
	fle	%x5 %f1 %f2	# 36 
	bne	%x5 %x0 fle_else.20193	# 36 
	lw	%f2 0(%x29)	# 36 
	fle	%x5 %f2 %f1	# 8 
	bne	%x5 %x0 fle.20194	# 8 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20196	# 4 
	j	fle_cont.20197	# 4 
fle.20196:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20198	# 5 
	lw	%f2 56(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20200	# 4 
	j	fle_cont.20201	# 4 
fle.20200:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20202	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20204	# 4 
	j	fle_cont.20205	# 4 
fle.20204:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20206	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20207	# 5 
fle.20206:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20207:	# 5 
fle_cont.20205:	# 4 
	j	fle_cont.20203	# 5 
fle.20202:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20208	# 4 
	j	fle_cont.20209	# 4 
fle.20208:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20210	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20211	# 5 
fle.20210:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20211:	# 5 
fle_cont.20209:	# 4 
fle_cont.20203:	# 5 
fle_cont.20201:	# 4 
	j	fle_cont.20199	# 5 
fle.20198:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 56(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20212	# 4 
	j	fle_cont.20213	# 4 
fle.20212:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20214	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20216	# 4 
	j	fle_cont.20217	# 4 
fle.20216:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20218	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20219	# 5 
fle.20218:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20219:	# 5 
fle_cont.20217:	# 4 
	j	fle_cont.20215	# 5 
fle.20214:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20220	# 4 
	j	fle_cont.20221	# 4 
fle.20220:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20222	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20223	# 5 
fle.20222:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11102	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20223:	# 5 
fle_cont.20221:	# 4 
fle_cont.20215:	# 5 
fle_cont.20213:	# 4 
fle_cont.20199:	# 5 
fle_cont.20197:	# 4 
	j	fle_cont.20195	# 8 
fle.20194:	# 8 
	lw	%f2 68(%x29)	# 8 
	sw	%x1 0(%x2)	# 8 
	addi	%x2 %x2 -4	# 8 
	jal	 %x1 reduction_f.6715	# 8 
	addi	%x2 %x2 4	# 8 
	lw	%x1 0(%x2)	# 8 
fle_cont.20195:	# 8 
	lw	%f2 16(%x29)	# 36 
	j	sin_f.6718	# 36 
fle_else.20193:	# 36 
	lw	%f2 52(%x29)	# 37 
	fle	%x5 %f2 %f1	# 37 
	bne	%x5 %x0 fle_else.20224	# 37 
	lw	%f2 48(%x29)	# 37 
	fmul	%f1 %f2 %f1	# 37 
	lw	%f2 0(%x29)	# 37 
	fle	%x5 %f2 %f1	# 8 
	bne	%x5 %x0 fle.20225	# 8 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20227	# 4 
	j	fle_cont.20228	# 4 
fle.20227:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20229	# 5 
	lw	%f2 56(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20231	# 4 
	j	fle_cont.20232	# 4 
fle.20231:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20233	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20235	# 4 
	j	fle_cont.20236	# 4 
fle.20235:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20237	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20238	# 5 
fle.20237:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20238:	# 5 
fle_cont.20236:	# 4 
	j	fle_cont.20234	# 5 
fle.20233:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20239	# 4 
	j	fle_cont.20240	# 4 
fle.20239:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20241	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20242	# 5 
fle.20241:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20242:	# 5 
fle_cont.20240:	# 4 
fle_cont.20234:	# 5 
fle_cont.20232:	# 4 
	j	fle_cont.20230	# 5 
fle.20229:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 56(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20243	# 4 
	j	fle_cont.20244	# 4 
fle.20243:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20245	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20247	# 4 
	j	fle_cont.20248	# 4 
fle.20247:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20249	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20250	# 5 
fle.20249:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20250:	# 5 
fle_cont.20248:	# 4 
	j	fle_cont.20246	# 5 
fle.20245:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 60(%x29)	# 5 
	lw	%f3 0(%x29)	# 4 
	fle	%x5 %f3 %f1	# 4 
	bne	%x5 %x0 fle.20251	# 4 
	j	fle_cont.20252	# 4 
fle.20251:	# 4 
	fle	%x5 %f2 %f1	# 5 
	bne	%x5 %x0 fle.20253	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	j	fle_cont.20254	# 5 
fle.20253:	# 5 
	fsub	%f1 %f1 %f2	# 5 
	lw	%f2 64(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 reduction_g.6780.11113	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
fle_cont.20254:	# 5 
fle_cont.20252:	# 4 
fle_cont.20246:	# 5 
fle_cont.20244:	# 4 
fle_cont.20230:	# 5 
fle_cont.20228:	# 4 
	j	fle_cont.20226	# 8 
fle.20225:	# 8 
	lw	%f2 68(%x29)	# 8 
	sw	%x1 0(%x2)	# 8 
	addi	%x2 %x2 -4	# 8 
	jal	 %x1 reduction_f.6715	# 8 
	addi	%x2 %x2 4	# 8 
	lw	%x1 0(%x2)	# 8 
fle_cont.20226:	# 8 
	lw	%f2 48(%x29)	# 37 
	j	sin_f.6718	# 37 
fle_else.20224:	# 37 
	lw	%f1 52(%x29)	# 38 
	jr	0(%x1)	# 38 
reduction_g.6704:	#- 5872
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20255	# 44 
	jr	0(%x1)	# 46 
fle_else.20255:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20256	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20257	# 44 
	jr	0(%x1)	# 46 
fle_else.20257:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20258	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20259	# 44 
	jr	0(%x1)	# 46 
fle_else.20259:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20260	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20261	# 44 
	jr	0(%x1)	# 46 
fle_else.20261:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20262	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20262:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20260:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20263	# 44 
	jr	0(%x1)	# 46 
fle_else.20263:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20264	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20264:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20258:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20265	# 44 
	jr	0(%x1)	# 46 
fle_else.20265:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20266	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20267	# 44 
	jr	0(%x1)	# 46 
fle_else.20267:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20268	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20268:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20266:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20269	# 44 
	jr	0(%x1)	# 46 
fle_else.20269:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20270	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20270:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20256:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20271	# 44 
	jr	0(%x1)	# 46 
fle_else.20271:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20272	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20273	# 44 
	jr	0(%x1)	# 46 
fle_else.20273:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20274	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20275	# 44 
	jr	0(%x1)	# 46 
fle_else.20275:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20276	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20276:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20274:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20277	# 44 
	jr	0(%x1)	# 46 
fle_else.20277:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20278	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20278:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20272:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20279	# 44 
	jr	0(%x1)	# 46 
fle_else.20279:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20280	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20281	# 44 
	jr	0(%x1)	# 46 
fle_else.20281:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20282	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20282:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20280:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20283	# 44 
	jr	0(%x1)	# 46 
fle_else.20283:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20284	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20284:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
reduction_g.6704.11079:	#- 6596
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20285	# 44 
	jr	0(%x1)	# 46 
fle_else.20285:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20286	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20287	# 44 
	jr	0(%x1)	# 46 
fle_else.20287:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20288	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20289	# 44 
	jr	0(%x1)	# 46 
fle_else.20289:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20290	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20291	# 44 
	jr	0(%x1)	# 46 
fle_else.20291:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20292	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20292:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20290:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20293	# 44 
	jr	0(%x1)	# 46 
fle_else.20293:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20294	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20294:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20288:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20295	# 44 
	jr	0(%x1)	# 46 
fle_else.20295:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20296	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20297	# 44 
	jr	0(%x1)	# 46 
fle_else.20297:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20298	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20298:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20296:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20299	# 44 
	jr	0(%x1)	# 46 
fle_else.20299:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20300	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20300:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20286:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20301	# 44 
	jr	0(%x1)	# 46 
fle_else.20301:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20302	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20303	# 44 
	jr	0(%x1)	# 46 
fle_else.20303:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20304	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20305	# 44 
	jr	0(%x1)	# 46 
fle_else.20305:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20306	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20306:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20304:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20307	# 44 
	jr	0(%x1)	# 46 
fle_else.20307:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20308	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20308:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20302:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20309	# 44 
	jr	0(%x1)	# 46 
fle_else.20309:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20310	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20311	# 44 
	jr	0(%x1)	# 46 
fle_else.20311:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20312	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20312:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20310:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20313	# 44 
	jr	0(%x1)	# 46 
fle_else.20313:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20314	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20314:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
reduction_f.6637:	#- 7320
	fle	%x5 %f2 %f1	# 48 
	bne	%x5 %x0 fle_else.20315	# 48 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20316	# 44 
	jr	0(%x1)	# 46 
fle_else.20316:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20317	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20318	# 44 
	jr	0(%x1)	# 46 
fle_else.20318:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20319	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20320	# 44 
	jr	0(%x1)	# 46 
fle_else.20320:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20321	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20321:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20319:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20322	# 44 
	jr	0(%x1)	# 46 
fle_else.20322:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20323	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20323:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20317:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20324	# 44 
	jr	0(%x1)	# 46 
fle_else.20324:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20325	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20326	# 44 
	jr	0(%x1)	# 46 
fle_else.20326:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20327	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20327:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20325:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20328	# 44 
	jr	0(%x1)	# 46 
fle_else.20328:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20329	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20329:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704	# 45 
fle_else.20315:	# 48 
	lw	%f3 4(%x29)	# 48 
	fmul	%f2 %f3 %f2	# 48 
	fle	%x5 %f2 %f1	# 48 
	bne	%x5 %x0 fle_else.20330	# 48 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20331	# 44 
	jr	0(%x1)	# 46 
fle_else.20331:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20332	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20333	# 44 
	jr	0(%x1)	# 46 
fle_else.20333:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20334	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20335	# 44 
	jr	0(%x1)	# 46 
fle_else.20335:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20336	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20336:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20334:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20337	# 44 
	jr	0(%x1)	# 46 
fle_else.20337:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20338	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20338:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20332:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20339	# 44 
	jr	0(%x1)	# 46 
fle_else.20339:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20340	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20341	# 44 
	jr	0(%x1)	# 46 
fle_else.20341:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20342	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20342:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20340:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20343	# 44 
	jr	0(%x1)	# 46 
fle_else.20343:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20344	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20344:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11079	# 45 
fle_else.20330:	# 48 
	lw	%f3 4(%x29)	# 48 
	fmul	%f2 %f3 %f2	# 48 
	j	reduction_f.6637	# 48 
cos_g.6653:	#- 8036
	lw	%f3 8(%x29)	# 70 
	fle	%x5 %f3 %f1	# 70 
	bne	%x5 %x0 fle_else.20345	# 70 
	lw	%f3 12(%x29)	# 67 
	fle	%x5 %f1 %f3	# 67 
	bne	%x5 %x0 fle_else.20346	# 67 
	lw	%f3 8(%x29)	# 67 
	fsub	%f1 %f3 %f1	# 67 
	fmul	%f3 %f1 %f1	# 61 
	fmul	%f4 %f3 %f1	# 62 
	fmul	%f5 %f4 %f3	# 63 
	fmul	%f3 %f5 %f3	# 64 
	lw	%f6 32(%x29)	# 65 
	fmul	%f4 %f6 %f4	# 65 
	fsub	%f1 %f1 %f4	# 65 
	lw	%f4 36(%x29)	# 65 
	fmul	%f4 %f4 %f5	# 65 
	fadd	%f1 %f1 %f4	# 65 
	lw	%f4 40(%x29)	# 65 
	fmul	%f3 %f4 %f3	# 65 
	fsub	%f1 %f1 %f3	# 65 
	fmul	%f1 %f2 %f1	# 65 
	jr	0(%x1)	# 65 
fle_else.20346:	# 67 
	fmul	%f1 %f1 %f1	# 55 
	fmul	%f3 %f1 %f1	# 56 
	fmul	%f4 %f3 %f1	# 57 
	lw	%f5 16(%x29)	# 58 
	lw	%f6 20(%x29)	# 58 
	fmul	%f1 %f6 %f1	# 58 
	fsub	%f1 %f5 %f1	# 58 
	lw	%f5 24(%x29)	# 58 
	fmul	%f3 %f5 %f3	# 58 
	fadd	%f1 %f1 %f3	# 58 
	lw	%f3 28(%x29)	# 58 
	fmul	%f3 %f3 %f4	# 58 
	fsub	%f1 %f1 %f3	# 58 
	fmul	%f1 %f2 %f1	# 58 
	jr	0(%x1)	# 58 
fle_else.20345:	# 70 
	lw	%f3 44(%x29)	# 70 
	fsub	%f1 %f3 %f1	# 70 
	lw	%f3 48(%x29)	# 70 
	fmul	%f2 %f3 %f2	# 70 
	lw	%f3 12(%x29)	# 67 
	fle	%x5 %f1 %f3	# 67 
	bne	%x5 %x0 fle_else.20347	# 67 
	lw	%f3 8(%x29)	# 67 
	fsub	%f1 %f3 %f1	# 67 
	fmul	%f3 %f1 %f1	# 61 
	fmul	%f4 %f3 %f1	# 62 
	fmul	%f5 %f4 %f3	# 63 
	fmul	%f3 %f5 %f3	# 64 
	lw	%f6 32(%x29)	# 65 
	fmul	%f4 %f6 %f4	# 65 
	fsub	%f1 %f1 %f4	# 65 
	lw	%f4 36(%x29)	# 65 
	fmul	%f4 %f4 %f5	# 65 
	fadd	%f1 %f1 %f4	# 65 
	lw	%f4 40(%x29)	# 65 
	fmul	%f3 %f4 %f3	# 65 
	fsub	%f1 %f1 %f3	# 65 
	fmul	%f1 %f2 %f1	# 65 
	jr	0(%x1)	# 65 
fle_else.20347:	# 67 
	fmul	%f1 %f1 %f1	# 55 
	fmul	%f3 %f1 %f1	# 56 
	fmul	%f4 %f3 %f1	# 57 
	lw	%f5 16(%x29)	# 58 
	lw	%f6 20(%x29)	# 58 
	fmul	%f1 %f6 %f1	# 58 
	fsub	%f1 %f5 %f1	# 58 
	lw	%f5 24(%x29)	# 58 
	fmul	%f3 %f5 %f3	# 58 
	fadd	%f1 %f1 %f3	# 58 
	lw	%f3 28(%x29)	# 58 
	fmul	%f3 %f3 %f4	# 58 
	fsub	%f1 %f1 %f3	# 58 
	fmul	%f1 %f2 %f1	# 58 
	jr	0(%x1)	# 58 
cos_f.6640:	#- 8344
	lw	%f3 44(%x29)	# 73 
	fle	%x5 %f3 %f1	# 73 
	bne	%x5 %x0 fle_else.20348	# 73 
	j	cos_g.6653	# 74 
fle_else.20348:	# 73 
	lw	%f3 44(%x29)	# 73 
	fsub	%f1 %f1 %f3	# 73 
	lw	%f3 48(%x29)	# 73 
	fmul	%f2 %f3 %f2	# 73 
	j	cos_g.6653	# 73 
reduction_g.6704.11025:	#- 8380
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20349	# 44 
	jr	0(%x1)	# 46 
fle_else.20349:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20350	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20351	# 44 
	jr	0(%x1)	# 46 
fle_else.20351:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20352	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20353	# 44 
	jr	0(%x1)	# 46 
fle_else.20353:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20354	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20355	# 44 
	jr	0(%x1)	# 46 
fle_else.20355:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20356	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20356:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20354:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20357	# 44 
	jr	0(%x1)	# 46 
fle_else.20357:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20358	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20358:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20352:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20359	# 44 
	jr	0(%x1)	# 46 
fle_else.20359:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20360	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20361	# 44 
	jr	0(%x1)	# 46 
fle_else.20361:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20362	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20362:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20360:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20363	# 44 
	jr	0(%x1)	# 46 
fle_else.20363:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20364	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20364:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20350:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20365	# 44 
	jr	0(%x1)	# 46 
fle_else.20365:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20366	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20367	# 44 
	jr	0(%x1)	# 46 
fle_else.20367:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20368	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20369	# 44 
	jr	0(%x1)	# 46 
fle_else.20369:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20370	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20370:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20368:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20371	# 44 
	jr	0(%x1)	# 46 
fle_else.20371:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20372	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20372:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20366:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20373	# 44 
	jr	0(%x1)	# 46 
fle_else.20373:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20374	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20375	# 44 
	jr	0(%x1)	# 46 
fle_else.20375:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20376	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20376:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20374:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20377	# 44 
	jr	0(%x1)	# 46 
fle_else.20377:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20378	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
fle_else.20378:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11025	# 45 
reduction_g.6704.11036:	#- 9104
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20379	# 44 
	jr	0(%x1)	# 46 
fle_else.20379:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20380	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20381	# 44 
	jr	0(%x1)	# 46 
fle_else.20381:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20382	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20383	# 44 
	jr	0(%x1)	# 46 
fle_else.20383:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20384	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20385	# 44 
	jr	0(%x1)	# 46 
fle_else.20385:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20386	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20386:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20384:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20387	# 44 
	jr	0(%x1)	# 46 
fle_else.20387:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20388	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20388:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20382:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20389	# 44 
	jr	0(%x1)	# 46 
fle_else.20389:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20390	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20391	# 44 
	jr	0(%x1)	# 46 
fle_else.20391:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20392	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20392:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20390:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20393	# 44 
	jr	0(%x1)	# 46 
fle_else.20393:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20394	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20394:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20380:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20395	# 44 
	jr	0(%x1)	# 46 
fle_else.20395:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20396	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20397	# 44 
	jr	0(%x1)	# 46 
fle_else.20397:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20398	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20399	# 44 
	jr	0(%x1)	# 46 
fle_else.20399:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20400	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20400:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20398:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20401	# 44 
	jr	0(%x1)	# 46 
fle_else.20401:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20402	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20402:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20396:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20403	# 44 
	jr	0(%x1)	# 46 
fle_else.20403:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20404	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20405	# 44 
	jr	0(%x1)	# 46 
fle_else.20405:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20406	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20406:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20404:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle_else.20407	# 44 
	jr	0(%x1)	# 46 
fle_else.20407:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle_else.20408	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
fle_else.20408:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f3 4(%x29)	# 45 
	fdiv	%f2 %f2 %f3	# 45 
	j	reduction_g.6704.11036	# 45 
cos.2720:	#- 9828
	lw	%f2 52(%x29)	# 76 
	fle	%x5 %f1 %f2	# 76 
	bne	%x5 %x0 fle_else.20409	# 76 
	lw	%f2 0(%x29)	# 76 
	fle	%x5 %f2 %f1	# 48 
	bne	%x5 %x0 fle.20410	# 48 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20412	# 44 
	j	fle_cont.20413	# 44 
fle.20412:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20414	# 45 
	lw	%f2 56(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20416	# 44 
	j	fle_cont.20417	# 44 
fle.20416:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20418	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20420	# 44 
	j	fle_cont.20421	# 44 
fle.20420:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20422	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20423	# 45 
fle.20422:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20423:	# 45 
fle_cont.20421:	# 44 
	j	fle_cont.20419	# 45 
fle.20418:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20424	# 44 
	j	fle_cont.20425	# 44 
fle.20424:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20426	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20427	# 45 
fle.20426:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20427:	# 45 
fle_cont.20425:	# 44 
fle_cont.20419:	# 45 
fle_cont.20417:	# 44 
	j	fle_cont.20415	# 45 
fle.20414:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 56(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20428	# 44 
	j	fle_cont.20429	# 44 
fle.20428:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20430	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20432	# 44 
	j	fle_cont.20433	# 44 
fle.20432:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20434	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20435	# 45 
fle.20434:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20435:	# 45 
fle_cont.20433:	# 44 
	j	fle_cont.20431	# 45 
fle.20430:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20436	# 44 
	j	fle_cont.20437	# 44 
fle.20436:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20438	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20439	# 45 
fle.20438:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11025	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20439:	# 45 
fle_cont.20437:	# 44 
fle_cont.20431:	# 45 
fle_cont.20429:	# 44 
fle_cont.20415:	# 45 
fle_cont.20413:	# 44 
	j	fle_cont.20411	# 48 
fle.20410:	# 48 
	lw	%f2 68(%x29)	# 48 
	sw	%x1 0(%x2)	# 48 
	addi	%x2 %x2 -4	# 48 
	jal	 %x1 reduction_f.6637	# 48 
	addi	%x2 %x2 4	# 48 
	lw	%x1 0(%x2)	# 48 
fle_cont.20411:	# 48 
	lw	%f2 16(%x29)	# 76 
	j	cos_f.6640	# 76 
fle_else.20409:	# 76 
	lw	%f2 52(%x29)	# 77 
	fle	%x5 %f2 %f1	# 77 
	bne	%x5 %x0 fle_else.20440	# 77 
	lw	%f2 48(%x29)	# 77 
	fmul	%f1 %f2 %f1	# 77 
	lw	%f2 0(%x29)	# 77 
	fle	%x5 %f2 %f1	# 48 
	bne	%x5 %x0 fle.20441	# 48 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20443	# 44 
	j	fle_cont.20444	# 44 
fle.20443:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20445	# 45 
	lw	%f2 56(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20447	# 44 
	j	fle_cont.20448	# 44 
fle.20447:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20449	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20451	# 44 
	j	fle_cont.20452	# 44 
fle.20451:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20453	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20454	# 45 
fle.20453:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20454:	# 45 
fle_cont.20452:	# 44 
	j	fle_cont.20450	# 45 
fle.20449:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20455	# 44 
	j	fle_cont.20456	# 44 
fle.20455:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20457	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20458	# 45 
fle.20457:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20458:	# 45 
fle_cont.20456:	# 44 
fle_cont.20450:	# 45 
fle_cont.20448:	# 44 
	j	fle_cont.20446	# 45 
fle.20445:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 56(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20459	# 44 
	j	fle_cont.20460	# 44 
fle.20459:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20461	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20463	# 44 
	j	fle_cont.20464	# 44 
fle.20463:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20465	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20466	# 45 
fle.20465:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20466:	# 45 
fle_cont.20464:	# 44 
	j	fle_cont.20462	# 45 
fle.20461:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 60(%x29)	# 45 
	lw	%f3 0(%x29)	# 44 
	fle	%x5 %f3 %f1	# 44 
	bne	%x5 %x0 fle.20467	# 44 
	j	fle_cont.20468	# 44 
fle.20467:	# 44 
	fle	%x5 %f2 %f1	# 45 
	bne	%x5 %x0 fle.20469	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
	j	fle_cont.20470	# 45 
fle.20469:	# 45 
	fsub	%f1 %f1 %f2	# 45 
	lw	%f2 64(%x29)	# 45 
	sw	%x1 0(%x2)	# 45 
	addi	%x2 %x2 -4	# 45 
	jal	 %x1 reduction_g.6704.11036	# 45 
	addi	%x2 %x2 4	# 45 
	lw	%x1 0(%x2)	# 45 
fle_cont.20470:	# 45 
fle_cont.20468:	# 44 
fle_cont.20462:	# 45 
fle_cont.20460:	# 44 
fle_cont.20446:	# 45 
fle_cont.20444:	# 44 
	j	fle_cont.20442	# 48 
fle.20441:	# 48 
	lw	%f2 68(%x29)	# 48 
	sw	%x1 0(%x2)	# 48 
	addi	%x2 %x2 -4	# 48 
	jal	 %x1 reduction_f.6637	# 48 
	addi	%x2 %x2 4	# 48 
	lw	%x1 0(%x2)	# 48 
fle_cont.20442:	# 48 
	lw	%f2 16(%x29)	# 77 
	j	cos_f.6640	# 77 
fle_else.20440:	# 77 
	lw	%f1 16(%x29)	# 78 
	jr	0(%x1)	# 78 
atan_f.6581:	#- 10844
	lw	%f3 72(%x29)	# 110 
	fle	%x5 %f1 %f3	# 110 
	bne	%x5 %x0 fle_else.20471	# 110 
	lw	%f3 16(%x29)	# 110 
	fdiv	%f1 %f3 %f1	# 110 
	lw	%f3 8(%x29)	# 110 
	lw	%f4 48(%x29)	# 110 
	fmul	%f5 %f1 %f1	# 101 
	fmul	%f6 %f5 %f1	# 102 
	fmul	%f7 %f6 %f5	# 103 
	fmul	%f8 %f7 %f5	# 104 
	fmul	%f9 %f8 %f5	# 105 
	fmul	%f10 %f9 %f5	# 106 
	fmul	%f5 %f10 %f5	# 107 
	lw	%f11 76(%x29)	# 108 
	fmul	%f6 %f11 %f6	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 80(%x29)	# 108 
	fmul	%f6 %f6 %f7	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 84(%x29)	# 108 
	fmul	%f6 %f6 %f8	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 88(%x29)	# 108 
	fmul	%f6 %f6 %f9	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 92(%x29)	# 108 
	fmul	%f6 %f6 %f10	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 96(%x29)	# 108 
	fmul	%f5 %f6 %f5	# 108 
	fadd	%f1 %f1 %f5	# 108 
	fmul	%f1 %f4 %f1	# 108 
	fadd	%f1 %f3 %f1	# 108 
	fmul	%f1 %f2 %f1	# 108 
	jr	0(%x1)	# 108 
fle_else.20471:	# 110 
	lw	%f3 100(%x29)	# 111 
	fle	%x5 %f3 %f1	# 111 
	bne	%x5 %x0 fle_else.20472	# 111 
	lw	%f3 52(%x29)	# 112 
	lw	%f4 16(%x29)	# 112 
	fmul	%f5 %f1 %f1	# 101 
	fmul	%f6 %f5 %f1	# 102 
	fmul	%f7 %f6 %f5	# 103 
	fmul	%f8 %f7 %f5	# 104 
	fmul	%f9 %f8 %f5	# 105 
	fmul	%f10 %f9 %f5	# 106 
	fmul	%f5 %f10 %f5	# 107 
	lw	%f11 76(%x29)	# 108 
	fmul	%f6 %f11 %f6	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 80(%x29)	# 108 
	fmul	%f6 %f6 %f7	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 84(%x29)	# 108 
	fmul	%f6 %f6 %f8	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 88(%x29)	# 108 
	fmul	%f6 %f6 %f9	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 92(%x29)	# 108 
	fmul	%f6 %f6 %f10	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 96(%x29)	# 108 
	fmul	%f5 %f6 %f5	# 108 
	fadd	%f1 %f1 %f5	# 108 
	fmul	%f1 %f4 %f1	# 108 
	fadd	%f1 %f3 %f1	# 108 
	fmul	%f1 %f2 %f1	# 108 
	jr	0(%x1)	# 108 
fle_else.20472:	# 111 
	lw	%f3 16(%x29)	# 111 
	fsub	%f3 %f1 %f3	# 111 
	lw	%f4 16(%x29)	# 111 
	fadd	%f1 %f1 %f4	# 111 
	fdiv	%f1 %f3 %f1	# 111 
	lw	%f3 12(%x29)	# 111 
	lw	%f4 16(%x29)	# 111 
	fmul	%f5 %f1 %f1	# 101 
	fmul	%f6 %f5 %f1	# 102 
	fmul	%f7 %f6 %f5	# 103 
	fmul	%f8 %f7 %f5	# 104 
	fmul	%f9 %f8 %f5	# 105 
	fmul	%f10 %f9 %f5	# 106 
	fmul	%f5 %f10 %f5	# 107 
	lw	%f11 76(%x29)	# 108 
	fmul	%f6 %f11 %f6	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 80(%x29)	# 108 
	fmul	%f6 %f6 %f7	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 84(%x29)	# 108 
	fmul	%f6 %f6 %f8	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 88(%x29)	# 108 
	fmul	%f6 %f6 %f9	# 108 
	fadd	%f1 %f1 %f6	# 108 
	lw	%f6 92(%x29)	# 108 
	fmul	%f6 %f6 %f10	# 108 
	fsub	%f1 %f1 %f6	# 108 
	lw	%f6 96(%x29)	# 108 
	fmul	%f5 %f6 %f5	# 108 
	fadd	%f1 %f1 %f5	# 108 
	fmul	%f1 %f4 %f1	# 108 
	fadd	%f1 %f3 %f1	# 108 
	fmul	%f1 %f2 %f1	# 108 
	jr	0(%x1)	# 108 
atan.2722:	#- 11268
	lw	%f2 52(%x29)	# 114 
	fle	%x5 %f1 %f2	# 114 
	bne	%x5 %x0 fle_else.20473	# 114 
	lw	%f2 16(%x29)	# 114 
	j	atan_f.6581	# 114 
fle_else.20473:	# 114 
	lw	%f2 52(%x29)	# 115 
	fle	%x5 %f2 %f1	# 115 
	bne	%x5 %x0 fle_else.20474	# 115 
	lw	%f2 48(%x29)	# 115 
	fmul	%f1 %f2 %f1	# 115 
	lw	%f2 48(%x29)	# 115 
	j	atan_f.6581	# 115 
fle_else.20474:	# 115 
	lw	%f1 52(%x29)	# 116 
	jr	0(%x1)	# 116 
hundredth.6523:	#- 11324
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge_else.20475	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x7 1	# 141 
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge_else.20476	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x7 1	# 141 
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge_else.20477	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x7 1	# 141 
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge_else.20478	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x7 1	# 141 
	j	hundredth.6523	# 141 
bge_else.20478:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
	jr	0(%x1)	# 140 
bge_else.20477:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
	jr	0(%x1)	# 140 
bge_else.20476:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
	jr	0(%x1)	# 140 
bge_else.20475:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
	jr	0(%x1)	# 140 
tenth.6526:	#- 11488
	addi	%x8 %x6 -10	# 144 
	blt	%x8 %x0 bge_else.20479	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x7 %x7 1	# 145 
	addi	%x8 %x6 -10	# 144 
	blt	%x8 %x0 bge_else.20480	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x7 %x7 1	# 145 
	addi	%x8 %x6 -10	# 144 
	blt	%x8 %x0 bge_else.20481	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x7 %x7 1	# 145 
	addi	%x8 %x6 -10	# 144 
	blt	%x8 %x0 bge_else.20482	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x7 %x7 1	# 145 
	j	tenth.6526	# 145 
bge_else.20482:	# 144 
	add	%x8 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x7 4(%x8)	# 144 
	sw	%x6 0(%x8)	# 144 
	add	%x6 %x0 %x8	# 144 
	jr	0(%x1)	# 144 
bge_else.20481:	# 144 
	add	%x8 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x7 4(%x8)	# 144 
	sw	%x6 0(%x8)	# 144 
	add	%x6 %x0 %x8	# 144 
	jr	0(%x1)	# 144 
bge_else.20480:	# 144 
	add	%x8 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x7 4(%x8)	# 144 
	sw	%x6 0(%x8)	# 144 
	add	%x6 %x0 %x8	# 144 
	jr	0(%x1)	# 144 
bge_else.20479:	# 144 
	add	%x8 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x7 4(%x8)	# 144 
	sw	%x6 0(%x8)	# 144 
	add	%x6 %x0 %x8	# 144 
	jr	0(%x1)	# 144 
oneth.6529:	#- 11652
	addi	%x8 %x6 -1	# 148 
	blt	%x8 %x0 bge_else.20483	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x7 %x7 1	# 149 
	addi	%x8 %x6 -1	# 148 
	blt	%x8 %x0 bge_else.20484	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x7 %x7 1	# 149 
	addi	%x8 %x6 -1	# 148 
	blt	%x8 %x0 bge_else.20485	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x7 %x7 1	# 149 
	addi	%x8 %x6 -1	# 148 
	blt	%x8 %x0 bge_else.20486	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x7 %x7 1	# 149 
	j	oneth.6529	# 149 
bge_else.20486:	# 148 
	add	%x8 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x7 4(%x8)	# 148 
	sw	%x6 0(%x8)	# 148 
	add	%x6 %x0 %x8	# 148 
	jr	0(%x1)	# 148 
bge_else.20485:	# 148 
	add	%x8 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x7 4(%x8)	# 148 
	sw	%x6 0(%x8)	# 148 
	add	%x6 %x0 %x8	# 148 
	jr	0(%x1)	# 148 
bge_else.20484:	# 148 
	add	%x8 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x7 4(%x8)	# 148 
	sw	%x6 0(%x8)	# 148 
	add	%x6 %x0 %x8	# 148 
	jr	0(%x1)	# 148 
bge_else.20483:	# 148 
	add	%x8 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x7 4(%x8)	# 148 
	sw	%x6 0(%x8)	# 148 
	add	%x6 %x0 %x8	# 148 
	jr	0(%x1)	# 148 
print_int.2730:	#- 11816
	addi	%x7 %x0 0	# 151
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge.20487	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x0 1	# 141
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge.20489	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x0 2	# 141
	addi	%x8 %x6 -100	# 140 
	blt	%x8 %x0 bge.20491	# 140 
	addi	%x6 %x6 -100	# 141 
	addi	%x7 %x0 3	# 141
	sw	%x1 0(%x2)	# 141 
	addi	%x2 %x2 -4	# 141 
	jal	 %x1 hundredth.6523	# 141 
	addi	%x2 %x2 4	# 141 
	lw	%x1 0(%x2)	# 141 
	j	beq_cont.20492	# 140 
bge.20491:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
beq_cont.20492:	# 140 
	j	beq_cont.20490	# 140 
bge.20489:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
beq_cont.20490:	# 140 
	j	beq_cont.20488	# 140 
bge.20487:	# 140 
	add	%x8 %x0 %x3	# 140 
	addi	%x3 %x3 8	# 140 
	sw	%x7 4(%x8)	# 140 
	sw	%x6 0(%x8)	# 140 
	add	%x6 %x0 %x8	# 140 
beq_cont.20488:	# 140 
	lw	%x7 4(%x6)	# 151 
	lw	%x6 0(%x6)	# 151 
	addi	%x8 %x0 0	# 152
	addi	%x9 %x6 -10	# 144 
	sw	%x7 -0(%x2)	# 144 
	blt	%x9 %x0 bge.20493	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x8 %x0 1	# 145
	addi	%x9 %x6 -10	# 144 
	blt	%x9 %x0 bge.20495	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x8 %x0 2	# 145
	addi	%x9 %x6 -10	# 144 
	blt	%x9 %x0 bge.20497	# 144 
	addi	%x6 %x6 -10	# 145 
	addi	%x8 %x0 3	# 145
	add	%x7 %x0 %x8	# 145 
	sw	%x1 -4(%x2)	# 145 
	addi	%x2 %x2 -8	# 145 
	jal	 %x1 tenth.6526	# 145 
	addi	%x2 %x2 8	# 145 
	lw	%x1 -4(%x2)	# 145 
	j	beq_cont.20498	# 144 
bge.20497:	# 144 
	add	%x9 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x8 4(%x9)	# 144 
	sw	%x6 0(%x9)	# 144 
	add	%x6 %x0 %x9	# 144 
beq_cont.20498:	# 144 
	j	beq_cont.20496	# 144 
bge.20495:	# 144 
	add	%x9 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x8 4(%x9)	# 144 
	sw	%x6 0(%x9)	# 144 
	add	%x6 %x0 %x9	# 144 
beq_cont.20496:	# 144 
	j	beq_cont.20494	# 144 
bge.20493:	# 144 
	add	%x9 %x0 %x3	# 144 
	addi	%x3 %x3 8	# 144 
	sw	%x8 4(%x9)	# 144 
	sw	%x6 0(%x9)	# 144 
	add	%x6 %x0 %x9	# 144 
beq_cont.20494:	# 144 
	lw	%x7 4(%x6)	# 152 
	lw	%x6 0(%x6)	# 152 
	addi	%x8 %x0 0	# 153
	addi	%x9 %x6 -1	# 148 
	sw	%x7 -4(%x2)	# 148 
	blt	%x9 %x0 bge.20499	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x8 %x0 1	# 149
	addi	%x9 %x6 -1	# 148 
	blt	%x9 %x0 bge.20501	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x8 %x0 2	# 149
	addi	%x9 %x6 -1	# 148 
	blt	%x9 %x0 bge.20503	# 148 
	addi	%x6 %x6 -1	# 149 
	addi	%x8 %x0 3	# 149
	add	%x7 %x0 %x8	# 149 
	sw	%x1 -8(%x2)	# 149 
	addi	%x2 %x2 -12	# 149 
	jal	 %x1 oneth.6529	# 149 
	addi	%x2 %x2 12	# 149 
	lw	%x1 -8(%x2)	# 149 
	j	beq_cont.20504	# 148 
bge.20503:	# 148 
	add	%x9 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x8 4(%x9)	# 148 
	sw	%x6 0(%x9)	# 148 
	add	%x6 %x0 %x9	# 148 
beq_cont.20504:	# 148 
	j	beq_cont.20502	# 148 
bge.20501:	# 148 
	add	%x9 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x8 4(%x9)	# 148 
	sw	%x6 0(%x9)	# 148 
	add	%x6 %x0 %x9	# 148 
beq_cont.20502:	# 148 
	j	beq_cont.20500	# 148 
bge.20499:	# 148 
	add	%x9 %x0 %x3	# 148 
	addi	%x3 %x3 8	# 148 
	sw	%x8 4(%x9)	# 148 
	sw	%x6 0(%x9)	# 148 
	add	%x6 %x0 %x9	# 148 
beq_cont.20500:	# 148 
	lw	%x6 4(%x6)	# 153 
	lw	%x7 -0(%x2)	# 128 
	bne	%x7 %x0 beq_else.20505	# 128 
	addi	%x7 %x0 48	# 128
	j	beq_cont.20506	# 128 
beq_else.20505:	# 128 
	addi	%x5 %x0 1	# 129 
	bne	%x7 %x5 beq_else.20507	# 129 
	addi	%x7 %x0 49	# 129
	j	beq_cont.20508	# 129 
beq_else.20507:	# 129 
	addi	%x5 %x0 2	# 130 
	bne	%x7 %x5 beq_else.20509	# 130 
	addi	%x7 %x0 50	# 130
	j	beq_cont.20510	# 130 
beq_else.20509:	# 130 
	addi	%x5 %x0 3	# 131 
	bne	%x7 %x5 beq_else.20511	# 131 
	addi	%x7 %x0 51	# 131
	j	beq_cont.20512	# 131 
beq_else.20511:	# 131 
	addi	%x5 %x0 4	# 132 
	bne	%x7 %x5 beq_else.20513	# 132 
	addi	%x7 %x0 52	# 132
	j	beq_cont.20514	# 132 
beq_else.20513:	# 132 
	addi	%x5 %x0 5	# 133 
	bne	%x7 %x5 beq_else.20515	# 133 
	addi	%x7 %x0 53	# 133
	j	beq_cont.20516	# 133 
beq_else.20515:	# 133 
	addi	%x5 %x0 6	# 134 
	bne	%x7 %x5 beq_else.20517	# 134 
	addi	%x7 %x0 54	# 134
	j	beq_cont.20518	# 134 
beq_else.20517:	# 134 
	addi	%x5 %x0 7	# 135 
	bne	%x7 %x5 beq_else.20519	# 135 
	addi	%x7 %x0 55	# 135
	j	beq_cont.20520	# 135 
beq_else.20519:	# 135 
	addi	%x5 %x0 8	# 136 
	bne	%x7 %x5 beq_else.20521	# 136 
	addi	%x7 %x0 56	# 136
	j	beq_cont.20522	# 136 
beq_else.20521:	# 136 
	addi	%x7 %x0 57	# 137
beq_cont.20522:	# 136 
beq_cont.20520:	# 135 
beq_cont.20518:	# 134 
beq_cont.20516:	# 133 
beq_cont.20514:	# 132 
beq_cont.20512:	# 131 
beq_cont.20510:	# 130 
beq_cont.20508:	# 129 
beq_cont.20506:	# 128 
	sw	%x6 -8(%x2)	# 154 
	add	%x6 %x0 %x7	# 154 
	sw	%x1 -12(%x2)	# 154 
	addi	%x2 %x2 -16	# 154 
	jal	 %x1 min_caml_print_char	# 154 
	addi	%x2 %x2 16	# 154 
	lw	%x1 -12(%x2)	# 154 
	lw	%x6 -4(%x2)	# 128 
	bne	%x6 %x0 beq_else.20523	# 128 
	addi	%x6 %x0 48	# 128
	j	beq_cont.20524	# 128 
beq_else.20523:	# 128 
	addi	%x5 %x0 1	# 129 
	bne	%x6 %x5 beq_else.20525	# 129 
	addi	%x6 %x0 49	# 129
	j	beq_cont.20526	# 129 
beq_else.20525:	# 129 
	addi	%x5 %x0 2	# 130 
	bne	%x6 %x5 beq_else.20527	# 130 
	addi	%x6 %x0 50	# 130
	j	beq_cont.20528	# 130 
beq_else.20527:	# 130 
	addi	%x5 %x0 3	# 131 
	bne	%x6 %x5 beq_else.20529	# 131 
	addi	%x6 %x0 51	# 131
	j	beq_cont.20530	# 131 
beq_else.20529:	# 131 
	addi	%x5 %x0 4	# 132 
	bne	%x6 %x5 beq_else.20531	# 132 
	addi	%x6 %x0 52	# 132
	j	beq_cont.20532	# 132 
beq_else.20531:	# 132 
	addi	%x5 %x0 5	# 133 
	bne	%x6 %x5 beq_else.20533	# 133 
	addi	%x6 %x0 53	# 133
	j	beq_cont.20534	# 133 
beq_else.20533:	# 133 
	addi	%x5 %x0 6	# 134 
	bne	%x6 %x5 beq_else.20535	# 134 
	addi	%x6 %x0 54	# 134
	j	beq_cont.20536	# 134 
beq_else.20535:	# 134 
	addi	%x5 %x0 7	# 135 
	bne	%x6 %x5 beq_else.20537	# 135 
	addi	%x6 %x0 55	# 135
	j	beq_cont.20538	# 135 
beq_else.20537:	# 135 
	addi	%x5 %x0 8	# 136 
	bne	%x6 %x5 beq_else.20539	# 136 
	addi	%x6 %x0 56	# 136
	j	beq_cont.20540	# 136 
beq_else.20539:	# 136 
	addi	%x6 %x0 57	# 137
beq_cont.20540:	# 136 
beq_cont.20538:	# 135 
beq_cont.20536:	# 134 
beq_cont.20534:	# 133 
beq_cont.20532:	# 132 
beq_cont.20530:	# 131 
beq_cont.20528:	# 130 
beq_cont.20526:	# 129 
beq_cont.20524:	# 128 
	sw	%x1 -12(%x2)	# 155 
	addi	%x2 %x2 -16	# 155 
	jal	 %x1 min_caml_print_char	# 155 
	addi	%x2 %x2 16	# 155 
	lw	%x1 -12(%x2)	# 155 
	lw	%x6 -8(%x2)	# 128 
	bne	%x6 %x0 beq_else.20541	# 128 
	addi	%x6 %x0 48	# 128
	j	beq_cont.20542	# 128 
beq_else.20541:	# 128 
	addi	%x5 %x0 1	# 129 
	bne	%x6 %x5 beq_else.20543	# 129 
	addi	%x6 %x0 49	# 129
	j	beq_cont.20544	# 129 
beq_else.20543:	# 129 
	addi	%x5 %x0 2	# 130 
	bne	%x6 %x5 beq_else.20545	# 130 
	addi	%x6 %x0 50	# 130
	j	beq_cont.20546	# 130 
beq_else.20545:	# 130 
	addi	%x5 %x0 3	# 131 
	bne	%x6 %x5 beq_else.20547	# 131 
	addi	%x6 %x0 51	# 131
	j	beq_cont.20548	# 131 
beq_else.20547:	# 131 
	addi	%x5 %x0 4	# 132 
	bne	%x6 %x5 beq_else.20549	# 132 
	addi	%x6 %x0 52	# 132
	j	beq_cont.20550	# 132 
beq_else.20549:	# 132 
	addi	%x5 %x0 5	# 133 
	bne	%x6 %x5 beq_else.20551	# 133 
	addi	%x6 %x0 53	# 133
	j	beq_cont.20552	# 133 
beq_else.20551:	# 133 
	addi	%x5 %x0 6	# 134 
	bne	%x6 %x5 beq_else.20553	# 134 
	addi	%x6 %x0 54	# 134
	j	beq_cont.20554	# 134 
beq_else.20553:	# 134 
	addi	%x5 %x0 7	# 135 
	bne	%x6 %x5 beq_else.20555	# 135 
	addi	%x6 %x0 55	# 135
	j	beq_cont.20556	# 135 
beq_else.20555:	# 135 
	addi	%x5 %x0 8	# 136 
	bne	%x6 %x5 beq_else.20557	# 136 
	addi	%x6 %x0 56	# 136
	j	beq_cont.20558	# 136 
beq_else.20557:	# 136 
	addi	%x6 %x0 57	# 137
beq_cont.20558:	# 136 
beq_cont.20556:	# 135 
beq_cont.20554:	# 134 
beq_cont.20552:	# 133 
beq_cont.20550:	# 132 
beq_cont.20548:	# 131 
beq_cont.20546:	# 130 
beq_cont.20544:	# 129 
beq_cont.20542:	# 128 
	j	min_caml_print_char	# 156 
vecunit_sgn.2761:	#- 12780
	addi	%x8 %x6 0	# 100 
	lw	%f1 0(%x8)	# 100 
	addi	%x8 %x6 0	# 100 
	lw	%f2 0(%x8)	# 100 
	fmul	%f1 %f1 %f2	# 100 
	addi	%x8 %x6 4	# 100 
	lw	%f2 0(%x8)	# 100 
	addi	%x8 %x6 4	# 100 
	lw	%f3 0(%x8)	# 100 
	fmul	%f2 %f2 %f3	# 100 
	fadd	%f1 %f1 %f2	# 100 
	addi	%x8 %x6 8	# 100 
	lw	%f2 0(%x8)	# 100 
	addi	%x8 %x6 8	# 100 
	lw	%f3 0(%x8)	# 100 
	fmul	%f2 %f2 %f3	# 100 
	fadd	%f1 %f1 %f2	# 100 
	fsqrt	%f1 %f1	# 100 
	lw	%f2 52(%x29)	# 101 
	fle	%x5 %f1 %f2	# 101 
	fle	%x31 %f2 %f1	# 101 
	and	%x5 %x5 %x31	# 101 
	bne	%x5 %x0 feq.20559	# 101 
	bne	%x7 %x0 beq_else.20561	# 101 
	lw	%f2 16(%x29)	# 101 
	fdiv	%f1 %f2 %f1	# 101 
	j	beq_cont.20562	# 101 
beq_else.20561:	# 101 
	lw	%f2 48(%x29)	# 101 
	fdiv	%f1 %f2 %f1	# 101 
beq_cont.20562:	# 101 
	j	feq_cont.20560	# 101 
feq.20559:	# 101 
	lw	%f1 16(%x29)	# 101 
feq_cont.20560:	# 101 
	addi	%x7 %x6 0	# 102 
	lw	%f2 0(%x7)	# 102 
	fmul	%f2 %f2 %f1	# 102 
	addi	%x7 %x6 0	# 102 
	sw	%f2 0(%x7)	# 102 
	addi	%x7 %x6 4	# 103 
	lw	%f2 0(%x7)	# 103 
	fmul	%f2 %f2 %f1	# 103 
	addi	%x7 %x6 4	# 103 
	sw	%f2 0(%x7)	# 103 
	addi	%x7 %x6 8	# 104 
	lw	%f2 0(%x7)	# 104 
	fmul	%f1 %f2 %f1	# 104 
	addi	%x6 %x6 8	# 104 
	sw	%f1 0(%x6)	# 104 
	jr	0(%x1)	# 104 
read_screen_settings.2862:	#- 12968
	sw	%x1 0(%x2)	# 499 
	addi	%x2 %x2 -4	# 499 
	jal	 %x1 min_caml_read_float	# 499 
	addi	%x2 %x2 4	# 499 
	lw	%x1 0(%x2)	# 499 
	lui	%x6 2097696	# 499
	addi	%x6 %x6 544	# 499
	addi	%x6 %x6 0	# 499 
	sw	%f1 0(%x6)	# 499 
	sw	%x1 0(%x2)	# 500 
	addi	%x2 %x2 -4	# 500 
	jal	 %x1 min_caml_read_float	# 500 
	addi	%x2 %x2 4	# 500 
	lw	%x1 0(%x2)	# 500 
	lui	%x6 2097696	# 500
	addi	%x6 %x6 544	# 500
	addi	%x6 %x6 4	# 500 
	sw	%f1 0(%x6)	# 500 
	sw	%x1 0(%x2)	# 501 
	addi	%x2 %x2 -4	# 501 
	jal	 %x1 min_caml_read_float	# 501 
	addi	%x2 %x2 4	# 501 
	lw	%x1 0(%x2)	# 501 
	lui	%x6 2097696	# 501
	addi	%x6 %x6 544	# 501
	addi	%x6 %x6 8	# 501 
	sw	%f1 0(%x6)	# 501 
	sw	%x1 0(%x2)	# 503 
	addi	%x2 %x2 -4	# 503 
	jal	 %x1 min_caml_read_float	# 503 
	addi	%x2 %x2 4	# 503 
	lw	%x1 0(%x2)	# 503 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	sw	%f1 -0(%x2)	# 504 
	sw	%x1 -4(%x2)	# 504 
	addi	%x2 %x2 -8	# 504 
	jal	 %x1 cos.2720	# 504 
	addi	%x2 %x2 8	# 504 
	lw	%x1 -4(%x2)	# 504 
	lw	%f2 -0(%x2)	# 505 
	sw	%f1 -4(%x2)	# 505 
	fadd	%f1 %f0 %f2	# 505 
	sw	%x1 -8(%x2)	# 505 
	addi	%x2 %x2 -12	# 505 
	jal	 %x1 sin.2718	# 505 
	addi	%x2 %x2 12	# 505 
	lw	%x1 -8(%x2)	# 505 
	sw	%f1 -8(%x2)	# 506 
	sw	%x1 -12(%x2)	# 506 
	addi	%x2 %x2 -16	# 506 
	jal	 %x1 min_caml_read_float	# 506 
	addi	%x2 %x2 16	# 506 
	lw	%x1 -12(%x2)	# 506 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	sw	%f1 -12(%x2)	# 507 
	sw	%x1 -16(%x2)	# 507 
	addi	%x2 %x2 -20	# 507 
	jal	 %x1 cos.2720	# 507 
	addi	%x2 %x2 20	# 507 
	lw	%x1 -16(%x2)	# 507 
	lw	%f2 -12(%x2)	# 508 
	sw	%f1 -16(%x2)	# 508 
	fadd	%f1 %f0 %f2	# 508 
	sw	%x1 -20(%x2)	# 508 
	addi	%x2 %x2 -24	# 508 
	jal	 %x1 sin.2718	# 508 
	addi	%x2 %x2 24	# 508 
	lw	%x1 -20(%x2)	# 508 
	lw	%f2 -4(%x2)	# 510 
	fmul	%f3 %f2 %f1	# 510 
	lw	%f4 108(%x29)	# 510 
	fmul	%f3 %f3 %f4	# 510 
	lui	%x6 2098092	# 510
	addi	%x6 %x6 940	# 510
	addi	%x6 %x6 0	# 510 
	sw	%f3 0(%x6)	# 510 
	lw	%f3 112(%x29)	# 511 
	lw	%f4 -8(%x2)	# 511 
	fmul	%f3 %f4 %f3	# 511 
	lui	%x6 2098092	# 511
	addi	%x6 %x6 940	# 511
	addi	%x6 %x6 4	# 511 
	sw	%f3 0(%x6)	# 511 
	lw	%f3 -16(%x2)	# 512 
	fmul	%f5 %f2 %f3	# 512 
	lw	%f6 108(%x29)	# 512 
	fmul	%f5 %f5 %f6	# 512 
	lui	%x6 2098092	# 512
	addi	%x6 %x6 940	# 512
	addi	%x6 %x6 8	# 512 
	sw	%f5 0(%x6)	# 512 
	lui	%x6 2098068	# 514
	addi	%x6 %x6 916	# 514
	addi	%x6 %x6 0	# 514 
	sw	%f3 0(%x6)	# 514 
	lw	%f5 52(%x29)	# 515 
	lui	%x6 2098068	# 515
	addi	%x6 %x6 916	# 515
	addi	%x6 %x6 4	# 515 
	sw	%f5 0(%x6)	# 515 
	lw	%f5 48(%x29)	# 516 
	fmul	%f5 %f5 %f1	# 516 
	lui	%x6 2098068	# 516
	addi	%x6 %x6 916	# 516
	addi	%x6 %x6 8	# 516 
	sw	%f5 0(%x6)	# 516 
	lw	%f5 48(%x29)	# 518 
	fmul	%f5 %f5 %f4	# 518 
	fmul	%f1 %f5 %f1	# 518 
	lui	%x6 2098080	# 518
	addi	%x6 %x6 928	# 518
	addi	%x6 %x6 0	# 518 
	sw	%f1 0(%x6)	# 518 
	lw	%f1 48(%x29)	# 519 
	fmul	%f1 %f1 %f2	# 519 
	lui	%x6 2098080	# 519
	addi	%x6 %x6 928	# 519
	addi	%x6 %x6 4	# 519 
	sw	%f1 0(%x6)	# 519 
	lw	%f1 48(%x29)	# 520 
	fmul	%f1 %f1 %f4	# 520 
	fmul	%f1 %f1 %f3	# 520 
	lui	%x6 2098080	# 520
	addi	%x6 %x6 928	# 520
	addi	%x6 %x6 8	# 520 
	sw	%f1 0(%x6)	# 520 
	lui	%x6 2097696	# 522
	addi	%x6 %x6 544	# 522
	addi	%x6 %x6 0	# 522 
	lw	%f1 0(%x6)	# 522 
	lui	%x6 2098092	# 522
	addi	%x6 %x6 940	# 522
	addi	%x6 %x6 0	# 522 
	lw	%f2 0(%x6)	# 522 
	fsub	%f1 %f1 %f2	# 522 
	lui	%x6 2097708	# 522
	addi	%x6 %x6 556	# 522
	addi	%x6 %x6 0	# 522 
	sw	%f1 0(%x6)	# 522 
	lui	%x6 2097696	# 523
	addi	%x6 %x6 544	# 523
	addi	%x6 %x6 4	# 523 
	lw	%f1 0(%x6)	# 523 
	lui	%x6 2098092	# 523
	addi	%x6 %x6 940	# 523
	addi	%x6 %x6 4	# 523 
	lw	%f2 0(%x6)	# 523 
	fsub	%f1 %f1 %f2	# 523 
	lui	%x6 2097708	# 523
	addi	%x6 %x6 556	# 523
	addi	%x6 %x6 4	# 523 
	sw	%f1 0(%x6)	# 523 
	lui	%x6 2097696	# 524
	addi	%x6 %x6 544	# 524
	addi	%x6 %x6 8	# 524 
	lw	%f1 0(%x6)	# 524 
	lui	%x6 2098092	# 524
	addi	%x6 %x6 940	# 524
	addi	%x6 %x6 8	# 524 
	lw	%f2 0(%x6)	# 524 
	fsub	%f1 %f1 %f2	# 524 
	lui	%x6 2097708	# 524
	addi	%x6 %x6 556	# 524
	addi	%x6 %x6 8	# 524 
	sw	%f1 0(%x6)	# 524 
	jr	0(%x1)	# 524 
read_light.2864:	#- 13640
	sw	%x1 0(%x2)	# 531 
	addi	%x2 %x2 -4	# 531 
	jal	 %x1 min_caml_read_int	# 531 
	addi	%x2 %x2 4	# 531 
	lw	%x1 0(%x2)	# 531 
	sw	%x1 0(%x2)	# 534 
	addi	%x2 %x2 -4	# 534 
	jal	 %x1 min_caml_read_float	# 534 
	addi	%x2 %x2 4	# 534 
	lw	%x1 0(%x2)	# 534 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	sw	%f1 -0(%x2)	# 535 
	sw	%x1 -4(%x2)	# 535 
	addi	%x2 %x2 -8	# 535 
	jal	 %x1 sin.2718	# 535 
	addi	%x2 %x2 8	# 535 
	lw	%x1 -4(%x2)	# 535 
	lw	%f2 48(%x29)	# 536 
	fmul	%f1 %f2 %f1	# 536 
	lui	%x6 2097720	# 536
	addi	%x6 %x6 568	# 536
	addi	%x6 %x6 4	# 536 
	sw	%f1 0(%x6)	# 536 
	sw	%x1 -4(%x2)	# 537 
	addi	%x2 %x2 -8	# 537 
	jal	 %x1 min_caml_read_float	# 537 
	addi	%x2 %x2 8	# 537 
	lw	%x1 -4(%x2)	# 537 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	lw	%f2 -0(%x2)	# 538 
	sw	%f1 -4(%x2)	# 538 
	fadd	%f1 %f0 %f2	# 538 
	sw	%x1 -8(%x2)	# 538 
	addi	%x2 %x2 -12	# 538 
	jal	 %x1 cos.2720	# 538 
	addi	%x2 %x2 12	# 538 
	lw	%x1 -8(%x2)	# 538 
	lw	%f2 -4(%x2)	# 539 
	sw	%f1 -8(%x2)	# 539 
	fadd	%f1 %f0 %f2	# 539 
	sw	%x1 -12(%x2)	# 539 
	addi	%x2 %x2 -16	# 539 
	jal	 %x1 sin.2718	# 539 
	addi	%x2 %x2 16	# 539 
	lw	%x1 -12(%x2)	# 539 
	lw	%f2 -8(%x2)	# 540 
	fmul	%f1 %f2 %f1	# 540 
	lui	%x6 2097720	# 540
	addi	%x6 %x6 568	# 540
	addi	%x6 %x6 0	# 540 
	sw	%f1 0(%x6)	# 540 
	lw	%f1 -4(%x2)	# 541 
	sw	%x1 -12(%x2)	# 541 
	addi	%x2 %x2 -16	# 541 
	jal	 %x1 cos.2720	# 541 
	addi	%x2 %x2 16	# 541 
	lw	%x1 -12(%x2)	# 541 
	lw	%f2 -8(%x2)	# 542 
	fmul	%f1 %f2 %f1	# 542 
	lui	%x6 2097720	# 542
	addi	%x6 %x6 568	# 542
	addi	%x6 %x6 8	# 542 
	sw	%f1 0(%x6)	# 542 
	sw	%x1 -12(%x2)	# 543 
	addi	%x2 %x2 -16	# 543 
	jal	 %x1 min_caml_read_float	# 543 
	addi	%x2 %x2 16	# 543 
	lw	%x1 -12(%x2)	# 543 
	lui	%x6 2097732	# 543
	addi	%x6 %x6 580	# 543
	addi	%x6 %x6 0	# 543 
	sw	%f1 0(%x6)	# 543 
	jr	0(%x1)	# 543 
rotate_quadratic_matrix.2866:	#- 13940
	addi	%x8 %x7 0	# 553 
	lw	%f1 0(%x8)	# 553 
	sw	%x6 -0(%x2)	# 553 
	sw	%x7 -4(%x2)	# 553 
	sw	%x1 -8(%x2)	# 553 
	addi	%x2 %x2 -12	# 553 
	jal	 %x1 cos.2720	# 553 
	addi	%x2 %x2 12	# 553 
	lw	%x1 -8(%x2)	# 553 
	lw	%x6 -4(%x2)	# 554 
	addi	%x7 %x6 0	# 554 
	lw	%f2 0(%x7)	# 554 
	sw	%f1 -8(%x2)	# 554 
	fadd	%f1 %f0 %f2	# 554 
	sw	%x1 -12(%x2)	# 554 
	addi	%x2 %x2 -16	# 554 
	jal	 %x1 sin.2718	# 554 
	addi	%x2 %x2 16	# 554 
	lw	%x1 -12(%x2)	# 554 
	lw	%x6 -4(%x2)	# 555 
	addi	%x7 %x6 4	# 555 
	lw	%f2 0(%x7)	# 555 
	sw	%f1 -12(%x2)	# 555 
	fadd	%f1 %f0 %f2	# 555 
	sw	%x1 -16(%x2)	# 555 
	addi	%x2 %x2 -20	# 555 
	jal	 %x1 cos.2720	# 555 
	addi	%x2 %x2 20	# 555 
	lw	%x1 -16(%x2)	# 555 
	lw	%x6 -4(%x2)	# 556 
	addi	%x7 %x6 4	# 556 
	lw	%f2 0(%x7)	# 556 
	sw	%f1 -16(%x2)	# 556 
	fadd	%f1 %f0 %f2	# 556 
	sw	%x1 -20(%x2)	# 556 
	addi	%x2 %x2 -24	# 556 
	jal	 %x1 sin.2718	# 556 
	addi	%x2 %x2 24	# 556 
	lw	%x1 -20(%x2)	# 556 
	lw	%x6 -4(%x2)	# 557 
	addi	%x7 %x6 8	# 557 
	lw	%f2 0(%x7)	# 557 
	sw	%f1 -20(%x2)	# 557 
	fadd	%f1 %f0 %f2	# 557 
	sw	%x1 -24(%x2)	# 557 
	addi	%x2 %x2 -28	# 557 
	jal	 %x1 cos.2720	# 557 
	addi	%x2 %x2 28	# 557 
	lw	%x1 -24(%x2)	# 557 
	lw	%x6 -4(%x2)	# 558 
	addi	%x7 %x6 8	# 558 
	lw	%f2 0(%x7)	# 558 
	sw	%f1 -24(%x2)	# 558 
	fadd	%f1 %f0 %f2	# 558 
	sw	%x1 -28(%x2)	# 558 
	addi	%x2 %x2 -32	# 558 
	jal	 %x1 sin.2718	# 558 
	addi	%x2 %x2 32	# 558 
	lw	%x1 -28(%x2)	# 558 
	lw	%f2 -24(%x2)	# 560 
	lw	%f3 -16(%x2)	# 560 
	fmul	%f4 %f3 %f2	# 560 
	lw	%f5 -20(%x2)	# 561 
	lw	%f6 -12(%x2)	# 561 
	fmul	%f7 %f6 %f5	# 561 
	fmul	%f7 %f7 %f2	# 561 
	lw	%f8 -8(%x2)	# 561 
	fmul	%f9 %f8 %f1	# 561 
	fsub	%f7 %f7 %f9	# 561 
	fmul	%f9 %f8 %f5	# 562 
	fmul	%f9 %f9 %f2	# 562 
	fmul	%f10 %f6 %f1	# 562 
	fadd	%f9 %f9 %f10	# 562 
	fmul	%f10 %f3 %f1	# 564 
	fmul	%f11 %f6 %f5	# 565 
	fmul	%f11 %f11 %f1	# 565 
	fmul	%f12 %f8 %f2	# 565 
	fadd	%f11 %f11 %f12	# 565 
	fmul	%f12 %f8 %f5	# 566 
	fmul	%f1 %f12 %f1	# 566 
	fmul	%f2 %f6 %f2	# 566 
	fsub	%f1 %f1 %f2	# 566 
	lw	%f2 48(%x29)	# 568 
	fmul	%f2 %f2 %f5	# 568 
	fmul	%f5 %f6 %f3	# 569 
	fmul	%f3 %f8 %f3	# 570 
	lw	%x6 -0(%x2)	# 573 
	addi	%x7 %x6 0	# 573 
	lw	%f6 0(%x7)	# 573 
	addi	%x7 %x6 4	# 574 
	lw	%f8 0(%x7)	# 574 
	addi	%x7 %x6 8	# 575 
	lw	%f12 0(%x7)	# 575 
	fmul	%f13 %f4 %f4	# 580 
	fmul	%f13 %f6 %f13	# 580 
	fmul	%f14 %f10 %f10	# 580 
	fmul	%f14 %f8 %f14	# 580 
	fadd	%f13 %f13 %f14	# 580 
	fmul	%f14 %f2 %f2	# 580 
	fmul	%f14 %f12 %f14	# 580 
	fadd	%f13 %f13 %f14	# 580 
	addi	%x7 %x6 0	# 580 
	sw	%f13 0(%x7)	# 580 
	fmul	%f13 %f7 %f7	# 581 
	fmul	%f13 %f6 %f13	# 581 
	fmul	%f14 %f11 %f11	# 581 
	fmul	%f14 %f8 %f14	# 581 
	fadd	%f13 %f13 %f14	# 581 
	fmul	%f14 %f5 %f5	# 581 
	fmul	%f14 %f12 %f14	# 581 
	fadd	%f13 %f13 %f14	# 581 
	addi	%x7 %x6 4	# 581 
	sw	%f13 0(%x7)	# 581 
	fmul	%f13 %f9 %f9	# 582 
	fmul	%f13 %f6 %f13	# 582 
	fmul	%f14 %f1 %f1	# 582 
	fmul	%f14 %f8 %f14	# 582 
	fadd	%f13 %f13 %f14	# 582 
	fmul	%f14 %f3 %f3	# 582 
	fmul	%f14 %f12 %f14	# 582 
	fadd	%f13 %f13 %f14	# 582 
	addi	%x6 %x6 8	# 582 
	sw	%f13 0(%x6)	# 582 
	lw	%f13 4(%x29)	# 585 
	fmul	%f14 %f6 %f7	# 585 
	fmul	%f14 %f14 %f9	# 585 
	fmul	%f15 %f8 %f11	# 585 
	fmul	%f15 %f15 %f1	# 585 
	fadd	%f14 %f14 %f15	# 585 
	fmul	%f15 %f12 %f5	# 585 
	fmul	%f15 %f15 %f3	# 585 
	fadd	%f14 %f14 %f15	# 585 
	fmul	%f13 %f13 %f14	# 585 
	lw	%x6 -4(%x2)	# 585 
	addi	%x7 %x6 0	# 585 
	sw	%f13 0(%x7)	# 585 
	lw	%f13 4(%x29)	# 586 
	fmul	%f14 %f6 %f4	# 586 
	fmul	%f9 %f14 %f9	# 586 
	fmul	%f14 %f8 %f10	# 586 
	fmul	%f1 %f14 %f1	# 586 
	fadd	%f1 %f9 %f1	# 586 
	fmul	%f9 %f12 %f2	# 586 
	fmul	%f3 %f9 %f3	# 586 
	fadd	%f1 %f1 %f3	# 586 
	fmul	%f1 %f13 %f1	# 586 
	addi	%x7 %x6 4	# 586 
	sw	%f1 0(%x7)	# 586 
	lw	%f1 4(%x29)	# 587 
	fmul	%f3 %f6 %f4	# 587 
	fmul	%f3 %f3 %f7	# 587 
	fmul	%f4 %f8 %f10	# 587 
	fmul	%f4 %f4 %f11	# 587 
	fadd	%f3 %f3 %f4	# 587 
	fmul	%f2 %f12 %f2	# 587 
	fmul	%f2 %f2 %f5	# 587 
	fadd	%f2 %f3 %f2	# 587 
	fmul	%f1 %f1 %f2	# 587 
	addi	%x6 %x6 8	# 587 
	sw	%f1 0(%x6)	# 587 
	jr	0(%x1)	# 587 
read_nth_object.2869:	#- 14584
	sw	%x6 -0(%x2)	# 594 
	sw	%x1 -4(%x2)	# 594 
	addi	%x2 %x2 -8	# 594 
	jal	 %x1 min_caml_read_int	# 594 
	addi	%x2 %x2 8	# 594 
	lw	%x1 -4(%x2)	# 594 
	addi	%x5 %x0 -1	# 595 
	bne	%x6 %x5 beq_else.20567	# 595 
	addi	%x6 %x0 0	# 671
	jr	0(%x1)	# 671 
beq_else.20567:	# 595 
	sw	%x6 -4(%x2)	# 597 
	sw	%x1 -8(%x2)	# 597 
	addi	%x2 %x2 -12	# 597 
	jal	 %x1 min_caml_read_int	# 597 
	addi	%x2 %x2 12	# 597 
	lw	%x1 -8(%x2)	# 597 
	sw	%x6 -8(%x2)	# 598 
	sw	%x1 -12(%x2)	# 598 
	addi	%x2 %x2 -16	# 598 
	jal	 %x1 min_caml_read_int	# 598 
	addi	%x2 %x2 16	# 598 
	lw	%x1 -12(%x2)	# 598 
	sw	%x6 -12(%x2)	# 599 
	sw	%x1 -16(%x2)	# 599 
	addi	%x2 %x2 -20	# 599 
	jal	 %x1 min_caml_read_int	# 599 
	addi	%x2 %x2 20	# 599 
	lw	%x1 -16(%x2)	# 599 
	addi	%x7 %x0 3	# 601
	lw	%f1 52(%x29)	# 601 
	sw	%x6 -16(%x2)	# 601 
	add	%x6 %x0 %x7	# 601 
	sw	%x1 -20(%x2)	# 601 
	addi	%x2 %x2 -24	# 601 
	jal	 %x1 min_caml_create_float_array	# 601 
	addi	%x2 %x2 24	# 601 
	lw	%x1 -20(%x2)	# 601 
	sw	%x6 -20(%x2)	# 602 
	sw	%x1 -24(%x2)	# 602 
	addi	%x2 %x2 -28	# 602 
	jal	 %x1 min_caml_read_float	# 602 
	addi	%x2 %x2 28	# 602 
	lw	%x1 -24(%x2)	# 602 
	lw	%x6 -20(%x2)	# 602 
	addi	%x7 %x6 0	# 602 
	sw	%f1 0(%x7)	# 602 
	sw	%x1 -24(%x2)	# 603 
	addi	%x2 %x2 -28	# 603 
	jal	 %x1 min_caml_read_float	# 603 
	addi	%x2 %x2 28	# 603 
	lw	%x1 -24(%x2)	# 603 
	lw	%x6 -20(%x2)	# 603 
	addi	%x7 %x6 4	# 603 
	sw	%f1 0(%x7)	# 603 
	sw	%x1 -24(%x2)	# 604 
	addi	%x2 %x2 -28	# 604 
	jal	 %x1 min_caml_read_float	# 604 
	addi	%x2 %x2 28	# 604 
	lw	%x1 -24(%x2)	# 604 
	lw	%x6 -20(%x2)	# 604 
	addi	%x7 %x6 8	# 604 
	sw	%f1 0(%x7)	# 604 
	addi	%x7 %x0 3	# 606
	lw	%f1 52(%x29)	# 606 
	add	%x6 %x0 %x7	# 606 
	sw	%x1 -24(%x2)	# 606 
	addi	%x2 %x2 -28	# 606 
	jal	 %x1 min_caml_create_float_array	# 606 
	addi	%x2 %x2 28	# 606 
	lw	%x1 -24(%x2)	# 606 
	sw	%x6 -24(%x2)	# 607 
	sw	%x1 -28(%x2)	# 607 
	addi	%x2 %x2 -32	# 607 
	jal	 %x1 min_caml_read_float	# 607 
	addi	%x2 %x2 32	# 607 
	lw	%x1 -28(%x2)	# 607 
	lw	%x6 -24(%x2)	# 607 
	addi	%x7 %x6 0	# 607 
	sw	%f1 0(%x7)	# 607 
	sw	%x1 -28(%x2)	# 608 
	addi	%x2 %x2 -32	# 608 
	jal	 %x1 min_caml_read_float	# 608 
	addi	%x2 %x2 32	# 608 
	lw	%x1 -28(%x2)	# 608 
	lw	%x6 -24(%x2)	# 608 
	addi	%x7 %x6 4	# 608 
	sw	%f1 0(%x7)	# 608 
	sw	%x1 -28(%x2)	# 609 
	addi	%x2 %x2 -32	# 609 
	jal	 %x1 min_caml_read_float	# 609 
	addi	%x2 %x2 32	# 609 
	lw	%x1 -28(%x2)	# 609 
	lw	%x6 -24(%x2)	# 609 
	addi	%x7 %x6 8	# 609 
	sw	%f1 0(%x7)	# 609 
	lw	%f1 52(%x29)	# 611 
	sw	%f1 -28(%x2)	# 611 
	sw	%x1 -32(%x2)	# 611 
	addi	%x2 %x2 -36	# 611 
	jal	 %x1 min_caml_read_float	# 611 
	addi	%x2 %x2 36	# 611 
	lw	%x1 -32(%x2)	# 611 
	lw	%f2 -28(%x2)	# 611 
	fle	%x5 %f2 %f1	# 611 
	bne	%x5 %x0 fle.20568	# 611 
	addi	%x6 %x0 1	# 611
	j	fle_cont.20569	# 611 
fle.20568:	# 611 
	addi	%x6 %x0 0	# 611
fle_cont.20569:	# 611 
	addi	%x7 %x0 2	# 613
	lw	%f1 52(%x29)	# 613 
	sw	%x6 -32(%x2)	# 613 
	add	%x6 %x0 %x7	# 613 
	sw	%x1 -36(%x2)	# 613 
	addi	%x2 %x2 -40	# 613 
	jal	 %x1 min_caml_create_float_array	# 613 
	addi	%x2 %x2 40	# 613 
	lw	%x1 -36(%x2)	# 613 
	sw	%x6 -36(%x2)	# 614 
	sw	%x1 -40(%x2)	# 614 
	addi	%x2 %x2 -44	# 614 
	jal	 %x1 min_caml_read_float	# 614 
	addi	%x2 %x2 44	# 614 
	lw	%x1 -40(%x2)	# 614 
	lw	%x6 -36(%x2)	# 614 
	addi	%x7 %x6 0	# 614 
	sw	%f1 0(%x7)	# 614 
	sw	%x1 -40(%x2)	# 615 
	addi	%x2 %x2 -44	# 615 
	jal	 %x1 min_caml_read_float	# 615 
	addi	%x2 %x2 44	# 615 
	lw	%x1 -40(%x2)	# 615 
	lw	%x6 -36(%x2)	# 615 
	addi	%x7 %x6 4	# 615 
	sw	%f1 0(%x7)	# 615 
	addi	%x7 %x0 3	# 617
	lw	%f1 52(%x29)	# 617 
	add	%x6 %x0 %x7	# 617 
	sw	%x1 -40(%x2)	# 617 
	addi	%x2 %x2 -44	# 617 
	jal	 %x1 min_caml_create_float_array	# 617 
	addi	%x2 %x2 44	# 617 
	lw	%x1 -40(%x2)	# 617 
	sw	%x6 -40(%x2)	# 618 
	sw	%x1 -44(%x2)	# 618 
	addi	%x2 %x2 -48	# 618 
	jal	 %x1 min_caml_read_float	# 618 
	addi	%x2 %x2 48	# 618 
	lw	%x1 -44(%x2)	# 618 
	lw	%x6 -40(%x2)	# 618 
	addi	%x7 %x6 0	# 618 
	sw	%f1 0(%x7)	# 618 
	sw	%x1 -44(%x2)	# 619 
	addi	%x2 %x2 -48	# 619 
	jal	 %x1 min_caml_read_float	# 619 
	addi	%x2 %x2 48	# 619 
	lw	%x1 -44(%x2)	# 619 
	lw	%x6 -40(%x2)	# 619 
	addi	%x7 %x6 4	# 619 
	sw	%f1 0(%x7)	# 619 
	sw	%x1 -44(%x2)	# 620 
	addi	%x2 %x2 -48	# 620 
	jal	 %x1 min_caml_read_float	# 620 
	addi	%x2 %x2 48	# 620 
	lw	%x1 -44(%x2)	# 620 
	lw	%x6 -40(%x2)	# 620 
	addi	%x7 %x6 8	# 620 
	sw	%f1 0(%x7)	# 620 
	addi	%x7 %x0 3	# 622
	lw	%f1 52(%x29)	# 622 
	add	%x6 %x0 %x7	# 622 
	sw	%x1 -44(%x2)	# 622 
	addi	%x2 %x2 -48	# 622 
	jal	 %x1 min_caml_create_float_array	# 622 
	addi	%x2 %x2 48	# 622 
	lw	%x1 -44(%x2)	# 622 
	lw	%x7 -16(%x2)	# 623 
	bne	%x7 %x0 beq_else.20570	# 623 
	j	beq_cont.20571	# 623 
beq_else.20570:	# 623 
	sw	%x6 -44(%x2)	# 625 
	sw	%x1 -48(%x2)	# 625 
	addi	%x2 %x2 -52	# 625 
	jal	 %x1 min_caml_read_float	# 625 
	addi	%x2 %x2 52	# 625 
	lw	%x1 -48(%x2)	# 625 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	lw	%x6 -44(%x2)	# 625 
	addi	%x7 %x6 0	# 625 
	sw	%f1 0(%x7)	# 625 
	sw	%x1 -48(%x2)	# 626 
	addi	%x2 %x2 -52	# 626 
	jal	 %x1 min_caml_read_float	# 626 
	addi	%x2 %x2 52	# 626 
	lw	%x1 -48(%x2)	# 626 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	lw	%x6 -44(%x2)	# 626 
	addi	%x7 %x6 4	# 626 
	sw	%f1 0(%x7)	# 626 
	sw	%x1 -48(%x2)	# 627 
	addi	%x2 %x2 -52	# 627 
	jal	 %x1 min_caml_read_float	# 627 
	addi	%x2 %x2 52	# 627 
	lw	%x1 -48(%x2)	# 627 
	lw	%f2 104(%x29)	# 492 
	fmul	%f1 %f1 %f2	# 492 
	lw	%x6 -44(%x2)	# 627 
	addi	%x7 %x6 8	# 627 
	sw	%f1 0(%x7)	# 627 
beq_cont.20571:	# 623 
	lw	%x7 -8(%x2)	# 634 
	addi	%x5 %x0 2	# 634 
	bne	%x7 %x5 beq_else.20572	# 634 
	addi	%x8 %x0 1	# 634
	j	beq_cont.20573	# 634 
beq_else.20572:	# 634 
	lw	%x8 -32(%x2)	# 634 
beq_cont.20573:	# 634 
	addi	%x9 %x0 4	# 635
	lw	%f1 52(%x29)	# 635 
	sw	%x8 -48(%x2)	# 635 
	sw	%x6 -44(%x2)	# 635 
	add	%x6 %x0 %x9	# 635 
	sw	%x1 -52(%x2)	# 635 
	addi	%x2 %x2 -56	# 635 
	jal	 %x1 min_caml_create_float_array	# 635 
	addi	%x2 %x2 56	# 635 
	lw	%x1 -52(%x2)	# 635 
	add	%x7 %x0 %x3	# 638 
	addi	%x3 %x3 44	# 638 
	sw	%x6 40(%x7)	# 638 
	lw	%x6 -44(%x2)	# 638 
	sw	%x6 36(%x7)	# 638 
	lw	%x8 -40(%x2)	# 638 
	sw	%x8 32(%x7)	# 638 
	lw	%x8 -36(%x2)	# 638 
	sw	%x8 28(%x7)	# 638 
	lw	%x8 -48(%x2)	# 638 
	sw	%x8 24(%x7)	# 638 
	lw	%x8 -24(%x2)	# 638 
	sw	%x8 20(%x7)	# 638 
	lw	%x8 -20(%x2)	# 638 
	sw	%x8 16(%x7)	# 638 
	lw	%x9 -16(%x2)	# 638 
	sw	%x9 12(%x7)	# 638 
	lw	%x10 -12(%x2)	# 638 
	sw	%x10 8(%x7)	# 638 
	lw	%x10 -8(%x2)	# 638 
	sw	%x10 4(%x7)	# 638 
	lw	%x11 -4(%x2)	# 638 
	sw	%x11 0(%x7)	# 638 
	lui	%x11 2097456	# 646
	addi	%x11 %x11 304	# 646
	lw	%x12 -0(%x2)	# 646 
	slli	%x12 %x12 2	# 646 
	add	%x11 %x11 %x12	# 646 
	sw	%x7 0(%x11)	# 646 
	addi	%x5 %x0 3	# 648 
	bne	%x10 %x5 beq_else.20574	# 648 
	addi	%x7 %x8 0	# 651 
	lw	%f1 0(%x7)	# 651 
	lw	%f2 52(%x29)	# 652 
	fle	%x5 %f1 %f2	# 652 
	fle	%x31 %f2 %f1	# 652 
	and	%x5 %x5 %x31	# 652 
	bne	%x5 %x0 feq.20576	# 652 
	lw	%f2 52(%x29)	# 33 
	fle	%x5 %f1 %f2	# 33 
	fle	%x31 %f2 %f1	# 33 
	and	%x5 %x5 %x31	# 33 
	bne	%x5 %x0 feq.20578	# 33 
	lw	%f2 52(%x29)	# 34 
	fle	%x5 %f1 %f2	# 34 
	bne	%x5 %x0 fle.20580	# 34 
	lw	%f2 16(%x29)	# 34 
	j	fle_cont.20581	# 34 
fle.20580:	# 34 
	lw	%f2 48(%x29)	# 35 
fle_cont.20581:	# 34 
	j	feq_cont.20579	# 33 
feq.20578:	# 33 
	lw	%f2 52(%x29)	# 33 
feq_cont.20579:	# 33 
	fmul	%f1 %f1 %f1	# 652 
	fdiv	%f1 %f2 %f1	# 652 
	j	feq_cont.20577	# 652 
feq.20576:	# 652 
	lw	%f1 52(%x29)	# 652 
feq_cont.20577:	# 652 
	addi	%x7 %x8 0	# 652 
	sw	%f1 0(%x7)	# 652 
	addi	%x7 %x8 4	# 653 
	lw	%f1 0(%x7)	# 653 
	lw	%f2 52(%x29)	# 654 
	fle	%x5 %f1 %f2	# 654 
	fle	%x31 %f2 %f1	# 654 
	and	%x5 %x5 %x31	# 654 
	bne	%x5 %x0 feq.20582	# 654 
	lw	%f2 52(%x29)	# 33 
	fle	%x5 %f1 %f2	# 33 
	fle	%x31 %f2 %f1	# 33 
	and	%x5 %x5 %x31	# 33 
	bne	%x5 %x0 feq.20584	# 33 
	lw	%f2 52(%x29)	# 34 
	fle	%x5 %f1 %f2	# 34 
	bne	%x5 %x0 fle.20586	# 34 
	lw	%f2 16(%x29)	# 34 
	j	fle_cont.20587	# 34 
fle.20586:	# 34 
	lw	%f2 48(%x29)	# 35 
fle_cont.20587:	# 34 
	j	feq_cont.20585	# 33 
feq.20584:	# 33 
	lw	%f2 52(%x29)	# 33 
feq_cont.20585:	# 33 
	fmul	%f1 %f1 %f1	# 654 
	fdiv	%f1 %f2 %f1	# 654 
	j	feq_cont.20583	# 654 
feq.20582:	# 654 
	lw	%f1 52(%x29)	# 654 
feq_cont.20583:	# 654 
	addi	%x7 %x8 4	# 654 
	sw	%f1 0(%x7)	# 654 
	addi	%x7 %x8 8	# 655 
	lw	%f1 0(%x7)	# 655 
	lw	%f2 52(%x29)	# 656 
	fle	%x5 %f1 %f2	# 656 
	fle	%x31 %f2 %f1	# 656 
	and	%x5 %x5 %x31	# 656 
	bne	%x5 %x0 feq.20588	# 656 
	lw	%f2 52(%x29)	# 33 
	fle	%x5 %f1 %f2	# 33 
	fle	%x31 %f2 %f1	# 33 
	and	%x5 %x5 %x31	# 33 
	bne	%x5 %x0 feq.20590	# 33 
	lw	%f2 52(%x29)	# 34 
	fle	%x5 %f1 %f2	# 34 
	bne	%x5 %x0 fle.20592	# 34 
	lw	%f2 16(%x29)	# 34 
	j	fle_cont.20593	# 34 
fle.20592:	# 34 
	lw	%f2 48(%x29)	# 35 
fle_cont.20593:	# 34 
	j	feq_cont.20591	# 33 
feq.20590:	# 33 
	lw	%f2 52(%x29)	# 33 
feq_cont.20591:	# 33 
	fmul	%f1 %f1 %f1	# 656 
	fdiv	%f1 %f2 %f1	# 656 
	j	feq_cont.20589	# 656 
feq.20588:	# 656 
	lw	%f1 52(%x29)	# 656 
feq_cont.20589:	# 656 
	addi	%x7 %x8 8	# 656 
	sw	%f1 0(%x7)	# 656 
	j	beq_cont.20575	# 648 
beq_else.20574:	# 648 
	addi	%x5 %x0 2	# 658 
	bne	%x10 %x5 beq_else.20594	# 658 
	lw	%x7 -32(%x2)	# 660 
	bne	%x7 %x0 beq_else.20596	# 660 
	addi	%x7 %x0 1	# 660
	j	beq_cont.20597	# 660 
beq_else.20596:	# 660 
	addi	%x7 %x0 0	# 660
beq_cont.20597:	# 660 
	add	%x6 %x0 %x8	# 660 
	sw	%x1 -52(%x2)	# 660 
	addi	%x2 %x2 -56	# 660 
	jal	 %x1 vecunit_sgn.2761	# 660 
	addi	%x2 %x2 56	# 660 
	lw	%x1 -52(%x2)	# 660 
	j	beq_cont.20595	# 658 
beq_else.20594:	# 658 
beq_cont.20595:	# 658 
beq_cont.20575:	# 648 
	lw	%x6 -16(%x2)	# 664 
	bne	%x6 %x0 beq_else.20598	# 664 
	j	beq_cont.20599	# 664 
beq_else.20598:	# 664 
	lw	%x6 -20(%x2)	# 665 
	lw	%x7 -44(%x2)	# 665 
	sw	%x1 -52(%x2)	# 665 
	addi	%x2 %x2 -56	# 665 
	jal	 %x1 rotate_quadratic_matrix.2866	# 665 
	addi	%x2 %x2 56	# 665 
	lw	%x1 -52(%x2)	# 665 
beq_cont.20599:	# 664 
	addi	%x6 %x0 1	# 668
	jr	0(%x1)	# 668 
read_object.2871:	#- 16028
	addi	%x5 %x0 60	# 676 
	blt	%x6 %x5 bge_else.20600	# 676 
	jr	0(%x1)	# 681 
bge_else.20600:	# 676 
	sw	%x6 -0(%x2)	# 677 
	sw	%x1 -4(%x2)	# 677 
	addi	%x2 %x2 -8	# 677 
	jal	 %x1 read_nth_object.2869	# 677 
	addi	%x2 %x2 8	# 677 
	lw	%x1 -4(%x2)	# 677 
	bne	%x6 %x0 beq_else.20602	# 677 
	lui	%x6 2097408	# 680
	addi	%x6 %x6 256	# 680
	addi	%x6 %x6 0	# 680 
	lw	%x7 -0(%x2)	# 680 
	sw	%x7 0(%x6)	# 680 
	jr	0(%x1)	# 680 
beq_else.20602:	# 677 
	lw	%x6 -0(%x2)	# 678 
	addi	%x6 %x6 1	# 678 
	addi	%x5 %x0 60	# 676 
	blt	%x6 %x5 bge_else.20604	# 676 
	jr	0(%x1)	# 681 
bge_else.20604:	# 676 
	sw	%x6 -4(%x2)	# 677 
	sw	%x1 -8(%x2)	# 677 
	addi	%x2 %x2 -12	# 677 
	jal	 %x1 read_nth_object.2869	# 677 
	addi	%x2 %x2 12	# 677 
	lw	%x1 -8(%x2)	# 677 
	bne	%x6 %x0 beq_else.20606	# 677 
	lui	%x6 2097408	# 680
	addi	%x6 %x6 256	# 680
	addi	%x6 %x6 0	# 680 
	lw	%x7 -4(%x2)	# 680 
	sw	%x7 0(%x6)	# 680 
	jr	0(%x1)	# 680 
beq_else.20606:	# 677 
	lw	%x6 -4(%x2)	# 678 
	addi	%x6 %x6 1	# 678 
	addi	%x5 %x0 60	# 676 
	blt	%x6 %x5 bge_else.20608	# 676 
	jr	0(%x1)	# 681 
bge_else.20608:	# 676 
	sw	%x6 -8(%x2)	# 677 
	sw	%x1 -12(%x2)	# 677 
	addi	%x2 %x2 -16	# 677 
	jal	 %x1 read_nth_object.2869	# 677 
	addi	%x2 %x2 16	# 677 
	lw	%x1 -12(%x2)	# 677 
	bne	%x6 %x0 beq_else.20610	# 677 
	lui	%x6 2097408	# 680
	addi	%x6 %x6 256	# 680
	addi	%x6 %x6 0	# 680 
	lw	%x7 -8(%x2)	# 680 
	sw	%x7 0(%x6)	# 680 
	jr	0(%x1)	# 680 
beq_else.20610:	# 677 
	lw	%x6 -8(%x2)	# 678 
	addi	%x6 %x6 1	# 678 
	addi	%x5 %x0 60	# 676 
	blt	%x6 %x5 bge_else.20612	# 676 
	jr	0(%x1)	# 681 
bge_else.20612:	# 676 
	sw	%x6 -12(%x2)	# 677 
	sw	%x1 -16(%x2)	# 677 
	addi	%x2 %x2 -20	# 677 
	jal	 %x1 read_nth_object.2869	# 677 
	addi	%x2 %x2 20	# 677 
	lw	%x1 -16(%x2)	# 677 
	bne	%x6 %x0 beq_else.20614	# 677 
	lui	%x6 2097408	# 680
	addi	%x6 %x6 256	# 680
	addi	%x6 %x6 0	# 680 
	lw	%x7 -12(%x2)	# 680 
	sw	%x7 0(%x6)	# 680 
	jr	0(%x1)	# 680 
beq_else.20614:	# 677 
	lw	%x6 -12(%x2)	# 678 
	addi	%x6 %x6 1	# 678 
	j	read_object.2871	# 678 
read_net_item.2875:	#- 16320
	sw	%x6 -0(%x2)	# 692 
	sw	%x1 -4(%x2)	# 692 
	addi	%x2 %x2 -8	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 8	# 692 
	lw	%x1 -4(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20616	# 693 
	lw	%x6 -0(%x2)	# 693 
	addi	%x6 %x6 1	# 693 
	addi	%x7 %x0 -1	# 693
	j	min_caml_create_array	# 693 
beq_else.20616:	# 693 
	lw	%x7 -0(%x2)	# 695 
	addi	%x8 %x7 1	# 695 
	sw	%x6 -4(%x2)	# 692 
	sw	%x8 -8(%x2)	# 692 
	sw	%x1 -12(%x2)	# 692 
	addi	%x2 %x2 -16	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 16	# 692 
	lw	%x1 -12(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20617	# 693 
	lw	%x6 -8(%x2)	# 693 
	addi	%x6 %x6 1	# 693 
	addi	%x7 %x0 -1	# 693
	sw	%x1 -12(%x2)	# 693 
	addi	%x2 %x2 -16	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 16	# 693 
	lw	%x1 -12(%x2)	# 693 
	j	beq_cont.20618	# 693 
beq_else.20617:	# 693 
	lw	%x7 -8(%x2)	# 695 
	addi	%x8 %x7 1	# 695 
	sw	%x6 -12(%x2)	# 692 
	sw	%x8 -16(%x2)	# 692 
	sw	%x1 -20(%x2)	# 692 
	addi	%x2 %x2 -24	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 24	# 692 
	lw	%x1 -20(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20619	# 693 
	lw	%x6 -16(%x2)	# 693 
	addi	%x6 %x6 1	# 693 
	addi	%x7 %x0 -1	# 693
	sw	%x1 -20(%x2)	# 693 
	addi	%x2 %x2 -24	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 24	# 693 
	lw	%x1 -20(%x2)	# 693 
	j	beq_cont.20620	# 693 
beq_else.20619:	# 693 
	lw	%x7 -16(%x2)	# 695 
	addi	%x8 %x7 1	# 695 
	sw	%x6 -20(%x2)	# 692 
	sw	%x8 -24(%x2)	# 692 
	sw	%x1 -28(%x2)	# 692 
	addi	%x2 %x2 -32	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 32	# 692 
	lw	%x1 -28(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20621	# 693 
	lw	%x6 -24(%x2)	# 693 
	addi	%x6 %x6 1	# 693 
	addi	%x7 %x0 -1	# 693
	sw	%x1 -28(%x2)	# 693 
	addi	%x2 %x2 -32	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 32	# 693 
	lw	%x1 -28(%x2)	# 693 
	j	beq_cont.20622	# 693 
beq_else.20621:	# 693 
	lw	%x7 -24(%x2)	# 695 
	addi	%x8 %x7 1	# 695 
	sw	%x6 -28(%x2)	# 695 
	add	%x6 %x0 %x8	# 695 
	sw	%x1 -32(%x2)	# 695 
	addi	%x2 %x2 -36	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 36	# 695 
	lw	%x1 -32(%x2)	# 695 
	lw	%x7 -24(%x2)	# 696 
	slli	%x7 %x7 2	# 696 
	add	%x7 %x6 %x7	# 696 
	lw	%x8 -28(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20622:	# 693 
	lw	%x7 -16(%x2)	# 696 
	slli	%x7 %x7 2	# 696 
	add	%x7 %x6 %x7	# 696 
	lw	%x8 -20(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20620:	# 693 
	lw	%x7 -8(%x2)	# 696 
	slli	%x7 %x7 2	# 696 
	add	%x7 %x6 %x7	# 696 
	lw	%x8 -12(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20618:	# 693 
	lw	%x7 -0(%x2)	# 696 
	slli	%x7 %x7 2	# 696 
	add	%x7 %x6 %x7	# 696 
	lw	%x8 -4(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
	jr	0(%x1)	# 696 
read_or_network.2877:	#- 16728
	sw	%x6 -0(%x2)	# 692 
	sw	%x1 -4(%x2)	# 692 
	addi	%x2 %x2 -8	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 8	# 692 
	lw	%x1 -4(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20623	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -4(%x2)	# 693 
	addi	%x2 %x2 -8	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 8	# 693 
	lw	%x1 -4(%x2)	# 693 
	add	%x7 %x0 %x6	# 693 
	j	beq_cont.20624	# 693 
beq_else.20623:	# 693 
	sw	%x6 -4(%x2)	# 692 
	sw	%x1 -8(%x2)	# 692 
	addi	%x2 %x2 -12	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 12	# 692 
	lw	%x1 -8(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20625	# 693 
	addi	%x6 %x0 2	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -8(%x2)	# 693 
	addi	%x2 %x2 -12	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 12	# 693 
	lw	%x1 -8(%x2)	# 693 
	j	beq_cont.20626	# 693 
beq_else.20625:	# 693 
	sw	%x6 -8(%x2)	# 692 
	sw	%x1 -12(%x2)	# 692 
	addi	%x2 %x2 -16	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 16	# 692 
	lw	%x1 -12(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20627	# 693 
	addi	%x6 %x0 3	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -12(%x2)	# 693 
	addi	%x2 %x2 -16	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 16	# 693 
	lw	%x1 -12(%x2)	# 693 
	j	beq_cont.20628	# 693 
beq_else.20627:	# 693 
	addi	%x7 %x0 3	# 695
	sw	%x6 -12(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -16(%x2)	# 695 
	addi	%x2 %x2 -20	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 20	# 695 
	lw	%x1 -16(%x2)	# 695 
	addi	%x7 %x6 8	# 696 
	lw	%x8 -12(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20628:	# 693 
	addi	%x7 %x6 4	# 696 
	lw	%x8 -8(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20626:	# 693 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -4(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
	add	%x7 %x0 %x6	# 696 
beq_cont.20624:	# 693 
	addi	%x6 %x7 0	# 701 
	lw	%x6 0(%x6)	# 701 
	addi	%x5 %x0 -1	# 701 
	bne	%x6 %x5 beq_else.20629	# 701 
	lw	%x6 -0(%x2)	# 702 
	addi	%x6 %x6 1	# 702 
	j	min_caml_create_array	# 702 
beq_else.20629:	# 701 
	lw	%x6 -0(%x2)	# 704 
	addi	%x8 %x6 1	# 704 
	sw	%x7 -16(%x2)	# 692 
	sw	%x8 -20(%x2)	# 692 
	sw	%x1 -24(%x2)	# 692 
	addi	%x2 %x2 -28	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 28	# 692 
	lw	%x1 -24(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20630	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -24(%x2)	# 693 
	addi	%x2 %x2 -28	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 28	# 693 
	lw	%x1 -24(%x2)	# 693 
	add	%x7 %x0 %x6	# 693 
	j	beq_cont.20631	# 693 
beq_else.20630:	# 693 
	sw	%x6 -24(%x2)	# 692 
	sw	%x1 -28(%x2)	# 692 
	addi	%x2 %x2 -32	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 32	# 692 
	lw	%x1 -28(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20632	# 693 
	addi	%x6 %x0 2	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -28(%x2)	# 693 
	addi	%x2 %x2 -32	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 32	# 693 
	lw	%x1 -28(%x2)	# 693 
	j	beq_cont.20633	# 693 
beq_else.20632:	# 693 
	addi	%x7 %x0 2	# 695
	sw	%x6 -28(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -32(%x2)	# 695 
	addi	%x2 %x2 -36	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 36	# 695 
	lw	%x1 -32(%x2)	# 695 
	addi	%x7 %x6 4	# 696 
	lw	%x8 -28(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20633:	# 693 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -24(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
	add	%x7 %x0 %x6	# 696 
beq_cont.20631:	# 693 
	addi	%x6 %x7 0	# 701 
	lw	%x6 0(%x6)	# 701 
	addi	%x5 %x0 -1	# 701 
	bne	%x6 %x5 beq_else.20634	# 701 
	lw	%x6 -20(%x2)	# 702 
	addi	%x6 %x6 1	# 702 
	sw	%x1 -32(%x2)	# 702 
	addi	%x2 %x2 -36	# 702 
	jal	 %x1 min_caml_create_array	# 702 
	addi	%x2 %x2 36	# 702 
	lw	%x1 -32(%x2)	# 702 
	j	beq_cont.20635	# 701 
beq_else.20634:	# 701 
	lw	%x6 -20(%x2)	# 704 
	addi	%x8 %x6 1	# 704 
	sw	%x7 -32(%x2)	# 704 
	add	%x6 %x0 %x8	# 704 
	sw	%x1 -36(%x2)	# 704 
	addi	%x2 %x2 -40	# 704 
	jal	 %x1 read_or_network.2877	# 704 
	addi	%x2 %x2 40	# 704 
	lw	%x1 -36(%x2)	# 704 
	lw	%x7 -20(%x2)	# 705 
	slli	%x7 %x7 2	# 705 
	add	%x7 %x6 %x7	# 705 
	lw	%x8 -32(%x2)	# 705 
	sw	%x8 0(%x7)	# 705 
beq_cont.20635:	# 701 
	lw	%x7 -0(%x2)	# 705 
	slli	%x7 %x7 2	# 705 
	add	%x7 %x6 %x7	# 705 
	lw	%x8 -16(%x2)	# 705 
	sw	%x8 0(%x7)	# 705 
	jr	0(%x1)	# 705 
read_and_network.2879:	#- 17356
	sw	%x6 -0(%x2)	# 692 
	sw	%x1 -4(%x2)	# 692 
	addi	%x2 %x2 -8	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 8	# 692 
	lw	%x1 -4(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20636	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -4(%x2)	# 693 
	addi	%x2 %x2 -8	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 8	# 693 
	lw	%x1 -4(%x2)	# 693 
	j	beq_cont.20637	# 693 
beq_else.20636:	# 693 
	sw	%x6 -4(%x2)	# 692 
	sw	%x1 -8(%x2)	# 692 
	addi	%x2 %x2 -12	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 12	# 692 
	lw	%x1 -8(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20638	# 693 
	addi	%x6 %x0 2	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -8(%x2)	# 693 
	addi	%x2 %x2 -12	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 12	# 693 
	lw	%x1 -8(%x2)	# 693 
	j	beq_cont.20639	# 693 
beq_else.20638:	# 693 
	sw	%x6 -8(%x2)	# 692 
	sw	%x1 -12(%x2)	# 692 
	addi	%x2 %x2 -16	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 16	# 692 
	lw	%x1 -12(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20640	# 693 
	addi	%x6 %x0 3	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -12(%x2)	# 693 
	addi	%x2 %x2 -16	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 16	# 693 
	lw	%x1 -12(%x2)	# 693 
	j	beq_cont.20641	# 693 
beq_else.20640:	# 693 
	addi	%x7 %x0 3	# 695
	sw	%x6 -12(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -16(%x2)	# 695 
	addi	%x2 %x2 -20	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 20	# 695 
	lw	%x1 -16(%x2)	# 695 
	addi	%x7 %x6 8	# 696 
	lw	%x8 -12(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20641:	# 693 
	addi	%x7 %x6 4	# 696 
	lw	%x8 -8(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20639:	# 693 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -4(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20637:	# 693 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.20642	# 710 
	jr	0(%x1)	# 710 
beq_else.20642:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	lw	%x8 -0(%x2)	# 712 
	slli	%x9 %x8 2	# 712 
	add	%x7 %x7 %x9	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x8 1	# 713 
	sw	%x6 -16(%x2)	# 692 
	sw	%x1 -20(%x2)	# 692 
	addi	%x2 %x2 -24	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 24	# 692 
	lw	%x1 -20(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20644	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -20(%x2)	# 693 
	addi	%x2 %x2 -24	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 24	# 693 
	lw	%x1 -20(%x2)	# 693 
	j	beq_cont.20645	# 693 
beq_else.20644:	# 693 
	sw	%x6 -20(%x2)	# 692 
	sw	%x1 -24(%x2)	# 692 
	addi	%x2 %x2 -28	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 28	# 692 
	lw	%x1 -24(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20646	# 693 
	addi	%x6 %x0 2	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -24(%x2)	# 693 
	addi	%x2 %x2 -28	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 28	# 693 
	lw	%x1 -24(%x2)	# 693 
	j	beq_cont.20647	# 693 
beq_else.20646:	# 693 
	addi	%x7 %x0 2	# 695
	sw	%x6 -24(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -28(%x2)	# 695 
	addi	%x2 %x2 -32	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 32	# 695 
	lw	%x1 -28(%x2)	# 695 
	addi	%x7 %x6 4	# 696 
	lw	%x8 -24(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20647:	# 693 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -20(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20645:	# 693 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.20648	# 710 
	jr	0(%x1)	# 710 
beq_else.20648:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	lw	%x8 -16(%x2)	# 712 
	slli	%x9 %x8 2	# 712 
	add	%x7 %x7 %x9	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x8 1	# 713 
	sw	%x6 -28(%x2)	# 692 
	sw	%x1 -32(%x2)	# 692 
	addi	%x2 %x2 -36	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 36	# 692 
	lw	%x1 -32(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.20650	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -32(%x2)	# 693 
	addi	%x2 %x2 -36	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 36	# 693 
	lw	%x1 -32(%x2)	# 693 
	j	beq_cont.20651	# 693 
beq_else.20650:	# 693 
	addi	%x7 %x0 1	# 695
	sw	%x6 -32(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -36(%x2)	# 695 
	addi	%x2 %x2 -40	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 40	# 695 
	lw	%x1 -36(%x2)	# 695 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -32(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.20651:	# 693 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.20652	# 710 
	jr	0(%x1)	# 710 
beq_else.20652:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	lw	%x8 -28(%x2)	# 712 
	slli	%x9 %x8 2	# 712 
	add	%x7 %x7 %x9	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x8 1	# 713 
	addi	%x7 %x0 0	# 709
	sw	%x6 -36(%x2)	# 709 
	add	%x6 %x0 %x7	# 709 
	sw	%x1 -40(%x2)	# 709 
	addi	%x2 %x2 -44	# 709 
	jal	 %x1 read_net_item.2875	# 709 
	addi	%x2 %x2 44	# 709 
	lw	%x1 -40(%x2)	# 709 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.20654	# 710 
	jr	0(%x1)	# 710 
beq_else.20654:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	lw	%x8 -36(%x2)	# 712 
	slli	%x9 %x8 2	# 712 
	add	%x7 %x7 %x9	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x8 1	# 713 
	j	read_and_network.2879	# 713 
solver_rect_surface.2883:	#- 18136
	slli	%x11 %x8 2	# 744 
	add	%x11 %x7 %x11	# 744 
	lw	%f4 0(%x11)	# 744 
	lw	%f5 52(%x29)	# 744 
	fle	%x5 %f4 %f5	# 744 
	fle	%x31 %f5 %f4	# 744 
	and	%x5 %x5 %x31	# 744 
	bne	%x5 %x0 feq.20656	# 744 
	lw	%x11 16(%x6)	# 236 
	lw	%x6 24(%x6)	# 188 
	lw	%f4 52(%x29)	# 746 
	slli	%x12 %x8 2	# 746 
	add	%x12 %x7 %x12	# 746 
	lw	%f5 0(%x12)	# 746 
	fle	%x5 %f4 %f5	# 746 
	bne	%x5 %x0 fle.20657	# 746 
	addi	%x12 %x0 1	# 746
	j	fle_cont.20658	# 746 
fle.20657:	# 746 
	addi	%x12 %x0 0	# 746
fle_cont.20658:	# 746 
	bne	%x6 %x0 beq_else.20659	# 25 
	add	%x6 %x0 %x12	# 25 
	j	beq_cont.20660	# 25 
beq_else.20659:	# 25 
	bne	%x12 %x0 beq_else.20661	# 25 
	addi	%x6 %x0 1	# 25
	j	beq_cont.20662	# 25 
beq_else.20661:	# 25 
	addi	%x6 %x0 0	# 25
beq_cont.20662:	# 25 
beq_cont.20660:	# 25 
	slli	%x12 %x8 2	# 746 
	add	%x12 %x11 %x12	# 746 
	lw	%f4 0(%x12)	# 746 
	bne	%x6 %x0 beq_else.20663	# 40 
	lw	%f5 48(%x29)	# 40 
	fmul	%f4 %f5 %f4	# 40 
	j	beq_cont.20664	# 40 
beq_else.20663:	# 40 
beq_cont.20664:	# 40 
	fsub	%f1 %f4 %f1	# 748 
	slli	%x6 %x8 2	# 748 
	add	%x6 %x7 %x6	# 748 
	lw	%f4 0(%x6)	# 748 
	fdiv	%f1 %f1 %f4	# 748 
	slli	%x6 %x9 2	# 749 
	add	%x6 %x11 %x6	# 749 
	lw	%f4 0(%x6)	# 749 
	slli	%x6 %x9 2	# 749 
	add	%x6 %x7 %x6	# 749 
	lw	%f5 0(%x6)	# 749 
	fmul	%f5 %f1 %f5	# 749 
	fadd	%f5 %f5 %f2	# 749 
	lw	%f6 52(%x29)	# 749 
	fle	%x5 %f5 %f6	# 749 
	bne	%x5 %x0 fle.20665	# 749 
	slli	%x6 %x9 2	# 749 
	add	%x6 %x7 %x6	# 749 
	lw	%f5 0(%x6)	# 749 
	fmul	%f5 %f1 %f5	# 749 
	fadd	%f2 %f5 %f2	# 749 
	j	fle_cont.20666	# 749 
fle.20665:	# 749 
	lw	%f5 48(%x29)	# 749 
	slli	%x6 %x9 2	# 749 
	add	%x6 %x7 %x6	# 749 
	lw	%f6 0(%x6)	# 749 
	fmul	%f6 %f1 %f6	# 749 
	fadd	%f2 %f6 %f2	# 749 
	fmul	%f2 %f5 %f2	# 749 
fle_cont.20666:	# 749 
	fle	%x5 %f4 %f2	# 749 
	bne	%x5 %x0 fle_else.20667	# 749 
	slli	%x6 %x10 2	# 750 
	add	%x6 %x11 %x6	# 750 
	lw	%f2 0(%x6)	# 750 
	slli	%x6 %x10 2	# 750 
	add	%x6 %x7 %x6	# 750 
	lw	%f4 0(%x6)	# 750 
	fmul	%f4 %f1 %f4	# 750 
	fadd	%f4 %f4 %f3	# 750 
	lw	%f5 52(%x29)	# 750 
	fle	%x5 %f4 %f5	# 750 
	bne	%x5 %x0 fle.20668	# 750 
	slli	%x6 %x10 2	# 750 
	add	%x6 %x7 %x6	# 750 
	lw	%f4 0(%x6)	# 750 
	fmul	%f4 %f1 %f4	# 750 
	fadd	%f3 %f4 %f3	# 750 
	j	fle_cont.20669	# 750 
fle.20668:	# 750 
	lw	%f4 48(%x29)	# 750 
	slli	%x6 %x10 2	# 750 
	add	%x6 %x7 %x6	# 750 
	lw	%f5 0(%x6)	# 750 
	fmul	%f5 %f1 %f5	# 750 
	fadd	%f3 %f5 %f3	# 750 
	fmul	%f3 %f4 %f3	# 750 
fle_cont.20669:	# 750 
	fle	%x5 %f2 %f3	# 750 
	bne	%x5 %x0 fle_else.20670	# 750 
	lui	%x6 2097948	# 751
	addi	%x6 %x6 796	# 751
	addi	%x6 %x6 0	# 751 
	sw	%f1 0(%x6)	# 751 
	addi	%x6 %x0 1	# 751
	jr	0(%x1)	# 751 
fle_else.20670:	# 750 
	addi	%x6 %x0 0	# 752
	jr	0(%x1)	# 752 
fle_else.20667:	# 749 
	addi	%x6 %x0 0	# 753
	jr	0(%x1)	# 753 
feq.20656:	# 744 
	addi	%x6 %x0 0	# 744
	jr	0(%x1)	# 744 
solver_surface.2898:	#- 18544
	lw	%x6 16(%x6)	# 236 
	addi	%x8 %x7 0	# 109 
	lw	%f4 0(%x8)	# 109 
	addi	%x8 %x6 0	# 109 
	lw	%f5 0(%x8)	# 109 
	fmul	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f6 0(%x8)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f5 0(%x7)	# 109 
	addi	%x7 %x6 8	# 109 
	lw	%f6 0(%x7)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	lw	%f5 52(%x29)	# 772 
	fle	%x5 %f4 %f5	# 772 
	bne	%x5 %x0 fle_else.20671	# 772 
	lw	%f5 48(%x29)	# 773 
	addi	%x7 %x6 0	# 114 
	lw	%f6 0(%x7)	# 114 
	fmul	%f1 %f6 %f1	# 114 
	addi	%x7 %x6 4	# 114 
	lw	%f6 0(%x7)	# 114 
	fmul	%f2 %f6 %f2	# 114 
	fadd	%f1 %f1 %f2	# 114 
	addi	%x6 %x6 8	# 114 
	lw	%f2 0(%x6)	# 114 
	fmul	%f2 %f2 %f3	# 114 
	fadd	%f1 %f1 %f2	# 114 
	fmul	%f1 %f5 %f1	# 773 
	fdiv	%f1 %f1 %f4	# 773 
	lui	%x6 2097948	# 773
	addi	%x6 %x6 796	# 773
	addi	%x6 %x6 0	# 773 
	sw	%f1 0(%x6)	# 773 
	addi	%x6 %x0 1	# 774
	jr	0(%x1)	# 774 
fle_else.20671:	# 772 
	addi	%x6 %x0 0	# 775
	jr	0(%x1)	# 775 
quadratic.2904:	#- 18716
	fmul	%f4 %f1 %f1	# 783 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f5 0(%x7)	# 211 
	fmul	%f4 %f4 %f5	# 783 
	fmul	%f5 %f2 %f2	# 783 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f6 0(%x7)	# 221 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	fmul	%f5 %f3 %f3	# 783 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f6 0(%x7)	# 231 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	lw	%x7 12(%x6)	# 197 
	bne	%x7 %x0 beq_else.20672	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f1 %f4 %x5	# 786 
	jr	0(%x1)	# 786 
beq_else.20672:	# 785 
	fmul	%f5 %f2 %f3	# 789 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f6 0(%x7)	# 331 
	fmul	%f5 %f5 %f6	# 789 
	fadd	%f4 %f4 %f5	# 788 
	fmul	%f3 %f3 %f1	# 790 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f5 0(%x7)	# 341 
	fmul	%f3 %f3 %f5	# 790 
	fadd	%f3 %f4 %f3	# 788 
	fmul	%f1 %f1 %f2	# 791 
	lw	%x6 36(%x6)	# 346 
	addi	%x6 %x6 8	# 351 
	lw	%f2 0(%x6)	# 351 
	fmul	%f1 %f1 %f2	# 791 
	fadd	%f1 %f3 %f1	# 788 
	jr	0(%x1)	# 788 
bilinear.2909:	#- 18880
	fmul	%f7 %f1 %f4	# 798 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f8 0(%x7)	# 211 
	fmul	%f7 %f7 %f8	# 798 
	fmul	%f8 %f2 %f5	# 799 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f9 0(%x7)	# 221 
	fmul	%f8 %f8 %f9	# 799 
	fadd	%f7 %f7 %f8	# 798 
	fmul	%f8 %f3 %f6	# 800 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f9 0(%x7)	# 231 
	fmul	%f8 %f8 %f9	# 800 
	fadd	%f7 %f7 %f8	# 798 
	lw	%x7 12(%x6)	# 197 
	bne	%x7 %x0 beq_else.20673	# 802 
	itof	%x5 %x0	# 803 
	fadd	%f1 %f7 %x5	# 803 
	jr	0(%x1)	# 803 
beq_else.20673:	# 802 
	fmul	%f8 %f3 %f5	# 806 
	fmul	%f9 %f2 %f6	# 806 
	fadd	%f8 %f8 %f9	# 806 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f9 0(%x7)	# 331 
	fmul	%f8 %f8 %f9	# 806 
	fmul	%f6 %f1 %f6	# 807 
	fmul	%f3 %f3 %f4	# 807 
	fadd	%f3 %f6 %f3	# 807 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f6 0(%x7)	# 341 
	fmul	%f3 %f3 %f6	# 807 
	fadd	%f3 %f8 %f3	# 806 
	fmul	%f1 %f1 %f5	# 808 
	fmul	%f2 %f2 %f4	# 808 
	fadd	%f1 %f1 %f2	# 808 
	lw	%x6 36(%x6)	# 346 
	addi	%x6 %x6 8	# 351 
	lw	%f2 0(%x6)	# 351 
	fmul	%f1 %f1 %f2	# 808 
	fadd	%f1 %f3 %f1	# 806 
	lw	%f2 4(%x29)	# 805 
	fdiv	%f1 %f1 %f2	# 805 
	fadd	%f1 %f7 %f1	# 805 
	jr	0(%x1)	# 805 
solver_second.2917:	#- 19076
	addi	%x8 %x7 0	# 823 
	lw	%f4 0(%x8)	# 823 
	addi	%x8 %x7 4	# 823 
	lw	%f5 0(%x8)	# 823 
	addi	%x8 %x7 8	# 823 
	lw	%f6 0(%x8)	# 823 
	fmul	%f7 %f4 %f4	# 783 
	lw	%x8 16(%x6)	# 206 
	addi	%x8 %x8 0	# 211 
	lw	%f8 0(%x8)	# 211 
	fmul	%f7 %f7 %f8	# 783 
	fmul	%f8 %f5 %f5	# 783 
	lw	%x8 16(%x6)	# 216 
	addi	%x8 %x8 4	# 221 
	lw	%f9 0(%x8)	# 221 
	fmul	%f8 %f8 %f9	# 783 
	fadd	%f7 %f7 %f8	# 783 
	fmul	%f8 %f6 %f6	# 783 
	lw	%x8 16(%x6)	# 226 
	addi	%x8 %x8 8	# 231 
	lw	%f9 0(%x8)	# 231 
	fmul	%f8 %f8 %f9	# 783 
	fadd	%f7 %f7 %f8	# 783 
	lw	%x8 12(%x6)	# 197 
	bne	%x8 %x0 beq_else.20674	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f4 %f7 %x5	# 786 
	j	beq_cont.20675	# 785 
beq_else.20674:	# 785 
	fmul	%f8 %f5 %f6	# 789 
	lw	%x8 36(%x6)	# 326 
	addi	%x8 %x8 0	# 331 
	lw	%f9 0(%x8)	# 331 
	fmul	%f8 %f8 %f9	# 789 
	fadd	%f7 %f7 %f8	# 788 
	fmul	%f6 %f6 %f4	# 790 
	lw	%x8 36(%x6)	# 336 
	addi	%x8 %x8 4	# 341 
	lw	%f8 0(%x8)	# 341 
	fmul	%f6 %f6 %f8	# 790 
	fadd	%f6 %f7 %f6	# 788 
	fmul	%f4 %f4 %f5	# 791 
	lw	%x8 36(%x6)	# 346 
	addi	%x8 %x8 8	# 351 
	lw	%f5 0(%x8)	# 351 
	fmul	%f4 %f4 %f5	# 791 
	fadd	%f4 %f6 %f4	# 788 
beq_cont.20675:	# 785 
	lw	%f5 52(%x29)	# 825 
	fle	%x5 %f4 %f5	# 825 
	fle	%x31 %f5 %f4	# 825 
	and	%x5 %x5 %x31	# 825 
	bne	%x5 %x0 feq.20676	# 825 
	addi	%x8 %x7 0	# 830 
	lw	%f5 0(%x8)	# 830 
	addi	%x8 %x7 4	# 830 
	lw	%f6 0(%x8)	# 830 
	addi	%x7 %x7 8	# 830 
	lw	%f7 0(%x7)	# 830 
	sw	%f4 -0(%x2)	# 830 
	sw	%f3 -4(%x2)	# 830 
	sw	%f2 -8(%x2)	# 830 
	sw	%x6 -12(%x2)	# 830 
	sw	%f1 -16(%x2)	# 830 
	fadd	%f4 %f0 %f1	# 830 
	fadd	%f1 %f0 %f5	# 830 
	fadd	%f5 %f0 %f2	# 830 
	fadd	%f2 %f0 %f6	# 830 
	fadd	%f6 %f0 %f3	# 830 
	fadd	%f3 %f0 %f7	# 830 
	sw	%x1 -20(%x2)	# 830 
	addi	%x2 %x2 -24	# 830 
	jal	 %x1 bilinear.2909	# 830 
	addi	%x2 %x2 24	# 830 
	lw	%x1 -20(%x2)	# 830 
	lw	%f2 -16(%x2)	# 783 
	fmul	%f3 %f2 %f2	# 783 
	lw	%x6 -12(%x2)	# 206 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f4 0(%x7)	# 211 
	fmul	%f3 %f3 %f4	# 783 
	lw	%f4 -8(%x2)	# 783 
	fmul	%f5 %f4 %f4	# 783 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f6 0(%x7)	# 221 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f3 %f3 %f5	# 783 
	lw	%f5 -4(%x2)	# 783 
	fmul	%f6 %f5 %f5	# 783 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f7 0(%x7)	# 231 
	fmul	%f6 %f6 %f7	# 783 
	fadd	%f3 %f3 %f6	# 783 
	lw	%x7 12(%x6)	# 197 
	bne	%x7 %x0 beq_else.20677	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f2 %f3 %x5	# 786 
	j	beq_cont.20678	# 785 
beq_else.20677:	# 785 
	fmul	%f6 %f4 %f5	# 789 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f7 0(%x7)	# 331 
	fmul	%f6 %f6 %f7	# 789 
	fadd	%f3 %f3 %f6	# 788 
	fmul	%f5 %f5 %f2	# 790 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f6 0(%x7)	# 341 
	fmul	%f5 %f5 %f6	# 790 
	fadd	%f3 %f3 %f5	# 788 
	fmul	%f2 %f2 %f4	# 791 
	lw	%x7 36(%x6)	# 346 
	addi	%x7 %x7 8	# 351 
	lw	%f4 0(%x7)	# 351 
	fmul	%f2 %f2 %f4	# 791 
	fadd	%f2 %f3 %f2	# 788 
beq_cont.20678:	# 785 
	lw	%x7 4(%x6)	# 168 
	addi	%x5 %x0 3	# 833 
	bne	%x7 %x5 beq_else.20679	# 833 
	lw	%f3 16(%x29)	# 833 
	fsub	%f2 %f2 %f3	# 833 
	j	beq_cont.20680	# 833 
beq_else.20679:	# 833 
beq_cont.20680:	# 833 
	fmul	%f3 %f1 %f1	# 835 
	lw	%f4 -0(%x2)	# 835 
	fmul	%f2 %f4 %f2	# 835 
	fsub	%f2 %f3 %f2	# 835 
	lw	%f3 52(%x29)	# 837 
	fle	%x5 %f2 %f3	# 837 
	bne	%x5 %x0 fle_else.20681	# 837 
	fsqrt	%f2 %f2	# 838 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20682	# 839 
	lw	%f3 48(%x29)	# 839 
	fmul	%f2 %f3 %f2	# 839 
	j	beq_cont.20683	# 839 
beq_else.20682:	# 839 
beq_cont.20683:	# 839 
	fsub	%f1 %f2 %f1	# 840 
	fdiv	%f1 %f1 %f4	# 840 
	lui	%x6 2097948	# 840
	addi	%x6 %x6 796	# 840
	addi	%x6 %x6 0	# 840 
	sw	%f1 0(%x6)	# 840 
	addi	%x6 %x0 1	# 840
	jr	0(%x1)	# 840 
fle_else.20681:	# 837 
	addi	%x6 %x0 0	# 843
	jr	0(%x1)	# 843 
feq.20676:	# 825 
	addi	%x6 %x0 0	# 826
	jr	0(%x1)	# 826 
solver.2923:	#- 19668
	lui	%x9 2097456	# 849
	addi	%x9 %x9 304	# 849
	slli	%x6 %x6 2	# 849 
	add	%x6 %x9 %x6	# 849 
	lw	%x6 0(%x6)	# 849 
	addi	%x9 %x8 0	# 851 
	lw	%f1 0(%x9)	# 851 
	lw	%x9 20(%x6)	# 246 
	addi	%x9 %x9 0	# 251 
	lw	%f2 0(%x9)	# 251 
	fsub	%f1 %f1 %f2	# 851 
	addi	%x9 %x8 4	# 852 
	lw	%f2 0(%x9)	# 852 
	lw	%x9 20(%x6)	# 256 
	addi	%x9 %x9 4	# 261 
	lw	%f3 0(%x9)	# 261 
	fsub	%f2 %f2 %f3	# 852 
	addi	%x8 %x8 8	# 853 
	lw	%f3 0(%x8)	# 853 
	lw	%x8 20(%x6)	# 266 
	addi	%x8 %x8 8	# 271 
	lw	%f4 0(%x8)	# 271 
	fsub	%f3 %f3 %f4	# 853 
	lw	%x8 4(%x6)	# 168 
	addi	%x5 %x0 1	# 856 
	bne	%x8 %x5 beq_else.20684	# 856 
	addi	%x8 %x0 0	# 759
	addi	%x9 %x0 1	# 759
	addi	%x10 %x0 2	# 759
	sw	%f1 -0(%x2)	# 759 
	sw	%f3 -4(%x2)	# 759 
	sw	%f2 -8(%x2)	# 759 
	sw	%x7 -12(%x2)	# 759 
	sw	%x6 -16(%x2)	# 759 
	sw	%x1 -20(%x2)	# 759 
	addi	%x2 %x2 -24	# 759 
	jal	 %x1 solver_rect_surface.2883	# 759 
	addi	%x2 %x2 24	# 759 
	lw	%x1 -20(%x2)	# 759 
	bne	%x6 %x0 beq_else.20685	# 759 
	addi	%x8 %x0 1	# 760
	addi	%x9 %x0 2	# 760
	addi	%x10 %x0 0	# 760
	lw	%f1 -8(%x2)	# 760 
	lw	%f2 -4(%x2)	# 760 
	lw	%f3 -0(%x2)	# 760 
	lw	%x6 -16(%x2)	# 760 
	lw	%x7 -12(%x2)	# 760 
	sw	%x1 -20(%x2)	# 760 
	addi	%x2 %x2 -24	# 760 
	jal	 %x1 solver_rect_surface.2883	# 760 
	addi	%x2 %x2 24	# 760 
	lw	%x1 -20(%x2)	# 760 
	bne	%x6 %x0 beq_else.20686	# 760 
	addi	%x8 %x0 2	# 761
	addi	%x9 %x0 0	# 761
	addi	%x10 %x0 1	# 761
	lw	%f1 -4(%x2)	# 761 
	lw	%f2 -0(%x2)	# 761 
	lw	%f3 -8(%x2)	# 761 
	lw	%x6 -16(%x2)	# 761 
	lw	%x7 -12(%x2)	# 761 
	sw	%x1 -20(%x2)	# 761 
	addi	%x2 %x2 -24	# 761 
	jal	 %x1 solver_rect_surface.2883	# 761 
	addi	%x2 %x2 24	# 761 
	lw	%x1 -20(%x2)	# 761 
	bne	%x6 %x0 beq_else.20687	# 761 
	addi	%x6 %x0 0	# 762
	jr	0(%x1)	# 762 
beq_else.20687:	# 761 
	addi	%x6 %x0 3	# 761
	jr	0(%x1)	# 761 
beq_else.20686:	# 760 
	addi	%x6 %x0 2	# 760
	jr	0(%x1)	# 760 
beq_else.20685:	# 759 
	addi	%x6 %x0 1	# 759
	jr	0(%x1)	# 759 
beq_else.20684:	# 856 
	addi	%x5 %x0 2	# 857 
	bne	%x8 %x5 beq_else.20688	# 857 
	lw	%x6 16(%x6)	# 236 
	addi	%x8 %x7 0	# 109 
	lw	%f4 0(%x8)	# 109 
	addi	%x8 %x6 0	# 109 
	lw	%f5 0(%x8)	# 109 
	fmul	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f6 0(%x8)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f5 0(%x7)	# 109 
	addi	%x7 %x6 8	# 109 
	lw	%f6 0(%x7)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	lw	%f5 52(%x29)	# 772 
	fle	%x5 %f4 %f5	# 772 
	bne	%x5 %x0 fle_else.20689	# 772 
	lw	%f5 48(%x29)	# 773 
	addi	%x7 %x6 0	# 114 
	lw	%f6 0(%x7)	# 114 
	fmul	%f1 %f6 %f1	# 114 
	addi	%x7 %x6 4	# 114 
	lw	%f6 0(%x7)	# 114 
	fmul	%f2 %f6 %f2	# 114 
	fadd	%f1 %f1 %f2	# 114 
	addi	%x6 %x6 8	# 114 
	lw	%f2 0(%x6)	# 114 
	fmul	%f2 %f2 %f3	# 114 
	fadd	%f1 %f1 %f2	# 114 
	fmul	%f1 %f5 %f1	# 773 
	fdiv	%f1 %f1 %f4	# 773 
	lui	%x6 2097948	# 773
	addi	%x6 %x6 796	# 773
	addi	%x6 %x6 0	# 773 
	sw	%f1 0(%x6)	# 773 
	addi	%x6 %x0 1	# 774
	jr	0(%x1)	# 774 
fle_else.20689:	# 772 
	addi	%x6 %x0 0	# 775
	jr	0(%x1)	# 775 
beq_else.20688:	# 857 
	j	solver_second.2917	# 858 
solver_rect_fast.2927:	#- 20156
	addi	%x9 %x8 0	# 881 
	lw	%f4 0(%x9)	# 881 
	fsub	%f4 %f4 %f1	# 881 
	addi	%x9 %x8 4	# 881 
	lw	%f5 0(%x9)	# 881 
	fmul	%f4 %f4 %f5	# 881 
	lw	%x9 16(%x6)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f5 0(%x9)	# 221 
	addi	%x9 %x7 4	# 883 
	lw	%f6 0(%x9)	# 883 
	fmul	%f6 %f4 %f6	# 883 
	fadd	%f6 %f6 %f2	# 883 
	lw	%f7 52(%x29)	# 883 
	fle	%x5 %f6 %f7	# 883 
	bne	%x5 %x0 fle.20690	# 883 
	addi	%x9 %x7 4	# 883 
	lw	%f6 0(%x9)	# 883 
	fmul	%f6 %f4 %f6	# 883 
	fadd	%f6 %f6 %f2	# 883 
	j	fle_cont.20691	# 883 
fle.20690:	# 883 
	lw	%f6 48(%x29)	# 883 
	addi	%x9 %x7 4	# 883 
	lw	%f7 0(%x9)	# 883 
	fmul	%f7 %f4 %f7	# 883 
	fadd	%f7 %f7 %f2	# 883 
	fmul	%f6 %f6 %f7	# 883 
fle_cont.20691:	# 883 
	fle	%x5 %f5 %f6	# 883 
	bne	%x5 %x0 fle.20692	# 883 
	lw	%x9 16(%x6)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f5 0(%x9)	# 231 
	addi	%x9 %x7 8	# 884 
	lw	%f6 0(%x9)	# 884 
	fmul	%f6 %f4 %f6	# 884 
	fadd	%f6 %f6 %f3	# 884 
	lw	%f7 52(%x29)	# 884 
	fle	%x5 %f6 %f7	# 884 
	bne	%x5 %x0 fle.20694	# 884 
	addi	%x9 %x7 8	# 884 
	lw	%f6 0(%x9)	# 884 
	fmul	%f6 %f4 %f6	# 884 
	fadd	%f6 %f6 %f3	# 884 
	j	fle_cont.20695	# 884 
fle.20694:	# 884 
	lw	%f6 48(%x29)	# 884 
	addi	%x9 %x7 8	# 884 
	lw	%f7 0(%x9)	# 884 
	fmul	%f7 %f4 %f7	# 884 
	fadd	%f7 %f7 %f3	# 884 
	fmul	%f6 %f6 %f7	# 884 
fle_cont.20695:	# 884 
	fle	%x5 %f5 %f6	# 884 
	bne	%x5 %x0 fle.20696	# 884 
	addi	%x9 %x8 4	# 885 
	lw	%f5 0(%x9)	# 885 
	lw	%f6 52(%x29)	# 885 
	fle	%x5 %f5 %f6	# 885 
	fle	%x31 %f6 %f5	# 885 
	and	%x5 %x5 %x31	# 885 
	bne	%x5 %x0 feq.20698	# 885 
	addi	%x9 %x0 1	# 885
	j	feq_cont.20699	# 885 
feq.20698:	# 885 
	addi	%x9 %x0 0	# 885
feq_cont.20699:	# 885 
	j	fle_cont.20697	# 884 
fle.20696:	# 884 
	addi	%x9 %x0 0	# 886
fle_cont.20697:	# 884 
	j	fle_cont.20693	# 883 
fle.20692:	# 883 
	addi	%x9 %x0 0	# 887
fle_cont.20693:	# 883 
	bne	%x9 %x0 beq_else.20700	# 882 
	addi	%x9 %x8 8	# 890 
	lw	%f4 0(%x9)	# 890 
	fsub	%f4 %f4 %f2	# 890 
	addi	%x9 %x8 12	# 890 
	lw	%f5 0(%x9)	# 890 
	fmul	%f4 %f4 %f5	# 890 
	lw	%x9 16(%x6)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f5 0(%x9)	# 211 
	addi	%x9 %x7 0	# 892 
	lw	%f6 0(%x9)	# 892 
	fmul	%f6 %f4 %f6	# 892 
	fadd	%f6 %f6 %f1	# 892 
	lw	%f7 52(%x29)	# 892 
	fle	%x5 %f6 %f7	# 892 
	bne	%x5 %x0 fle.20701	# 892 
	addi	%x9 %x7 0	# 892 
	lw	%f6 0(%x9)	# 892 
	fmul	%f6 %f4 %f6	# 892 
	fadd	%f6 %f6 %f1	# 892 
	j	fle_cont.20702	# 892 
fle.20701:	# 892 
	lw	%f6 48(%x29)	# 892 
	addi	%x9 %x7 0	# 892 
	lw	%f7 0(%x9)	# 892 
	fmul	%f7 %f4 %f7	# 892 
	fadd	%f7 %f7 %f1	# 892 
	fmul	%f6 %f6 %f7	# 892 
fle_cont.20702:	# 892 
	fle	%x5 %f5 %f6	# 892 
	bne	%x5 %x0 fle.20703	# 892 
	lw	%x9 16(%x6)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f5 0(%x9)	# 231 
	addi	%x9 %x7 8	# 893 
	lw	%f6 0(%x9)	# 893 
	fmul	%f6 %f4 %f6	# 893 
	fadd	%f6 %f6 %f3	# 893 
	lw	%f7 52(%x29)	# 893 
	fle	%x5 %f6 %f7	# 893 
	bne	%x5 %x0 fle.20705	# 893 
	addi	%x9 %x7 8	# 893 
	lw	%f6 0(%x9)	# 893 
	fmul	%f6 %f4 %f6	# 893 
	fadd	%f6 %f6 %f3	# 893 
	j	fle_cont.20706	# 893 
fle.20705:	# 893 
	lw	%f6 48(%x29)	# 893 
	addi	%x9 %x7 8	# 893 
	lw	%f7 0(%x9)	# 893 
	fmul	%f7 %f4 %f7	# 893 
	fadd	%f7 %f7 %f3	# 893 
	fmul	%f6 %f6 %f7	# 893 
fle_cont.20706:	# 893 
	fle	%x5 %f5 %f6	# 893 
	bne	%x5 %x0 fle.20707	# 893 
	addi	%x9 %x8 12	# 894 
	lw	%f5 0(%x9)	# 894 
	lw	%f6 52(%x29)	# 894 
	fle	%x5 %f5 %f6	# 894 
	fle	%x31 %f6 %f5	# 894 
	and	%x5 %x5 %x31	# 894 
	bne	%x5 %x0 feq.20709	# 894 
	addi	%x9 %x0 1	# 894
	j	feq_cont.20710	# 894 
feq.20709:	# 894 
	addi	%x9 %x0 0	# 894
feq_cont.20710:	# 894 
	j	fle_cont.20708	# 893 
fle.20707:	# 893 
	addi	%x9 %x0 0	# 895
fle_cont.20708:	# 893 
	j	fle_cont.20704	# 892 
fle.20703:	# 892 
	addi	%x9 %x0 0	# 896
fle_cont.20704:	# 892 
	bne	%x9 %x0 beq_else.20711	# 891 
	addi	%x9 %x8 16	# 899 
	lw	%f4 0(%x9)	# 899 
	fsub	%f3 %f4 %f3	# 899 
	addi	%x9 %x8 20	# 899 
	lw	%f4 0(%x9)	# 899 
	fmul	%f3 %f3 %f4	# 899 
	lw	%x9 16(%x6)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f4 0(%x9)	# 211 
	addi	%x9 %x7 0	# 901 
	lw	%f5 0(%x9)	# 901 
	fmul	%f5 %f3 %f5	# 901 
	fadd	%f5 %f5 %f1	# 901 
	lw	%f6 52(%x29)	# 901 
	fle	%x5 %f5 %f6	# 901 
	bne	%x5 %x0 fle.20712	# 901 
	addi	%x9 %x7 0	# 901 
	lw	%f5 0(%x9)	# 901 
	fmul	%f5 %f3 %f5	# 901 
	fadd	%f1 %f5 %f1	# 901 
	j	fle_cont.20713	# 901 
fle.20712:	# 901 
	lw	%f5 48(%x29)	# 901 
	addi	%x9 %x7 0	# 901 
	lw	%f6 0(%x9)	# 901 
	fmul	%f6 %f3 %f6	# 901 
	fadd	%f1 %f6 %f1	# 901 
	fmul	%f1 %f5 %f1	# 901 
fle_cont.20713:	# 901 
	fle	%x5 %f4 %f1	# 901 
	bne	%x5 %x0 fle.20714	# 901 
	lw	%x6 16(%x6)	# 216 
	addi	%x6 %x6 4	# 221 
	lw	%f1 0(%x6)	# 221 
	addi	%x6 %x7 4	# 902 
	lw	%f4 0(%x6)	# 902 
	fmul	%f4 %f3 %f4	# 902 
	fadd	%f4 %f4 %f2	# 902 
	lw	%f5 52(%x29)	# 902 
	fle	%x5 %f4 %f5	# 902 
	bne	%x5 %x0 fle.20716	# 902 
	addi	%x6 %x7 4	# 902 
	lw	%f4 0(%x6)	# 902 
	fmul	%f4 %f3 %f4	# 902 
	fadd	%f2 %f4 %f2	# 902 
	j	fle_cont.20717	# 902 
fle.20716:	# 902 
	lw	%f4 48(%x29)	# 902 
	addi	%x6 %x7 4	# 902 
	lw	%f5 0(%x6)	# 902 
	fmul	%f5 %f3 %f5	# 902 
	fadd	%f2 %f5 %f2	# 902 
	fmul	%f2 %f4 %f2	# 902 
fle_cont.20717:	# 902 
	fle	%x5 %f1 %f2	# 902 
	bne	%x5 %x0 fle.20718	# 902 
	addi	%x6 %x8 20	# 903 
	lw	%f1 0(%x6)	# 903 
	lw	%f2 52(%x29)	# 903 
	fle	%x5 %f1 %f2	# 903 
	fle	%x31 %f2 %f1	# 903 
	and	%x5 %x5 %x31	# 903 
	bne	%x5 %x0 feq.20720	# 903 
	addi	%x6 %x0 1	# 903
	j	feq_cont.20721	# 903 
feq.20720:	# 903 
	addi	%x6 %x0 0	# 903
feq_cont.20721:	# 903 
	j	fle_cont.20719	# 902 
fle.20718:	# 902 
	addi	%x6 %x0 0	# 904
fle_cont.20719:	# 902 
	j	fle_cont.20715	# 901 
fle.20714:	# 901 
	addi	%x6 %x0 0	# 905
fle_cont.20715:	# 901 
	bne	%x6 %x0 beq_else.20722	# 900 
	addi	%x6 %x0 0	# 909
	jr	0(%x1)	# 909 
beq_else.20722:	# 900 
	lui	%x6 2097948	# 907
	addi	%x6 %x6 796	# 907
	addi	%x6 %x6 0	# 907 
	sw	%f3 0(%x6)	# 907 
	addi	%x6 %x0 3	# 907
	jr	0(%x1)	# 907 
beq_else.20711:	# 891 
	lui	%x6 2097948	# 898
	addi	%x6 %x6 796	# 898
	addi	%x6 %x6 0	# 898 
	sw	%f4 0(%x6)	# 898 
	addi	%x6 %x0 2	# 898
	jr	0(%x1)	# 898 
beq_else.20700:	# 882 
	lui	%x6 2097948	# 889
	addi	%x6 %x6 796	# 889
	addi	%x6 %x6 0	# 889 
	sw	%f4 0(%x6)	# 889 
	addi	%x6 %x0 1	# 889
	jr	0(%x1)	# 889 
solver_second_fast.2940:	#- 21040
	addi	%x8 %x7 0	# 924 
	lw	%f4 0(%x8)	# 924 
	lw	%f5 52(%x29)	# 925 
	fle	%x5 %f4 %f5	# 925 
	fle	%x31 %f5 %f4	# 925 
	and	%x5 %x5 %x31	# 925 
	bne	%x5 %x0 feq.20723	# 925 
	addi	%x8 %x7 4	# 928 
	lw	%f5 0(%x8)	# 928 
	fmul	%f5 %f5 %f1	# 928 
	addi	%x8 %x7 8	# 928 
	lw	%f6 0(%x8)	# 928 
	fmul	%f6 %f6 %f2	# 928 
	fadd	%f5 %f5 %f6	# 928 
	addi	%x8 %x7 12	# 928 
	lw	%f6 0(%x8)	# 928 
	fmul	%f6 %f6 %f3	# 928 
	fadd	%f5 %f5 %f6	# 928 
	fmul	%f6 %f1 %f1	# 783 
	lw	%x8 16(%x6)	# 206 
	addi	%x8 %x8 0	# 211 
	lw	%f7 0(%x8)	# 211 
	fmul	%f6 %f6 %f7	# 783 
	fmul	%f7 %f2 %f2	# 783 
	lw	%x8 16(%x6)	# 216 
	addi	%x8 %x8 4	# 221 
	lw	%f8 0(%x8)	# 221 
	fmul	%f7 %f7 %f8	# 783 
	fadd	%f6 %f6 %f7	# 783 
	fmul	%f7 %f3 %f3	# 783 
	lw	%x8 16(%x6)	# 226 
	addi	%x8 %x8 8	# 231 
	lw	%f8 0(%x8)	# 231 
	fmul	%f7 %f7 %f8	# 783 
	fadd	%f6 %f6 %f7	# 783 
	lw	%x8 12(%x6)	# 197 
	bne	%x8 %x0 beq_else.20724	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f1 %f6 %x5	# 786 
	j	beq_cont.20725	# 785 
beq_else.20724:	# 785 
	fmul	%f7 %f2 %f3	# 789 
	lw	%x8 36(%x6)	# 326 
	addi	%x8 %x8 0	# 331 
	lw	%f8 0(%x8)	# 331 
	fmul	%f7 %f7 %f8	# 789 
	fadd	%f6 %f6 %f7	# 788 
	fmul	%f3 %f3 %f1	# 790 
	lw	%x8 36(%x6)	# 336 
	addi	%x8 %x8 4	# 341 
	lw	%f7 0(%x8)	# 341 
	fmul	%f3 %f3 %f7	# 790 
	fadd	%f3 %f6 %f3	# 788 
	fmul	%f1 %f1 %f2	# 791 
	lw	%x8 36(%x6)	# 346 
	addi	%x8 %x8 8	# 351 
	lw	%f2 0(%x8)	# 351 
	fmul	%f1 %f1 %f2	# 791 
	fadd	%f1 %f3 %f1	# 788 
beq_cont.20725:	# 785 
	lw	%x8 4(%x6)	# 168 
	addi	%x5 %x0 3	# 930 
	bne	%x8 %x5 beq_else.20726	# 930 
	lw	%f2 16(%x29)	# 930 
	fsub	%f1 %f1 %f2	# 930 
	j	beq_cont.20727	# 930 
beq_else.20726:	# 930 
beq_cont.20727:	# 930 
	fmul	%f2 %f5 %f5	# 931 
	fmul	%f1 %f4 %f1	# 931 
	fsub	%f1 %f2 %f1	# 931 
	lw	%f2 52(%x29)	# 932 
	fle	%x5 %f1 %f2	# 932 
	bne	%x5 %x0 fle_else.20728	# 932 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20729	# 933 
	fsqrt	%f1 %f1	# 936 
	fsub	%f1 %f5 %f1	# 936 
	addi	%x6 %x7 16	# 936 
	lw	%f2 0(%x6)	# 936 
	fmul	%f1 %f1 %f2	# 936 
	lui	%x6 2097948	# 936
	addi	%x6 %x6 796	# 936
	addi	%x6 %x6 0	# 936 
	sw	%f1 0(%x6)	# 936 
	j	beq_cont.20730	# 933 
beq_else.20729:	# 933 
	fsqrt	%f1 %f1	# 934 
	fadd	%f1 %f5 %f1	# 934 
	addi	%x6 %x7 16	# 934 
	lw	%f2 0(%x6)	# 934 
	fmul	%f1 %f1 %f2	# 934 
	lui	%x6 2097948	# 934
	addi	%x6 %x6 796	# 934
	addi	%x6 %x6 0	# 934 
	sw	%f1 0(%x6)	# 934 
beq_cont.20730:	# 933 
	addi	%x6 %x0 1	# 937
	jr	0(%x1)	# 937 
fle_else.20728:	# 932 
	addi	%x6 %x0 0	# 938
	jr	0(%x1)	# 938 
feq.20723:	# 925 
	addi	%x6 %x0 0	# 926
	jr	0(%x1)	# 926 
solver_second_fast2.2957:	#- 21428
	addi	%x9 %x7 0	# 972 
	lw	%f4 0(%x9)	# 972 
	lw	%f5 52(%x29)	# 973 
	fle	%x5 %f4 %f5	# 973 
	fle	%x31 %f5 %f4	# 973 
	and	%x5 %x5 %x31	# 973 
	bne	%x5 %x0 feq.20731	# 973 
	addi	%x9 %x7 4	# 976 
	lw	%f5 0(%x9)	# 976 
	fmul	%f1 %f5 %f1	# 976 
	addi	%x9 %x7 8	# 976 
	lw	%f5 0(%x9)	# 976 
	fmul	%f2 %f5 %f2	# 976 
	fadd	%f1 %f1 %f2	# 976 
	addi	%x9 %x7 12	# 976 
	lw	%f2 0(%x9)	# 976 
	fmul	%f2 %f2 %f3	# 976 
	fadd	%f1 %f1 %f2	# 976 
	addi	%x8 %x8 12	# 977 
	lw	%f2 0(%x8)	# 977 
	fmul	%f3 %f1 %f1	# 978 
	fmul	%f2 %f4 %f2	# 978 
	fsub	%f2 %f3 %f2	# 978 
	lw	%f3 52(%x29)	# 979 
	fle	%x5 %f2 %f3	# 979 
	bne	%x5 %x0 fle_else.20732	# 979 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20733	# 980 
	fsqrt	%f2 %f2	# 983 
	fsub	%f1 %f1 %f2	# 983 
	addi	%x6 %x7 16	# 983 
	lw	%f2 0(%x6)	# 983 
	fmul	%f1 %f1 %f2	# 983 
	lui	%x6 2097948	# 983
	addi	%x6 %x6 796	# 983
	addi	%x6 %x6 0	# 983 
	sw	%f1 0(%x6)	# 983 
	j	beq_cont.20734	# 980 
beq_else.20733:	# 980 
	fsqrt	%f2 %f2	# 981 
	fadd	%f1 %f1 %f2	# 981 
	addi	%x6 %x7 16	# 981 
	lw	%f2 0(%x6)	# 981 
	fmul	%f1 %f1 %f2	# 981 
	lui	%x6 2097948	# 981
	addi	%x6 %x6 796	# 981
	addi	%x6 %x6 0	# 981 
	sw	%f1 0(%x6)	# 981 
beq_cont.20734:	# 980 
	addi	%x6 %x0 1	# 984
	jr	0(%x1)	# 984 
fle_else.20732:	# 979 
	addi	%x6 %x0 0	# 985
	jr	0(%x1)	# 985 
feq.20731:	# 973 
	addi	%x6 %x0 0	# 974
	jr	0(%x1)	# 974 
setup_rect_table.2967:	#- 21640
	addi	%x8 %x0 6	# 1012
	lw	%f1 52(%x29)	# 1012 
	sw	%x7 -0(%x2)	# 1012 
	sw	%x6 -4(%x2)	# 1012 
	add	%x6 %x0 %x8	# 1012 
	sw	%x1 -8(%x2)	# 1012 
	addi	%x2 %x2 -12	# 1012 
	jal	 %x1 min_caml_create_float_array	# 1012 
	addi	%x2 %x2 12	# 1012 
	lw	%x1 -8(%x2)	# 1012 
	lw	%x7 -4(%x2)	# 1014 
	addi	%x8 %x7 0	# 1014 
	lw	%f1 0(%x8)	# 1014 
	lw	%f2 52(%x29)	# 1014 
	fle	%x5 %f1 %f2	# 1014 
	fle	%x31 %f2 %f1	# 1014 
	and	%x5 %x5 %x31	# 1014 
	bne	%x5 %x0 feq.20735	# 1014 
	lw	%x8 -0(%x2)	# 188 
	lw	%x9 24(%x8)	# 188 
	lw	%f1 52(%x29)	# 1018 
	addi	%x10 %x7 0	# 1018 
	lw	%f2 0(%x10)	# 1018 
	fle	%x5 %f1 %f2	# 1018 
	bne	%x5 %x0 fle.20737	# 1018 
	addi	%x10 %x0 1	# 1018
	j	fle_cont.20738	# 1018 
fle.20737:	# 1018 
	addi	%x10 %x0 0	# 1018
fle_cont.20738:	# 1018 
	bne	%x9 %x0 beq_else.20739	# 25 
	add	%x9 %x0 %x10	# 25 
	j	beq_cont.20740	# 25 
beq_else.20739:	# 25 
	bne	%x10 %x0 beq_else.20741	# 25 
	addi	%x9 %x0 1	# 25
	j	beq_cont.20742	# 25 
beq_else.20741:	# 25 
	addi	%x9 %x0 0	# 25
beq_cont.20742:	# 25 
beq_cont.20740:	# 25 
	lw	%x10 16(%x8)	# 206 
	addi	%x10 %x10 0	# 211 
	lw	%f1 0(%x10)	# 211 
	bne	%x9 %x0 beq_else.20743	# 40 
	lw	%f2 48(%x29)	# 40 
	fmul	%f1 %f2 %f1	# 40 
	j	beq_cont.20744	# 40 
beq_else.20743:	# 40 
beq_cont.20744:	# 40 
	addi	%x9 %x6 0	# 1018 
	sw	%f1 0(%x9)	# 1018 
	lw	%f1 16(%x29)	# 1020 
	addi	%x9 %x7 0	# 1020 
	lw	%f2 0(%x9)	# 1020 
	fdiv	%f1 %f1 %f2	# 1020 
	addi	%x9 %x6 4	# 1020 
	sw	%f1 0(%x9)	# 1020 
	j	feq_cont.20736	# 1014 
feq.20735:	# 1014 
	lw	%f1 52(%x29)	# 1015 
	addi	%x8 %x6 4	# 1015 
	sw	%f1 0(%x8)	# 1015 
feq_cont.20736:	# 1014 
	addi	%x8 %x7 4	# 1022 
	lw	%f1 0(%x8)	# 1022 
	lw	%f2 52(%x29)	# 1022 
	fle	%x5 %f1 %f2	# 1022 
	fle	%x31 %f2 %f1	# 1022 
	and	%x5 %x5 %x31	# 1022 
	bne	%x5 %x0 feq.20745	# 1022 
	lw	%x8 -0(%x2)	# 188 
	lw	%x9 24(%x8)	# 188 
	lw	%f1 52(%x29)	# 1025 
	addi	%x10 %x7 4	# 1025 
	lw	%f2 0(%x10)	# 1025 
	fle	%x5 %f1 %f2	# 1025 
	bne	%x5 %x0 fle.20747	# 1025 
	addi	%x10 %x0 1	# 1025
	j	fle_cont.20748	# 1025 
fle.20747:	# 1025 
	addi	%x10 %x0 0	# 1025
fle_cont.20748:	# 1025 
	bne	%x9 %x0 beq_else.20749	# 25 
	add	%x9 %x0 %x10	# 25 
	j	beq_cont.20750	# 25 
beq_else.20749:	# 25 
	bne	%x10 %x0 beq_else.20751	# 25 
	addi	%x9 %x0 1	# 25
	j	beq_cont.20752	# 25 
beq_else.20751:	# 25 
	addi	%x9 %x0 0	# 25
beq_cont.20752:	# 25 
beq_cont.20750:	# 25 
	lw	%x10 16(%x8)	# 216 
	addi	%x10 %x10 4	# 221 
	lw	%f1 0(%x10)	# 221 
	bne	%x9 %x0 beq_else.20753	# 40 
	lw	%f2 48(%x29)	# 40 
	fmul	%f1 %f2 %f1	# 40 
	j	beq_cont.20754	# 40 
beq_else.20753:	# 40 
beq_cont.20754:	# 40 
	addi	%x9 %x6 8	# 1025 
	sw	%f1 0(%x9)	# 1025 
	lw	%f1 16(%x29)	# 1026 
	addi	%x9 %x7 4	# 1026 
	lw	%f2 0(%x9)	# 1026 
	fdiv	%f1 %f1 %f2	# 1026 
	addi	%x9 %x6 12	# 1026 
	sw	%f1 0(%x9)	# 1026 
	j	feq_cont.20746	# 1022 
feq.20745:	# 1022 
	lw	%f1 52(%x29)	# 1023 
	addi	%x8 %x6 12	# 1023 
	sw	%f1 0(%x8)	# 1023 
feq_cont.20746:	# 1022 
	addi	%x8 %x7 8	# 1028 
	lw	%f1 0(%x8)	# 1028 
	lw	%f2 52(%x29)	# 1028 
	fle	%x5 %f1 %f2	# 1028 
	fle	%x31 %f2 %f1	# 1028 
	and	%x5 %x5 %x31	# 1028 
	bne	%x5 %x0 feq.20755	# 1028 
	lw	%x8 -0(%x2)	# 188 
	lw	%x9 24(%x8)	# 188 
	lw	%f1 52(%x29)	# 1031 
	addi	%x10 %x7 8	# 1031 
	lw	%f2 0(%x10)	# 1031 
	fle	%x5 %f1 %f2	# 1031 
	bne	%x5 %x0 fle.20757	# 1031 
	addi	%x10 %x0 1	# 1031
	j	fle_cont.20758	# 1031 
fle.20757:	# 1031 
	addi	%x10 %x0 0	# 1031
fle_cont.20758:	# 1031 
	bne	%x9 %x0 beq_else.20759	# 25 
	add	%x9 %x0 %x10	# 25 
	j	beq_cont.20760	# 25 
beq_else.20759:	# 25 
	bne	%x10 %x0 beq_else.20761	# 25 
	addi	%x9 %x0 1	# 25
	j	beq_cont.20762	# 25 
beq_else.20761:	# 25 
	addi	%x9 %x0 0	# 25
beq_cont.20762:	# 25 
beq_cont.20760:	# 25 
	lw	%x8 16(%x8)	# 226 
	addi	%x8 %x8 8	# 231 
	lw	%f1 0(%x8)	# 231 
	bne	%x9 %x0 beq_else.20763	# 40 
	lw	%f2 48(%x29)	# 40 
	fmul	%f1 %f2 %f1	# 40 
	j	beq_cont.20764	# 40 
beq_else.20763:	# 40 
beq_cont.20764:	# 40 
	addi	%x8 %x6 16	# 1031 
	sw	%f1 0(%x8)	# 1031 
	lw	%f1 16(%x29)	# 1032 
	addi	%x7 %x7 8	# 1032 
	lw	%f2 0(%x7)	# 1032 
	fdiv	%f1 %f1 %f2	# 1032 
	addi	%x7 %x6 20	# 1032 
	sw	%f1 0(%x7)	# 1032 
	j	feq_cont.20756	# 1028 
feq.20755:	# 1028 
	lw	%f1 52(%x29)	# 1029 
	addi	%x7 %x6 20	# 1029 
	sw	%f1 0(%x7)	# 1029 
feq_cont.20756:	# 1028 
	jr	0(%x1)	# 1034 
setup_surface_table.2970:	#- 22204
	addi	%x8 %x0 4	# 1039
	lw	%f1 52(%x29)	# 1039 
	sw	%x7 -0(%x2)	# 1039 
	sw	%x6 -4(%x2)	# 1039 
	add	%x6 %x0 %x8	# 1039 
	sw	%x1 -8(%x2)	# 1039 
	addi	%x2 %x2 -12	# 1039 
	jal	 %x1 min_caml_create_float_array	# 1039 
	addi	%x2 %x2 12	# 1039 
	lw	%x1 -8(%x2)	# 1039 
	lw	%x7 -4(%x2)	# 1041 
	addi	%x8 %x7 0	# 1041 
	lw	%f1 0(%x8)	# 1041 
	lw	%x8 -0(%x2)	# 206 
	lw	%x9 16(%x8)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f2 0(%x9)	# 211 
	fmul	%f1 %f1 %f2	# 1041 
	addi	%x9 %x7 4	# 1041 
	lw	%f2 0(%x9)	# 1041 
	lw	%x9 16(%x8)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f3 0(%x9)	# 221 
	fmul	%f2 %f2 %f3	# 1041 
	fadd	%f1 %f1 %f2	# 1041 
	addi	%x7 %x7 8	# 1041 
	lw	%f2 0(%x7)	# 1041 
	lw	%x7 16(%x8)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f3 0(%x7)	# 231 
	fmul	%f2 %f2 %f3	# 1041 
	fadd	%f1 %f1 %f2	# 1041 
	lw	%f2 52(%x29)	# 1043 
	fle	%x5 %f1 %f2	# 1043 
	bne	%x5 %x0 fle.20765	# 1043 
	lw	%f2 48(%x29)	# 1045 
	fdiv	%f2 %f2 %f1	# 1045 
	addi	%x7 %x6 0	# 1045 
	sw	%f2 0(%x7)	# 1045 
	lw	%f2 48(%x29)	# 1047 
	lw	%x7 16(%x8)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f3 0(%x7)	# 211 
	fdiv	%f3 %f3 %f1	# 1047 
	fmul	%f2 %f2 %f3	# 1047 
	addi	%x7 %x6 4	# 1047 
	sw	%f2 0(%x7)	# 1047 
	lw	%f2 48(%x29)	# 1048 
	lw	%x7 16(%x8)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f3 0(%x7)	# 221 
	fdiv	%f3 %f3 %f1	# 1048 
	fmul	%f2 %f2 %f3	# 1048 
	addi	%x7 %x6 8	# 1048 
	sw	%f2 0(%x7)	# 1048 
	lw	%f2 48(%x29)	# 1049 
	lw	%x7 16(%x8)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f3 0(%x7)	# 231 
	fdiv	%f1 %f3 %f1	# 1049 
	fmul	%f1 %f2 %f1	# 1049 
	addi	%x7 %x6 12	# 1049 
	sw	%f1 0(%x7)	# 1049 
	j	fle_cont.20766	# 1043 
fle.20765:	# 1043 
	lw	%f1 52(%x29)	# 1051 
	addi	%x7 %x6 0	# 1051 
	sw	%f1 0(%x7)	# 1051 
fle_cont.20766:	# 1043 
	jr	0(%x1)	# 1052 
setup_second_table.2973:	#- 22476
	addi	%x8 %x0 5	# 1058
	lw	%f1 52(%x29)	# 1058 
	sw	%x7 -0(%x2)	# 1058 
	sw	%x6 -4(%x2)	# 1058 
	add	%x6 %x0 %x8	# 1058 
	sw	%x1 -8(%x2)	# 1058 
	addi	%x2 %x2 -12	# 1058 
	jal	 %x1 min_caml_create_float_array	# 1058 
	addi	%x2 %x2 12	# 1058 
	lw	%x1 -8(%x2)	# 1058 
	lw	%x7 -4(%x2)	# 1060 
	addi	%x8 %x7 0	# 1060 
	lw	%f1 0(%x8)	# 1060 
	addi	%x8 %x7 4	# 1060 
	lw	%f2 0(%x8)	# 1060 
	addi	%x8 %x7 8	# 1060 
	lw	%f3 0(%x8)	# 1060 
	fmul	%f4 %f1 %f1	# 783 
	lw	%x8 -0(%x2)	# 206 
	lw	%x9 16(%x8)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f5 0(%x9)	# 211 
	fmul	%f4 %f4 %f5	# 783 
	fmul	%f5 %f2 %f2	# 783 
	lw	%x9 16(%x8)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f6 0(%x9)	# 221 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	fmul	%f5 %f3 %f3	# 783 
	lw	%x9 16(%x8)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f6 0(%x9)	# 231 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	lw	%x9 12(%x8)	# 197 
	bne	%x9 %x0 beq_else.20767	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f1 %f4 %x5	# 786 
	j	beq_cont.20768	# 785 
beq_else.20767:	# 785 
	fmul	%f5 %f2 %f3	# 789 
	lw	%x9 36(%x8)	# 326 
	addi	%x9 %x9 0	# 331 
	lw	%f6 0(%x9)	# 331 
	fmul	%f5 %f5 %f6	# 789 
	fadd	%f4 %f4 %f5	# 788 
	fmul	%f3 %f3 %f1	# 790 
	lw	%x9 36(%x8)	# 336 
	addi	%x9 %x9 4	# 341 
	lw	%f5 0(%x9)	# 341 
	fmul	%f3 %f3 %f5	# 790 
	fadd	%f3 %f4 %f3	# 788 
	fmul	%f1 %f1 %f2	# 791 
	lw	%x9 36(%x8)	# 346 
	addi	%x9 %x9 8	# 351 
	lw	%f2 0(%x9)	# 351 
	fmul	%f1 %f1 %f2	# 791 
	fadd	%f1 %f3 %f1	# 788 
beq_cont.20768:	# 785 
	lw	%f2 48(%x29)	# 1061 
	addi	%x9 %x7 0	# 1061 
	lw	%f3 0(%x9)	# 1061 
	lw	%x9 16(%x8)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f4 0(%x9)	# 211 
	fmul	%f3 %f3 %f4	# 1061 
	fmul	%f2 %f2 %f3	# 1061 
	lw	%f3 48(%x29)	# 1062 
	addi	%x9 %x7 4	# 1062 
	lw	%f4 0(%x9)	# 1062 
	lw	%x9 16(%x8)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f5 0(%x9)	# 221 
	fmul	%f4 %f4 %f5	# 1062 
	fmul	%f3 %f3 %f4	# 1062 
	lw	%f4 48(%x29)	# 1063 
	addi	%x9 %x7 8	# 1063 
	lw	%f5 0(%x9)	# 1063 
	lw	%x9 16(%x8)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f6 0(%x9)	# 231 
	fmul	%f5 %f5 %f6	# 1063 
	fmul	%f4 %f4 %f5	# 1063 
	addi	%x9 %x6 0	# 1065 
	sw	%f1 0(%x9)	# 1065 
	lw	%x9 12(%x8)	# 197 
	bne	%x9 %x0 beq_else.20769	# 1069 
	addi	%x7 %x6 4	# 1074 
	sw	%f2 0(%x7)	# 1074 
	addi	%x7 %x6 8	# 1075 
	sw	%f3 0(%x7)	# 1075 
	addi	%x7 %x6 12	# 1076 
	sw	%f4 0(%x7)	# 1076 
	j	beq_cont.20770	# 1069 
beq_else.20769:	# 1069 
	addi	%x9 %x7 8	# 1070 
	lw	%f5 0(%x9)	# 1070 
	lw	%x9 36(%x8)	# 336 
	addi	%x9 %x9 4	# 341 
	lw	%f6 0(%x9)	# 341 
	fmul	%f5 %f5 %f6	# 1070 
	addi	%x9 %x7 4	# 1070 
	lw	%f6 0(%x9)	# 1070 
	lw	%x9 36(%x8)	# 346 
	addi	%x9 %x9 8	# 351 
	lw	%f7 0(%x9)	# 351 
	fmul	%f6 %f6 %f7	# 1070 
	fadd	%f5 %f5 %f6	# 1070 
	lw	%f6 4(%x29)	# 1070 
	fdiv	%f5 %f5 %f6	# 1070 
	fsub	%f2 %f2 %f5	# 1070 
	addi	%x9 %x6 4	# 1070 
	sw	%f2 0(%x9)	# 1070 
	addi	%x9 %x7 8	# 1071 
	lw	%f2 0(%x9)	# 1071 
	lw	%x9 36(%x8)	# 326 
	addi	%x9 %x9 0	# 331 
	lw	%f5 0(%x9)	# 331 
	fmul	%f2 %f2 %f5	# 1071 
	addi	%x9 %x7 0	# 1071 
	lw	%f5 0(%x9)	# 1071 
	lw	%x9 36(%x8)	# 346 
	addi	%x9 %x9 8	# 351 
	lw	%f6 0(%x9)	# 351 
	fmul	%f5 %f5 %f6	# 1071 
	fadd	%f2 %f2 %f5	# 1071 
	lw	%f5 4(%x29)	# 1071 
	fdiv	%f2 %f2 %f5	# 1071 
	fsub	%f2 %f3 %f2	# 1071 
	addi	%x9 %x6 8	# 1071 
	sw	%f2 0(%x9)	# 1071 
	addi	%x9 %x7 4	# 1072 
	lw	%f2 0(%x9)	# 1072 
	lw	%x9 36(%x8)	# 326 
	addi	%x9 %x9 0	# 331 
	lw	%f3 0(%x9)	# 331 
	fmul	%f2 %f2 %f3	# 1072 
	addi	%x7 %x7 0	# 1072 
	lw	%f3 0(%x7)	# 1072 
	lw	%x7 36(%x8)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f5 0(%x7)	# 341 
	fmul	%f3 %f3 %f5	# 1072 
	fadd	%f2 %f2 %f3	# 1072 
	lw	%f3 4(%x29)	# 1072 
	fdiv	%f2 %f2 %f3	# 1072 
	fsub	%f2 %f4 %f2	# 1072 
	addi	%x7 %x6 12	# 1072 
	sw	%f2 0(%x7)	# 1072 
beq_cont.20770:	# 1069 
	lw	%f2 52(%x29)	# 1078 
	fle	%x5 %f1 %f2	# 1078 
	fle	%x31 %f2 %f1	# 1078 
	and	%x5 %x5 %x31	# 1078 
	bne	%x5 %x0 feq.20771	# 1078 
	lw	%f2 16(%x29)	# 1079 
	fdiv	%f1 %f2 %f1	# 1079 
	addi	%x7 %x6 16	# 1079 
	sw	%f1 0(%x7)	# 1079 
	j	feq_cont.20772	# 1078 
feq.20771:	# 1078 
feq_cont.20772:	# 1078 
	jr	0(%x1)	# 1081 
iter_setup_dirvec_constants.2976:	#- 23108
	blt	%x7 %x0 bge_else.20773	# 1087 
	lui	%x8 2097456	# 1088
	addi	%x8 %x8 304	# 1088
	slli	%x9 %x7 2	# 1088 
	add	%x8 %x8 %x9	# 1088 
	lw	%x8 0(%x8)	# 1088 
	lw	%x9 4(%x6)	# 460 
	lw	%x10 0(%x6)	# 454 
	lw	%x11 4(%x8)	# 168 
	sw	%x6 -0(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.20774	# 1092 
	sw	%x9 -4(%x2)	# 1093 
	sw	%x7 -8(%x2)	# 1093 
	add	%x7 %x0 %x8	# 1093 
	add	%x6 %x0 %x10	# 1093 
	sw	%x1 -12(%x2)	# 1093 
	addi	%x2 %x2 -16	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 16	# 1093 
	lw	%x1 -12(%x2)	# 1093 
	lw	%x7 -8(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -4(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.20775	# 1092 
beq_else.20774:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.20776	# 1094 
	sw	%x9 -4(%x2)	# 1095 
	sw	%x7 -8(%x2)	# 1095 
	add	%x7 %x0 %x8	# 1095 
	add	%x6 %x0 %x10	# 1095 
	sw	%x1 -12(%x2)	# 1095 
	addi	%x2 %x2 -16	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 16	# 1095 
	lw	%x1 -12(%x2)	# 1095 
	lw	%x7 -8(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -4(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.20777	# 1094 
beq_else.20776:	# 1094 
	sw	%x9 -4(%x2)	# 1097 
	sw	%x7 -8(%x2)	# 1097 
	add	%x7 %x0 %x8	# 1097 
	add	%x6 %x0 %x10	# 1097 
	sw	%x1 -12(%x2)	# 1097 
	addi	%x2 %x2 -16	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 16	# 1097 
	lw	%x1 -12(%x2)	# 1097 
	lw	%x7 -8(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -4(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.20777:	# 1094 
beq_cont.20775:	# 1092 
	addi	%x6 %x7 -1	# 1099 
	blt	%x6 %x0 bge_else.20778	# 1087 
	lui	%x7 2097456	# 1088
	addi	%x7 %x7 304	# 1088
	slli	%x8 %x6 2	# 1088 
	add	%x7 %x7 %x8	# 1088 
	lw	%x7 0(%x7)	# 1088 
	lw	%x8 -0(%x2)	# 460 
	lw	%x9 4(%x8)	# 460 
	lw	%x10 0(%x8)	# 454 
	lw	%x11 4(%x7)	# 168 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.20779	# 1092 
	sw	%x9 -12(%x2)	# 1093 
	sw	%x6 -16(%x2)	# 1093 
	add	%x6 %x0 %x10	# 1093 
	sw	%x1 -20(%x2)	# 1093 
	addi	%x2 %x2 -24	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 24	# 1093 
	lw	%x1 -20(%x2)	# 1093 
	lw	%x7 -16(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -12(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.20780	# 1092 
beq_else.20779:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.20781	# 1094 
	sw	%x9 -12(%x2)	# 1095 
	sw	%x6 -16(%x2)	# 1095 
	add	%x6 %x0 %x10	# 1095 
	sw	%x1 -20(%x2)	# 1095 
	addi	%x2 %x2 -24	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 24	# 1095 
	lw	%x1 -20(%x2)	# 1095 
	lw	%x7 -16(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -12(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.20782	# 1094 
beq_else.20781:	# 1094 
	sw	%x9 -12(%x2)	# 1097 
	sw	%x6 -16(%x2)	# 1097 
	add	%x6 %x0 %x10	# 1097 
	sw	%x1 -20(%x2)	# 1097 
	addi	%x2 %x2 -24	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 24	# 1097 
	lw	%x1 -20(%x2)	# 1097 
	lw	%x7 -16(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -12(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.20782:	# 1094 
beq_cont.20780:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -0(%x2)	# 1099 
	j	iter_setup_dirvec_constants.2976	# 1099 
bge_else.20778:	# 1087 
	jr	0(%x1)	# 1100 
bge_else.20773:	# 1087 
	jr	0(%x1)	# 1100 
setup_startp_constants.2981:	#- 23584
	blt	%x7 %x0 bge_else.20785	# 1112 
	lui	%x8 2097456	# 1113
	addi	%x8 %x8 304	# 1113
	slli	%x9 %x7 2	# 1113 
	add	%x8 %x8 %x9	# 1113 
	lw	%x8 0(%x8)	# 1113 
	lw	%x9 40(%x8)	# 363 
	lw	%x10 4(%x8)	# 168 
	addi	%x11 %x6 0	# 1116 
	lw	%f1 0(%x11)	# 1116 
	lw	%x11 20(%x8)	# 246 
	addi	%x11 %x11 0	# 251 
	lw	%f2 0(%x11)	# 251 
	fsub	%f1 %f1 %f2	# 1116 
	addi	%x11 %x9 0	# 1116 
	sw	%f1 0(%x11)	# 1116 
	addi	%x11 %x6 4	# 1117 
	lw	%f1 0(%x11)	# 1117 
	lw	%x11 20(%x8)	# 256 
	addi	%x11 %x11 4	# 261 
	lw	%f2 0(%x11)	# 261 
	fsub	%f1 %f1 %f2	# 1117 
	addi	%x11 %x9 4	# 1117 
	sw	%f1 0(%x11)	# 1117 
	addi	%x11 %x6 8	# 1118 
	lw	%f1 0(%x11)	# 1118 
	lw	%x11 20(%x8)	# 266 
	addi	%x11 %x11 8	# 271 
	lw	%f2 0(%x11)	# 271 
	fsub	%f1 %f1 %f2	# 1118 
	addi	%x11 %x9 8	# 1118 
	sw	%f1 0(%x11)	# 1118 
	addi	%x5 %x0 2	# 1119 
	bne	%x10 %x5 beq_else.20786	# 1119 
	lw	%x8 16(%x8)	# 236 
	addi	%x10 %x9 0	# 1121 
	lw	%f1 0(%x10)	# 1121 
	addi	%x10 %x9 4	# 1121 
	lw	%f2 0(%x10)	# 1121 
	addi	%x10 %x9 8	# 1121 
	lw	%f3 0(%x10)	# 1121 
	addi	%x10 %x8 0	# 114 
	lw	%f4 0(%x10)	# 114 
	fmul	%f1 %f4 %f1	# 114 
	addi	%x10 %x8 4	# 114 
	lw	%f4 0(%x10)	# 114 
	fmul	%f2 %f4 %f2	# 114 
	fadd	%f1 %f1 %f2	# 114 
	addi	%x8 %x8 8	# 114 
	lw	%f2 0(%x8)	# 114 
	fmul	%f2 %f2 %f3	# 114 
	fadd	%f1 %f1 %f2	# 114 
	addi	%x8 %x9 12	# 1120 
	sw	%f1 0(%x8)	# 1120 
	j	beq_cont.20787	# 1119 
beq_else.20786:	# 1119 
	addi	%x5 %x0 2	# 1122 
	blt	%x5 %x10 blt.20788	# 1122 
	j	blt_cont.20789	# 1122 
blt.20788:	# 1122 
	addi	%x11 %x9 0	# 1123 
	lw	%f1 0(%x11)	# 1123 
	addi	%x11 %x9 4	# 1123 
	lw	%f2 0(%x11)	# 1123 
	addi	%x11 %x9 8	# 1123 
	lw	%f3 0(%x11)	# 1123 
	fmul	%f4 %f1 %f1	# 783 
	lw	%x11 16(%x8)	# 206 
	addi	%x11 %x11 0	# 211 
	lw	%f5 0(%x11)	# 211 
	fmul	%f4 %f4 %f5	# 783 
	fmul	%f5 %f2 %f2	# 783 
	lw	%x11 16(%x8)	# 216 
	addi	%x11 %x11 4	# 221 
	lw	%f6 0(%x11)	# 221 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	fmul	%f5 %f3 %f3	# 783 
	lw	%x11 16(%x8)	# 226 
	addi	%x11 %x11 8	# 231 
	lw	%f6 0(%x11)	# 231 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	lw	%x11 12(%x8)	# 197 
	bne	%x11 %x0 beq_else.20790	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f1 %f4 %x5	# 786 
	j	beq_cont.20791	# 785 
beq_else.20790:	# 785 
	fmul	%f5 %f2 %f3	# 789 
	lw	%x11 36(%x8)	# 326 
	addi	%x11 %x11 0	# 331 
	lw	%f6 0(%x11)	# 331 
	fmul	%f5 %f5 %f6	# 789 
	fadd	%f4 %f4 %f5	# 788 
	fmul	%f3 %f3 %f1	# 790 
	lw	%x11 36(%x8)	# 336 
	addi	%x11 %x11 4	# 341 
	lw	%f5 0(%x11)	# 341 
	fmul	%f3 %f3 %f5	# 790 
	fadd	%f3 %f4 %f3	# 788 
	fmul	%f1 %f1 %f2	# 791 
	lw	%x8 36(%x8)	# 346 
	addi	%x8 %x8 8	# 351 
	lw	%f2 0(%x8)	# 351 
	fmul	%f1 %f1 %f2	# 791 
	fadd	%f1 %f3 %f1	# 788 
beq_cont.20791:	# 785 
	addi	%x5 %x0 3	# 1124 
	bne	%x10 %x5 beq_else.20792	# 1124 
	lw	%f2 16(%x29)	# 1124 
	fsub	%f1 %f1 %f2	# 1124 
	j	beq_cont.20793	# 1124 
beq_else.20792:	# 1124 
beq_cont.20793:	# 1124 
	addi	%x8 %x9 12	# 1124 
	sw	%f1 0(%x8)	# 1124 
blt_cont.20789:	# 1122 
beq_cont.20787:	# 1119 
	addi	%x7 %x7 -1	# 1126 
	j	setup_startp_constants.2981	# 1126 
bge_else.20785:	# 1112 
	jr	0(%x1)	# 1127 
is_second_outside.2996:	#- 24040
	fmul	%f4 %f1 %f1	# 783 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f5 0(%x7)	# 211 
	fmul	%f4 %f4 %f5	# 783 
	fmul	%f5 %f2 %f2	# 783 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f6 0(%x7)	# 221 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	fmul	%f5 %f3 %f3	# 783 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f6 0(%x7)	# 231 
	fmul	%f5 %f5 %f6	# 783 
	fadd	%f4 %f4 %f5	# 783 
	lw	%x7 12(%x6)	# 197 
	bne	%x7 %x0 beq_else.20795	# 785 
	itof	%x5 %x0	# 786 
	fadd	%f1 %f4 %x5	# 786 
	j	beq_cont.20796	# 785 
beq_else.20795:	# 785 
	fmul	%f5 %f2 %f3	# 789 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f6 0(%x7)	# 331 
	fmul	%f5 %f5 %f6	# 789 
	fadd	%f4 %f4 %f5	# 788 
	fmul	%f3 %f3 %f1	# 790 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f5 0(%x7)	# 341 
	fmul	%f3 %f3 %f5	# 790 
	fadd	%f3 %f4 %f3	# 788 
	fmul	%f1 %f1 %f2	# 791 
	lw	%x7 36(%x6)	# 346 
	addi	%x7 %x7 8	# 351 
	lw	%f2 0(%x7)	# 351 
	fmul	%f1 %f1 %f2	# 791 
	fadd	%f1 %f3 %f1	# 788 
beq_cont.20796:	# 785 
	lw	%x7 4(%x6)	# 168 
	addi	%x5 %x0 3	# 1161 
	bne	%x7 %x5 beq_else.20797	# 1161 
	lw	%f2 16(%x29)	# 1161 
	fsub	%f1 %f1 %f2	# 1161 
	j	beq_cont.20798	# 1161 
beq_else.20797:	# 1161 
beq_cont.20798:	# 1161 
	lw	%x6 24(%x6)	# 188 
	lw	%f2 52(%x29)	# 1162 
	fle	%x5 %f2 %f1	# 1162 
	bne	%x5 %x0 fle.20799	# 1162 
	addi	%x7 %x0 1	# 1162
	j	fle_cont.20800	# 1162 
fle.20799:	# 1162 
	addi	%x7 %x0 0	# 1162
fle_cont.20800:	# 1162 
	bne	%x6 %x0 beq_else.20801	# 25 
	add	%x6 %x0 %x7	# 25 
	j	beq_cont.20802	# 25 
beq_else.20801:	# 25 
	bne	%x7 %x0 beq_else.20803	# 25 
	addi	%x6 %x0 1	# 25
	j	beq_cont.20804	# 25 
beq_else.20803:	# 25 
	addi	%x6 %x0 0	# 25
beq_cont.20804:	# 25 
beq_cont.20802:	# 25 
	bne	%x6 %x0 beq_else.20805	# 1162 
	addi	%x6 %x0 1	# 1162
	jr	0(%x1)	# 1162 
beq_else.20805:	# 1162 
	addi	%x6 %x0 0	# 1162
	jr	0(%x1)	# 1162 
is_outside.3001:	#- 24300
	lw	%x7 20(%x6)	# 246 
	addi	%x7 %x7 0	# 251 
	lw	%f4 0(%x7)	# 251 
	fsub	%f1 %f1 %f4	# 1167 
	lw	%x7 20(%x6)	# 256 
	addi	%x7 %x7 4	# 261 
	lw	%f4 0(%x7)	# 261 
	fsub	%f2 %f2 %f4	# 1168 
	lw	%x7 20(%x6)	# 266 
	addi	%x7 %x7 8	# 271 
	lw	%f4 0(%x7)	# 271 
	fsub	%f3 %f3 %f4	# 1169 
	lw	%x7 4(%x6)	# 168 
	addi	%x5 %x0 1	# 1171 
	bne	%x7 %x5 beq_else.20806	# 1171 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f4 0(%x7)	# 211 
	lw	%f5 52(%x29)	# 1144 
	fle	%x5 %f1 %f5	# 1144 
	bne	%x5 %x0 fle.20807	# 1144 
	j	fle_cont.20808	# 1144 
fle.20807:	# 1144 
	lw	%f5 48(%x29)	# 1144 
	fmul	%f1 %f5 %f1	# 1144 
fle_cont.20808:	# 1144 
	fle	%x5 %f4 %f1	# 1144 
	bne	%x5 %x0 fle.20809	# 1144 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f1 0(%x7)	# 221 
	lw	%f4 52(%x29)	# 1145 
	fle	%x5 %f2 %f4	# 1145 
	bne	%x5 %x0 fle.20811	# 1145 
	j	fle_cont.20812	# 1145 
fle.20811:	# 1145 
	lw	%f4 48(%x29)	# 1145 
	fmul	%f2 %f4 %f2	# 1145 
fle_cont.20812:	# 1145 
	fle	%x5 %f1 %f2	# 1145 
	bne	%x5 %x0 fle.20813	# 1145 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f1 0(%x7)	# 231 
	lw	%f2 52(%x29)	# 1146 
	fle	%x5 %f3 %f2	# 1146 
	bne	%x5 %x0 fle.20815	# 1146 
	itof	%x5 %x0	# 1146 
	fadd	%f2 %f3 %x5	# 1146 
	j	fle_cont.20816	# 1146 
fle.20815:	# 1146 
	lw	%f2 48(%x29)	# 1146 
	fmul	%f2 %f2 %f3	# 1146 
fle_cont.20816:	# 1146 
	fle	%x5 %f1 %f2	# 1146 
	bne	%x5 %x0 fle.20817	# 1146 
	addi	%x7 %x0 1	# 1146
	j	fle_cont.20818	# 1146 
fle.20817:	# 1146 
	addi	%x7 %x0 0	# 1146
fle_cont.20818:	# 1146 
	j	fle_cont.20814	# 1145 
fle.20813:	# 1145 
	addi	%x7 %x0 0	# 1147
fle_cont.20814:	# 1145 
	j	fle_cont.20810	# 1144 
fle.20809:	# 1144 
	addi	%x7 %x0 0	# 1148
fle_cont.20810:	# 1144 
	bne	%x7 %x0 beq_else.20819	# 1143 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20820	# 1149 
	addi	%x6 %x0 1	# 1149
	jr	0(%x1)	# 1149 
beq_else.20820:	# 1149 
	addi	%x6 %x0 0	# 1149
	jr	0(%x1)	# 1149 
beq_else.20819:	# 1143 
	lw	%x6 24(%x6)	# 188 
	jr	0(%x1)	# 192 
beq_else.20806:	# 1171 
	addi	%x5 %x0 2	# 1173 
	bne	%x7 %x5 beq_else.20821	# 1173 
	lw	%x7 16(%x6)	# 236 
	addi	%x8 %x7 0	# 114 
	lw	%f4 0(%x8)	# 114 
	fmul	%f1 %f4 %f1	# 114 
	addi	%x8 %x7 4	# 114 
	lw	%f4 0(%x8)	# 114 
	fmul	%f2 %f4 %f2	# 114 
	fadd	%f1 %f1 %f2	# 114 
	addi	%x7 %x7 8	# 114 
	lw	%f2 0(%x7)	# 114 
	fmul	%f2 %f2 %f3	# 114 
	fadd	%f1 %f1 %f2	# 114 
	lw	%x6 24(%x6)	# 188 
	lw	%f2 52(%x29)	# 1155 
	fle	%x5 %f2 %f1	# 1155 
	bne	%x5 %x0 fle.20822	# 1155 
	addi	%x7 %x0 1	# 1155
	j	fle_cont.20823	# 1155 
fle.20822:	# 1155 
	addi	%x7 %x0 0	# 1155
fle_cont.20823:	# 1155 
	bne	%x6 %x0 beq_else.20824	# 25 
	add	%x6 %x0 %x7	# 25 
	j	beq_cont.20825	# 25 
beq_else.20824:	# 25 
	bne	%x7 %x0 beq_else.20826	# 25 
	addi	%x6 %x0 1	# 25
	j	beq_cont.20827	# 25 
beq_else.20826:	# 25 
	addi	%x6 %x0 0	# 25
beq_cont.20827:	# 25 
beq_cont.20825:	# 25 
	bne	%x6 %x0 beq_else.20828	# 1155 
	addi	%x6 %x0 1	# 1155
	jr	0(%x1)	# 1155 
beq_else.20828:	# 1155 
	addi	%x6 %x0 0	# 1155
	jr	0(%x1)	# 1155 
beq_else.20821:	# 1173 
	sw	%x6 -0(%x2)	# 1160 
	sw	%x1 -4(%x2)	# 1160 
	addi	%x2 %x2 -8	# 1160 
	jal	 %x1 quadratic.2904	# 1160 
	addi	%x2 %x2 8	# 1160 
	lw	%x1 -4(%x2)	# 1160 
	lw	%x6 -0(%x2)	# 168 
	lw	%x7 4(%x6)	# 168 
	addi	%x5 %x0 3	# 1161 
	bne	%x7 %x5 beq_else.20829	# 1161 
	lw	%f2 16(%x29)	# 1161 
	fsub	%f1 %f1 %f2	# 1161 
	j	beq_cont.20830	# 1161 
beq_else.20829:	# 1161 
beq_cont.20830:	# 1161 
	lw	%x6 24(%x6)	# 188 
	lw	%f2 52(%x29)	# 1162 
	fle	%x5 %f2 %f1	# 1162 
	bne	%x5 %x0 fle.20831	# 1162 
	addi	%x7 %x0 1	# 1162
	j	fle_cont.20832	# 1162 
fle.20831:	# 1162 
	addi	%x7 %x0 0	# 1162
fle_cont.20832:	# 1162 
	bne	%x6 %x0 beq_else.20833	# 25 
	add	%x6 %x0 %x7	# 25 
	j	beq_cont.20834	# 25 
beq_else.20833:	# 25 
	bne	%x7 %x0 beq_else.20835	# 25 
	addi	%x6 %x0 1	# 25
	j	beq_cont.20836	# 25 
beq_else.20835:	# 25 
	addi	%x6 %x0 0	# 25
beq_cont.20836:	# 25 
beq_cont.20834:	# 25 
	bne	%x6 %x0 beq_else.20837	# 1162 
	addi	%x6 %x0 1	# 1162
	jr	0(%x1)	# 1162 
beq_else.20837:	# 1162 
	addi	%x6 %x0 0	# 1162
	jr	0(%x1)	# 1162 
check_all_inside.3006:	#- 24824
	slli	%x8 %x6 2	# 1181 
	add	%x8 %x7 %x8	# 1181 
	lw	%x8 0(%x8)	# 1181 
	addi	%x5 %x0 -1	# 1182 
	bne	%x8 %x5 beq_else.20838	# 1182 
	addi	%x6 %x0 1	# 1183
	jr	0(%x1)	# 1183 
beq_else.20838:	# 1182 
	lui	%x9 2097456	# 1185
	addi	%x9 %x9 304	# 1185
	slli	%x8 %x8 2	# 1185 
	add	%x8 %x9 %x8	# 1185 
	lw	%x8 0(%x8)	# 1185 
	lw	%x9 20(%x8)	# 246 
	addi	%x9 %x9 0	# 251 
	lw	%f4 0(%x9)	# 251 
	fsub	%f4 %f1 %f4	# 1167 
	lw	%x9 20(%x8)	# 256 
	addi	%x9 %x9 4	# 261 
	lw	%f5 0(%x9)	# 261 
	fsub	%f5 %f2 %f5	# 1168 
	lw	%x9 20(%x8)	# 266 
	addi	%x9 %x9 8	# 271 
	lw	%f6 0(%x9)	# 271 
	fsub	%f6 %f3 %f6	# 1169 
	lw	%x9 4(%x8)	# 168 
	sw	%f3 -0(%x2)	# 1171 
	sw	%f2 -4(%x2)	# 1171 
	sw	%f1 -8(%x2)	# 1171 
	sw	%x7 -12(%x2)	# 1171 
	sw	%x6 -16(%x2)	# 1171 
	addi	%x5 %x0 1	# 1171 
	bne	%x9 %x5 beq_else.20839	# 1171 
	lw	%x9 16(%x8)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f7 0(%x9)	# 211 
	lw	%f8 52(%x29)	# 1144 
	fle	%x5 %f4 %f8	# 1144 
	bne	%x5 %x0 fle.20841	# 1144 
	j	fle_cont.20842	# 1144 
fle.20841:	# 1144 
	lw	%f8 48(%x29)	# 1144 
	fmul	%f4 %f8 %f4	# 1144 
fle_cont.20842:	# 1144 
	fle	%x5 %f7 %f4	# 1144 
	bne	%x5 %x0 fle.20843	# 1144 
	lw	%x9 16(%x8)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f4 0(%x9)	# 221 
	lw	%f7 52(%x29)	# 1145 
	fle	%x5 %f5 %f7	# 1145 
	bne	%x5 %x0 fle.20845	# 1145 
	j	fle_cont.20846	# 1145 
fle.20845:	# 1145 
	lw	%f7 48(%x29)	# 1145 
	fmul	%f5 %f7 %f5	# 1145 
fle_cont.20846:	# 1145 
	fle	%x5 %f4 %f5	# 1145 
	bne	%x5 %x0 fle.20847	# 1145 
	lw	%x9 16(%x8)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f4 0(%x9)	# 231 
	lw	%f5 52(%x29)	# 1146 
	fle	%x5 %f6 %f5	# 1146 
	bne	%x5 %x0 fle.20849	# 1146 
	itof	%x5 %x0	# 1146 
	fadd	%f5 %f6 %x5	# 1146 
	j	fle_cont.20850	# 1146 
fle.20849:	# 1146 
	lw	%f5 48(%x29)	# 1146 
	fmul	%f5 %f5 %f6	# 1146 
fle_cont.20850:	# 1146 
	fle	%x5 %f4 %f5	# 1146 
	bne	%x5 %x0 fle.20851	# 1146 
	addi	%x9 %x0 1	# 1146
	j	fle_cont.20852	# 1146 
fle.20851:	# 1146 
	addi	%x9 %x0 0	# 1146
fle_cont.20852:	# 1146 
	j	fle_cont.20848	# 1145 
fle.20847:	# 1145 
	addi	%x9 %x0 0	# 1147
fle_cont.20848:	# 1145 
	j	fle_cont.20844	# 1144 
fle.20843:	# 1144 
	addi	%x9 %x0 0	# 1148
fle_cont.20844:	# 1144 
	bne	%x9 %x0 beq_else.20853	# 1143 
	lw	%x8 24(%x8)	# 188 
	bne	%x8 %x0 beq_else.20855	# 1149 
	addi	%x6 %x0 1	# 1149
	j	beq_cont.20856	# 1149 
beq_else.20855:	# 1149 
	addi	%x6 %x0 0	# 1149
beq_cont.20856:	# 1149 
	j	beq_cont.20854	# 1143 
beq_else.20853:	# 1143 
	lw	%x8 24(%x8)	# 188 
	add	%x6 %x0 %x8	# 192 
beq_cont.20854:	# 1143 
	j	beq_cont.20840	# 1171 
beq_else.20839:	# 1171 
	addi	%x5 %x0 2	# 1173 
	bne	%x9 %x5 beq_else.20857	# 1173 
	lw	%x9 16(%x8)	# 236 
	addi	%x10 %x9 0	# 114 
	lw	%f7 0(%x10)	# 114 
	fmul	%f4 %f7 %f4	# 114 
	addi	%x10 %x9 4	# 114 
	lw	%f7 0(%x10)	# 114 
	fmul	%f5 %f7 %f5	# 114 
	fadd	%f4 %f4 %f5	# 114 
	addi	%x9 %x9 8	# 114 
	lw	%f5 0(%x9)	# 114 
	fmul	%f5 %f5 %f6	# 114 
	fadd	%f4 %f4 %f5	# 114 
	lw	%x8 24(%x8)	# 188 
	lw	%f5 52(%x29)	# 1155 
	fle	%x5 %f5 %f4	# 1155 
	bne	%x5 %x0 fle.20859	# 1155 
	addi	%x9 %x0 1	# 1155
	j	fle_cont.20860	# 1155 
fle.20859:	# 1155 
	addi	%x9 %x0 0	# 1155
fle_cont.20860:	# 1155 
	bne	%x8 %x0 beq_else.20861	# 25 
	add	%x8 %x0 %x9	# 25 
	j	beq_cont.20862	# 25 
beq_else.20861:	# 25 
	bne	%x9 %x0 beq_else.20863	# 25 
	addi	%x8 %x0 1	# 25
	j	beq_cont.20864	# 25 
beq_else.20863:	# 25 
	addi	%x8 %x0 0	# 25
beq_cont.20864:	# 25 
beq_cont.20862:	# 25 
	bne	%x8 %x0 beq_else.20865	# 1155 
	addi	%x6 %x0 1	# 1155
	j	beq_cont.20866	# 1155 
beq_else.20865:	# 1155 
	addi	%x6 %x0 0	# 1155
beq_cont.20866:	# 1155 
	j	beq_cont.20858	# 1173 
beq_else.20857:	# 1173 
	add	%x6 %x0 %x8	# 1176 
	fadd	%f3 %f0 %f6	# 1176 
	fadd	%f2 %f0 %f5	# 1176 
	fadd	%f1 %f0 %f4	# 1176 
	sw	%x1 -20(%x2)	# 1176 
	addi	%x2 %x2 -24	# 1176 
	jal	 %x1 is_second_outside.2996	# 1176 
	addi	%x2 %x2 24	# 1176 
	lw	%x1 -20(%x2)	# 1176 
beq_cont.20858:	# 1173 
beq_cont.20840:	# 1171 
	bne	%x6 %x0 beq_else.20867	# 1185 
	lw	%x6 -16(%x2)	# 1188 
	addi	%x6 %x6 1	# 1188 
	slli	%x7 %x6 2	# 1181 
	lw	%x8 -12(%x2)	# 1181 
	add	%x7 %x8 %x7	# 1181 
	lw	%x7 0(%x7)	# 1181 
	addi	%x5 %x0 -1	# 1182 
	bne	%x7 %x5 beq_else.20868	# 1182 
	addi	%x6 %x0 1	# 1183
	jr	0(%x1)	# 1183 
beq_else.20868:	# 1182 
	lui	%x9 2097456	# 1185
	addi	%x9 %x9 304	# 1185
	slli	%x7 %x7 2	# 1185 
	add	%x7 %x9 %x7	# 1185 
	lw	%x7 0(%x7)	# 1185 
	lw	%f1 -8(%x2)	# 1185 
	lw	%f2 -4(%x2)	# 1185 
	lw	%f3 -0(%x2)	# 1185 
	sw	%x6 -20(%x2)	# 1185 
	add	%x6 %x0 %x7	# 1185 
	sw	%x1 -24(%x2)	# 1185 
	addi	%x2 %x2 -28	# 1185 
	jal	 %x1 is_outside.3001	# 1185 
	addi	%x2 %x2 28	# 1185 
	lw	%x1 -24(%x2)	# 1185 
	bne	%x6 %x0 beq_else.20869	# 1185 
	lw	%x6 -20(%x2)	# 1188 
	addi	%x6 %x6 1	# 1188 
	lw	%f1 -8(%x2)	# 1188 
	lw	%f2 -4(%x2)	# 1188 
	lw	%f3 -0(%x2)	# 1188 
	lw	%x7 -12(%x2)	# 1188 
	j	check_all_inside.3006	# 1188 
beq_else.20869:	# 1185 
	addi	%x6 %x0 0	# 1186
	jr	0(%x1)	# 1186 
beq_else.20867:	# 1185 
	addi	%x6 %x0 0	# 1186
	jr	0(%x1)	# 1186 
shadow_check_and_group.3012:	#- 25480
	slli	%x8 %x6 2	# 1201 
	add	%x8 %x7 %x8	# 1201 
	lw	%x8 0(%x8)	# 1201 
	addi	%x5 %x0 -1	# 1201 
	bne	%x8 %x5 beq_else.20870	# 1201 
	addi	%x6 %x0 0	# 1202
	jr	0(%x1)	# 1202 
beq_else.20870:	# 1201 
	slli	%x8 %x6 2	# 1204 
	add	%x8 %x7 %x8	# 1204 
	lw	%x8 0(%x8)	# 1204 
	lui	%x9 2098388	# 1205
	addi	%x9 %x9 1236	# 1205
	lui	%x10 2097960	# 1205
	addi	%x10 %x10 808	# 1205
	lui	%x11 2097456	# 943
	addi	%x11 %x11 304	# 943
	slli	%x12 %x8 2	# 943 
	add	%x11 %x11 %x12	# 943 
	lw	%x11 0(%x11)	# 943 
	addi	%x12 %x10 0	# 944 
	lw	%f1 0(%x12)	# 944 
	lw	%x12 20(%x11)	# 246 
	addi	%x12 %x12 0	# 251 
	lw	%f2 0(%x12)	# 251 
	fsub	%f1 %f1 %f2	# 944 
	addi	%x12 %x10 4	# 945 
	lw	%f2 0(%x12)	# 945 
	lw	%x12 20(%x11)	# 256 
	addi	%x12 %x12 4	# 261 
	lw	%f3 0(%x12)	# 261 
	fsub	%f2 %f2 %f3	# 945 
	addi	%x10 %x10 8	# 946 
	lw	%f3 0(%x10)	# 946 
	lw	%x10 20(%x11)	# 266 
	addi	%x10 %x10 8	# 271 
	lw	%f4 0(%x10)	# 271 
	fsub	%f3 %f3 %f4	# 946 
	lw	%x10 4(%x9)	# 460 
	slli	%x12 %x8 2	# 948 
	add	%x10 %x10 %x12	# 948 
	lw	%x10 0(%x10)	# 948 
	lw	%x12 4(%x11)	# 168 
	sw	%x7 -0(%x2)	# 950 
	sw	%x6 -4(%x2)	# 950 
	sw	%x8 -8(%x2)	# 950 
	addi	%x5 %x0 1	# 950 
	bne	%x12 %x5 beq_else.20871	# 950 
	lw	%x9 0(%x9)	# 454 
	add	%x8 %x0 %x10	# 951 
	add	%x7 %x0 %x9	# 951 
	add	%x6 %x0 %x11	# 951 
	sw	%x1 -12(%x2)	# 951 
	addi	%x2 %x2 -16	# 951 
	jal	 %x1 solver_rect_fast.2927	# 951 
	addi	%x2 %x2 16	# 951 
	lw	%x1 -12(%x2)	# 951 
	j	beq_cont.20872	# 950 
beq_else.20871:	# 950 
	addi	%x5 %x0 2	# 952 
	bne	%x12 %x5 beq_else.20873	# 952 
	lw	%f4 52(%x29)	# 914 
	addi	%x9 %x10 0	# 914 
	lw	%f5 0(%x9)	# 914 
	fle	%x5 %f4 %f5	# 914 
	bne	%x5 %x0 fle.20875	# 914 
	addi	%x9 %x10 4	# 916 
	lw	%f4 0(%x9)	# 916 
	fmul	%f1 %f4 %f1	# 916 
	addi	%x9 %x10 8	# 916 
	lw	%f4 0(%x9)	# 916 
	fmul	%f2 %f4 %f2	# 916 
	fadd	%f1 %f1 %f2	# 916 
	addi	%x9 %x10 12	# 916 
	lw	%f2 0(%x9)	# 916 
	fmul	%f2 %f2 %f3	# 916 
	fadd	%f1 %f1 %f2	# 916 
	lui	%x9 2097948	# 915
	addi	%x9 %x9 796	# 915
	addi	%x9 %x9 0	# 915 
	sw	%f1 0(%x9)	# 915 
	addi	%x6 %x0 1	# 917
	j	fle_cont.20876	# 914 
fle.20875:	# 914 
	addi	%x6 %x0 0	# 918
fle_cont.20876:	# 914 
	j	beq_cont.20874	# 952 
beq_else.20873:	# 952 
	add	%x7 %x0 %x10	# 955 
	add	%x6 %x0 %x11	# 955 
	sw	%x1 -12(%x2)	# 955 
	addi	%x2 %x2 -16	# 955 
	jal	 %x1 solver_second_fast.2940	# 955 
	addi	%x2 %x2 16	# 955 
	lw	%x1 -12(%x2)	# 955 
beq_cont.20874:	# 952 
beq_cont.20872:	# 950 
	lui	%x7 2097948	# 1206
	addi	%x7 %x7 796	# 1206
	addi	%x7 %x7 0	# 1206 
	lw	%f1 0(%x7)	# 1206 
	bne	%x6 %x0 beq_else.20877	# 1207 
	addi	%x6 %x0 0	# 1207
	j	beq_cont.20878	# 1207 
beq_else.20877:	# 1207 
	lw	%f2 116(%x29)	# 1207 
	fle	%x5 %f2 %f1	# 1207 
	bne	%x5 %x0 fle.20879	# 1207 
	addi	%x6 %x0 1	# 1207
	j	fle_cont.20880	# 1207 
fle.20879:	# 1207 
	addi	%x6 %x0 0	# 1207
fle_cont.20880:	# 1207 
beq_cont.20878:	# 1207 
	bne	%x6 %x0 beq_else.20881	# 1207 
	lui	%x6 2097456	# 1223
	addi	%x6 %x6 304	# 1223
	lw	%x7 -8(%x2)	# 1223 
	slli	%x7 %x7 2	# 1223 
	add	%x6 %x6 %x7	# 1223 
	lw	%x6 0(%x6)	# 1223 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20882	# 1223 
	addi	%x6 %x0 0	# 1226
	jr	0(%x1)	# 1226 
beq_else.20882:	# 1223 
	lw	%x6 -4(%x2)	# 1224 
	addi	%x6 %x6 1	# 1224 
	lw	%x7 -0(%x2)	# 1224 
	j	shadow_check_and_group.3012	# 1224 
beq_else.20881:	# 1207 
	lw	%f2 120(%x29)	# 1210 
	fadd	%f1 %f1 %f2	# 1210 
	lui	%x6 2097720	# 1211
	addi	%x6 %x6 568	# 1211
	addi	%x6 %x6 0	# 1211 
	lw	%f2 0(%x6)	# 1211 
	fmul	%f2 %f2 %f1	# 1211 
	lui	%x6 2097960	# 1211
	addi	%x6 %x6 808	# 1211
	addi	%x6 %x6 0	# 1211 
	lw	%f3 0(%x6)	# 1211 
	fadd	%f2 %f2 %f3	# 1211 
	lui	%x6 2097720	# 1212
	addi	%x6 %x6 568	# 1212
	addi	%x6 %x6 4	# 1212 
	lw	%f3 0(%x6)	# 1212 
	fmul	%f3 %f3 %f1	# 1212 
	lui	%x6 2097960	# 1212
	addi	%x6 %x6 808	# 1212
	addi	%x6 %x6 4	# 1212 
	lw	%f4 0(%x6)	# 1212 
	fadd	%f3 %f3 %f4	# 1212 
	lui	%x6 2097720	# 1213
	addi	%x6 %x6 568	# 1213
	addi	%x6 %x6 8	# 1213 
	lw	%f4 0(%x6)	# 1213 
	fmul	%f1 %f4 %f1	# 1213 
	lui	%x6 2097960	# 1213
	addi	%x6 %x6 808	# 1213
	addi	%x6 %x6 8	# 1213 
	lw	%f4 0(%x6)	# 1213 
	fadd	%f1 %f1 %f4	# 1213 
	lw	%x7 -0(%x2)	# 1181 
	addi	%x6 %x7 0	# 1181 
	lw	%x6 0(%x6)	# 1181 
	addi	%x5 %x0 -1	# 1182 
	bne	%x6 %x5 beq_else.20883	# 1182 
	addi	%x6 %x0 1	# 1183
	j	beq_cont.20884	# 1182 
beq_else.20883:	# 1182 
	lui	%x8 2097456	# 1185
	addi	%x8 %x8 304	# 1185
	slli	%x6 %x6 2	# 1185 
	add	%x6 %x8 %x6	# 1185 
	lw	%x6 0(%x6)	# 1185 
	sw	%f1 -12(%x2)	# 1185 
	sw	%f3 -16(%x2)	# 1185 
	sw	%f2 -20(%x2)	# 1185 
	fadd	%x5 %f0 %f3	# 1185 
	fadd	%f3 %f0 %f1	# 1185 
	fadd	%f1 %f0 %f2	# 1185 
	fadd	%f2 %f0 %x5	# 1185 
	sw	%x1 -24(%x2)	# 1185 
	addi	%x2 %x2 -28	# 1185 
	jal	 %x1 is_outside.3001	# 1185 
	addi	%x2 %x2 28	# 1185 
	lw	%x1 -24(%x2)	# 1185 
	bne	%x6 %x0 beq_else.20885	# 1185 
	addi	%x6 %x0 1	# 1188
	lw	%f1 -20(%x2)	# 1188 
	lw	%f2 -16(%x2)	# 1188 
	lw	%f3 -12(%x2)	# 1188 
	lw	%x7 -0(%x2)	# 1188 
	sw	%x1 -24(%x2)	# 1188 
	addi	%x2 %x2 -28	# 1188 
	jal	 %x1 check_all_inside.3006	# 1188 
	addi	%x2 %x2 28	# 1188 
	lw	%x1 -24(%x2)	# 1188 
	j	beq_cont.20886	# 1185 
beq_else.20885:	# 1185 
	addi	%x6 %x0 0	# 1186
beq_cont.20886:	# 1185 
beq_cont.20884:	# 1182 
	bne	%x6 %x0 beq_else.20887	# 1214 
	lw	%x6 -4(%x2)	# 1217 
	addi	%x6 %x6 1	# 1217 
	lw	%x7 -0(%x2)	# 1217 
	j	shadow_check_and_group.3012	# 1217 
beq_else.20887:	# 1214 
	addi	%x6 %x0 1	# 1215
	jr	0(%x1)	# 1215 
shadow_check_one_or_group.3015:	#- 26256
	slli	%x8 %x6 2	# 1231 
	add	%x8 %x7 %x8	# 1231 
	lw	%x8 0(%x8)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x8 %x5 beq_else.20888	# 1232 
	addi	%x6 %x0 0	# 1233
	jr	0(%x1)	# 1233 
beq_else.20888:	# 1232 
	lui	%x9 2097740	# 1235
	addi	%x9 %x9 588	# 1235
	slli	%x8 %x8 2	# 1235 
	add	%x8 %x9 %x8	# 1235 
	lw	%x8 0(%x8)	# 1235 
	addi	%x9 %x0 0	# 1236
	sw	%x7 -0(%x2)	# 1236 
	sw	%x6 -4(%x2)	# 1236 
	add	%x7 %x0 %x8	# 1236 
	add	%x6 %x0 %x9	# 1236 
	sw	%x1 -8(%x2)	# 1236 
	addi	%x2 %x2 -12	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 12	# 1236 
	lw	%x1 -8(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20889	# 1237 
	lw	%x6 -4(%x2)	# 1240 
	addi	%x6 %x6 1	# 1240 
	slli	%x7 %x6 2	# 1231 
	lw	%x8 -0(%x2)	# 1231 
	add	%x7 %x8 %x7	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20890	# 1232 
	addi	%x6 %x0 0	# 1233
	jr	0(%x1)	# 1233 
beq_else.20890:	# 1232 
	lui	%x9 2097740	# 1235
	addi	%x9 %x9 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x9 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x9 %x0 0	# 1236
	sw	%x6 -8(%x2)	# 1236 
	add	%x6 %x0 %x9	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20891	# 1237 
	lw	%x6 -8(%x2)	# 1240 
	addi	%x6 %x6 1	# 1240 
	slli	%x7 %x6 2	# 1231 
	lw	%x8 -0(%x2)	# 1231 
	add	%x7 %x8 %x7	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20892	# 1232 
	addi	%x6 %x0 0	# 1233
	jr	0(%x1)	# 1233 
beq_else.20892:	# 1232 
	lui	%x9 2097740	# 1235
	addi	%x9 %x9 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x9 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x9 %x0 0	# 1236
	sw	%x6 -12(%x2)	# 1236 
	add	%x6 %x0 %x9	# 1236 
	sw	%x1 -16(%x2)	# 1236 
	addi	%x2 %x2 -20	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 20	# 1236 
	lw	%x1 -16(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20893	# 1237 
	lw	%x6 -12(%x2)	# 1240 
	addi	%x6 %x6 1	# 1240 
	slli	%x7 %x6 2	# 1231 
	lw	%x8 -0(%x2)	# 1231 
	add	%x7 %x8 %x7	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20894	# 1232 
	addi	%x6 %x0 0	# 1233
	jr	0(%x1)	# 1233 
beq_else.20894:	# 1232 
	lui	%x9 2097740	# 1235
	addi	%x9 %x9 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x9 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x9 %x0 0	# 1236
	sw	%x6 -16(%x2)	# 1236 
	add	%x6 %x0 %x9	# 1236 
	sw	%x1 -20(%x2)	# 1236 
	addi	%x2 %x2 -24	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 24	# 1236 
	lw	%x1 -20(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20895	# 1237 
	lw	%x6 -16(%x2)	# 1240 
	addi	%x6 %x6 1	# 1240 
	lw	%x7 -0(%x2)	# 1240 
	j	shadow_check_one_or_group.3015	# 1240 
beq_else.20895:	# 1237 
	addi	%x6 %x0 1	# 1238
	jr	0(%x1)	# 1238 
beq_else.20893:	# 1237 
	addi	%x6 %x0 1	# 1238
	jr	0(%x1)	# 1238 
beq_else.20891:	# 1237 
	addi	%x6 %x0 1	# 1238
	jr	0(%x1)	# 1238 
beq_else.20889:	# 1237 
	addi	%x6 %x0 1	# 1238
	jr	0(%x1)	# 1238 
shadow_check_one_or_matrix.3018:	#- 26684
	slli	%x8 %x6 2	# 1246 
	add	%x8 %x7 %x8	# 1246 
	lw	%x8 0(%x8)	# 1246 
	addi	%x9 %x8 0	# 1247 
	lw	%x9 0(%x9)	# 1247 
	addi	%x5 %x0 -1	# 1248 
	bne	%x9 %x5 beq_else.20896	# 1248 
	addi	%x6 %x0 0	# 1249
	jr	0(%x1)	# 1249 
beq_else.20896:	# 1248 
	sw	%x8 -0(%x2)	# 1252 
	sw	%x7 -4(%x2)	# 1252 
	sw	%x6 -8(%x2)	# 1252 
	addi	%x5 %x0 99	# 1252 
	bne	%x9 %x5 beq_else.20897	# 1252 
	addi	%x6 %x0 1	# 1253
	j	beq_cont.20898	# 1252 
beq_else.20897:	# 1252 
	lui	%x10 2098388	# 1255
	addi	%x10 %x10 1236	# 1255
	lui	%x11 2097960	# 1255
	addi	%x11 %x11 808	# 1255
	lui	%x12 2097456	# 943
	addi	%x12 %x12 304	# 943
	slli	%x13 %x9 2	# 943 
	add	%x12 %x12 %x13	# 943 
	lw	%x12 0(%x12)	# 943 
	addi	%x13 %x11 0	# 944 
	lw	%f1 0(%x13)	# 944 
	lw	%x13 20(%x12)	# 246 
	addi	%x13 %x13 0	# 251 
	lw	%f2 0(%x13)	# 251 
	fsub	%f1 %f1 %f2	# 944 
	addi	%x13 %x11 4	# 945 
	lw	%f2 0(%x13)	# 945 
	lw	%x13 20(%x12)	# 256 
	addi	%x13 %x13 4	# 261 
	lw	%f3 0(%x13)	# 261 
	fsub	%f2 %f2 %f3	# 945 
	addi	%x11 %x11 8	# 946 
	lw	%f3 0(%x11)	# 946 
	lw	%x11 20(%x12)	# 266 
	addi	%x11 %x11 8	# 271 
	lw	%f4 0(%x11)	# 271 
	fsub	%f3 %f3 %f4	# 946 
	lw	%x11 4(%x10)	# 460 
	slli	%x9 %x9 2	# 948 
	add	%x9 %x11 %x9	# 948 
	lw	%x9 0(%x9)	# 948 
	lw	%x11 4(%x12)	# 168 
	addi	%x5 %x0 1	# 950 
	bne	%x11 %x5 beq_else.20899	# 950 
	lw	%x10 0(%x10)	# 454 
	add	%x8 %x0 %x9	# 951 
	add	%x7 %x0 %x10	# 951 
	add	%x6 %x0 %x12	# 951 
	sw	%x1 -12(%x2)	# 951 
	addi	%x2 %x2 -16	# 951 
	jal	 %x1 solver_rect_fast.2927	# 951 
	addi	%x2 %x2 16	# 951 
	lw	%x1 -12(%x2)	# 951 
	j	beq_cont.20900	# 950 
beq_else.20899:	# 950 
	addi	%x5 %x0 2	# 952 
	bne	%x11 %x5 beq_else.20901	# 952 
	lw	%f4 52(%x29)	# 914 
	addi	%x10 %x9 0	# 914 
	lw	%f5 0(%x10)	# 914 
	fle	%x5 %f4 %f5	# 914 
	bne	%x5 %x0 fle.20903	# 914 
	addi	%x10 %x9 4	# 916 
	lw	%f4 0(%x10)	# 916 
	fmul	%f1 %f4 %f1	# 916 
	addi	%x10 %x9 8	# 916 
	lw	%f4 0(%x10)	# 916 
	fmul	%f2 %f4 %f2	# 916 
	fadd	%f1 %f1 %f2	# 916 
	addi	%x9 %x9 12	# 916 
	lw	%f2 0(%x9)	# 916 
	fmul	%f2 %f2 %f3	# 916 
	fadd	%f1 %f1 %f2	# 916 
	lui	%x9 2097948	# 915
	addi	%x9 %x9 796	# 915
	addi	%x9 %x9 0	# 915 
	sw	%f1 0(%x9)	# 915 
	addi	%x6 %x0 1	# 917
	j	fle_cont.20904	# 914 
fle.20903:	# 914 
	addi	%x6 %x0 0	# 918
fle_cont.20904:	# 914 
	j	beq_cont.20902	# 952 
beq_else.20901:	# 952 
	add	%x7 %x0 %x9	# 955 
	add	%x6 %x0 %x12	# 955 
	sw	%x1 -12(%x2)	# 955 
	addi	%x2 %x2 -16	# 955 
	jal	 %x1 solver_second_fast.2940	# 955 
	addi	%x2 %x2 16	# 955 
	lw	%x1 -12(%x2)	# 955 
beq_cont.20902:	# 952 
beq_cont.20900:	# 950 
	bne	%x6 %x0 beq_else.20905	# 1258 
	addi	%x6 %x0 0	# 1264
	j	beq_cont.20906	# 1258 
beq_else.20905:	# 1258 
	lw	%f1 124(%x29)	# 1259 
	lui	%x6 2097948	# 1259
	addi	%x6 %x6 796	# 1259
	addi	%x6 %x6 0	# 1259 
	lw	%f2 0(%x6)	# 1259 
	fle	%x5 %f1 %f2	# 1259 
	bne	%x5 %x0 fle.20907	# 1259 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 4	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20909	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20910	# 1232 
beq_else.20909:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20911	# 1237 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 8	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20913	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20914	# 1232 
beq_else.20913:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20915	# 1237 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 12	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20917	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20918	# 1232 
beq_else.20917:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20919	# 1237 
	addi	%x6 %x0 4	# 1240
	lw	%x7 -0(%x2)	# 1240 
	sw	%x1 -12(%x2)	# 1240 
	addi	%x2 %x2 -16	# 1240 
	jal	 %x1 shadow_check_one_or_group.3015	# 1240 
	addi	%x2 %x2 16	# 1240 
	lw	%x1 -12(%x2)	# 1240 
	j	beq_cont.20920	# 1237 
beq_else.20919:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20920:	# 1237 
beq_cont.20918:	# 1232 
	j	beq_cont.20916	# 1237 
beq_else.20915:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20916:	# 1237 
beq_cont.20914:	# 1232 
	j	beq_cont.20912	# 1237 
beq_else.20911:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20912:	# 1237 
beq_cont.20910:	# 1232 
	bne	%x6 %x0 beq_else.20921	# 1260 
	addi	%x6 %x0 0	# 1262
	j	beq_cont.20922	# 1260 
beq_else.20921:	# 1260 
	addi	%x6 %x0 1	# 1261
beq_cont.20922:	# 1260 
	j	fle_cont.20908	# 1259 
fle.20907:	# 1259 
	addi	%x6 %x0 0	# 1263
fle_cont.20908:	# 1259 
beq_cont.20906:	# 1258 
beq_cont.20898:	# 1252 
	bne	%x6 %x0 beq_else.20923	# 1251 
	lw	%x6 -8(%x2)	# 1271 
	addi	%x6 %x6 1	# 1271 
	lw	%x7 -4(%x2)	# 1271 
	j	shadow_check_one_or_matrix.3018	# 1271 
beq_else.20923:	# 1251 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 4	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20924	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20925	# 1232 
beq_else.20924:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20926	# 1237 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 8	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20928	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20929	# 1232 
beq_else.20928:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20930	# 1237 
	lw	%x6 -0(%x2)	# 1231 
	addi	%x7 %x6 12	# 1231 
	lw	%x7 0(%x7)	# 1231 
	addi	%x5 %x0 -1	# 1232 
	bne	%x7 %x5 beq_else.20932	# 1232 
	addi	%x6 %x0 0	# 1233
	j	beq_cont.20933	# 1232 
beq_else.20932:	# 1232 
	lui	%x8 2097740	# 1235
	addi	%x8 %x8 588	# 1235
	slli	%x7 %x7 2	# 1235 
	add	%x7 %x8 %x7	# 1235 
	lw	%x7 0(%x7)	# 1235 
	addi	%x8 %x0 0	# 1236
	add	%x6 %x0 %x8	# 1236 
	sw	%x1 -12(%x2)	# 1236 
	addi	%x2 %x2 -16	# 1236 
	jal	 %x1 shadow_check_and_group.3012	# 1236 
	addi	%x2 %x2 16	# 1236 
	lw	%x1 -12(%x2)	# 1236 
	bne	%x6 %x0 beq_else.20934	# 1237 
	addi	%x6 %x0 4	# 1240
	lw	%x7 -0(%x2)	# 1240 
	sw	%x1 -12(%x2)	# 1240 
	addi	%x2 %x2 -16	# 1240 
	jal	 %x1 shadow_check_one_or_group.3015	# 1240 
	addi	%x2 %x2 16	# 1240 
	lw	%x1 -12(%x2)	# 1240 
	j	beq_cont.20935	# 1237 
beq_else.20934:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20935:	# 1237 
beq_cont.20933:	# 1232 
	j	beq_cont.20931	# 1237 
beq_else.20930:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20931:	# 1237 
beq_cont.20929:	# 1232 
	j	beq_cont.20927	# 1237 
beq_else.20926:	# 1237 
	addi	%x6 %x0 1	# 1238
beq_cont.20927:	# 1237 
beq_cont.20925:	# 1232 
	bne	%x6 %x0 beq_else.20936	# 1266 
	lw	%x6 -8(%x2)	# 1269 
	addi	%x6 %x6 1	# 1269 
	lw	%x7 -4(%x2)	# 1269 
	j	shadow_check_one_or_matrix.3018	# 1269 
beq_else.20936:	# 1266 
	addi	%x6 %x0 1	# 1267
	jr	0(%x1)	# 1267 
solve_each_element.3021:	#- 27752
	slli	%x9 %x6 2	# 1282 
	add	%x9 %x7 %x9	# 1282 
	lw	%x9 0(%x9)	# 1282 
	addi	%x5 %x0 -1	# 1283 
	bne	%x9 %x5 beq_else.20937	# 1283 
	jr	0(%x1)	# 1283 
beq_else.20937:	# 1283 
	lui	%x10 2098044	# 1285
	addi	%x10 %x10 892	# 1285
	lui	%x11 2097456	# 849
	addi	%x11 %x11 304	# 849
	slli	%x12 %x9 2	# 849 
	add	%x11 %x11 %x12	# 849 
	lw	%x11 0(%x11)	# 849 
	addi	%x12 %x10 0	# 851 
	lw	%f1 0(%x12)	# 851 
	lw	%x12 20(%x11)	# 246 
	addi	%x12 %x12 0	# 251 
	lw	%f2 0(%x12)	# 251 
	fsub	%f1 %f1 %f2	# 851 
	addi	%x12 %x10 4	# 852 
	lw	%f2 0(%x12)	# 852 
	lw	%x12 20(%x11)	# 256 
	addi	%x12 %x12 4	# 261 
	lw	%f3 0(%x12)	# 261 
	fsub	%f2 %f2 %f3	# 852 
	addi	%x10 %x10 8	# 853 
	lw	%f3 0(%x10)	# 853 
	lw	%x10 20(%x11)	# 266 
	addi	%x10 %x10 8	# 271 
	lw	%f4 0(%x10)	# 271 
	fsub	%f3 %f3 %f4	# 853 
	lw	%x10 4(%x11)	# 168 
	sw	%x8 -0(%x2)	# 856 
	sw	%x7 -4(%x2)	# 856 
	sw	%x6 -8(%x2)	# 856 
	sw	%x9 -12(%x2)	# 856 
	addi	%x5 %x0 1	# 856 
	bne	%x10 %x5 beq_else.20939	# 856 
	addi	%x10 %x0 0	# 759
	addi	%x12 %x0 1	# 759
	addi	%x13 %x0 2	# 759
	sw	%f1 -16(%x2)	# 759 
	sw	%f3 -20(%x2)	# 759 
	sw	%f2 -24(%x2)	# 759 
	sw	%x11 -28(%x2)	# 759 
	add	%x9 %x0 %x12	# 759 
	add	%x7 %x0 %x8	# 759 
	add	%x6 %x0 %x11	# 759 
	add	%x8 %x0 %x10	# 759 
	add	%x10 %x0 %x13	# 759 
	sw	%x1 -32(%x2)	# 759 
	addi	%x2 %x2 -36	# 759 
	jal	 %x1 solver_rect_surface.2883	# 759 
	addi	%x2 %x2 36	# 759 
	lw	%x1 -32(%x2)	# 759 
	bne	%x6 %x0 beq_else.20941	# 759 
	addi	%x8 %x0 1	# 760
	addi	%x9 %x0 2	# 760
	addi	%x10 %x0 0	# 760
	lw	%f1 -24(%x2)	# 760 
	lw	%f2 -20(%x2)	# 760 
	lw	%f3 -16(%x2)	# 760 
	lw	%x6 -28(%x2)	# 760 
	lw	%x7 -0(%x2)	# 760 
	sw	%x1 -32(%x2)	# 760 
	addi	%x2 %x2 -36	# 760 
	jal	 %x1 solver_rect_surface.2883	# 760 
	addi	%x2 %x2 36	# 760 
	lw	%x1 -32(%x2)	# 760 
	bne	%x6 %x0 beq_else.20943	# 760 
	addi	%x8 %x0 2	# 761
	addi	%x9 %x0 0	# 761
	addi	%x10 %x0 1	# 761
	lw	%f1 -20(%x2)	# 761 
	lw	%f2 -16(%x2)	# 761 
	lw	%f3 -24(%x2)	# 761 
	lw	%x6 -28(%x2)	# 761 
	lw	%x7 -0(%x2)	# 761 
	sw	%x1 -32(%x2)	# 761 
	addi	%x2 %x2 -36	# 761 
	jal	 %x1 solver_rect_surface.2883	# 761 
	addi	%x2 %x2 36	# 761 
	lw	%x1 -32(%x2)	# 761 
	bne	%x6 %x0 beq_else.20945	# 761 
	addi	%x6 %x0 0	# 762
	j	beq_cont.20946	# 761 
beq_else.20945:	# 761 
	addi	%x6 %x0 3	# 761
beq_cont.20946:	# 761 
	j	beq_cont.20944	# 760 
beq_else.20943:	# 760 
	addi	%x6 %x0 2	# 760
beq_cont.20944:	# 760 
	j	beq_cont.20942	# 759 
beq_else.20941:	# 759 
	addi	%x6 %x0 1	# 759
beq_cont.20942:	# 759 
	j	beq_cont.20940	# 856 
beq_else.20939:	# 856 
	addi	%x5 %x0 2	# 857 
	bne	%x10 %x5 beq_else.20947	# 857 
	add	%x7 %x0 %x8	# 857 
	add	%x6 %x0 %x11	# 857 
	sw	%x1 -32(%x2)	# 857 
	addi	%x2 %x2 -36	# 857 
	jal	 %x1 solver_surface.2898	# 857 
	addi	%x2 %x2 36	# 857 
	lw	%x1 -32(%x2)	# 857 
	j	beq_cont.20948	# 857 
beq_else.20947:	# 857 
	add	%x7 %x0 %x8	# 858 
	add	%x6 %x0 %x11	# 858 
	sw	%x1 -32(%x2)	# 858 
	addi	%x2 %x2 -36	# 858 
	jal	 %x1 solver_second.2917	# 858 
	addi	%x2 %x2 36	# 858 
	lw	%x1 -32(%x2)	# 858 
beq_cont.20948:	# 857 
beq_cont.20940:	# 856 
	bne	%x6 %x0 beq_else.20949	# 1286 
	lui	%x6 2097456	# 1314
	addi	%x6 %x6 304	# 1314
	lw	%x7 -12(%x2)	# 1314 
	slli	%x7 %x7 2	# 1314 
	add	%x6 %x6 %x7	# 1314 
	lw	%x6 0(%x6)	# 1314 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.20950	# 1314 
	jr	0(%x1)	# 1316 
beq_else.20950:	# 1314 
	lw	%x6 -8(%x2)	# 1315 
	addi	%x6 %x6 1	# 1315 
	lw	%x7 -4(%x2)	# 1315 
	lw	%x8 -0(%x2)	# 1315 
	j	solve_each_element.3021	# 1315 
beq_else.20949:	# 1286 
	lui	%x7 2097948	# 1290
	addi	%x7 %x7 796	# 1290
	addi	%x7 %x7 0	# 1290 
	lw	%f1 0(%x7)	# 1290 
	lw	%f2 52(%x29)	# 1292 
	fle	%x5 %f1 %f2	# 1292 
	bne	%x5 %x0 fle.20952	# 1292 
	lui	%x7 2097956	# 1293
	addi	%x7 %x7 804	# 1293
	addi	%x7 %x7 0	# 1293 
	lw	%f2 0(%x7)	# 1293 
	fle	%x5 %f2 %f1	# 1293 
	bne	%x5 %x0 fle.20954	# 1293 
	lw	%f2 120(%x29)	# 1295 
	fadd	%f1 %f1 %f2	# 1295 
	lw	%x8 -0(%x2)	# 1296 
	addi	%x7 %x8 0	# 1296 
	lw	%f2 0(%x7)	# 1296 
	fmul	%f2 %f2 %f1	# 1296 
	lui	%x7 2098044	# 1296
	addi	%x7 %x7 892	# 1296
	addi	%x7 %x7 0	# 1296 
	lw	%f3 0(%x7)	# 1296 
	fadd	%f2 %f2 %f3	# 1296 
	addi	%x7 %x8 4	# 1297 
	lw	%f3 0(%x7)	# 1297 
	fmul	%f3 %f3 %f1	# 1297 
	lui	%x7 2098044	# 1297
	addi	%x7 %x7 892	# 1297
	addi	%x7 %x7 4	# 1297 
	lw	%f4 0(%x7)	# 1297 
	fadd	%f3 %f3 %f4	# 1297 
	addi	%x7 %x8 8	# 1298 
	lw	%f4 0(%x7)	# 1298 
	fmul	%f4 %f4 %f1	# 1298 
	lui	%x7 2098044	# 1298
	addi	%x7 %x7 892	# 1298
	addi	%x7 %x7 8	# 1298 
	lw	%f5 0(%x7)	# 1298 
	fadd	%f4 %f4 %f5	# 1298 
	lw	%x7 -4(%x2)	# 1181 
	addi	%x9 %x7 0	# 1181 
	lw	%x9 0(%x9)	# 1181 
	sw	%x6 -32(%x2)	# 1182 
	sw	%f4 -36(%x2)	# 1182 
	sw	%f3 -40(%x2)	# 1182 
	sw	%f2 -44(%x2)	# 1182 
	sw	%f1 -48(%x2)	# 1182 
	addi	%x5 %x0 -1	# 1182 
	bne	%x9 %x5 beq_else.20956	# 1182 
	addi	%x6 %x0 1	# 1183
	j	beq_cont.20957	# 1182 
beq_else.20956:	# 1182 
	lui	%x10 2097456	# 1185
	addi	%x10 %x10 304	# 1185
	slli	%x9 %x9 2	# 1185 
	add	%x9 %x10 %x9	# 1185 
	lw	%x9 0(%x9)	# 1185 
	add	%x6 %x0 %x9	# 1185 
	fadd	%f1 %f0 %f2	# 1185 
	fadd	%f2 %f0 %f3	# 1185 
	fadd	%f3 %f0 %f4	# 1185 
	sw	%x1 -52(%x2)	# 1185 
	addi	%x2 %x2 -56	# 1185 
	jal	 %x1 is_outside.3001	# 1185 
	addi	%x2 %x2 56	# 1185 
	lw	%x1 -52(%x2)	# 1185 
	bne	%x6 %x0 beq_else.20958	# 1185 
	addi	%x6 %x0 1	# 1188
	lw	%f1 -44(%x2)	# 1188 
	lw	%f2 -40(%x2)	# 1188 
	lw	%f3 -36(%x2)	# 1188 
	lw	%x7 -4(%x2)	# 1188 
	sw	%x1 -52(%x2)	# 1188 
	addi	%x2 %x2 -56	# 1188 
	jal	 %x1 check_all_inside.3006	# 1188 
	addi	%x2 %x2 56	# 1188 
	lw	%x1 -52(%x2)	# 1188 
	j	beq_cont.20959	# 1185 
beq_else.20958:	# 1185 
	addi	%x6 %x0 0	# 1186
beq_cont.20959:	# 1185 
beq_cont.20957:	# 1182 
	bne	%x6 %x0 beq_else.20960	# 1299 
	j	beq_cont.20961	# 1299 
beq_else.20960:	# 1299 
	lui	%x6 2097956	# 1301
	addi	%x6 %x6 804	# 1301
	addi	%x6 %x6 0	# 1301 
	lw	%f1 -48(%x2)	# 1301 
	sw	%f1 0(%x6)	# 1301 
	lui	%x6 2097960	# 1302
	addi	%x6 %x6 808	# 1302
	addi	%x7 %x6 0	# 61 
	lw	%f1 -44(%x2)	# 61 
	sw	%f1 0(%x7)	# 61 
	addi	%x7 %x6 4	# 62 
	lw	%f1 -40(%x2)	# 62 
	sw	%f1 0(%x7)	# 62 
	addi	%x6 %x6 8	# 63 
	lw	%f1 -36(%x2)	# 63 
	sw	%f1 0(%x6)	# 63 
	lui	%x6 2097972	# 1303
	addi	%x6 %x6 820	# 1303
	addi	%x6 %x6 0	# 1303 
	lw	%x7 -12(%x2)	# 1303 
	sw	%x7 0(%x6)	# 1303 
	lui	%x6 2097952	# 1304
	addi	%x6 %x6 800	# 1304
	addi	%x6 %x6 0	# 1304 
	lw	%x7 -32(%x2)	# 1304 
	sw	%x7 0(%x6)	# 1304 
beq_cont.20961:	# 1299 
	j	fle_cont.20955	# 1293 
fle.20954:	# 1293 
fle_cont.20955:	# 1293 
	j	fle_cont.20953	# 1292 
fle.20952:	# 1292 
fle_cont.20953:	# 1292 
	lw	%x6 -8(%x2)	# 1310 
	addi	%x6 %x6 1	# 1310 
	lw	%x7 -4(%x2)	# 1310 
	lw	%x8 -0(%x2)	# 1310 
	j	solve_each_element.3021	# 1310 
solve_one_or_network.3025:	#- 28704
	slli	%x9 %x6 2	# 1323 
	add	%x9 %x7 %x9	# 1323 
	lw	%x9 0(%x9)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x9 %x5 beq_else.20962	# 1324 
	jr	0(%x1)	# 1328 
beq_else.20962:	# 1324 
	lui	%x10 2097740	# 1325
	addi	%x10 %x10 588	# 1325
	slli	%x9 %x9 2	# 1325 
	add	%x9 %x10 %x9	# 1325 
	lw	%x9 0(%x9)	# 1325 
	addi	%x10 %x0 0	# 1326
	sw	%x8 -0(%x2)	# 1326 
	sw	%x7 -4(%x2)	# 1326 
	sw	%x6 -8(%x2)	# 1326 
	add	%x7 %x0 %x9	# 1326 
	add	%x6 %x0 %x10	# 1326 
	sw	%x1 -12(%x2)	# 1326 
	addi	%x2 %x2 -16	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 16	# 1326 
	lw	%x1 -12(%x2)	# 1326 
	lw	%x6 -8(%x2)	# 1327 
	addi	%x6 %x6 1	# 1327 
	slli	%x7 %x6 2	# 1323 
	lw	%x8 -4(%x2)	# 1323 
	add	%x7 %x8 %x7	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20964	# 1324 
	jr	0(%x1)	# 1328 
beq_else.20964:	# 1324 
	lui	%x9 2097740	# 1325
	addi	%x9 %x9 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x9 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x9 %x0 0	# 1326
	lw	%x10 -0(%x2)	# 1326 
	sw	%x6 -12(%x2)	# 1326 
	add	%x8 %x0 %x10	# 1326 
	add	%x6 %x0 %x9	# 1326 
	sw	%x1 -16(%x2)	# 1326 
	addi	%x2 %x2 -20	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 20	# 1326 
	lw	%x1 -16(%x2)	# 1326 
	lw	%x6 -12(%x2)	# 1327 
	addi	%x6 %x6 1	# 1327 
	slli	%x7 %x6 2	# 1323 
	lw	%x8 -4(%x2)	# 1323 
	add	%x7 %x8 %x7	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20966	# 1324 
	jr	0(%x1)	# 1328 
beq_else.20966:	# 1324 
	lui	%x9 2097740	# 1325
	addi	%x9 %x9 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x9 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x9 %x0 0	# 1326
	lw	%x10 -0(%x2)	# 1326 
	sw	%x6 -16(%x2)	# 1326 
	add	%x8 %x0 %x10	# 1326 
	add	%x6 %x0 %x9	# 1326 
	sw	%x1 -20(%x2)	# 1326 
	addi	%x2 %x2 -24	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 24	# 1326 
	lw	%x1 -20(%x2)	# 1326 
	lw	%x6 -16(%x2)	# 1327 
	addi	%x6 %x6 1	# 1327 
	slli	%x7 %x6 2	# 1323 
	lw	%x8 -4(%x2)	# 1323 
	add	%x7 %x8 %x7	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20968	# 1324 
	jr	0(%x1)	# 1328 
beq_else.20968:	# 1324 
	lui	%x9 2097740	# 1325
	addi	%x9 %x9 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x9 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x9 %x0 0	# 1326
	lw	%x10 -0(%x2)	# 1326 
	sw	%x6 -20(%x2)	# 1326 
	add	%x8 %x0 %x10	# 1326 
	add	%x6 %x0 %x9	# 1326 
	sw	%x1 -24(%x2)	# 1326 
	addi	%x2 %x2 -28	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 28	# 1326 
	lw	%x1 -24(%x2)	# 1326 
	lw	%x6 -20(%x2)	# 1327 
	addi	%x6 %x6 1	# 1327 
	lw	%x7 -4(%x2)	# 1327 
	lw	%x8 -0(%x2)	# 1327 
	j	solve_one_or_network.3025	# 1327 
trace_or_matrix.3029:	#- 29100
	slli	%x9 %x6 2	# 1333 
	add	%x9 %x7 %x9	# 1333 
	lw	%x9 0(%x9)	# 1333 
	addi	%x10 %x9 0	# 1334 
	lw	%x10 0(%x10)	# 1334 
	addi	%x5 %x0 -1	# 1335 
	bne	%x10 %x5 beq_else.20970	# 1335 
	jr	0(%x1)	# 1336 
beq_else.20970:	# 1335 
	sw	%x8 -0(%x2)	# 1338 
	sw	%x7 -4(%x2)	# 1338 
	sw	%x6 -8(%x2)	# 1338 
	addi	%x5 %x0 99	# 1338 
	bne	%x10 %x5 beq_else.20972	# 1338 
	addi	%x10 %x9 4	# 1323 
	lw	%x10 0(%x10)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x10 %x5 beq_else.20974	# 1324 
	j	beq_cont.20975	# 1324 
beq_else.20974:	# 1324 
	lui	%x11 2097740	# 1325
	addi	%x11 %x11 588	# 1325
	slli	%x10 %x10 2	# 1325 
	add	%x10 %x11 %x10	# 1325 
	lw	%x10 0(%x10)	# 1325 
	addi	%x11 %x0 0	# 1326
	sw	%x9 -12(%x2)	# 1326 
	add	%x7 %x0 %x10	# 1326 
	add	%x6 %x0 %x11	# 1326 
	sw	%x1 -16(%x2)	# 1326 
	addi	%x2 %x2 -20	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 20	# 1326 
	lw	%x1 -16(%x2)	# 1326 
	lw	%x6 -12(%x2)	# 1323 
	addi	%x7 %x6 8	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20976	# 1324 
	j	beq_cont.20977	# 1324 
beq_else.20976:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -16(%x2)	# 1326 
	addi	%x2 %x2 -20	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 20	# 1326 
	lw	%x1 -16(%x2)	# 1326 
	lw	%x6 -12(%x2)	# 1323 
	addi	%x7 %x6 12	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20978	# 1324 
	j	beq_cont.20979	# 1324 
beq_else.20978:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -16(%x2)	# 1326 
	addi	%x2 %x2 -20	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 20	# 1326 
	lw	%x1 -16(%x2)	# 1326 
	addi	%x6 %x0 4	# 1327
	lw	%x7 -12(%x2)	# 1327 
	lw	%x8 -0(%x2)	# 1327 
	sw	%x1 -16(%x2)	# 1327 
	addi	%x2 %x2 -20	# 1327 
	jal	 %x1 solve_one_or_network.3025	# 1327 
	addi	%x2 %x2 20	# 1327 
	lw	%x1 -16(%x2)	# 1327 
beq_cont.20979:	# 1324 
beq_cont.20977:	# 1324 
beq_cont.20975:	# 1324 
	j	beq_cont.20973	# 1338 
beq_else.20972:	# 1338 
	lui	%x11 2098044	# 1343
	addi	%x11 %x11 892	# 1343
	lui	%x12 2097456	# 849
	addi	%x12 %x12 304	# 849
	slli	%x10 %x10 2	# 849 
	add	%x10 %x12 %x10	# 849 
	lw	%x10 0(%x10)	# 849 
	addi	%x12 %x11 0	# 851 
	lw	%f1 0(%x12)	# 851 
	lw	%x12 20(%x10)	# 246 
	addi	%x12 %x12 0	# 251 
	lw	%f2 0(%x12)	# 251 
	fsub	%f1 %f1 %f2	# 851 
	addi	%x12 %x11 4	# 852 
	lw	%f2 0(%x12)	# 852 
	lw	%x12 20(%x10)	# 256 
	addi	%x12 %x12 4	# 261 
	lw	%f3 0(%x12)	# 261 
	fsub	%f2 %f2 %f3	# 852 
	addi	%x11 %x11 8	# 853 
	lw	%f3 0(%x11)	# 853 
	lw	%x11 20(%x10)	# 266 
	addi	%x11 %x11 8	# 271 
	lw	%f4 0(%x11)	# 271 
	fsub	%f3 %f3 %f4	# 853 
	lw	%x11 4(%x10)	# 168 
	sw	%x9 -12(%x2)	# 856 
	addi	%x5 %x0 1	# 856 
	bne	%x11 %x5 beq_else.20980	# 856 
	addi	%x11 %x0 0	# 759
	addi	%x12 %x0 1	# 759
	addi	%x13 %x0 2	# 759
	sw	%f1 -16(%x2)	# 759 
	sw	%f3 -20(%x2)	# 759 
	sw	%f2 -24(%x2)	# 759 
	sw	%x10 -28(%x2)	# 759 
	add	%x9 %x0 %x12	# 759 
	add	%x7 %x0 %x8	# 759 
	add	%x6 %x0 %x10	# 759 
	add	%x10 %x0 %x13	# 759 
	add	%x8 %x0 %x11	# 759 
	sw	%x1 -32(%x2)	# 759 
	addi	%x2 %x2 -36	# 759 
	jal	 %x1 solver_rect_surface.2883	# 759 
	addi	%x2 %x2 36	# 759 
	lw	%x1 -32(%x2)	# 759 
	bne	%x6 %x0 beq_else.20982	# 759 
	addi	%x8 %x0 1	# 760
	addi	%x9 %x0 2	# 760
	addi	%x10 %x0 0	# 760
	lw	%f1 -24(%x2)	# 760 
	lw	%f2 -20(%x2)	# 760 
	lw	%f3 -16(%x2)	# 760 
	lw	%x6 -28(%x2)	# 760 
	lw	%x7 -0(%x2)	# 760 
	sw	%x1 -32(%x2)	# 760 
	addi	%x2 %x2 -36	# 760 
	jal	 %x1 solver_rect_surface.2883	# 760 
	addi	%x2 %x2 36	# 760 
	lw	%x1 -32(%x2)	# 760 
	bne	%x6 %x0 beq_else.20984	# 760 
	addi	%x8 %x0 2	# 761
	addi	%x9 %x0 0	# 761
	addi	%x10 %x0 1	# 761
	lw	%f1 -20(%x2)	# 761 
	lw	%f2 -16(%x2)	# 761 
	lw	%f3 -24(%x2)	# 761 
	lw	%x6 -28(%x2)	# 761 
	lw	%x7 -0(%x2)	# 761 
	sw	%x1 -32(%x2)	# 761 
	addi	%x2 %x2 -36	# 761 
	jal	 %x1 solver_rect_surface.2883	# 761 
	addi	%x2 %x2 36	# 761 
	lw	%x1 -32(%x2)	# 761 
	bne	%x6 %x0 beq_else.20986	# 761 
	addi	%x6 %x0 0	# 762
	j	beq_cont.20987	# 761 
beq_else.20986:	# 761 
	addi	%x6 %x0 3	# 761
beq_cont.20987:	# 761 
	j	beq_cont.20985	# 760 
beq_else.20984:	# 760 
	addi	%x6 %x0 2	# 760
beq_cont.20985:	# 760 
	j	beq_cont.20983	# 759 
beq_else.20982:	# 759 
	addi	%x6 %x0 1	# 759
beq_cont.20983:	# 759 
	j	beq_cont.20981	# 856 
beq_else.20980:	# 856 
	addi	%x5 %x0 2	# 857 
	bne	%x11 %x5 beq_else.20988	# 857 
	add	%x7 %x0 %x8	# 857 
	add	%x6 %x0 %x10	# 857 
	sw	%x1 -32(%x2)	# 857 
	addi	%x2 %x2 -36	# 857 
	jal	 %x1 solver_surface.2898	# 857 
	addi	%x2 %x2 36	# 857 
	lw	%x1 -32(%x2)	# 857 
	j	beq_cont.20989	# 857 
beq_else.20988:	# 857 
	add	%x7 %x0 %x8	# 858 
	add	%x6 %x0 %x10	# 858 
	sw	%x1 -32(%x2)	# 858 
	addi	%x2 %x2 -36	# 858 
	jal	 %x1 solver_second.2917	# 858 
	addi	%x2 %x2 36	# 858 
	lw	%x1 -32(%x2)	# 858 
beq_cont.20989:	# 857 
beq_cont.20981:	# 856 
	bne	%x6 %x0 beq_else.20990	# 1344 
	j	beq_cont.20991	# 1344 
beq_else.20990:	# 1344 
	lui	%x6 2097948	# 1345
	addi	%x6 %x6 796	# 1345
	addi	%x6 %x6 0	# 1345 
	lw	%f1 0(%x6)	# 1345 
	lui	%x6 2097956	# 1346
	addi	%x6 %x6 804	# 1346
	addi	%x6 %x6 0	# 1346 
	lw	%f2 0(%x6)	# 1346 
	fle	%x5 %f2 %f1	# 1346 
	bne	%x5 %x0 fle.20992	# 1346 
	lw	%x6 -12(%x2)	# 1323 
	addi	%x7 %x6 4	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20994	# 1324 
	j	beq_cont.20995	# 1324 
beq_else.20994:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -32(%x2)	# 1326 
	addi	%x2 %x2 -36	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 36	# 1326 
	lw	%x1 -32(%x2)	# 1326 
	lw	%x6 -12(%x2)	# 1323 
	addi	%x7 %x6 8	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20996	# 1324 
	j	beq_cont.20997	# 1324 
beq_else.20996:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -32(%x2)	# 1326 
	addi	%x2 %x2 -36	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 36	# 1326 
	lw	%x1 -32(%x2)	# 1326 
	lw	%x6 -12(%x2)	# 1323 
	addi	%x7 %x6 12	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.20998	# 1324 
	j	beq_cont.20999	# 1324 
beq_else.20998:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -32(%x2)	# 1326 
	addi	%x2 %x2 -36	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 36	# 1326 
	lw	%x1 -32(%x2)	# 1326 
	addi	%x6 %x0 4	# 1327
	lw	%x7 -12(%x2)	# 1327 
	lw	%x8 -0(%x2)	# 1327 
	sw	%x1 -32(%x2)	# 1327 
	addi	%x2 %x2 -36	# 1327 
	jal	 %x1 solve_one_or_network.3025	# 1327 
	addi	%x2 %x2 36	# 1327 
	lw	%x1 -32(%x2)	# 1327 
beq_cont.20999:	# 1324 
beq_cont.20997:	# 1324 
beq_cont.20995:	# 1324 
	j	fle_cont.20993	# 1346 
fle.20992:	# 1346 
fle_cont.20993:	# 1346 
beq_cont.20991:	# 1344 
beq_cont.20973:	# 1338 
	lw	%x6 -8(%x2)	# 1351 
	addi	%x6 %x6 1	# 1351 
	slli	%x7 %x6 2	# 1333 
	lw	%x8 -4(%x2)	# 1333 
	add	%x7 %x8 %x7	# 1333 
	lw	%x7 0(%x7)	# 1333 
	addi	%x9 %x7 0	# 1334 
	lw	%x9 0(%x9)	# 1334 
	addi	%x5 %x0 -1	# 1335 
	bne	%x9 %x5 beq_else.21000	# 1335 
	jr	0(%x1)	# 1336 
beq_else.21000:	# 1335 
	sw	%x6 -32(%x2)	# 1338 
	addi	%x5 %x0 99	# 1338 
	bne	%x9 %x5 beq_else.21002	# 1338 
	addi	%x9 %x7 4	# 1323 
	lw	%x9 0(%x9)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x9 %x5 beq_else.21004	# 1324 
	j	beq_cont.21005	# 1324 
beq_else.21004:	# 1324 
	lui	%x10 2097740	# 1325
	addi	%x10 %x10 588	# 1325
	slli	%x9 %x9 2	# 1325 
	add	%x9 %x10 %x9	# 1325 
	lw	%x9 0(%x9)	# 1325 
	addi	%x10 %x0 0	# 1326
	lw	%x11 -0(%x2)	# 1326 
	sw	%x7 -36(%x2)	# 1326 
	add	%x8 %x0 %x11	# 1326 
	add	%x7 %x0 %x9	# 1326 
	add	%x6 %x0 %x10	# 1326 
	sw	%x1 -40(%x2)	# 1326 
	addi	%x2 %x2 -44	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 44	# 1326 
	lw	%x1 -40(%x2)	# 1326 
	lw	%x6 -36(%x2)	# 1323 
	addi	%x7 %x6 8	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.21006	# 1324 
	j	beq_cont.21007	# 1324 
beq_else.21006:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -40(%x2)	# 1326 
	addi	%x2 %x2 -44	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 44	# 1326 
	lw	%x1 -40(%x2)	# 1326 
	addi	%x6 %x0 3	# 1327
	lw	%x7 -36(%x2)	# 1327 
	lw	%x8 -0(%x2)	# 1327 
	sw	%x1 -40(%x2)	# 1327 
	addi	%x2 %x2 -44	# 1327 
	jal	 %x1 solve_one_or_network.3025	# 1327 
	addi	%x2 %x2 44	# 1327 
	lw	%x1 -40(%x2)	# 1327 
beq_cont.21007:	# 1324 
beq_cont.21005:	# 1324 
	j	beq_cont.21003	# 1338 
beq_else.21002:	# 1338 
	lui	%x10 2098044	# 1343
	addi	%x10 %x10 892	# 1343
	lw	%x11 -0(%x2)	# 1343 
	sw	%x7 -36(%x2)	# 1343 
	add	%x8 %x0 %x10	# 1343 
	add	%x7 %x0 %x11	# 1343 
	add	%x6 %x0 %x9	# 1343 
	sw	%x1 -40(%x2)	# 1343 
	addi	%x2 %x2 -44	# 1343 
	jal	 %x1 solver.2923	# 1343 
	addi	%x2 %x2 44	# 1343 
	lw	%x1 -40(%x2)	# 1343 
	bne	%x6 %x0 beq_else.21008	# 1344 
	j	beq_cont.21009	# 1344 
beq_else.21008:	# 1344 
	lui	%x6 2097948	# 1345
	addi	%x6 %x6 796	# 1345
	addi	%x6 %x6 0	# 1345 
	lw	%f1 0(%x6)	# 1345 
	lui	%x6 2097956	# 1346
	addi	%x6 %x6 804	# 1346
	addi	%x6 %x6 0	# 1346 
	lw	%f2 0(%x6)	# 1346 
	fle	%x5 %f2 %f1	# 1346 
	bne	%x5 %x0 fle.21010	# 1346 
	lw	%x6 -36(%x2)	# 1323 
	addi	%x7 %x6 4	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.21012	# 1324 
	j	beq_cont.21013	# 1324 
beq_else.21012:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -40(%x2)	# 1326 
	addi	%x2 %x2 -44	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 44	# 1326 
	lw	%x1 -40(%x2)	# 1326 
	lw	%x6 -36(%x2)	# 1323 
	addi	%x7 %x6 8	# 1323 
	lw	%x7 0(%x7)	# 1323 
	addi	%x5 %x0 -1	# 1324 
	bne	%x7 %x5 beq_else.21014	# 1324 
	j	beq_cont.21015	# 1324 
beq_else.21014:	# 1324 
	lui	%x8 2097740	# 1325
	addi	%x8 %x8 588	# 1325
	slli	%x7 %x7 2	# 1325 
	add	%x7 %x8 %x7	# 1325 
	lw	%x7 0(%x7)	# 1325 
	addi	%x8 %x0 0	# 1326
	lw	%x9 -0(%x2)	# 1326 
	add	%x6 %x0 %x8	# 1326 
	add	%x8 %x0 %x9	# 1326 
	sw	%x1 -40(%x2)	# 1326 
	addi	%x2 %x2 -44	# 1326 
	jal	 %x1 solve_each_element.3021	# 1326 
	addi	%x2 %x2 44	# 1326 
	lw	%x1 -40(%x2)	# 1326 
	addi	%x6 %x0 3	# 1327
	lw	%x7 -36(%x2)	# 1327 
	lw	%x8 -0(%x2)	# 1327 
	sw	%x1 -40(%x2)	# 1327 
	addi	%x2 %x2 -44	# 1327 
	jal	 %x1 solve_one_or_network.3025	# 1327 
	addi	%x2 %x2 44	# 1327 
	lw	%x1 -40(%x2)	# 1327 
beq_cont.21015:	# 1324 
beq_cont.21013:	# 1324 
	j	fle_cont.21011	# 1346 
fle.21010:	# 1346 
fle_cont.21011:	# 1346 
beq_cont.21009:	# 1344 
beq_cont.21003:	# 1338 
	lw	%x6 -32(%x2)	# 1351 
	addi	%x6 %x6 1	# 1351 
	lw	%x7 -4(%x2)	# 1351 
	lw	%x8 -0(%x2)	# 1351 
	j	trace_or_matrix.3029	# 1351 
solve_each_element_fast.3035:	#- 30716
	lw	%x9 0(%x8)	# 454 
	slli	%x10 %x6 2	# 1376 
	add	%x10 %x7 %x10	# 1376 
	lw	%x10 0(%x10)	# 1376 
	addi	%x5 %x0 -1	# 1377 
	bne	%x10 %x5 beq_else.21016	# 1377 
	jr	0(%x1)	# 1377 
beq_else.21016:	# 1377 
	lui	%x11 2097456	# 990
	addi	%x11 %x11 304	# 990
	slli	%x12 %x10 2	# 990 
	add	%x11 %x11 %x12	# 990 
	lw	%x11 0(%x11)	# 990 
	lw	%x12 40(%x11)	# 363 
	addi	%x13 %x12 0	# 992 
	lw	%f1 0(%x13)	# 992 
	addi	%x13 %x12 4	# 993 
	lw	%f2 0(%x13)	# 993 
	addi	%x13 %x12 8	# 994 
	lw	%f3 0(%x13)	# 994 
	lw	%x13 4(%x8)	# 460 
	slli	%x14 %x10 2	# 996 
	add	%x13 %x13 %x14	# 996 
	lw	%x13 0(%x13)	# 996 
	lw	%x14 4(%x11)	# 168 
	sw	%x9 -0(%x2)	# 998 
	sw	%x8 -4(%x2)	# 998 
	sw	%x7 -8(%x2)	# 998 
	sw	%x6 -12(%x2)	# 998 
	sw	%x10 -16(%x2)	# 998 
	addi	%x5 %x0 1	# 998 
	bne	%x14 %x5 beq_else.21018	# 998 
	lw	%x12 0(%x8)	# 454 
	add	%x8 %x0 %x13	# 999 
	add	%x7 %x0 %x12	# 999 
	add	%x6 %x0 %x11	# 999 
	sw	%x1 -20(%x2)	# 999 
	addi	%x2 %x2 -24	# 999 
	jal	 %x1 solver_rect_fast.2927	# 999 
	addi	%x2 %x2 24	# 999 
	lw	%x1 -20(%x2)	# 999 
	j	beq_cont.21019	# 998 
beq_else.21018:	# 998 
	addi	%x5 %x0 2	# 1000 
	bne	%x14 %x5 beq_else.21020	# 1000 
	lw	%f1 52(%x29)	# 963 
	addi	%x11 %x13 0	# 963 
	lw	%f2 0(%x11)	# 963 
	fle	%x5 %f1 %f2	# 963 
	bne	%x5 %x0 fle.21022	# 963 
	addi	%x11 %x13 0	# 964 
	lw	%f1 0(%x11)	# 964 
	addi	%x11 %x12 12	# 964 
	lw	%f2 0(%x11)	# 964 
	fmul	%f1 %f1 %f2	# 964 
	lui	%x11 2097948	# 964
	addi	%x11 %x11 796	# 964
	addi	%x11 %x11 0	# 964 
	sw	%f1 0(%x11)	# 964 
	addi	%x6 %x0 1	# 965
	j	fle_cont.21023	# 963 
fle.21022:	# 963 
	addi	%x6 %x0 0	# 966
fle_cont.21023:	# 963 
	j	beq_cont.21021	# 1000 
beq_else.21020:	# 1000 
	add	%x8 %x0 %x12	# 1003 
	add	%x7 %x0 %x13	# 1003 
	add	%x6 %x0 %x11	# 1003 
	sw	%x1 -20(%x2)	# 1003 
	addi	%x2 %x2 -24	# 1003 
	jal	 %x1 solver_second_fast2.2957	# 1003 
	addi	%x2 %x2 24	# 1003 
	lw	%x1 -20(%x2)	# 1003 
beq_cont.21021:	# 1000 
beq_cont.21019:	# 998 
	bne	%x6 %x0 beq_else.21024	# 1380 
	lui	%x6 2097456	# 1408
	addi	%x6 %x6 304	# 1408
	lw	%x7 -16(%x2)	# 1408 
	slli	%x7 %x7 2	# 1408 
	add	%x6 %x6 %x7	# 1408 
	lw	%x6 0(%x6)	# 1408 
	lw	%x6 24(%x6)	# 188 
	bne	%x6 %x0 beq_else.21025	# 1408 
	jr	0(%x1)	# 1410 
beq_else.21025:	# 1408 
	lw	%x6 -12(%x2)	# 1409 
	addi	%x6 %x6 1	# 1409 
	lw	%x7 -8(%x2)	# 1409 
	lw	%x8 -4(%x2)	# 1409 
	j	solve_each_element_fast.3035	# 1409 
beq_else.21024:	# 1380 
	lui	%x7 2097948	# 1384
	addi	%x7 %x7 796	# 1384
	addi	%x7 %x7 0	# 1384 
	lw	%f1 0(%x7)	# 1384 
	lw	%f2 52(%x29)	# 1386 
	fle	%x5 %f1 %f2	# 1386 
	bne	%x5 %x0 fle.21027	# 1386 
	lui	%x7 2097956	# 1387
	addi	%x7 %x7 804	# 1387
	addi	%x7 %x7 0	# 1387 
	lw	%f2 0(%x7)	# 1387 
	fle	%x5 %f2 %f1	# 1387 
	bne	%x5 %x0 fle.21029	# 1387 
	lw	%f2 120(%x29)	# 1389 
	fadd	%f1 %f1 %f2	# 1389 
	lw	%x7 -0(%x2)	# 1390 
	addi	%x8 %x7 0	# 1390 
	lw	%f2 0(%x8)	# 1390 
	fmul	%f2 %f2 %f1	# 1390 
	lui	%x8 2098056	# 1390
	addi	%x8 %x8 904	# 1390
	addi	%x8 %x8 0	# 1390 
	lw	%f3 0(%x8)	# 1390 
	fadd	%f2 %f2 %f3	# 1390 
	addi	%x8 %x7 4	# 1391 
	lw	%f3 0(%x8)	# 1391 
	fmul	%f3 %f3 %f1	# 1391 
	lui	%x8 2098056	# 1391
	addi	%x8 %x8 904	# 1391
	addi	%x8 %x8 4	# 1391 
	lw	%f4 0(%x8)	# 1391 
	fadd	%f3 %f3 %f4	# 1391 
	addi	%x7 %x7 8	# 1392 
	lw	%f4 0(%x7)	# 1392 
	fmul	%f4 %f4 %f1	# 1392 
	lui	%x7 2098056	# 1392
	addi	%x7 %x7 904	# 1392
	addi	%x7 %x7 8	# 1392 
	lw	%f5 0(%x7)	# 1392 
	fadd	%f4 %f4 %f5	# 1392 
	lw	%x7 -8(%x2)	# 1181 
	addi	%x8 %x7 0	# 1181 
	lw	%x8 0(%x8)	# 1181 
	sw	%x6 -20(%x2)	# 1182 
	sw	%f4 -24(%x2)	# 1182 
	sw	%f3 -28(%x2)	# 1182 
	sw	%f2 -32(%x2)	# 1182 
	sw	%f1 -36(%x2)	# 1182 
	addi	%x5 %x0 -1	# 1182 
	bne	%x8 %x5 beq_else.21031	# 1182 
	addi	%x6 %x0 1	# 1183
	j	beq_cont.21032	# 1182 
beq_else.21031:	# 1182 
	lui	%x9 2097456	# 1185
	addi	%x9 %x9 304	# 1185
	slli	%x8 %x8 2	# 1185 
	add	%x8 %x9 %x8	# 1185 
	lw	%x8 0(%x8)	# 1185 
	add	%x6 %x0 %x8	# 1185 
	fadd	%f1 %f0 %f2	# 1185 
	fadd	%f2 %f0 %f3	# 1185 
	fadd	%f3 %f0 %f4	# 1185 
	sw	%x1 -40(%x2)	# 1185 
	addi	%x2 %x2 -44	# 1185 
	jal	 %x1 is_outside.3001	# 1185 
	addi	%x2 %x2 44	# 1185 
	lw	%x1 -40(%x2)	# 1185 
	bne	%x6 %x0 beq_else.21033	# 1185 
	addi	%x6 %x0 1	# 1188
	lw	%f1 -32(%x2)	# 1188 
	lw	%f2 -28(%x2)	# 1188 
	lw	%f3 -24(%x2)	# 1188 
	lw	%x7 -8(%x2)	# 1188 
	sw	%x1 -40(%x2)	# 1188 
	addi	%x2 %x2 -44	# 1188 
	jal	 %x1 check_all_inside.3006	# 1188 
	addi	%x2 %x2 44	# 1188 
	lw	%x1 -40(%x2)	# 1188 
	j	beq_cont.21034	# 1185 
beq_else.21033:	# 1185 
	addi	%x6 %x0 0	# 1186
beq_cont.21034:	# 1185 
beq_cont.21032:	# 1182 
	bne	%x6 %x0 beq_else.21035	# 1393 
	j	beq_cont.21036	# 1393 
beq_else.21035:	# 1393 
	lui	%x6 2097956	# 1395
	addi	%x6 %x6 804	# 1395
	addi	%x6 %x6 0	# 1395 
	lw	%f1 -36(%x2)	# 1395 
	sw	%f1 0(%x6)	# 1395 
	lui	%x6 2097960	# 1396
	addi	%x6 %x6 808	# 1396
	addi	%x7 %x6 0	# 61 
	lw	%f1 -32(%x2)	# 61 
	sw	%f1 0(%x7)	# 61 
	addi	%x7 %x6 4	# 62 
	lw	%f1 -28(%x2)	# 62 
	sw	%f1 0(%x7)	# 62 
	addi	%x6 %x6 8	# 63 
	lw	%f1 -24(%x2)	# 63 
	sw	%f1 0(%x6)	# 63 
	lui	%x6 2097972	# 1397
	addi	%x6 %x6 820	# 1397
	addi	%x6 %x6 0	# 1397 
	lw	%x7 -16(%x2)	# 1397 
	sw	%x7 0(%x6)	# 1397 
	lui	%x6 2097952	# 1398
	addi	%x6 %x6 800	# 1398
	addi	%x6 %x6 0	# 1398 
	lw	%x7 -20(%x2)	# 1398 
	sw	%x7 0(%x6)	# 1398 
beq_cont.21036:	# 1393 
	j	fle_cont.21030	# 1387 
fle.21029:	# 1387 
fle_cont.21030:	# 1387 
	j	fle_cont.21028	# 1386 
fle.21027:	# 1386 
fle_cont.21028:	# 1386 
	lw	%x6 -12(%x2)	# 1404 
	addi	%x6 %x6 1	# 1404 
	lw	%x7 -8(%x2)	# 1404 
	lw	%x8 -4(%x2)	# 1404 
	j	solve_each_element_fast.3035	# 1404 
solve_one_or_network_fast.3039:	#- 31508
	slli	%x9 %x6 2	# 1416 
	add	%x9 %x7 %x9	# 1416 
	lw	%x9 0(%x9)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x9 %x5 beq_else.21037	# 1417 
	jr	0(%x1)	# 1421 
beq_else.21037:	# 1417 
	lui	%x10 2097740	# 1418
	addi	%x10 %x10 588	# 1418
	slli	%x9 %x9 2	# 1418 
	add	%x9 %x10 %x9	# 1418 
	lw	%x9 0(%x9)	# 1418 
	addi	%x10 %x0 0	# 1419
	sw	%x8 -0(%x2)	# 1419 
	sw	%x7 -4(%x2)	# 1419 
	sw	%x6 -8(%x2)	# 1419 
	add	%x7 %x0 %x9	# 1419 
	add	%x6 %x0 %x10	# 1419 
	sw	%x1 -12(%x2)	# 1419 
	addi	%x2 %x2 -16	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 16	# 1419 
	lw	%x1 -12(%x2)	# 1419 
	lw	%x6 -8(%x2)	# 1420 
	addi	%x6 %x6 1	# 1420 
	slli	%x7 %x6 2	# 1416 
	lw	%x8 -4(%x2)	# 1416 
	add	%x7 %x8 %x7	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21039	# 1417 
	jr	0(%x1)	# 1421 
beq_else.21039:	# 1417 
	lui	%x9 2097740	# 1418
	addi	%x9 %x9 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x9 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x9 %x0 0	# 1419
	lw	%x10 -0(%x2)	# 1419 
	sw	%x6 -12(%x2)	# 1419 
	add	%x8 %x0 %x10	# 1419 
	add	%x6 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	lw	%x6 -12(%x2)	# 1420 
	addi	%x6 %x6 1	# 1420 
	slli	%x7 %x6 2	# 1416 
	lw	%x8 -4(%x2)	# 1416 
	add	%x7 %x8 %x7	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21041	# 1417 
	jr	0(%x1)	# 1421 
beq_else.21041:	# 1417 
	lui	%x9 2097740	# 1418
	addi	%x9 %x9 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x9 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x9 %x0 0	# 1419
	lw	%x10 -0(%x2)	# 1419 
	sw	%x6 -16(%x2)	# 1419 
	add	%x8 %x0 %x10	# 1419 
	add	%x6 %x0 %x9	# 1419 
	sw	%x1 -20(%x2)	# 1419 
	addi	%x2 %x2 -24	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 24	# 1419 
	lw	%x1 -20(%x2)	# 1419 
	lw	%x6 -16(%x2)	# 1420 
	addi	%x6 %x6 1	# 1420 
	slli	%x7 %x6 2	# 1416 
	lw	%x8 -4(%x2)	# 1416 
	add	%x7 %x8 %x7	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21043	# 1417 
	jr	0(%x1)	# 1421 
beq_else.21043:	# 1417 
	lui	%x9 2097740	# 1418
	addi	%x9 %x9 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x9 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x9 %x0 0	# 1419
	lw	%x10 -0(%x2)	# 1419 
	sw	%x6 -20(%x2)	# 1419 
	add	%x8 %x0 %x10	# 1419 
	add	%x6 %x0 %x9	# 1419 
	sw	%x1 -24(%x2)	# 1419 
	addi	%x2 %x2 -28	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 28	# 1419 
	lw	%x1 -24(%x2)	# 1419 
	lw	%x6 -20(%x2)	# 1420 
	addi	%x6 %x6 1	# 1420 
	lw	%x7 -4(%x2)	# 1420 
	lw	%x8 -0(%x2)	# 1420 
	j	solve_one_or_network_fast.3039	# 1420 
trace_or_matrix_fast.3043:	#- 31904
	slli	%x9 %x6 2	# 1426 
	add	%x9 %x7 %x9	# 1426 
	lw	%x9 0(%x9)	# 1426 
	addi	%x10 %x9 0	# 1427 
	lw	%x10 0(%x10)	# 1427 
	addi	%x5 %x0 -1	# 1428 
	bne	%x10 %x5 beq_else.21045	# 1428 
	jr	0(%x1)	# 1429 
beq_else.21045:	# 1428 
	sw	%x8 -0(%x2)	# 1431 
	sw	%x7 -4(%x2)	# 1431 
	sw	%x6 -8(%x2)	# 1431 
	addi	%x5 %x0 99	# 1431 
	bne	%x10 %x5 beq_else.21047	# 1431 
	addi	%x10 %x9 4	# 1416 
	lw	%x10 0(%x10)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x10 %x5 beq_else.21049	# 1417 
	j	beq_cont.21050	# 1417 
beq_else.21049:	# 1417 
	lui	%x11 2097740	# 1418
	addi	%x11 %x11 588	# 1418
	slli	%x10 %x10 2	# 1418 
	add	%x10 %x11 %x10	# 1418 
	lw	%x10 0(%x10)	# 1418 
	addi	%x11 %x0 0	# 1419
	sw	%x9 -12(%x2)	# 1419 
	add	%x7 %x0 %x10	# 1419 
	add	%x6 %x0 %x11	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	lw	%x6 -12(%x2)	# 1416 
	addi	%x7 %x6 8	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21051	# 1417 
	j	beq_cont.21052	# 1417 
beq_else.21051:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	lw	%x6 -12(%x2)	# 1416 
	addi	%x7 %x6 12	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21053	# 1417 
	j	beq_cont.21054	# 1417 
beq_else.21053:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	addi	%x6 %x0 4	# 1420
	lw	%x7 -12(%x2)	# 1420 
	lw	%x8 -0(%x2)	# 1420 
	sw	%x1 -16(%x2)	# 1420 
	addi	%x2 %x2 -20	# 1420 
	jal	 %x1 solve_one_or_network_fast.3039	# 1420 
	addi	%x2 %x2 20	# 1420 
	lw	%x1 -16(%x2)	# 1420 
beq_cont.21054:	# 1417 
beq_cont.21052:	# 1417 
beq_cont.21050:	# 1417 
	j	beq_cont.21048	# 1431 
beq_else.21047:	# 1431 
	lui	%x11 2097456	# 990
	addi	%x11 %x11 304	# 990
	slli	%x12 %x10 2	# 990 
	add	%x11 %x11 %x12	# 990 
	lw	%x11 0(%x11)	# 990 
	lw	%x12 40(%x11)	# 363 
	addi	%x13 %x12 0	# 992 
	lw	%f1 0(%x13)	# 992 
	addi	%x13 %x12 4	# 993 
	lw	%f2 0(%x13)	# 993 
	addi	%x13 %x12 8	# 994 
	lw	%f3 0(%x13)	# 994 
	lw	%x13 4(%x8)	# 460 
	slli	%x10 %x10 2	# 996 
	add	%x10 %x13 %x10	# 996 
	lw	%x10 0(%x10)	# 996 
	lw	%x13 4(%x11)	# 168 
	sw	%x9 -12(%x2)	# 998 
	addi	%x5 %x0 1	# 998 
	bne	%x13 %x5 beq_else.21055	# 998 
	lw	%x12 0(%x8)	# 454 
	add	%x8 %x0 %x10	# 999 
	add	%x7 %x0 %x12	# 999 
	add	%x6 %x0 %x11	# 999 
	sw	%x1 -16(%x2)	# 999 
	addi	%x2 %x2 -20	# 999 
	jal	 %x1 solver_rect_fast.2927	# 999 
	addi	%x2 %x2 20	# 999 
	lw	%x1 -16(%x2)	# 999 
	j	beq_cont.21056	# 998 
beq_else.21055:	# 998 
	addi	%x5 %x0 2	# 1000 
	bne	%x13 %x5 beq_else.21057	# 1000 
	lw	%f1 52(%x29)	# 963 
	addi	%x11 %x10 0	# 963 
	lw	%f2 0(%x11)	# 963 
	fle	%x5 %f1 %f2	# 963 
	bne	%x5 %x0 fle.21059	# 963 
	addi	%x10 %x10 0	# 964 
	lw	%f1 0(%x10)	# 964 
	addi	%x10 %x12 12	# 964 
	lw	%f2 0(%x10)	# 964 
	fmul	%f1 %f1 %f2	# 964 
	lui	%x10 2097948	# 964
	addi	%x10 %x10 796	# 964
	addi	%x10 %x10 0	# 964 
	sw	%f1 0(%x10)	# 964 
	addi	%x6 %x0 1	# 965
	j	fle_cont.21060	# 963 
fle.21059:	# 963 
	addi	%x6 %x0 0	# 966
fle_cont.21060:	# 963 
	j	beq_cont.21058	# 1000 
beq_else.21057:	# 1000 
	add	%x8 %x0 %x12	# 1003 
	add	%x7 %x0 %x10	# 1003 
	add	%x6 %x0 %x11	# 1003 
	sw	%x1 -16(%x2)	# 1003 
	addi	%x2 %x2 -20	# 1003 
	jal	 %x1 solver_second_fast2.2957	# 1003 
	addi	%x2 %x2 20	# 1003 
	lw	%x1 -16(%x2)	# 1003 
beq_cont.21058:	# 1000 
beq_cont.21056:	# 998 
	bne	%x6 %x0 beq_else.21061	# 1437 
	j	beq_cont.21062	# 1437 
beq_else.21061:	# 1437 
	lui	%x6 2097948	# 1438
	addi	%x6 %x6 796	# 1438
	addi	%x6 %x6 0	# 1438 
	lw	%f1 0(%x6)	# 1438 
	lui	%x6 2097956	# 1439
	addi	%x6 %x6 804	# 1439
	addi	%x6 %x6 0	# 1439 
	lw	%f2 0(%x6)	# 1439 
	fle	%x5 %f2 %f1	# 1439 
	bne	%x5 %x0 fle.21063	# 1439 
	lw	%x6 -12(%x2)	# 1416 
	addi	%x7 %x6 4	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21065	# 1417 
	j	beq_cont.21066	# 1417 
beq_else.21065:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	lw	%x6 -12(%x2)	# 1416 
	addi	%x7 %x6 8	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21067	# 1417 
	j	beq_cont.21068	# 1417 
beq_else.21067:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	lw	%x6 -12(%x2)	# 1416 
	addi	%x7 %x6 12	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21069	# 1417 
	j	beq_cont.21070	# 1417 
beq_else.21069:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -16(%x2)	# 1419 
	addi	%x2 %x2 -20	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 20	# 1419 
	lw	%x1 -16(%x2)	# 1419 
	addi	%x6 %x0 4	# 1420
	lw	%x7 -12(%x2)	# 1420 
	lw	%x8 -0(%x2)	# 1420 
	sw	%x1 -16(%x2)	# 1420 
	addi	%x2 %x2 -20	# 1420 
	jal	 %x1 solve_one_or_network_fast.3039	# 1420 
	addi	%x2 %x2 20	# 1420 
	lw	%x1 -16(%x2)	# 1420 
beq_cont.21070:	# 1417 
beq_cont.21068:	# 1417 
beq_cont.21066:	# 1417 
	j	fle_cont.21064	# 1439 
fle.21063:	# 1439 
fle_cont.21064:	# 1439 
beq_cont.21062:	# 1437 
beq_cont.21048:	# 1431 
	lw	%x6 -8(%x2)	# 1444 
	addi	%x6 %x6 1	# 1444 
	slli	%x7 %x6 2	# 1426 
	lw	%x8 -4(%x2)	# 1426 
	add	%x7 %x8 %x7	# 1426 
	lw	%x7 0(%x7)	# 1426 
	addi	%x9 %x7 0	# 1427 
	lw	%x9 0(%x9)	# 1427 
	addi	%x5 %x0 -1	# 1428 
	bne	%x9 %x5 beq_else.21071	# 1428 
	jr	0(%x1)	# 1429 
beq_else.21071:	# 1428 
	sw	%x6 -16(%x2)	# 1431 
	addi	%x5 %x0 99	# 1431 
	bne	%x9 %x5 beq_else.21073	# 1431 
	addi	%x9 %x7 4	# 1416 
	lw	%x9 0(%x9)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x9 %x5 beq_else.21075	# 1417 
	j	beq_cont.21076	# 1417 
beq_else.21075:	# 1417 
	lui	%x10 2097740	# 1418
	addi	%x10 %x10 588	# 1418
	slli	%x9 %x9 2	# 1418 
	add	%x9 %x10 %x9	# 1418 
	lw	%x9 0(%x9)	# 1418 
	addi	%x10 %x0 0	# 1419
	lw	%x11 -0(%x2)	# 1419 
	sw	%x7 -20(%x2)	# 1419 
	add	%x8 %x0 %x11	# 1419 
	add	%x7 %x0 %x9	# 1419 
	add	%x6 %x0 %x10	# 1419 
	sw	%x1 -24(%x2)	# 1419 
	addi	%x2 %x2 -28	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 28	# 1419 
	lw	%x1 -24(%x2)	# 1419 
	lw	%x6 -20(%x2)	# 1416 
	addi	%x7 %x6 8	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21077	# 1417 
	j	beq_cont.21078	# 1417 
beq_else.21077:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -24(%x2)	# 1419 
	addi	%x2 %x2 -28	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 28	# 1419 
	lw	%x1 -24(%x2)	# 1419 
	addi	%x6 %x0 3	# 1420
	lw	%x7 -20(%x2)	# 1420 
	lw	%x8 -0(%x2)	# 1420 
	sw	%x1 -24(%x2)	# 1420 
	addi	%x2 %x2 -28	# 1420 
	jal	 %x1 solve_one_or_network_fast.3039	# 1420 
	addi	%x2 %x2 28	# 1420 
	lw	%x1 -24(%x2)	# 1420 
beq_cont.21078:	# 1417 
beq_cont.21076:	# 1417 
	j	beq_cont.21074	# 1431 
beq_else.21073:	# 1431 
	lui	%x10 2097456	# 990
	addi	%x10 %x10 304	# 990
	slli	%x11 %x9 2	# 990 
	add	%x10 %x10 %x11	# 990 
	lw	%x10 0(%x10)	# 990 
	lw	%x11 40(%x10)	# 363 
	addi	%x12 %x11 0	# 992 
	lw	%f1 0(%x12)	# 992 
	addi	%x12 %x11 4	# 993 
	lw	%f2 0(%x12)	# 993 
	addi	%x12 %x11 8	# 994 
	lw	%f3 0(%x12)	# 994 
	lw	%x12 -0(%x2)	# 460 
	lw	%x13 4(%x12)	# 460 
	slli	%x9 %x9 2	# 996 
	add	%x9 %x13 %x9	# 996 
	lw	%x9 0(%x9)	# 996 
	lw	%x13 4(%x10)	# 168 
	sw	%x7 -20(%x2)	# 998 
	addi	%x5 %x0 1	# 998 
	bne	%x13 %x5 beq_else.21079	# 998 
	lw	%x11 0(%x12)	# 454 
	add	%x8 %x0 %x9	# 999 
	add	%x7 %x0 %x11	# 999 
	add	%x6 %x0 %x10	# 999 
	sw	%x1 -24(%x2)	# 999 
	addi	%x2 %x2 -28	# 999 
	jal	 %x1 solver_rect_fast.2927	# 999 
	addi	%x2 %x2 28	# 999 
	lw	%x1 -24(%x2)	# 999 
	j	beq_cont.21080	# 998 
beq_else.21079:	# 998 
	addi	%x5 %x0 2	# 1000 
	bne	%x13 %x5 beq_else.21081	# 1000 
	lw	%f1 52(%x29)	# 963 
	addi	%x10 %x9 0	# 963 
	lw	%f2 0(%x10)	# 963 
	fle	%x5 %f1 %f2	# 963 
	bne	%x5 %x0 fle.21083	# 963 
	addi	%x9 %x9 0	# 964 
	lw	%f1 0(%x9)	# 964 
	addi	%x9 %x11 12	# 964 
	lw	%f2 0(%x9)	# 964 
	fmul	%f1 %f1 %f2	# 964 
	lui	%x9 2097948	# 964
	addi	%x9 %x9 796	# 964
	addi	%x9 %x9 0	# 964 
	sw	%f1 0(%x9)	# 964 
	addi	%x6 %x0 1	# 965
	j	fle_cont.21084	# 963 
fle.21083:	# 963 
	addi	%x6 %x0 0	# 966
fle_cont.21084:	# 963 
	j	beq_cont.21082	# 1000 
beq_else.21081:	# 1000 
	add	%x8 %x0 %x11	# 1003 
	add	%x7 %x0 %x9	# 1003 
	add	%x6 %x0 %x10	# 1003 
	sw	%x1 -24(%x2)	# 1003 
	addi	%x2 %x2 -28	# 1003 
	jal	 %x1 solver_second_fast2.2957	# 1003 
	addi	%x2 %x2 28	# 1003 
	lw	%x1 -24(%x2)	# 1003 
beq_cont.21082:	# 1000 
beq_cont.21080:	# 998 
	bne	%x6 %x0 beq_else.21085	# 1437 
	j	beq_cont.21086	# 1437 
beq_else.21085:	# 1437 
	lui	%x6 2097948	# 1438
	addi	%x6 %x6 796	# 1438
	addi	%x6 %x6 0	# 1438 
	lw	%f1 0(%x6)	# 1438 
	lui	%x6 2097956	# 1439
	addi	%x6 %x6 804	# 1439
	addi	%x6 %x6 0	# 1439 
	lw	%f2 0(%x6)	# 1439 
	fle	%x5 %f2 %f1	# 1439 
	bne	%x5 %x0 fle.21087	# 1439 
	lw	%x6 -20(%x2)	# 1416 
	addi	%x7 %x6 4	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21089	# 1417 
	j	beq_cont.21090	# 1417 
beq_else.21089:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -24(%x2)	# 1419 
	addi	%x2 %x2 -28	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 28	# 1419 
	lw	%x1 -24(%x2)	# 1419 
	lw	%x6 -20(%x2)	# 1416 
	addi	%x7 %x6 8	# 1416 
	lw	%x7 0(%x7)	# 1416 
	addi	%x5 %x0 -1	# 1417 
	bne	%x7 %x5 beq_else.21091	# 1417 
	j	beq_cont.21092	# 1417 
beq_else.21091:	# 1417 
	lui	%x8 2097740	# 1418
	addi	%x8 %x8 588	# 1418
	slli	%x7 %x7 2	# 1418 
	add	%x7 %x8 %x7	# 1418 
	lw	%x7 0(%x7)	# 1418 
	addi	%x8 %x0 0	# 1419
	lw	%x9 -0(%x2)	# 1419 
	add	%x6 %x0 %x8	# 1419 
	add	%x8 %x0 %x9	# 1419 
	sw	%x1 -24(%x2)	# 1419 
	addi	%x2 %x2 -28	# 1419 
	jal	 %x1 solve_each_element_fast.3035	# 1419 
	addi	%x2 %x2 28	# 1419 
	lw	%x1 -24(%x2)	# 1419 
	addi	%x6 %x0 3	# 1420
	lw	%x7 -20(%x2)	# 1420 
	lw	%x8 -0(%x2)	# 1420 
	sw	%x1 -24(%x2)	# 1420 
	addi	%x2 %x2 -28	# 1420 
	jal	 %x1 solve_one_or_network_fast.3039	# 1420 
	addi	%x2 %x2 28	# 1420 
	lw	%x1 -24(%x2)	# 1420 
beq_cont.21092:	# 1417 
beq_cont.21090:	# 1417 
	j	fle_cont.21088	# 1439 
fle.21087:	# 1439 
fle_cont.21088:	# 1439 
beq_cont.21086:	# 1437 
beq_cont.21074:	# 1431 
	lw	%x6 -16(%x2)	# 1444 
	addi	%x6 %x6 1	# 1444 
	lw	%x7 -4(%x2)	# 1444 
	lw	%x8 -0(%x2)	# 1444 
	j	trace_or_matrix_fast.3043	# 1444 
get_nvector_second.3053:	#- 33540
	lui	%x7 2097960	# 1487
	addi	%x7 %x7 808	# 1487
	addi	%x7 %x7 0	# 1487 
	lw	%f1 0(%x7)	# 1487 
	lw	%x7 20(%x6)	# 246 
	addi	%x7 %x7 0	# 251 
	lw	%f2 0(%x7)	# 251 
	fsub	%f1 %f1 %f2	# 1487 
	lui	%x7 2097960	# 1488
	addi	%x7 %x7 808	# 1488
	addi	%x7 %x7 4	# 1488 
	lw	%f2 0(%x7)	# 1488 
	lw	%x7 20(%x6)	# 256 
	addi	%x7 %x7 4	# 261 
	lw	%f3 0(%x7)	# 261 
	fsub	%f2 %f2 %f3	# 1488 
	lui	%x7 2097960	# 1489
	addi	%x7 %x7 808	# 1489
	addi	%x7 %x7 8	# 1489 
	lw	%f3 0(%x7)	# 1489 
	lw	%x7 20(%x6)	# 266 
	addi	%x7 %x7 8	# 271 
	lw	%f4 0(%x7)	# 271 
	fsub	%f3 %f3 %f4	# 1489 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f4 0(%x7)	# 211 
	fmul	%f4 %f1 %f4	# 1491 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f5 0(%x7)	# 221 
	fmul	%f5 %f2 %f5	# 1492 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f6 0(%x7)	# 231 
	fmul	%f6 %f3 %f6	# 1493 
	lw	%x7 12(%x6)	# 197 
	bne	%x7 %x0 beq_else.21093	# 1495 
	lui	%x7 2097976	# 1496
	addi	%x7 %x7 824	# 1496
	addi	%x7 %x7 0	# 1496 
	sw	%f4 0(%x7)	# 1496 
	lui	%x7 2097976	# 1497
	addi	%x7 %x7 824	# 1497
	addi	%x7 %x7 4	# 1497 
	sw	%f5 0(%x7)	# 1497 
	lui	%x7 2097976	# 1498
	addi	%x7 %x7 824	# 1498
	addi	%x7 %x7 8	# 1498 
	sw	%f6 0(%x7)	# 1498 
	j	beq_cont.21094	# 1495 
beq_else.21093:	# 1495 
	lw	%x7 36(%x6)	# 346 
	addi	%x7 %x7 8	# 351 
	lw	%f7 0(%x7)	# 351 
	fmul	%f7 %f2 %f7	# 1500 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f8 0(%x7)	# 341 
	fmul	%f8 %f3 %f8	# 1500 
	fadd	%f7 %f7 %f8	# 1500 
	lw	%f8 4(%x29)	# 1500 
	fdiv	%f7 %f7 %f8	# 1500 
	fadd	%f4 %f4 %f7	# 1500 
	lui	%x7 2097976	# 1500
	addi	%x7 %x7 824	# 1500
	addi	%x7 %x7 0	# 1500 
	sw	%f4 0(%x7)	# 1500 
	lw	%x7 36(%x6)	# 346 
	addi	%x7 %x7 8	# 351 
	lw	%f4 0(%x7)	# 351 
	fmul	%f4 %f1 %f4	# 1501 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f7 0(%x7)	# 331 
	fmul	%f3 %f3 %f7	# 1501 
	fadd	%f3 %f4 %f3	# 1501 
	lw	%f4 4(%x29)	# 1501 
	fdiv	%f3 %f3 %f4	# 1501 
	fadd	%f3 %f5 %f3	# 1501 
	lui	%x7 2097976	# 1501
	addi	%x7 %x7 824	# 1501
	addi	%x7 %x7 4	# 1501 
	sw	%f3 0(%x7)	# 1501 
	lw	%x7 36(%x6)	# 336 
	addi	%x7 %x7 4	# 341 
	lw	%f3 0(%x7)	# 341 
	fmul	%f1 %f1 %f3	# 1502 
	lw	%x7 36(%x6)	# 326 
	addi	%x7 %x7 0	# 331 
	lw	%f3 0(%x7)	# 331 
	fmul	%f2 %f2 %f3	# 1502 
	fadd	%f1 %f1 %f2	# 1502 
	lw	%f2 4(%x29)	# 1502 
	fdiv	%f1 %f1 %f2	# 1502 
	fadd	%f1 %f6 %f1	# 1502 
	lui	%x7 2097976	# 1502
	addi	%x7 %x7 824	# 1502
	addi	%x7 %x7 8	# 1502 
	sw	%f1 0(%x7)	# 1502 
beq_cont.21094:	# 1495 
	lui	%x7 2097976	# 1504
	addi	%x7 %x7 824	# 1504
	lw	%x6 24(%x6)	# 188 
	add	%x5 %x0 %x7	# 1504 
	add	%x7 %x0 %x6	# 1504 
	add	%x6 %x0 %x5	# 1504 
	j	vecunit_sgn.2761	# 1504 
utexture.3058:	#- 33964
	lw	%x8 0(%x6)	# 158 
	lw	%x9 32(%x6)	# 296 
	addi	%x9 %x9 0	# 301 
	lw	%f1 0(%x9)	# 301 
	lui	%x9 2097988	# 1527
	addi	%x9 %x9 836	# 1527
	addi	%x9 %x9 0	# 1527 
	sw	%f1 0(%x9)	# 1527 
	lw	%x9 32(%x6)	# 306 
	addi	%x9 %x9 4	# 311 
	lw	%f1 0(%x9)	# 311 
	lui	%x9 2097988	# 1528
	addi	%x9 %x9 836	# 1528
	addi	%x9 %x9 4	# 1528 
	sw	%f1 0(%x9)	# 1528 
	lw	%x9 32(%x6)	# 316 
	addi	%x9 %x9 8	# 321 
	lw	%f1 0(%x9)	# 321 
	lui	%x9 2097988	# 1529
	addi	%x9 %x9 836	# 1529
	addi	%x9 %x9 8	# 1529 
	sw	%f1 0(%x9)	# 1529 
	addi	%x5 %x0 1	# 1530 
	bne	%x8 %x5 beq_else.21095	# 1530 
	addi	%x8 %x7 0	# 1533 
	lw	%f1 0(%x8)	# 1533 
	lw	%x8 20(%x6)	# 246 
	addi	%x8 %x8 0	# 251 
	lw	%f2 0(%x8)	# 251 
	fsub	%f1 %f1 %f2	# 1533 
	lw	%f2 164(%x29)	# 1535 
	fmul	%f2 %f1 %f2	# 1535 
	floor	%f2 %f2	# 1535 
	lw	%f3 168(%x29)	# 1535 
	fmul	%f2 %f2 %f3	# 1535 
	lw	%f3 156(%x29)	# 1536 
	fsub	%f1 %f1 %f2	# 1536 
	fle	%x5 %f3 %f1	# 1536 
	bne	%x5 %x0 fle.21096	# 1536 
	addi	%x8 %x0 1	# 1536
	j	fle_cont.21097	# 1536 
fle.21096:	# 1536 
	addi	%x8 %x0 0	# 1536
fle_cont.21097:	# 1536 
	addi	%x7 %x7 8	# 1538 
	lw	%f1 0(%x7)	# 1538 
	lw	%x6 20(%x6)	# 266 
	addi	%x6 %x6 8	# 271 
	lw	%f2 0(%x6)	# 271 
	fsub	%f1 %f1 %f2	# 1538 
	lw	%f2 164(%x29)	# 1540 
	fmul	%f2 %f1 %f2	# 1540 
	floor	%f2 %f2	# 1540 
	lw	%f3 168(%x29)	# 1540 
	fmul	%f2 %f2 %f3	# 1540 
	lw	%f3 156(%x29)	# 1541 
	fsub	%f1 %f1 %f2	# 1541 
	fle	%x5 %f3 %f1	# 1541 
	bne	%x5 %x0 fle.21098	# 1541 
	addi	%x6 %x0 1	# 1541
	j	fle_cont.21099	# 1541 
fle.21098:	# 1541 
	addi	%x6 %x0 0	# 1541
fle_cont.21099:	# 1541 
	bne	%x8 %x0 beq_else.21100	# 1544 
	bne	%x6 %x0 beq_else.21102	# 1546 
	lw	%f1 148(%x29)	# 1546 
	j	beq_cont.21103	# 1546 
beq_else.21102:	# 1546 
	lw	%f1 52(%x29)	# 1546 
beq_cont.21103:	# 1546 
	j	beq_cont.21101	# 1544 
beq_else.21100:	# 1544 
	bne	%x6 %x0 beq_else.21104	# 1545 
	lw	%f1 52(%x29)	# 1545 
	j	beq_cont.21105	# 1545 
beq_else.21104:	# 1545 
	lw	%f1 148(%x29)	# 1545 
beq_cont.21105:	# 1545 
beq_cont.21101:	# 1544 
	lui	%x6 2097988	# 1543
	addi	%x6 %x6 836	# 1543
	addi	%x6 %x6 4	# 1543 
	sw	%f1 0(%x6)	# 1543 
	jr	0(%x1)	# 1543 
beq_else.21095:	# 1530 
	addi	%x5 %x0 2	# 1548 
	bne	%x8 %x5 beq_else.21107	# 1548 
	addi	%x6 %x7 4	# 1551 
	lw	%f1 0(%x6)	# 1551 
	lw	%f2 160(%x29)	# 1551 
	fmul	%f1 %f1 %f2	# 1551 
	sw	%x7 -0(%x2)	# 1551 
	sw	%x1 -4(%x2)	# 1551 
	addi	%x2 %x2 -8	# 1551 
	jal	 %x1 sin.2718	# 1551 
	addi	%x2 %x2 8	# 1551 
	lw	%x1 -4(%x2)	# 1551 
	lw	%x6 -0(%x2)	# 1551 
	addi	%x6 %x6 4	# 1551 
	lw	%f2 0(%x6)	# 1551 
	lw	%f3 160(%x29)	# 1551 
	fmul	%f2 %f2 %f3	# 1551 
	sw	%f1 -4(%x2)	# 1551 
	fadd	%f1 %f0 %f2	# 1551 
	sw	%x1 -8(%x2)	# 1551 
	addi	%x2 %x2 -12	# 1551 
	jal	 %x1 sin.2718	# 1551 
	addi	%x2 %x2 12	# 1551 
	lw	%x1 -8(%x2)	# 1551 
	lw	%f2 -4(%x2)	# 1551 
	fmul	%f1 %f2 %f1	# 1551 
	lw	%f2 148(%x29)	# 1552 
	fmul	%f2 %f2 %f1	# 1552 
	lui	%x6 2097988	# 1552
	addi	%x6 %x6 836	# 1552
	addi	%x6 %x6 0	# 1552 
	sw	%f2 0(%x6)	# 1552 
	lw	%f2 148(%x29)	# 1553 
	lw	%f3 16(%x29)	# 1553 
	fsub	%f1 %f3 %f1	# 1553 
	fmul	%f1 %f2 %f1	# 1553 
	lui	%x6 2097988	# 1553
	addi	%x6 %x6 836	# 1553
	addi	%x6 %x6 4	# 1553 
	sw	%f1 0(%x6)	# 1553 
	jr	0(%x1)	# 1553 
beq_else.21107:	# 1548 
	addi	%x5 %x0 3	# 1555 
	bne	%x8 %x5 beq_else.21109	# 1555 
	addi	%x8 %x7 0	# 1558 
	lw	%f1 0(%x8)	# 1558 
	lw	%x8 20(%x6)	# 246 
	addi	%x8 %x8 0	# 251 
	lw	%f2 0(%x8)	# 251 
	fsub	%f1 %f1 %f2	# 1558 
	addi	%x7 %x7 8	# 1559 
	lw	%f2 0(%x7)	# 1559 
	lw	%x6 20(%x6)	# 266 
	addi	%x6 %x6 8	# 271 
	lw	%f3 0(%x6)	# 271 
	fsub	%f2 %f2 %f3	# 1559 
	fmul	%f1 %f1 %f1	# 1560 
	fmul	%f2 %f2 %f2	# 1560 
	fadd	%f1 %f1 %f2	# 1560 
	fsqrt	%f1 %f1	# 1560 
	lw	%f2 156(%x29)	# 1560 
	fdiv	%f1 %f1 %f2	# 1560 
	floor	%f2 %f1	# 1561 
	fsub	%f1 %f1 %f2	# 1561 
	lw	%f2 140(%x29)	# 1561 
	fmul	%f1 %f1 %f2	# 1561 
	sw	%f1 -8(%x2)	# 1562 
	sw	%x1 -12(%x2)	# 1562 
	addi	%x2 %x2 -16	# 1562 
	jal	 %x1 cos.2720	# 1562 
	addi	%x2 %x2 16	# 1562 
	lw	%x1 -12(%x2)	# 1562 
	lw	%f2 -8(%x2)	# 1562 
	sw	%f1 -12(%x2)	# 1562 
	fadd	%f1 %f0 %f2	# 1562 
	sw	%x1 -16(%x2)	# 1562 
	addi	%x2 %x2 -20	# 1562 
	jal	 %x1 cos.2720	# 1562 
	addi	%x2 %x2 20	# 1562 
	lw	%x1 -16(%x2)	# 1562 
	lw	%f2 -12(%x2)	# 1562 
	fmul	%f1 %f2 %f1	# 1562 
	lw	%f2 148(%x29)	# 1563 
	fmul	%f2 %f1 %f2	# 1563 
	lui	%x6 2097988	# 1563
	addi	%x6 %x6 836	# 1563
	addi	%x6 %x6 4	# 1563 
	sw	%f2 0(%x6)	# 1563 
	lw	%f2 16(%x29)	# 1564 
	fsub	%f1 %f2 %f1	# 1564 
	lw	%f2 148(%x29)	# 1564 
	fmul	%f1 %f1 %f2	# 1564 
	lui	%x6 2097988	# 1564
	addi	%x6 %x6 836	# 1564
	addi	%x6 %x6 8	# 1564 
	sw	%f1 0(%x6)	# 1564 
	jr	0(%x1)	# 1564 
beq_else.21109:	# 1555 
	addi	%x5 %x0 4	# 1566 
	bne	%x8 %x5 beq_else.21111	# 1566 
	addi	%x8 %x7 0	# 1568 
	lw	%f1 0(%x8)	# 1568 
	lw	%x8 20(%x6)	# 246 
	addi	%x8 %x8 0	# 251 
	lw	%f2 0(%x8)	# 251 
	fsub	%f1 %f1 %f2	# 1568 
	lw	%x8 16(%x6)	# 206 
	addi	%x8 %x8 0	# 211 
	lw	%f2 0(%x8)	# 211 
	fsqrt	%f2 %f2	# 1568 
	fmul	%f1 %f1 %f2	# 1568 
	addi	%x8 %x7 8	# 1569 
	lw	%f2 0(%x8)	# 1569 
	lw	%x8 20(%x6)	# 266 
	addi	%x8 %x8 8	# 271 
	lw	%f3 0(%x8)	# 271 
	fsub	%f2 %f2 %f3	# 1569 
	lw	%x8 16(%x6)	# 226 
	addi	%x8 %x8 8	# 231 
	lw	%f3 0(%x8)	# 231 
	fsqrt	%f3 %f3	# 1569 
	fmul	%f2 %f2 %f3	# 1569 
	fmul	%f3 %f1 %f1	# 1570 
	fmul	%f4 %f2 %f2	# 1570 
	fadd	%f3 %f3 %f4	# 1570 
	lw	%f4 128(%x29)	# 1572 
	lw	%f5 52(%x29)	# 1572 
	fle	%x5 %f1 %f5	# 1572 
	bne	%x5 %x0 fle.21112	# 1572 
	itof	%x5 %x0	# 1572 
	fadd	%f5 %f1 %x5	# 1572 
	j	fle_cont.21113	# 1572 
fle.21112:	# 1572 
	lw	%f5 48(%x29)	# 1572 
	fmul	%f5 %f5 %f1	# 1572 
fle_cont.21113:	# 1572 
	sw	%f3 -16(%x2)	# 1572 
	sw	%x6 -20(%x2)	# 1572 
	sw	%x7 -0(%x2)	# 1572 
	fle	%x5 %f4 %f5	# 1572 
	bne	%x5 %x0 fle.21114	# 1572 
	lw	%f1 132(%x29)	# 1573 
	j	fle_cont.21115	# 1572 
fle.21114:	# 1572 
	fdiv	%f4 %f2 %f1	# 1575 
	lw	%f5 52(%x29)	# 1575 
	fle	%x5 %f4 %f5	# 1575 
	bne	%x5 %x0 fle.21116	# 1575 
	fdiv	%f1 %f2 %f1	# 1575 
	j	fle_cont.21117	# 1575 
fle.21116:	# 1575 
	lw	%f4 48(%x29)	# 1575 
	fdiv	%f1 %f2 %f1	# 1575 
	fmul	%f1 %f4 %f1	# 1575 
fle_cont.21117:	# 1575 
	sw	%x1 -24(%x2)	# 1577 
	addi	%x2 %x2 -28	# 1577 
	jal	 %x1 atan.2722	# 1577 
	addi	%x2 %x2 28	# 1577 
	lw	%x1 -24(%x2)	# 1577 
	lw	%f2 136(%x29)	# 1577 
	fmul	%f1 %f1 %f2	# 1577 
	lw	%f2 140(%x29)	# 1577 
	fdiv	%f1 %f1 %f2	# 1577 
fle_cont.21115:	# 1572 
	floor	%f2 %f1	# 1579 
	fsub	%f1 %f1 %f2	# 1579 
	lw	%x6 -0(%x2)	# 1581 
	addi	%x6 %x6 4	# 1581 
	lw	%f2 0(%x6)	# 1581 
	lw	%x6 -20(%x2)	# 256 
	lw	%x7 20(%x6)	# 256 
	addi	%x7 %x7 4	# 261 
	lw	%f3 0(%x7)	# 261 
	fsub	%f2 %f2 %f3	# 1581 
	lw	%x6 16(%x6)	# 216 
	addi	%x6 %x6 4	# 221 
	lw	%f3 0(%x6)	# 221 
	fsqrt	%f3 %f3	# 1581 
	fmul	%f2 %f2 %f3	# 1581 
	lw	%f3 128(%x29)	# 1583 
	lw	%f4 52(%x29)	# 1583 
	lw	%f5 -16(%x2)	# 1583 
	fle	%x5 %f5 %f4	# 1583 
	bne	%x5 %x0 fle.21118	# 1583 
	itof	%x5 %x0	# 1583 
	fadd	%f4 %f5 %x5	# 1583 
	j	fle_cont.21119	# 1583 
fle.21118:	# 1583 
	lw	%f4 48(%x29)	# 1583 
	fmul	%f4 %f4 %f5	# 1583 
fle_cont.21119:	# 1583 
	sw	%f1 -24(%x2)	# 1583 
	fle	%x5 %f3 %f4	# 1583 
	bne	%x5 %x0 fle.21120	# 1583 
	lw	%f1 132(%x29)	# 1584 
	j	fle_cont.21121	# 1583 
fle.21120:	# 1583 
	fdiv	%f3 %f2 %f5	# 1586 
	lw	%f4 52(%x29)	# 1586 
	fle	%x5 %f3 %f4	# 1586 
	bne	%x5 %x0 fle.21122	# 1586 
	fdiv	%f2 %f2 %f5	# 1586 
	j	fle_cont.21123	# 1586 
fle.21122:	# 1586 
	lw	%f3 48(%x29)	# 1586 
	fdiv	%f2 %f2 %f5	# 1586 
	fmul	%f2 %f3 %f2	# 1586 
fle_cont.21123:	# 1586 
	fadd	%f1 %f0 %f2	# 1587 
	sw	%x1 -28(%x2)	# 1587 
	addi	%x2 %x2 -32	# 1587 
	jal	 %x1 atan.2722	# 1587 
	addi	%x2 %x2 32	# 1587 
	lw	%x1 -28(%x2)	# 1587 
	lw	%f2 136(%x29)	# 1587 
	fmul	%f1 %f1 %f2	# 1587 
	lw	%f2 140(%x29)	# 1587 
	fdiv	%f1 %f1 %f2	# 1587 
fle_cont.21121:	# 1583 
	floor	%f2 %f1	# 1589 
	fsub	%f1 %f1 %f2	# 1589 
	lw	%f2 144(%x29)	# 1590 
	lw	%f3 20(%x29)	# 1590 
	lw	%f4 -24(%x2)	# 1590 
	fsub	%f3 %f3 %f4	# 1590 
	lw	%f5 20(%x29)	# 1590 
	fsub	%f4 %f5 %f4	# 1590 
	fmul	%f3 %f3 %f4	# 1590 
	fsub	%f2 %f2 %f3	# 1590 
	lw	%f3 20(%x29)	# 1590 
	fsub	%f3 %f3 %f1	# 1590 
	lw	%f4 20(%x29)	# 1590 
	fsub	%f1 %f4 %f1	# 1590 
	fmul	%f1 %f3 %f1	# 1590 
	fsub	%f1 %f2 %f1	# 1590 
	lw	%f2 52(%x29)	# 1591 
	fle	%x5 %f2 %f1	# 1591 
	bne	%x5 %x0 fle.21124	# 1591 
	lw	%f1 52(%x29)	# 1591 
	j	fle_cont.21125	# 1591 
fle.21124:	# 1591 
fle_cont.21125:	# 1591 
	lw	%f2 148(%x29)	# 1592 
	fmul	%f1 %f2 %f1	# 1592 
	lw	%f2 152(%x29)	# 1592 
	fdiv	%f1 %f1 %f2	# 1592 
	lui	%x6 2097988	# 1592
	addi	%x6 %x6 836	# 1592
	addi	%x6 %x6 8	# 1592 
	sw	%f1 0(%x6)	# 1592 
	jr	0(%x1)	# 1592 
beq_else.21111:	# 1566 
	jr	0(%x1)	# 1594 
add_light.3061:	#- 35212
	lw	%f4 52(%x29)	# 1605 
	fle	%x5 %f1 %f4	# 1605 
	bne	%x5 %x0 fle.21128	# 1605 
	lui	%x6 2098012	# 1606
	addi	%x6 %x6 860	# 1606
	lui	%x7 2097988	# 1606
	addi	%x7 %x7 836	# 1606
	addi	%x8 %x6 0	# 119 
	lw	%f4 0(%x8)	# 119 
	addi	%x8 %x7 0	# 119 
	lw	%f5 0(%x8)	# 119 
	fmul	%f5 %f1 %f5	# 119 
	fadd	%f4 %f4 %f5	# 119 
	addi	%x8 %x6 0	# 119 
	sw	%f4 0(%x8)	# 119 
	addi	%x8 %x6 4	# 120 
	lw	%f4 0(%x8)	# 120 
	addi	%x8 %x7 4	# 120 
	lw	%f5 0(%x8)	# 120 
	fmul	%f5 %f1 %f5	# 120 
	fadd	%f4 %f4 %f5	# 120 
	addi	%x8 %x6 4	# 120 
	sw	%f4 0(%x8)	# 120 
	addi	%x8 %x6 8	# 121 
	lw	%f4 0(%x8)	# 121 
	addi	%x7 %x7 8	# 121 
	lw	%f5 0(%x7)	# 121 
	fmul	%f1 %f1 %f5	# 121 
	fadd	%f1 %f4 %f1	# 121 
	addi	%x6 %x6 8	# 121 
	sw	%f1 0(%x6)	# 121 
	j	fle_cont.21129	# 1605 
fle.21128:	# 1605 
fle_cont.21129:	# 1605 
	lw	%f1 52(%x29)	# 1610 
	fle	%x5 %f2 %f1	# 1610 
	bne	%x5 %x0 fle_else.21130	# 1610 
	fmul	%f1 %f2 %f2	# 1611 
	fmul	%f2 %f2 %f2	# 1611 
	fmul	%f1 %f1 %f2	# 1611 
	fmul	%f1 %f1 %f3	# 1611 
	lui	%x6 2098012	# 1612
	addi	%x6 %x6 860	# 1612
	addi	%x6 %x6 0	# 1612 
	lw	%f2 0(%x6)	# 1612 
	fadd	%f2 %f2 %f1	# 1612 
	lui	%x6 2098012	# 1612
	addi	%x6 %x6 860	# 1612
	addi	%x6 %x6 0	# 1612 
	sw	%f2 0(%x6)	# 1612 
	lui	%x6 2098012	# 1613
	addi	%x6 %x6 860	# 1613
	addi	%x6 %x6 4	# 1613 
	lw	%f2 0(%x6)	# 1613 
	fadd	%f2 %f2 %f1	# 1613 
	lui	%x6 2098012	# 1613
	addi	%x6 %x6 860	# 1613
	addi	%x6 %x6 4	# 1613 
	sw	%f2 0(%x6)	# 1613 
	lui	%x6 2098012	# 1614
	addi	%x6 %x6 860	# 1614
	addi	%x6 %x6 8	# 1614 
	lw	%f2 0(%x6)	# 1614 
	fadd	%f1 %f2 %f1	# 1614 
	lui	%x6 2098012	# 1614
	addi	%x6 %x6 860	# 1614
	addi	%x6 %x6 8	# 1614 
	sw	%f1 0(%x6)	# 1614 
	jr	0(%x1)	# 1614 
fle_else.21130:	# 1610 
	jr	0(%x1)	# 1615 
trace_reflections.3065:	#- 35484
	blt	%x6 %x0 bge_else.21133	# 1621 
	lui	%x8 2098416	# 1622
	addi	%x8 %x8 1264	# 1622
	slli	%x9 %x6 2	# 1622 
	add	%x8 %x8 %x9	# 1622 
	lw	%x8 0(%x8)	# 1622 
	lw	%x9 4(%x8)	# 476 
	lw	%f3 172(%x29)	# 1451 
	lui	%x10 2097956	# 1451
	addi	%x10 %x10 804	# 1451
	addi	%x10 %x10 0	# 1451 
	sw	%f3 0(%x10)	# 1451 
	addi	%x10 %x0 0	# 1452
	lui	%x11 2097944	# 1452
	addi	%x11 %x11 792	# 1452
	addi	%x11 %x11 0	# 1452 
	lw	%x11 0(%x11)	# 1452 
	sw	%x6 -0(%x2)	# 1452 
	sw	%f2 -4(%x2)	# 1452 
	sw	%x7 -8(%x2)	# 1452 
	sw	%f1 -12(%x2)	# 1452 
	sw	%x9 -16(%x2)	# 1452 
	sw	%x8 -20(%x2)	# 1452 
	add	%x8 %x0 %x9	# 1452 
	add	%x7 %x0 %x11	# 1452 
	add	%x6 %x0 %x10	# 1452 
	sw	%x1 -24(%x2)	# 1452 
	addi	%x2 %x2 -28	# 1452 
	jal	 %x1 trace_or_matrix_fast.3043	# 1452 
	addi	%x2 %x2 28	# 1452 
	lw	%x1 -24(%x2)	# 1452 
	lui	%x6 2097956	# 1453
	addi	%x6 %x6 804	# 1453
	addi	%x6 %x6 0	# 1453 
	lw	%f1 0(%x6)	# 1453 
	lw	%f2 124(%x29)	# 1455 
	fle	%x5 %f1 %f2	# 1455 
	bne	%x5 %x0 fle.21134	# 1455 
	lw	%f2 176(%x29)	# 1456 
	fle	%x5 %f2 %f1	# 1456 
	bne	%x5 %x0 fle.21136	# 1456 
	addi	%x6 %x0 1	# 1456
	j	fle_cont.21137	# 1456 
fle.21136:	# 1456 
	addi	%x6 %x0 0	# 1456
fle_cont.21137:	# 1456 
	j	fle_cont.21135	# 1455 
fle.21134:	# 1455 
	addi	%x6 %x0 0	# 1457
fle_cont.21135:	# 1455 
	bne	%x6 %x0 beq_else.21138	# 1626 
	j	beq_cont.21139	# 1626 
beq_else.21138:	# 1626 
	lui	%x6 2097972	# 1627
	addi	%x6 %x6 820	# 1627
	addi	%x6 %x6 0	# 1627 
	lw	%x6 0(%x6)	# 1627 
	addi	%x7 %x0 2	# 120
	sw	%x1 -24(%x2)	# 120 
	addi	%x2 %x2 -28	# 120 
	jal	 %x1 min_caml_sll	# 120 
	addi	%x2 %x2 28	# 120 
	lw	%x1 -24(%x2)	# 120 
	lui	%x7 2097952	# 1627
	addi	%x7 %x7 800	# 1627
	addi	%x7 %x7 0	# 1627 
	lw	%x7 0(%x7)	# 1627 
	add	%x6 %x6 %x7	# 1627 
	lw	%x7 -20(%x2)	# 470 
	lw	%x8 0(%x7)	# 470 
	bne	%x6 %x8 beq_else.21140	# 1628 
	addi	%x6 %x0 0	# 1630
	lui	%x8 2097944	# 1630
	addi	%x8 %x8 792	# 1630
	addi	%x8 %x8 0	# 1630 
	lw	%x8 0(%x8)	# 1630 
	add	%x7 %x0 %x8	# 1630 
	sw	%x1 -24(%x2)	# 1630 
	addi	%x2 %x2 -28	# 1630 
	jal	 %x1 shadow_check_one_or_matrix.3018	# 1630 
	addi	%x2 %x2 28	# 1630 
	lw	%x1 -24(%x2)	# 1630 
	bne	%x6 %x0 beq_else.21142	# 1630 
	lui	%x6 2097976	# 1632
	addi	%x6 %x6 824	# 1632
	lw	%x7 -16(%x2)	# 454 
	lw	%x8 0(%x7)	# 454 
	addi	%x9 %x6 0	# 109 
	lw	%f1 0(%x9)	# 109 
	addi	%x9 %x8 0	# 109 
	lw	%f2 0(%x9)	# 109 
	fmul	%f1 %f1 %f2	# 109 
	addi	%x9 %x6 4	# 109 
	lw	%f2 0(%x9)	# 109 
	addi	%x9 %x8 4	# 109 
	lw	%f3 0(%x9)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f2 0(%x6)	# 109 
	addi	%x6 %x8 8	# 109 
	lw	%f3 0(%x6)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	lw	%x6 -20(%x2)	# 482 
	lw	%f2 8(%x6)	# 482 
	lw	%f3 -12(%x2)	# 1634 
	fmul	%f4 %f2 %f3	# 1634 
	fmul	%f1 %f4 %f1	# 1634 
	lw	%x6 0(%x7)	# 454 
	lw	%x7 -8(%x2)	# 109 
	addi	%x8 %x7 0	# 109 
	lw	%f4 0(%x8)	# 109 
	addi	%x8 %x6 0	# 109 
	lw	%f5 0(%x8)	# 109 
	fmul	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f6 0(%x8)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 8	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f6 0(%x6)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	fmul	%f2 %f2 %f4	# 1635 
	lw	%f4 -4(%x2)	# 1636 
	fadd	%f3 %f0 %f4	# 1636 
	sw	%x1 -24(%x2)	# 1636 
	addi	%x2 %x2 -28	# 1636 
	jal	 %x1 add_light.3061	# 1636 
	addi	%x2 %x2 28	# 1636 
	lw	%x1 -24(%x2)	# 1636 
	j	beq_cont.21143	# 1630 
beq_else.21142:	# 1630 
beq_cont.21143:	# 1630 
	j	beq_cont.21141	# 1628 
beq_else.21140:	# 1628 
beq_cont.21141:	# 1628 
beq_cont.21139:	# 1626 
	lw	%x6 -0(%x2)	# 1640 
	addi	%x6 %x6 -1	# 1640 
	lw	%f1 -12(%x2)	# 1640 
	lw	%f2 -4(%x2)	# 1640 
	lw	%x7 -8(%x2)	# 1640 
	j	trace_reflections.3065	# 1640 
bge_else.21133:	# 1621 
	jr	0(%x1)	# 1641 
trace_ray.3070:	#- 36044
	addi	%x5 %x0 4	# 1649 
	blt	%x5 %x6 blt.21145	# 1649 
	lw	%x9 8(%x8)	# 392 
	lw	%f3 172(%x29)	# 1360 
	lui	%x10 2097956	# 1360
	addi	%x10 %x10 804	# 1360
	addi	%x10 %x10 0	# 1360 
	sw	%f3 0(%x10)	# 1360 
	addi	%x10 %x0 0	# 1361
	lui	%x11 2097944	# 1361
	addi	%x11 %x11 792	# 1361
	addi	%x11 %x11 0	# 1361 
	lw	%x11 0(%x11)	# 1361 
	sw	%f2 -0(%x2)	# 1361 
	sw	%x8 -4(%x2)	# 1361 
	sw	%f1 -8(%x2)	# 1361 
	sw	%x7 -12(%x2)	# 1361 
	sw	%x9 -16(%x2)	# 1361 
	sw	%x6 -20(%x2)	# 1361 
	add	%x8 %x0 %x7	# 1361 
	add	%x6 %x0 %x10	# 1361 
	add	%x7 %x0 %x11	# 1361 
	sw	%x1 -24(%x2)	# 1361 
	addi	%x2 %x2 -28	# 1361 
	jal	 %x1 trace_or_matrix.3029	# 1361 
	addi	%x2 %x2 28	# 1361 
	lw	%x1 -24(%x2)	# 1361 
	lui	%x6 2097956	# 1362
	addi	%x6 %x6 804	# 1362
	addi	%x6 %x6 0	# 1362 
	lw	%f1 0(%x6)	# 1362 
	lw	%f2 124(%x29)	# 1364 
	fle	%x5 %f1 %f2	# 1364 
	bne	%x5 %x0 fle.21146	# 1364 
	lw	%f2 176(%x29)	# 1365 
	fle	%x5 %f2 %f1	# 1365 
	bne	%x5 %x0 fle.21148	# 1365 
	addi	%x6 %x0 1	# 1365
	j	fle_cont.21149	# 1365 
fle.21148:	# 1365 
	addi	%x6 %x0 0	# 1365
fle_cont.21149:	# 1365 
	j	fle_cont.21147	# 1364 
fle.21146:	# 1364 
	addi	%x6 %x0 0	# 1366
fle_cont.21147:	# 1364 
	bne	%x6 %x0 beq_else.21150	# 1651 
	addi	%x6 %x0 -1	# 1714
	lw	%x7 -20(%x2)	# 1714 
	slli	%x8 %x7 2	# 1714 
	lw	%x9 -16(%x2)	# 1714 
	add	%x8 %x9 %x8	# 1714 
	sw	%x6 0(%x8)	# 1714 
	bne	%x7 %x0 beq_else.21151	# 1716 
	jr	0(%x1)	# 1728 
beq_else.21151:	# 1716 
	lw	%f1 48(%x29)	# 1717 
	lui	%x6 2097720	# 1717
	addi	%x6 %x6 568	# 1717
	lw	%x7 -12(%x2)	# 109 
	addi	%x8 %x7 0	# 109 
	lw	%f2 0(%x8)	# 109 
	addi	%x8 %x6 0	# 109 
	lw	%f3 0(%x8)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f3 0(%x8)	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f4 0(%x8)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f3 0(%x7)	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f4 0(%x6)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	fmul	%f1 %f1 %f2	# 1717 
	lw	%f2 52(%x29)	# 1719 
	fle	%x5 %f1 %f2	# 1719 
	bne	%x5 %x0 fle_else.21153	# 1719 
	fmul	%f2 %f1 %f1	# 1722 
	fmul	%f1 %f2 %f1	# 1722 
	lw	%f2 -8(%x2)	# 1722 
	fmul	%f1 %f1 %f2	# 1722 
	lui	%x6 2097732	# 1722
	addi	%x6 %x6 580	# 1722
	addi	%x6 %x6 0	# 1722 
	lw	%f2 0(%x6)	# 1722 
	fmul	%f1 %f1 %f2	# 1722 
	lui	%x6 2098012	# 1723
	addi	%x6 %x6 860	# 1723
	addi	%x6 %x6 0	# 1723 
	lw	%f2 0(%x6)	# 1723 
	fadd	%f2 %f2 %f1	# 1723 
	lui	%x6 2098012	# 1723
	addi	%x6 %x6 860	# 1723
	addi	%x6 %x6 0	# 1723 
	sw	%f2 0(%x6)	# 1723 
	lui	%x6 2098012	# 1724
	addi	%x6 %x6 860	# 1724
	addi	%x6 %x6 4	# 1724 
	lw	%f2 0(%x6)	# 1724 
	fadd	%f2 %f2 %f1	# 1724 
	lui	%x6 2098012	# 1724
	addi	%x6 %x6 860	# 1724
	addi	%x6 %x6 4	# 1724 
	sw	%f2 0(%x6)	# 1724 
	lui	%x6 2098012	# 1725
	addi	%x6 %x6 860	# 1725
	addi	%x6 %x6 8	# 1725 
	lw	%f2 0(%x6)	# 1725 
	fadd	%f1 %f2 %f1	# 1725 
	lui	%x6 2098012	# 1725
	addi	%x6 %x6 860	# 1725
	addi	%x6 %x6 8	# 1725 
	sw	%f1 0(%x6)	# 1725 
	jr	0(%x1)	# 1725 
fle_else.21153:	# 1719 
	jr	0(%x1)	# 1727 
beq_else.21150:	# 1651 
	lui	%x6 2097972	# 1653
	addi	%x6 %x6 820	# 1653
	addi	%x6 %x6 0	# 1653 
	lw	%x6 0(%x6)	# 1653 
	lui	%x7 2097456	# 1654
	addi	%x7 %x7 304	# 1654
	slli	%x8 %x6 2	# 1654 
	add	%x7 %x7 %x8	# 1654 
	lw	%x7 0(%x7)	# 1654 
	lw	%x8 8(%x7)	# 178 
	lw	%x9 28(%x7)	# 276 
	addi	%x9 %x9 0	# 281 
	lw	%f1 0(%x9)	# 281 
	lw	%f2 -8(%x2)	# 1656 
	fmul	%f1 %f1 %f2	# 1656 
	lw	%x9 4(%x7)	# 168 
	sw	%x8 -24(%x2)	# 1510 
	sw	%f1 -28(%x2)	# 1510 
	sw	%x6 -32(%x2)	# 1510 
	sw	%x7 -36(%x2)	# 1510 
	addi	%x5 %x0 1	# 1510 
	bne	%x9 %x5 beq_else.21156	# 1510 
	lui	%x9 2097952	# 1471
	addi	%x9 %x9 800	# 1471
	addi	%x9 %x9 0	# 1471 
	lw	%x9 0(%x9)	# 1471 
	lui	%x10 2097976	# 1473
	addi	%x10 %x10 824	# 1473
	lw	%f3 52(%x29)	# 75 
	addi	%x11 %x10 0	# 68 
	sw	%f3 0(%x11)	# 68 
	addi	%x11 %x10 4	# 69 
	sw	%f3 0(%x11)	# 69 
	addi	%x10 %x10 8	# 70 
	sw	%f3 0(%x10)	# 70 
	lw	%f3 48(%x29)	# 1474 
	addi	%x10 %x9 -1	# 1474 
	slli	%x10 %x10 2	# 1474 
	lw	%x11 -12(%x2)	# 1474 
	add	%x10 %x11 %x10	# 1474 
	lw	%f4 0(%x10)	# 1474 
	lw	%f5 52(%x29)	# 33 
	fle	%x5 %f4 %f5	# 33 
	fle	%x31 %f5 %f4	# 33 
	and	%x5 %x5 %x31	# 33 
	bne	%x5 %x0 feq.21158	# 33 
	lw	%f5 52(%x29)	# 34 
	fle	%x5 %f4 %f5	# 34 
	bne	%x5 %x0 fle.21160	# 34 
	lw	%f4 16(%x29)	# 34 
	j	fle_cont.21161	# 34 
fle.21160:	# 34 
	lw	%f4 48(%x29)	# 35 
fle_cont.21161:	# 34 
	j	feq_cont.21159	# 33 
feq.21158:	# 33 
	lw	%f4 52(%x29)	# 33 
feq_cont.21159:	# 33 
	fmul	%f3 %f3 %f4	# 1474 
	addi	%x9 %x9 -1	# 1474 
	lui	%x10 2097976	# 1474
	addi	%x10 %x10 824	# 1474
	slli	%x9 %x9 2	# 1474 
	add	%x9 %x10 %x9	# 1474 
	sw	%f3 0(%x9)	# 1474 
	j	beq_cont.21157	# 1510 
beq_else.21156:	# 1510 
	addi	%x5 %x0 2	# 1512 
	bne	%x9 %x5 beq_else.21162	# 1512 
	lw	%f3 48(%x29)	# 1480 
	lw	%x9 16(%x7)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f4 0(%x9)	# 211 
	fmul	%f3 %f3 %f4	# 1480 
	lui	%x9 2097976	# 1480
	addi	%x9 %x9 824	# 1480
	addi	%x9 %x9 0	# 1480 
	sw	%f3 0(%x9)	# 1480 
	lw	%f3 48(%x29)	# 1481 
	lw	%x9 16(%x7)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f4 0(%x9)	# 221 
	fmul	%f3 %f3 %f4	# 1481 
	lui	%x9 2097976	# 1481
	addi	%x9 %x9 824	# 1481
	addi	%x9 %x9 4	# 1481 
	sw	%f3 0(%x9)	# 1481 
	lw	%f3 48(%x29)	# 1482 
	lw	%x9 16(%x7)	# 226 
	addi	%x9 %x9 8	# 231 
	lw	%f4 0(%x9)	# 231 
	fmul	%f3 %f3 %f4	# 1482 
	lui	%x9 2097976	# 1482
	addi	%x9 %x9 824	# 1482
	addi	%x9 %x9 8	# 1482 
	sw	%f3 0(%x9)	# 1482 
	j	beq_cont.21163	# 1512 
beq_else.21162:	# 1512 
	add	%x6 %x0 %x7	# 1515 
	sw	%x1 -40(%x2)	# 1515 
	addi	%x2 %x2 -44	# 1515 
	jal	 %x1 get_nvector_second.3053	# 1515 
	addi	%x2 %x2 44	# 1515 
	lw	%x1 -40(%x2)	# 1515 
beq_cont.21163:	# 1512 
beq_cont.21157:	# 1510 
	lui	%x6 2098044	# 1659
	addi	%x6 %x6 892	# 1659
	lui	%x7 2097960	# 1659
	addi	%x7 %x7 808	# 1659
	addi	%x8 %x7 0	# 80 
	lw	%f1 0(%x8)	# 80 
	addi	%x8 %x6 0	# 80 
	sw	%f1 0(%x8)	# 80 
	addi	%x8 %x7 4	# 81 
	lw	%f1 0(%x8)	# 81 
	addi	%x8 %x6 4	# 81 
	sw	%f1 0(%x8)	# 81 
	addi	%x7 %x7 8	# 82 
	lw	%f1 0(%x7)	# 82 
	addi	%x6 %x6 8	# 82 
	sw	%f1 0(%x6)	# 82 
	lui	%x7 2097960	# 1660
	addi	%x7 %x7 808	# 1660
	lw	%x6 -36(%x2)	# 1660 
	sw	%x1 -40(%x2)	# 1660 
	addi	%x2 %x2 -44	# 1660 
	jal	 %x1 utexture.3058	# 1660 
	addi	%x2 %x2 44	# 1660 
	lw	%x1 -40(%x2)	# 1660 
	addi	%x7 %x0 2	# 120
	lw	%x6 -32(%x2)	# 120 
	sw	%x1 -40(%x2)	# 120 
	addi	%x2 %x2 -44	# 120 
	jal	 %x1 min_caml_sll	# 120 
	addi	%x2 %x2 44	# 120 
	lw	%x1 -40(%x2)	# 120 
	lui	%x7 2097952	# 1663
	addi	%x7 %x7 800	# 1663
	addi	%x7 %x7 0	# 1663 
	lw	%x7 0(%x7)	# 1663 
	add	%x6 %x6 %x7	# 1663 
	lw	%x7 -20(%x2)	# 1663 
	slli	%x8 %x7 2	# 1663 
	lw	%x9 -16(%x2)	# 1663 
	add	%x8 %x9 %x8	# 1663 
	sw	%x6 0(%x8)	# 1663 
	lw	%x6 -4(%x2)	# 384 
	lw	%x8 4(%x6)	# 384 
	slli	%x10 %x7 2	# 1665 
	add	%x8 %x8 %x10	# 1665 
	lw	%x8 0(%x8)	# 1665 
	lui	%x10 2097960	# 1665
	addi	%x10 %x10 808	# 1665
	addi	%x11 %x10 0	# 80 
	lw	%f1 0(%x11)	# 80 
	addi	%x11 %x8 0	# 80 
	sw	%f1 0(%x11)	# 80 
	addi	%x11 %x10 4	# 81 
	lw	%f1 0(%x11)	# 81 
	addi	%x11 %x8 4	# 81 
	sw	%f1 0(%x11)	# 81 
	addi	%x10 %x10 8	# 82 
	lw	%f1 0(%x10)	# 82 
	addi	%x8 %x8 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lw	%x8 12(%x6)	# 399 
	lw	%f1 20(%x29)	# 1669 
	lw	%x10 -36(%x2)	# 276 
	lw	%x11 28(%x10)	# 276 
	addi	%x11 %x11 0	# 281 
	lw	%f2 0(%x11)	# 281 
	fle	%x5 %f1 %f2	# 1669 
	bne	%x5 %x0 fle.21164	# 1669 
	addi	%x11 %x0 0	# 1670
	slli	%x12 %x7 2	# 1670 
	add	%x8 %x8 %x12	# 1670 
	sw	%x11 0(%x8)	# 1670 
	j	fle_cont.21165	# 1669 
fle.21164:	# 1669 
	addi	%x11 %x0 1	# 1672
	slli	%x12 %x7 2	# 1672 
	add	%x8 %x8 %x12	# 1672 
	sw	%x11 0(%x8)	# 1672 
	lw	%x8 16(%x6)	# 406 
	slli	%x11 %x7 2	# 1674 
	add	%x11 %x8 %x11	# 1674 
	lw	%x11 0(%x11)	# 1674 
	lui	%x12 2097988	# 1674
	addi	%x12 %x12 836	# 1674
	addi	%x13 %x12 0	# 80 
	lw	%f1 0(%x13)	# 80 
	addi	%x13 %x11 0	# 80 
	sw	%f1 0(%x13)	# 80 
	addi	%x13 %x12 4	# 81 
	lw	%f1 0(%x13)	# 81 
	addi	%x13 %x11 4	# 81 
	sw	%f1 0(%x13)	# 81 
	addi	%x12 %x12 8	# 82 
	lw	%f1 0(%x12)	# 82 
	addi	%x11 %x11 8	# 82 
	sw	%f1 0(%x11)	# 82 
	slli	%x11 %x7 2	# 1675 
	add	%x8 %x8 %x11	# 1675 
	lw	%x8 0(%x8)	# 1675 
	lw	%f1 180(%x29)	# 1675 
	lw	%f2 -28(%x2)	# 1675 
	fmul	%f1 %f1 %f2	# 1675 
	addi	%x11 %x8 0	# 140 
	lw	%f3 0(%x11)	# 140 
	fmul	%f3 %f3 %f1	# 140 
	addi	%x11 %x8 0	# 140 
	sw	%f3 0(%x11)	# 140 
	addi	%x11 %x8 4	# 141 
	lw	%f3 0(%x11)	# 141 
	fmul	%f3 %f3 %f1	# 141 
	addi	%x11 %x8 4	# 141 
	sw	%f3 0(%x11)	# 141 
	addi	%x11 %x8 8	# 142 
	lw	%f3 0(%x11)	# 142 
	fmul	%f1 %f3 %f1	# 142 
	addi	%x8 %x8 8	# 142 
	sw	%f1 0(%x8)	# 142 
	lw	%x8 28(%x6)	# 443 
	slli	%x11 %x7 2	# 1677 
	add	%x8 %x8 %x11	# 1677 
	lw	%x8 0(%x8)	# 1677 
	lui	%x11 2097976	# 1677
	addi	%x11 %x11 824	# 1677
	addi	%x12 %x11 0	# 80 
	lw	%f1 0(%x12)	# 80 
	addi	%x12 %x8 0	# 80 
	sw	%f1 0(%x12)	# 80 
	addi	%x12 %x11 4	# 81 
	lw	%f1 0(%x12)	# 81 
	addi	%x12 %x8 4	# 81 
	sw	%f1 0(%x12)	# 81 
	addi	%x11 %x11 8	# 82 
	lw	%f1 0(%x11)	# 82 
	addi	%x8 %x8 8	# 82 
	sw	%f1 0(%x8)	# 82 
fle_cont.21165:	# 1669 
	lw	%f1 184(%x29)	# 1680 
	lui	%x8 2097976	# 1680
	addi	%x8 %x8 824	# 1680
	lw	%x11 -12(%x2)	# 109 
	addi	%x12 %x11 0	# 109 
	lw	%f2 0(%x12)	# 109 
	addi	%x12 %x8 0	# 109 
	lw	%f3 0(%x12)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	addi	%x12 %x11 4	# 109 
	lw	%f3 0(%x12)	# 109 
	addi	%x12 %x8 4	# 109 
	lw	%f4 0(%x12)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	addi	%x12 %x11 8	# 109 
	lw	%f3 0(%x12)	# 109 
	addi	%x8 %x8 8	# 109 
	lw	%f4 0(%x8)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	fmul	%f1 %f1 %f2	# 1680 
	lui	%x8 2097976	# 1682
	addi	%x8 %x8 824	# 1682
	addi	%x12 %x11 0	# 119 
	lw	%f2 0(%x12)	# 119 
	addi	%x12 %x8 0	# 119 
	lw	%f3 0(%x12)	# 119 
	fmul	%f3 %f1 %f3	# 119 
	fadd	%f2 %f2 %f3	# 119 
	addi	%x12 %x11 0	# 119 
	sw	%f2 0(%x12)	# 119 
	addi	%x12 %x11 4	# 120 
	lw	%f2 0(%x12)	# 120 
	addi	%x12 %x8 4	# 120 
	lw	%f3 0(%x12)	# 120 
	fmul	%f3 %f1 %f3	# 120 
	fadd	%f2 %f2 %f3	# 120 
	addi	%x12 %x11 4	# 120 
	sw	%f2 0(%x12)	# 120 
	addi	%x12 %x11 8	# 121 
	lw	%f2 0(%x12)	# 121 
	addi	%x8 %x8 8	# 121 
	lw	%f3 0(%x8)	# 121 
	fmul	%f1 %f1 %f3	# 121 
	fadd	%f1 %f2 %f1	# 121 
	addi	%x8 %x11 8	# 121 
	sw	%f1 0(%x8)	# 121 
	lw	%x8 28(%x10)	# 286 
	addi	%x8 %x8 4	# 291 
	lw	%f1 0(%x8)	# 291 
	lw	%f2 -8(%x2)	# 1684 
	fmul	%f1 %f2 %f1	# 1684 
	addi	%x8 %x0 0	# 1687
	lui	%x12 2097944	# 1687
	addi	%x12 %x12 792	# 1687
	addi	%x12 %x12 0	# 1687 
	lw	%x12 0(%x12)	# 1687 
	sw	%f1 -40(%x2)	# 1687 
	add	%x7 %x0 %x12	# 1687 
	add	%x6 %x0 %x8	# 1687 
	sw	%x1 -44(%x2)	# 1687 
	addi	%x2 %x2 -48	# 1687 
	jal	 %x1 shadow_check_one_or_matrix.3018	# 1687 
	addi	%x2 %x2 48	# 1687 
	lw	%x1 -44(%x2)	# 1687 
	bne	%x6 %x0 beq_else.21166	# 1687 
	lw	%f1 48(%x29)	# 1688 
	lui	%x6 2097976	# 1688
	addi	%x6 %x6 824	# 1688
	lui	%x7 2097720	# 1688
	addi	%x7 %x7 568	# 1688
	addi	%x8 %x6 0	# 109 
	lw	%f2 0(%x8)	# 109 
	addi	%x8 %x7 0	# 109 
	lw	%f3 0(%x8)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f3 0(%x8)	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f4 0(%x8)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f3 0(%x6)	# 109 
	addi	%x6 %x7 8	# 109 
	lw	%f4 0(%x6)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	fmul	%f1 %f1 %f2	# 1688 
	lw	%f2 -28(%x2)	# 1688 
	fmul	%f1 %f1 %f2	# 1688 
	lw	%f3 48(%x29)	# 1689 
	lui	%x6 2097720	# 1689
	addi	%x6 %x6 568	# 1689
	lw	%x7 -12(%x2)	# 109 
	addi	%x8 %x7 0	# 109 
	lw	%f4 0(%x8)	# 109 
	addi	%x8 %x6 0	# 109 
	lw	%f5 0(%x8)	# 109 
	fmul	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f6 0(%x8)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	addi	%x8 %x7 8	# 109 
	lw	%f5 0(%x8)	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f6 0(%x6)	# 109 
	fmul	%f5 %f5 %f6	# 109 
	fadd	%f4 %f4 %f5	# 109 
	fmul	%f3 %f3 %f4	# 1689 
	lw	%f4 -40(%x2)	# 1690 
	fadd	%f2 %f0 %f3	# 1690 
	fadd	%f3 %f0 %f4	# 1690 
	sw	%x1 -44(%x2)	# 1690 
	addi	%x2 %x2 -48	# 1690 
	jal	 %x1 add_light.3061	# 1690 
	addi	%x2 %x2 48	# 1690 
	lw	%x1 -44(%x2)	# 1690 
	j	beq_cont.21167	# 1687 
beq_else.21166:	# 1687 
beq_cont.21167:	# 1687 
	lui	%x6 2097960	# 1694
	addi	%x6 %x6 808	# 1694
	lui	%x7 2098056	# 1131
	addi	%x7 %x7 904	# 1131
	addi	%x8 %x6 0	# 80 
	lw	%f1 0(%x8)	# 80 
	addi	%x8 %x7 0	# 80 
	sw	%f1 0(%x8)	# 80 
	addi	%x8 %x6 4	# 81 
	lw	%f1 0(%x8)	# 81 
	addi	%x8 %x7 4	# 81 
	sw	%f1 0(%x8)	# 81 
	addi	%x8 %x6 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
	lui	%x7 2097408	# 1132
	addi	%x7 %x7 256	# 1132
	addi	%x7 %x7 0	# 1132 
	lw	%x7 0(%x7)	# 1132 
	addi	%x7 %x7 -1	# 1132 
	sw	%x1 -44(%x2)	# 1132 
	addi	%x2 %x2 -48	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 48	# 1132 
	lw	%x1 -44(%x2)	# 1132 
	lui	%x6 2099136	# 1695
	addi	%x6 %x6 1984	# 1695
	addi	%x6 %x6 0	# 1695 
	lw	%x6 0(%x6)	# 1695 
	addi	%x6 %x6 -1	# 1695 
	lw	%f1 -28(%x2)	# 1695 
	lw	%f2 -40(%x2)	# 1695 
	lw	%x7 -12(%x2)	# 1695 
	sw	%x1 -44(%x2)	# 1695 
	addi	%x2 %x2 -48	# 1695 
	jal	 %x1 trace_reflections.3065	# 1695 
	addi	%x2 %x2 48	# 1695 
	lw	%x1 -44(%x2)	# 1695 
	lw	%f1 188(%x29)	# 1698 
	lw	%f2 -8(%x2)	# 1698 
	fle	%x5 %f2 %f1	# 1698 
	bne	%x5 %x0 fle_else.21168	# 1698 
	lw	%x6 -20(%x2)	# 1700 
	addi	%x5 %x0 4	# 1700 
	blt	%x6 %x5 bge.21169	# 1700 
	j	beq_cont.21170	# 1700 
bge.21169:	# 1700 
	addi	%x7 %x0 -1	# 1701
	addi	%x8 %x6 1	# 1701 
	slli	%x8 %x8 2	# 1701 
	lw	%x9 -16(%x2)	# 1701 
	add	%x8 %x9 %x8	# 1701 
	sw	%x7 0(%x8)	# 1701 
beq_cont.21170:	# 1700 
	lw	%x7 -24(%x2)	# 1704 
	addi	%x5 %x0 2	# 1704 
	bne	%x7 %x5 beq_else.21171	# 1704 
	lw	%f1 16(%x29)	# 1705 
	lw	%x7 -36(%x2)	# 276 
	lw	%x7 28(%x7)	# 276 
	addi	%x7 %x7 0	# 281 
	lw	%f3 0(%x7)	# 281 
	fsub	%f1 %f1 %f3	# 1705 
	fmul	%f1 %f2 %f1	# 1705 
	addi	%x6 %x6 1	# 1706 
	lui	%x7 2097956	# 1706
	addi	%x7 %x7 804	# 1706
	addi	%x7 %x7 0	# 1706 
	lw	%f2 0(%x7)	# 1706 
	lw	%f3 -0(%x2)	# 1706 
	fadd	%f2 %f3 %f2	# 1706 
	lw	%x7 -12(%x2)	# 1706 
	lw	%x8 -4(%x2)	# 1706 
	j	trace_ray.3070	# 1706 
beq_else.21171:	# 1704 
	jr	0(%x1)	# 1707 
fle_else.21168:	# 1698 
	jr	0(%x1)	# 1709 
blt.21145:	# 1649 
	jr	0(%x1)	# 1730 
trace_diffuse_ray.3076:	#- 38224
	lw	%f2 172(%x29)	# 1451 
	lui	%x7 2097956	# 1451
	addi	%x7 %x7 804	# 1451
	addi	%x7 %x7 0	# 1451 
	sw	%f2 0(%x7)	# 1451 
	addi	%x7 %x0 0	# 1452
	lui	%x8 2097944	# 1452
	addi	%x8 %x8 792	# 1452
	addi	%x8 %x8 0	# 1452 
	lw	%x8 0(%x8)	# 1452 
	sw	%f1 -0(%x2)	# 1452 
	sw	%x6 -4(%x2)	# 1452 
	add	%x5 %x0 %x8	# 1452 
	add	%x8 %x0 %x6	# 1452 
	add	%x6 %x0 %x7	# 1452 
	add	%x7 %x0 %x5	# 1452 
	sw	%x1 -8(%x2)	# 1452 
	addi	%x2 %x2 -12	# 1452 
	jal	 %x1 trace_or_matrix_fast.3043	# 1452 
	addi	%x2 %x2 12	# 1452 
	lw	%x1 -8(%x2)	# 1452 
	lui	%x6 2097956	# 1453
	addi	%x6 %x6 804	# 1453
	addi	%x6 %x6 0	# 1453 
	lw	%f1 0(%x6)	# 1453 
	lw	%f2 124(%x29)	# 1455 
	fle	%x5 %f1 %f2	# 1455 
	bne	%x5 %x0 fle.21175	# 1455 
	lw	%f2 176(%x29)	# 1456 
	fle	%x5 %f2 %f1	# 1456 
	bne	%x5 %x0 fle.21177	# 1456 
	addi	%x6 %x0 1	# 1456
	j	fle_cont.21178	# 1456 
fle.21177:	# 1456 
	addi	%x6 %x0 0	# 1456
fle_cont.21178:	# 1456 
	j	fle_cont.21176	# 1455 
fle.21175:	# 1455 
	addi	%x6 %x0 0	# 1457
fle_cont.21176:	# 1455 
	bne	%x6 %x0 beq_else.21179	# 1744 
	jr	0(%x1)	# 1755 
beq_else.21179:	# 1744 
	lui	%x6 2097456	# 1745
	addi	%x6 %x6 304	# 1745
	lui	%x7 2097972	# 1745
	addi	%x7 %x7 820	# 1745
	addi	%x7 %x7 0	# 1745 
	lw	%x7 0(%x7)	# 1745 
	slli	%x7 %x7 2	# 1745 
	add	%x6 %x6 %x7	# 1745 
	lw	%x6 0(%x6)	# 1745 
	lw	%x7 -4(%x2)	# 454 
	lw	%x7 0(%x7)	# 454 
	lw	%x8 4(%x6)	# 168 
	sw	%x6 -8(%x2)	# 1510 
	addi	%x5 %x0 1	# 1510 
	bne	%x8 %x5 beq_else.21181	# 1510 
	lui	%x8 2097952	# 1471
	addi	%x8 %x8 800	# 1471
	addi	%x8 %x8 0	# 1471 
	lw	%x8 0(%x8)	# 1471 
	lui	%x9 2097976	# 1473
	addi	%x9 %x9 824	# 1473
	lw	%f1 52(%x29)	# 75 
	addi	%x10 %x9 0	# 68 
	sw	%f1 0(%x10)	# 68 
	addi	%x10 %x9 4	# 69 
	sw	%f1 0(%x10)	# 69 
	addi	%x9 %x9 8	# 70 
	sw	%f1 0(%x9)	# 70 
	lw	%f1 48(%x29)	# 1474 
	addi	%x9 %x8 -1	# 1474 
	slli	%x9 %x9 2	# 1474 
	add	%x7 %x7 %x9	# 1474 
	lw	%f2 0(%x7)	# 1474 
	lw	%f3 52(%x29)	# 33 
	fle	%x5 %f2 %f3	# 33 
	fle	%x31 %f3 %f2	# 33 
	and	%x5 %x5 %x31	# 33 
	bne	%x5 %x0 feq.21183	# 33 
	lw	%f3 52(%x29)	# 34 
	fle	%x5 %f2 %f3	# 34 
	bne	%x5 %x0 fle.21185	# 34 
	lw	%f2 16(%x29)	# 34 
	j	fle_cont.21186	# 34 
fle.21185:	# 34 
	lw	%f2 48(%x29)	# 35 
fle_cont.21186:	# 34 
	j	feq_cont.21184	# 33 
feq.21183:	# 33 
	lw	%f2 52(%x29)	# 33 
feq_cont.21184:	# 33 
	fmul	%f1 %f1 %f2	# 1474 
	addi	%x7 %x8 -1	# 1474 
	lui	%x8 2097976	# 1474
	addi	%x8 %x8 824	# 1474
	slli	%x7 %x7 2	# 1474 
	add	%x7 %x8 %x7	# 1474 
	sw	%f1 0(%x7)	# 1474 
	j	beq_cont.21182	# 1510 
beq_else.21181:	# 1510 
	addi	%x5 %x0 2	# 1512 
	bne	%x8 %x5 beq_else.21187	# 1512 
	lw	%f1 48(%x29)	# 1480 
	lw	%x7 16(%x6)	# 206 
	addi	%x7 %x7 0	# 211 
	lw	%f2 0(%x7)	# 211 
	fmul	%f1 %f1 %f2	# 1480 
	lui	%x7 2097976	# 1480
	addi	%x7 %x7 824	# 1480
	addi	%x7 %x7 0	# 1480 
	sw	%f1 0(%x7)	# 1480 
	lw	%f1 48(%x29)	# 1481 
	lw	%x7 16(%x6)	# 216 
	addi	%x7 %x7 4	# 221 
	lw	%f2 0(%x7)	# 221 
	fmul	%f1 %f1 %f2	# 1481 
	lui	%x7 2097976	# 1481
	addi	%x7 %x7 824	# 1481
	addi	%x7 %x7 4	# 1481 
	sw	%f1 0(%x7)	# 1481 
	lw	%f1 48(%x29)	# 1482 
	lw	%x7 16(%x6)	# 226 
	addi	%x7 %x7 8	# 231 
	lw	%f2 0(%x7)	# 231 
	fmul	%f1 %f1 %f2	# 1482 
	lui	%x7 2097976	# 1482
	addi	%x7 %x7 824	# 1482
	addi	%x7 %x7 8	# 1482 
	sw	%f1 0(%x7)	# 1482 
	j	beq_cont.21188	# 1512 
beq_else.21187:	# 1512 
	sw	%x1 -12(%x2)	# 1515 
	addi	%x2 %x2 -16	# 1515 
	jal	 %x1 get_nvector_second.3053	# 1515 
	addi	%x2 %x2 16	# 1515 
	lw	%x1 -12(%x2)	# 1515 
beq_cont.21188:	# 1512 
beq_cont.21182:	# 1510 
	lui	%x7 2097960	# 1747
	addi	%x7 %x7 808	# 1747
	lw	%x6 -8(%x2)	# 1747 
	sw	%x1 -12(%x2)	# 1747 
	addi	%x2 %x2 -16	# 1747 
	jal	 %x1 utexture.3058	# 1747 
	addi	%x2 %x2 16	# 1747 
	lw	%x1 -12(%x2)	# 1747 
	addi	%x6 %x0 0	# 1750
	lui	%x7 2097944	# 1750
	addi	%x7 %x7 792	# 1750
	addi	%x7 %x7 0	# 1750 
	lw	%x7 0(%x7)	# 1750 
	sw	%x1 -12(%x2)	# 1750 
	addi	%x2 %x2 -16	# 1750 
	jal	 %x1 shadow_check_one_or_matrix.3018	# 1750 
	addi	%x2 %x2 16	# 1750 
	lw	%x1 -12(%x2)	# 1750 
	bne	%x6 %x0 beq_else.21189	# 1750 
	lw	%f1 48(%x29)	# 1751 
	lui	%x6 2097976	# 1751
	addi	%x6 %x6 824	# 1751
	lui	%x7 2097720	# 1751
	addi	%x7 %x7 568	# 1751
	addi	%x8 %x6 0	# 109 
	lw	%f2 0(%x8)	# 109 
	addi	%x8 %x7 0	# 109 
	lw	%f3 0(%x8)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	addi	%x8 %x6 4	# 109 
	lw	%f3 0(%x8)	# 109 
	addi	%x8 %x7 4	# 109 
	lw	%f4 0(%x8)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	addi	%x6 %x6 8	# 109 
	lw	%f3 0(%x6)	# 109 
	addi	%x6 %x7 8	# 109 
	lw	%f4 0(%x6)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	fmul	%f1 %f1 %f2	# 1751 
	lw	%f2 52(%x29)	# 1752 
	fle	%x5 %f1 %f2	# 1752 
	bne	%x5 %x0 fle.21190	# 1752 
	j	fle_cont.21191	# 1752 
fle.21190:	# 1752 
	lw	%f1 52(%x29)	# 1752 
fle_cont.21191:	# 1752 
	lui	%x6 2098000	# 1753
	addi	%x6 %x6 848	# 1753
	lw	%f2 -0(%x2)	# 1753 
	fmul	%f1 %f2 %f1	# 1753 
	lw	%x7 -8(%x2)	# 276 
	lw	%x7 28(%x7)	# 276 
	addi	%x7 %x7 0	# 281 
	lw	%f2 0(%x7)	# 281 
	fmul	%f1 %f1 %f2	# 1753 
	lui	%x7 2097988	# 1753
	addi	%x7 %x7 836	# 1753
	addi	%x8 %x6 0	# 119 
	lw	%f2 0(%x8)	# 119 
	addi	%x8 %x7 0	# 119 
	lw	%f3 0(%x8)	# 119 
	fmul	%f3 %f1 %f3	# 119 
	fadd	%f2 %f2 %f3	# 119 
	addi	%x8 %x6 0	# 119 
	sw	%f2 0(%x8)	# 119 
	addi	%x8 %x6 4	# 120 
	lw	%f2 0(%x8)	# 120 
	addi	%x8 %x7 4	# 120 
	lw	%f3 0(%x8)	# 120 
	fmul	%f3 %f1 %f3	# 120 
	fadd	%f2 %f2 %f3	# 120 
	addi	%x8 %x6 4	# 120 
	sw	%f2 0(%x8)	# 120 
	addi	%x8 %x6 8	# 121 
	lw	%f2 0(%x8)	# 121 
	addi	%x7 %x7 8	# 121 
	lw	%f3 0(%x7)	# 121 
	fmul	%f1 %f1 %f3	# 121 
	fadd	%f1 %f2 %f1	# 121 
	addi	%x6 %x6 8	# 121 
	sw	%f1 0(%x6)	# 121 
	jr	0(%x1)	# 121 
beq_else.21189:	# 1750 
	jr	0(%x1)	# 1754 
iter_trace_diffuse_rays.3079:	#- 39068
	blt	%x9 %x0 bge_else.21194	# 1761 
	slli	%x7 %x9 2	# 1762 
	add	%x7 %x6 %x7	# 1762 
	lw	%x7 0(%x7)	# 1762 
	lw	%x7 0(%x7)	# 454 
	lui	%x10 2097976	# 1762
	addi	%x10 %x10 824	# 1762
	addi	%x11 %x7 0	# 109 
	lw	%f1 0(%x11)	# 109 
	addi	%x11 %x10 0	# 109 
	lw	%f2 0(%x11)	# 109 
	fmul	%f1 %f1 %f2	# 109 
	addi	%x11 %x7 4	# 109 
	lw	%f2 0(%x11)	# 109 
	addi	%x11 %x10 4	# 109 
	lw	%f3 0(%x11)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f2 0(%x7)	# 109 
	addi	%x7 %x10 8	# 109 
	lw	%f3 0(%x7)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	lw	%f2 52(%x29)	# 1766 
	sw	%x8 -0(%x2)	# 1766 
	sw	%x6 -4(%x2)	# 1766 
	sw	%x9 -8(%x2)	# 1766 
	fle	%x5 %f2 %f1	# 1766 
	bne	%x5 %x0 fle.21195	# 1766 
	addi	%x7 %x9 1	# 1767 
	slli	%x7 %x7 2	# 1767 
	add	%x7 %x6 %x7	# 1767 
	lw	%x7 0(%x7)	# 1767 
	lw	%f2 192(%x29)	# 1767 
	fdiv	%f1 %f1 %f2	# 1767 
	add	%x6 %x0 %x7	# 1767 
	sw	%x1 -12(%x2)	# 1767 
	addi	%x2 %x2 -16	# 1767 
	jal	 %x1 trace_diffuse_ray.3076	# 1767 
	addi	%x2 %x2 16	# 1767 
	lw	%x1 -12(%x2)	# 1767 
	j	fle_cont.21196	# 1766 
fle.21195:	# 1766 
	slli	%x7 %x9 2	# 1769 
	add	%x7 %x6 %x7	# 1769 
	lw	%x7 0(%x7)	# 1769 
	lw	%f2 196(%x29)	# 1769 
	fdiv	%f1 %f1 %f2	# 1769 
	add	%x6 %x0 %x7	# 1769 
	sw	%x1 -12(%x2)	# 1769 
	addi	%x2 %x2 -16	# 1769 
	jal	 %x1 trace_diffuse_ray.3076	# 1769 
	addi	%x2 %x2 16	# 1769 
	lw	%x1 -12(%x2)	# 1769 
fle_cont.21196:	# 1766 
	lw	%x6 -8(%x2)	# 1771 
	addi	%x6 %x6 -2	# 1771 
	blt	%x6 %x0 bge_else.21197	# 1761 
	slli	%x7 %x6 2	# 1762 
	lw	%x8 -4(%x2)	# 1762 
	add	%x7 %x8 %x7	# 1762 
	lw	%x7 0(%x7)	# 1762 
	lw	%x7 0(%x7)	# 454 
	lui	%x9 2097976	# 1762
	addi	%x9 %x9 824	# 1762
	addi	%x10 %x7 0	# 109 
	lw	%f1 0(%x10)	# 109 
	addi	%x10 %x9 0	# 109 
	lw	%f2 0(%x10)	# 109 
	fmul	%f1 %f1 %f2	# 109 
	addi	%x10 %x7 4	# 109 
	lw	%f2 0(%x10)	# 109 
	addi	%x10 %x9 4	# 109 
	lw	%f3 0(%x10)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f2 0(%x7)	# 109 
	addi	%x7 %x9 8	# 109 
	lw	%f3 0(%x7)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	lw	%f2 52(%x29)	# 1766 
	sw	%x6 -12(%x2)	# 1766 
	fle	%x5 %f2 %f1	# 1766 
	bne	%x5 %x0 fle.21198	# 1766 
	addi	%x7 %x6 1	# 1767 
	slli	%x7 %x7 2	# 1767 
	add	%x7 %x8 %x7	# 1767 
	lw	%x7 0(%x7)	# 1767 
	lw	%f2 192(%x29)	# 1767 
	fdiv	%f1 %f1 %f2	# 1767 
	add	%x6 %x0 %x7	# 1767 
	sw	%x1 -16(%x2)	# 1767 
	addi	%x2 %x2 -20	# 1767 
	jal	 %x1 trace_diffuse_ray.3076	# 1767 
	addi	%x2 %x2 20	# 1767 
	lw	%x1 -16(%x2)	# 1767 
	j	fle_cont.21199	# 1766 
fle.21198:	# 1766 
	slli	%x7 %x6 2	# 1769 
	add	%x7 %x8 %x7	# 1769 
	lw	%x7 0(%x7)	# 1769 
	lw	%f2 196(%x29)	# 1769 
	fdiv	%f1 %f1 %f2	# 1769 
	add	%x6 %x0 %x7	# 1769 
	sw	%x1 -16(%x2)	# 1769 
	addi	%x2 %x2 -20	# 1769 
	jal	 %x1 trace_diffuse_ray.3076	# 1769 
	addi	%x2 %x2 20	# 1769 
	lw	%x1 -16(%x2)	# 1769 
fle_cont.21199:	# 1766 
	lui	%x7 2097976	# 1771
	addi	%x7 %x7 824	# 1771
	lw	%x6 -12(%x2)	# 1771 
	addi	%x9 %x6 -2	# 1771 
	lw	%x6 -4(%x2)	# 1771 
	lw	%x8 -0(%x2)	# 1771 
	j	iter_trace_diffuse_rays.3079	# 1771 
bge_else.21197:	# 1761 
	jr	0(%x1)	# 1772 
bge_else.21194:	# 1761 
	jr	0(%x1)	# 1772 
trace_diffuse_ray_80percent.3086:	#- 39540
	sw	%x8 -0(%x2)	# 1788 
	sw	%x6 -4(%x2)	# 1788 
	bne	%x6 %x0 beq_else.21202	# 1788 
	j	beq_cont.21203	# 1788 
beq_else.21202:	# 1788 
	lui	%x7 2098116	# 1789
	addi	%x7 %x7 964	# 1789
	addi	%x7 %x7 0	# 1789 
	lw	%x7 0(%x7)	# 1789 
	lui	%x9 2098056	# 1131
	addi	%x9 %x9 904	# 1131
	addi	%x10 %x8 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x9 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x10 %x8 8	# 82 
	lw	%f1 0(%x10)	# 82 
	addi	%x9 %x9 8	# 82 
	sw	%f1 0(%x9)	# 82 
	lui	%x9 2097408	# 1132
	addi	%x9 %x9 256	# 1132
	addi	%x9 %x9 0	# 1132 
	lw	%x9 0(%x9)	# 1132 
	addi	%x9 %x9 -1	# 1132 
	sw	%x7 -8(%x2)	# 1132 
	add	%x7 %x0 %x9	# 1132 
	add	%x6 %x0 %x8	# 1132 
	sw	%x1 -12(%x2)	# 1132 
	addi	%x2 %x2 -16	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 16	# 1132 
	lw	%x1 -12(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -8(%x2)	# 1781 
	lw	%x8 -0(%x2)	# 1781 
	sw	%x1 -12(%x2)	# 1781 
	addi	%x2 %x2 -16	# 1781 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1781 
	addi	%x2 %x2 16	# 1781 
	lw	%x1 -12(%x2)	# 1781 
beq_cont.21203:	# 1788 
	lw	%x6 -4(%x2)	# 1792 
	addi	%x5 %x0 1	# 1792 
	bne	%x6 %x5 beq_else.21204	# 1792 
	j	beq_cont.21205	# 1792 
beq_else.21204:	# 1792 
	lui	%x7 2098116	# 1793
	addi	%x7 %x7 964	# 1793
	addi	%x7 %x7 4	# 1793 
	lw	%x7 0(%x7)	# 1793 
	lui	%x8 2098056	# 1131
	addi	%x8 %x8 904	# 1131
	lw	%x9 -0(%x2)	# 80 
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x8 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x10 %x9 8	# 82 
	lw	%f1 0(%x10)	# 82 
	addi	%x8 %x8 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lui	%x8 2097408	# 1132
	addi	%x8 %x8 256	# 1132
	addi	%x8 %x8 0	# 1132 
	lw	%x8 0(%x8)	# 1132 
	addi	%x8 %x8 -1	# 1132 
	sw	%x7 -12(%x2)	# 1132 
	add	%x7 %x0 %x8	# 1132 
	add	%x6 %x0 %x9	# 1132 
	sw	%x1 -16(%x2)	# 1132 
	addi	%x2 %x2 -20	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 20	# 1132 
	lw	%x1 -16(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -12(%x2)	# 1781 
	lw	%x8 -0(%x2)	# 1781 
	sw	%x1 -16(%x2)	# 1781 
	addi	%x2 %x2 -20	# 1781 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1781 
	addi	%x2 %x2 20	# 1781 
	lw	%x1 -16(%x2)	# 1781 
beq_cont.21205:	# 1792 
	lw	%x6 -4(%x2)	# 1796 
	addi	%x5 %x0 2	# 1796 
	bne	%x6 %x5 beq_else.21206	# 1796 
	j	beq_cont.21207	# 1796 
beq_else.21206:	# 1796 
	lui	%x7 2098116	# 1797
	addi	%x7 %x7 964	# 1797
	addi	%x7 %x7 8	# 1797 
	lw	%x7 0(%x7)	# 1797 
	lui	%x8 2098056	# 1131
	addi	%x8 %x8 904	# 1131
	lw	%x9 -0(%x2)	# 80 
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x8 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x10 %x9 8	# 82 
	lw	%f1 0(%x10)	# 82 
	addi	%x8 %x8 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lui	%x8 2097408	# 1132
	addi	%x8 %x8 256	# 1132
	addi	%x8 %x8 0	# 1132 
	lw	%x8 0(%x8)	# 1132 
	addi	%x8 %x8 -1	# 1132 
	sw	%x7 -16(%x2)	# 1132 
	add	%x7 %x0 %x8	# 1132 
	add	%x6 %x0 %x9	# 1132 
	sw	%x1 -20(%x2)	# 1132 
	addi	%x2 %x2 -24	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 24	# 1132 
	lw	%x1 -20(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -16(%x2)	# 1781 
	lw	%x8 -0(%x2)	# 1781 
	sw	%x1 -20(%x2)	# 1781 
	addi	%x2 %x2 -24	# 1781 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1781 
	addi	%x2 %x2 24	# 1781 
	lw	%x1 -20(%x2)	# 1781 
beq_cont.21207:	# 1796 
	lw	%x6 -4(%x2)	# 1800 
	addi	%x5 %x0 3	# 1800 
	bne	%x6 %x5 beq_else.21208	# 1800 
	j	beq_cont.21209	# 1800 
beq_else.21208:	# 1800 
	lui	%x7 2098116	# 1801
	addi	%x7 %x7 964	# 1801
	addi	%x7 %x7 12	# 1801 
	lw	%x7 0(%x7)	# 1801 
	lui	%x8 2098056	# 1131
	addi	%x8 %x8 904	# 1131
	lw	%x9 -0(%x2)	# 80 
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x8 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x10 %x9 8	# 82 
	lw	%f1 0(%x10)	# 82 
	addi	%x8 %x8 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lui	%x8 2097408	# 1132
	addi	%x8 %x8 256	# 1132
	addi	%x8 %x8 0	# 1132 
	lw	%x8 0(%x8)	# 1132 
	addi	%x8 %x8 -1	# 1132 
	sw	%x7 -20(%x2)	# 1132 
	add	%x7 %x0 %x8	# 1132 
	add	%x6 %x0 %x9	# 1132 
	sw	%x1 -24(%x2)	# 1132 
	addi	%x2 %x2 -28	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 28	# 1132 
	lw	%x1 -24(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -20(%x2)	# 1781 
	lw	%x8 -0(%x2)	# 1781 
	sw	%x1 -24(%x2)	# 1781 
	addi	%x2 %x2 -28	# 1781 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1781 
	addi	%x2 %x2 28	# 1781 
	lw	%x1 -24(%x2)	# 1781 
beq_cont.21209:	# 1800 
	lw	%x6 -4(%x2)	# 1804 
	addi	%x5 %x0 4	# 1804 
	bne	%x6 %x5 beq_else.21210	# 1804 
	jr	0(%x1)	# 1806 
beq_else.21210:	# 1804 
	lui	%x6 2098116	# 1805
	addi	%x6 %x6 964	# 1805
	addi	%x6 %x6 16	# 1805 
	lw	%x6 0(%x6)	# 1805 
	lui	%x7 2098056	# 1131
	addi	%x7 %x7 904	# 1131
	lw	%x8 -0(%x2)	# 80 
	addi	%x9 %x8 0	# 80 
	lw	%f1 0(%x9)	# 80 
	addi	%x9 %x7 0	# 80 
	sw	%f1 0(%x9)	# 80 
	addi	%x9 %x8 4	# 81 
	lw	%f1 0(%x9)	# 81 
	addi	%x9 %x7 4	# 81 
	sw	%f1 0(%x9)	# 81 
	addi	%x9 %x8 8	# 82 
	lw	%f1 0(%x9)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
	lui	%x7 2097408	# 1132
	addi	%x7 %x7 256	# 1132
	addi	%x7 %x7 0	# 1132 
	lw	%x7 0(%x7)	# 1132 
	addi	%x7 %x7 -1	# 1132 
	sw	%x6 -24(%x2)	# 1132 
	add	%x6 %x0 %x8	# 1132 
	sw	%x1 -28(%x2)	# 1132 
	addi	%x2 %x2 -32	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 32	# 1132 
	lw	%x1 -28(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -24(%x2)	# 1781 
	lw	%x8 -0(%x2)	# 1781 
	j	iter_trace_diffuse_rays.3079	# 1781 
calc_diffuse_using_1point.3089:	#- 40436
	lw	%x8 20(%x6)	# 413 
	lw	%x9 28(%x6)	# 443 
	lw	%x10 4(%x6)	# 384 
	lw	%x11 16(%x6)	# 406 
	lui	%x12 2098000	# 1819
	addi	%x12 %x12 848	# 1819
	slli	%x13 %x7 2	# 1819 
	add	%x8 %x8 %x13	# 1819 
	lw	%x8 0(%x8)	# 1819 
	addi	%x13 %x8 0	# 80 
	lw	%f1 0(%x13)	# 80 
	addi	%x13 %x12 0	# 80 
	sw	%f1 0(%x13)	# 80 
	addi	%x13 %x8 4	# 81 
	lw	%f1 0(%x13)	# 81 
	addi	%x13 %x12 4	# 81 
	sw	%f1 0(%x13)	# 81 
	addi	%x8 %x8 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x8 %x12 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lw	%x6 24(%x6)	# 429 
	addi	%x6 %x6 0	# 431 
	lw	%x6 0(%x6)	# 431 
	slli	%x8 %x7 2	# 1822 
	add	%x8 %x9 %x8	# 1822 
	lw	%x8 0(%x8)	# 1822 
	slli	%x9 %x7 2	# 1823 
	add	%x9 %x10 %x9	# 1823 
	lw	%x9 0(%x9)	# 1823 
	sw	%x11 -0(%x2)	# 1820 
	sw	%x7 -4(%x2)	# 1820 
	add	%x7 %x0 %x8	# 1820 
	add	%x8 %x0 %x9	# 1820 
	sw	%x1 -8(%x2)	# 1820 
	addi	%x2 %x2 -12	# 1820 
	jal	 %x1 trace_diffuse_ray_80percent.3086	# 1820 
	addi	%x2 %x2 12	# 1820 
	lw	%x1 -8(%x2)	# 1820 
	lui	%x6 2098012	# 1824
	addi	%x6 %x6 860	# 1824
	lw	%x7 -4(%x2)	# 1824 
	slli	%x7 %x7 2	# 1824 
	lw	%x8 -0(%x2)	# 1824 
	add	%x7 %x8 %x7	# 1824 
	lw	%x7 0(%x7)	# 1824 
	lui	%x8 2098000	# 1824
	addi	%x8 %x8 848	# 1824
	addi	%x9 %x6 0	# 147 
	lw	%f1 0(%x9)	# 147 
	addi	%x9 %x7 0	# 147 
	lw	%f2 0(%x9)	# 147 
	addi	%x9 %x8 0	# 147 
	lw	%f3 0(%x9)	# 147 
	fmul	%f2 %f2 %f3	# 147 
	fadd	%f1 %f1 %f2	# 147 
	addi	%x9 %x6 0	# 147 
	sw	%f1 0(%x9)	# 147 
	addi	%x9 %x6 4	# 148 
	lw	%f1 0(%x9)	# 148 
	addi	%x9 %x7 4	# 148 
	lw	%f2 0(%x9)	# 148 
	addi	%x9 %x8 4	# 148 
	lw	%f3 0(%x9)	# 148 
	fmul	%f2 %f2 %f3	# 148 
	fadd	%f1 %f1 %f2	# 148 
	addi	%x9 %x6 4	# 148 
	sw	%f1 0(%x9)	# 148 
	addi	%x9 %x6 8	# 149 
	lw	%f1 0(%x9)	# 149 
	addi	%x7 %x7 8	# 149 
	lw	%f2 0(%x7)	# 149 
	addi	%x7 %x8 8	# 149 
	lw	%f3 0(%x7)	# 149 
	fmul	%f2 %f2 %f3	# 149 
	fadd	%f1 %f1 %f2	# 149 
	addi	%x6 %x6 8	# 149 
	sw	%f1 0(%x6)	# 149 
	jr	0(%x1)	# 149 
calc_diffuse_using_5points.3092:	#- 40752
	slli	%x11 %x6 2	# 1833 
	add	%x7 %x7 %x11	# 1833 
	lw	%x7 0(%x7)	# 1833 
	lw	%x7 20(%x7)	# 413 
	addi	%x11 %x6 -1	# 1834 
	slli	%x11 %x11 2	# 1834 
	add	%x11 %x8 %x11	# 1834 
	lw	%x11 0(%x11)	# 1834 
	lw	%x11 20(%x11)	# 413 
	slli	%x12 %x6 2	# 1835 
	add	%x12 %x8 %x12	# 1835 
	lw	%x12 0(%x12)	# 1835 
	lw	%x12 20(%x12)	# 413 
	addi	%x13 %x6 1	# 1836 
	slli	%x13 %x13 2	# 1836 
	add	%x13 %x8 %x13	# 1836 
	lw	%x13 0(%x13)	# 1836 
	lw	%x13 20(%x13)	# 413 
	slli	%x14 %x6 2	# 1837 
	add	%x9 %x9 %x14	# 1837 
	lw	%x9 0(%x9)	# 1837 
	lw	%x9 20(%x9)	# 413 
	lui	%x14 2098000	# 1839
	addi	%x14 %x14 848	# 1839
	slli	%x15 %x10 2	# 1839 
	add	%x7 %x7 %x15	# 1839 
	lw	%x7 0(%x7)	# 1839 
	addi	%x15 %x7 0	# 80 
	lw	%f1 0(%x15)	# 80 
	addi	%x15 %x14 0	# 80 
	sw	%f1 0(%x15)	# 80 
	addi	%x15 %x7 4	# 81 
	lw	%f1 0(%x15)	# 81 
	addi	%x15 %x14 4	# 81 
	sw	%f1 0(%x15)	# 81 
	addi	%x7 %x7 8	# 82 
	lw	%f1 0(%x7)	# 82 
	addi	%x7 %x14 8	# 82 
	sw	%f1 0(%x7)	# 82 
	lui	%x7 2098000	# 1840
	addi	%x7 %x7 848	# 1840
	slli	%x14 %x10 2	# 1840 
	add	%x11 %x11 %x14	# 1840 
	lw	%x11 0(%x11)	# 1840 
	addi	%x14 %x7 0	# 126 
	lw	%f1 0(%x14)	# 126 
	addi	%x14 %x11 0	# 126 
	lw	%f2 0(%x14)	# 126 
	fadd	%f1 %f1 %f2	# 126 
	addi	%x14 %x7 0	# 126 
	sw	%f1 0(%x14)	# 126 
	addi	%x14 %x7 4	# 127 
	lw	%f1 0(%x14)	# 127 
	addi	%x14 %x11 4	# 127 
	lw	%f2 0(%x14)	# 127 
	fadd	%f1 %f1 %f2	# 127 
	addi	%x14 %x7 4	# 127 
	sw	%f1 0(%x14)	# 127 
	addi	%x14 %x7 8	# 128 
	lw	%f1 0(%x14)	# 128 
	addi	%x11 %x11 8	# 128 
	lw	%f2 0(%x11)	# 128 
	fadd	%f1 %f1 %f2	# 128 
	addi	%x7 %x7 8	# 128 
	sw	%f1 0(%x7)	# 128 
	lui	%x7 2098000	# 1841
	addi	%x7 %x7 848	# 1841
	slli	%x11 %x10 2	# 1841 
	add	%x11 %x12 %x11	# 1841 
	lw	%x11 0(%x11)	# 1841 
	addi	%x12 %x7 0	# 126 
	lw	%f1 0(%x12)	# 126 
	addi	%x12 %x11 0	# 126 
	lw	%f2 0(%x12)	# 126 
	fadd	%f1 %f1 %f2	# 126 
	addi	%x12 %x7 0	# 126 
	sw	%f1 0(%x12)	# 126 
	addi	%x12 %x7 4	# 127 
	lw	%f1 0(%x12)	# 127 
	addi	%x12 %x11 4	# 127 
	lw	%f2 0(%x12)	# 127 
	fadd	%f1 %f1 %f2	# 127 
	addi	%x12 %x7 4	# 127 
	sw	%f1 0(%x12)	# 127 
	addi	%x12 %x7 8	# 128 
	lw	%f1 0(%x12)	# 128 
	addi	%x11 %x11 8	# 128 
	lw	%f2 0(%x11)	# 128 
	fadd	%f1 %f1 %f2	# 128 
	addi	%x7 %x7 8	# 128 
	sw	%f1 0(%x7)	# 128 
	lui	%x7 2098000	# 1842
	addi	%x7 %x7 848	# 1842
	slli	%x11 %x10 2	# 1842 
	add	%x11 %x13 %x11	# 1842 
	lw	%x11 0(%x11)	# 1842 
	addi	%x12 %x7 0	# 126 
	lw	%f1 0(%x12)	# 126 
	addi	%x12 %x11 0	# 126 
	lw	%f2 0(%x12)	# 126 
	fadd	%f1 %f1 %f2	# 126 
	addi	%x12 %x7 0	# 126 
	sw	%f1 0(%x12)	# 126 
	addi	%x12 %x7 4	# 127 
	lw	%f1 0(%x12)	# 127 
	addi	%x12 %x11 4	# 127 
	lw	%f2 0(%x12)	# 127 
	fadd	%f1 %f1 %f2	# 127 
	addi	%x12 %x7 4	# 127 
	sw	%f1 0(%x12)	# 127 
	addi	%x12 %x7 8	# 128 
	lw	%f1 0(%x12)	# 128 
	addi	%x11 %x11 8	# 128 
	lw	%f2 0(%x11)	# 128 
	fadd	%f1 %f1 %f2	# 128 
	addi	%x7 %x7 8	# 128 
	sw	%f1 0(%x7)	# 128 
	lui	%x7 2098000	# 1843
	addi	%x7 %x7 848	# 1843
	slli	%x11 %x10 2	# 1843 
	add	%x9 %x9 %x11	# 1843 
	lw	%x9 0(%x9)	# 1843 
	addi	%x11 %x7 0	# 126 
	lw	%f1 0(%x11)	# 126 
	addi	%x11 %x9 0	# 126 
	lw	%f2 0(%x11)	# 126 
	fadd	%f1 %f1 %f2	# 126 
	addi	%x11 %x7 0	# 126 
	sw	%f1 0(%x11)	# 126 
	addi	%x11 %x7 4	# 127 
	lw	%f1 0(%x11)	# 127 
	addi	%x11 %x9 4	# 127 
	lw	%f2 0(%x11)	# 127 
	fadd	%f1 %f1 %f2	# 127 
	addi	%x11 %x7 4	# 127 
	sw	%f1 0(%x11)	# 127 
	addi	%x11 %x7 8	# 128 
	lw	%f1 0(%x11)	# 128 
	addi	%x9 %x9 8	# 128 
	lw	%f2 0(%x9)	# 128 
	fadd	%f1 %f1 %f2	# 128 
	addi	%x7 %x7 8	# 128 
	sw	%f1 0(%x7)	# 128 
	slli	%x6 %x6 2	# 1845 
	add	%x6 %x8 %x6	# 1845 
	lw	%x6 0(%x6)	# 1845 
	lw	%x6 16(%x6)	# 406 
	lui	%x7 2098012	# 1846
	addi	%x7 %x7 860	# 1846
	slli	%x8 %x10 2	# 1846 
	add	%x6 %x6 %x8	# 1846 
	lw	%x6 0(%x6)	# 1846 
	lui	%x8 2098000	# 1846
	addi	%x8 %x8 848	# 1846
	addi	%x9 %x7 0	# 147 
	lw	%f1 0(%x9)	# 147 
	addi	%x9 %x6 0	# 147 
	lw	%f2 0(%x9)	# 147 
	addi	%x9 %x8 0	# 147 
	lw	%f3 0(%x9)	# 147 
	fmul	%f2 %f2 %f3	# 147 
	fadd	%f1 %f1 %f2	# 147 
	addi	%x9 %x7 0	# 147 
	sw	%f1 0(%x9)	# 147 
	addi	%x9 %x7 4	# 148 
	lw	%f1 0(%x9)	# 148 
	addi	%x9 %x6 4	# 148 
	lw	%f2 0(%x9)	# 148 
	addi	%x9 %x8 4	# 148 
	lw	%f3 0(%x9)	# 148 
	fmul	%f2 %f2 %f3	# 148 
	fadd	%f1 %f1 %f2	# 148 
	addi	%x9 %x7 4	# 148 
	sw	%f1 0(%x9)	# 148 
	addi	%x9 %x7 8	# 149 
	lw	%f1 0(%x9)	# 149 
	addi	%x6 %x6 8	# 149 
	lw	%f2 0(%x6)	# 149 
	addi	%x6 %x8 8	# 149 
	lw	%f3 0(%x6)	# 149 
	fmul	%f2 %f2 %f3	# 149 
	fadd	%f1 %f1 %f2	# 149 
	addi	%x6 %x7 8	# 149 
	sw	%f1 0(%x6)	# 149 
	jr	0(%x1)	# 149 
do_without_neighbors.3098:	#- 41492
	addi	%x5 %x0 4	# 1852 
	blt	%x5 %x7 blt.21214	# 1852 
	lw	%x8 8(%x6)	# 392 
	slli	%x9 %x7 2	# 1855 
	add	%x8 %x8 %x9	# 1855 
	lw	%x8 0(%x8)	# 1855 
	blt	%x8 %x0 bge_else.21215	# 1855 
	lw	%x8 12(%x6)	# 399 
	slli	%x9 %x7 2	# 1857 
	add	%x8 %x8 %x9	# 1857 
	lw	%x8 0(%x8)	# 1857 
	sw	%x6 -0(%x2)	# 1857 
	bne	%x8 %x0 beq_else.21216	# 1857 
	j	beq_cont.21217	# 1857 
beq_else.21216:	# 1857 
	lw	%x8 20(%x6)	# 413 
	lw	%x9 28(%x6)	# 443 
	lw	%x10 4(%x6)	# 384 
	lw	%x11 16(%x6)	# 406 
	lui	%x12 2098000	# 1819
	addi	%x12 %x12 848	# 1819
	slli	%x13 %x7 2	# 1819 
	add	%x8 %x8 %x13	# 1819 
	lw	%x8 0(%x8)	# 1819 
	addi	%x13 %x8 0	# 80 
	lw	%f1 0(%x13)	# 80 
	addi	%x13 %x12 0	# 80 
	sw	%f1 0(%x13)	# 80 
	addi	%x13 %x8 4	# 81 
	lw	%f1 0(%x13)	# 81 
	addi	%x13 %x12 4	# 81 
	sw	%f1 0(%x13)	# 81 
	addi	%x8 %x8 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x8 %x12 8	# 82 
	sw	%f1 0(%x8)	# 82 
	lw	%x8 24(%x6)	# 429 
	addi	%x8 %x8 0	# 431 
	lw	%x8 0(%x8)	# 431 
	slli	%x12 %x7 2	# 1822 
	add	%x9 %x9 %x12	# 1822 
	lw	%x9 0(%x9)	# 1822 
	slli	%x12 %x7 2	# 1823 
	add	%x10 %x10 %x12	# 1823 
	lw	%x10 0(%x10)	# 1823 
	sw	%x11 -4(%x2)	# 1820 
	sw	%x7 -8(%x2)	# 1820 
	add	%x7 %x0 %x9	# 1820 
	add	%x6 %x0 %x8	# 1820 
	add	%x8 %x0 %x10	# 1820 
	sw	%x1 -12(%x2)	# 1820 
	addi	%x2 %x2 -16	# 1820 
	jal	 %x1 trace_diffuse_ray_80percent.3086	# 1820 
	addi	%x2 %x2 16	# 1820 
	lw	%x1 -12(%x2)	# 1820 
	lui	%x6 2098012	# 1824
	addi	%x6 %x6 860	# 1824
	lw	%x7 -8(%x2)	# 1824 
	slli	%x8 %x7 2	# 1824 
	lw	%x9 -4(%x2)	# 1824 
	add	%x8 %x9 %x8	# 1824 
	lw	%x8 0(%x8)	# 1824 
	lui	%x9 2098000	# 1824
	addi	%x9 %x9 848	# 1824
	addi	%x10 %x6 0	# 147 
	lw	%f1 0(%x10)	# 147 
	addi	%x10 %x8 0	# 147 
	lw	%f2 0(%x10)	# 147 
	addi	%x10 %x9 0	# 147 
	lw	%f3 0(%x10)	# 147 
	fmul	%f2 %f2 %f3	# 147 
	fadd	%f1 %f1 %f2	# 147 
	addi	%x10 %x6 0	# 147 
	sw	%f1 0(%x10)	# 147 
	addi	%x10 %x6 4	# 148 
	lw	%f1 0(%x10)	# 148 
	addi	%x10 %x8 4	# 148 
	lw	%f2 0(%x10)	# 148 
	addi	%x10 %x9 4	# 148 
	lw	%f3 0(%x10)	# 148 
	fmul	%f2 %f2 %f3	# 148 
	fadd	%f1 %f1 %f2	# 148 
	addi	%x10 %x6 4	# 148 
	sw	%f1 0(%x10)	# 148 
	addi	%x10 %x6 8	# 149 
	lw	%f1 0(%x10)	# 149 
	addi	%x8 %x8 8	# 149 
	lw	%f2 0(%x8)	# 149 
	addi	%x8 %x9 8	# 149 
	lw	%f3 0(%x8)	# 149 
	fmul	%f2 %f2 %f3	# 149 
	fadd	%f1 %f1 %f2	# 149 
	addi	%x6 %x6 8	# 149 
	sw	%f1 0(%x6)	# 149 
beq_cont.21217:	# 1857 
	addi	%x7 %x7 1	# 1860 
	addi	%x5 %x0 4	# 1852 
	blt	%x5 %x7 blt.21218	# 1852 
	lw	%x6 -0(%x2)	# 392 
	lw	%x8 8(%x6)	# 392 
	slli	%x9 %x7 2	# 1855 
	add	%x8 %x8 %x9	# 1855 
	lw	%x8 0(%x8)	# 1855 
	blt	%x8 %x0 bge_else.21219	# 1855 
	lw	%x8 12(%x6)	# 399 
	slli	%x9 %x7 2	# 1857 
	add	%x8 %x8 %x9	# 1857 
	lw	%x8 0(%x8)	# 1857 
	sw	%x7 -12(%x2)	# 1857 
	bne	%x8 %x0 beq_else.21220	# 1857 
	j	beq_cont.21221	# 1857 
beq_else.21220:	# 1857 
	sw	%x1 -16(%x2)	# 1858 
	addi	%x2 %x2 -20	# 1858 
	jal	 %x1 calc_diffuse_using_1point.3089	# 1858 
	addi	%x2 %x2 20	# 1858 
	lw	%x1 -16(%x2)	# 1858 
beq_cont.21221:	# 1857 
	lw	%x6 -12(%x2)	# 1860 
	addi	%x7 %x6 1	# 1860 
	lw	%x6 -0(%x2)	# 1860 
	j	do_without_neighbors.3098	# 1860 
bge_else.21219:	# 1855 
	jr	0(%x1)	# 1861 
blt.21218:	# 1852 
	jr	0(%x1)	# 1862 
bge_else.21215:	# 1855 
	jr	0(%x1)	# 1861 
blt.21214:	# 1852 
	jr	0(%x1)	# 1862 
try_exploit_neighbors.3114:	#- 41980
	slli	%x12 %x6 2	# 1904 
	add	%x12 %x9 %x12	# 1904 
	lw	%x12 0(%x12)	# 1904 
	addi	%x5 %x0 4	# 1905 
	blt	%x5 %x11 blt.21226	# 1905 
	lw	%x13 8(%x12)	# 392 
	slli	%x14 %x11 2	# 1880 
	add	%x13 %x13 %x14	# 1880 
	lw	%x13 0(%x13)	# 1880 
	blt	%x13 %x0 bge_else.21227	# 1908 
	slli	%x13 %x6 2	# 1886 
	add	%x13 %x9 %x13	# 1886 
	lw	%x13 0(%x13)	# 1886 
	lw	%x13 8(%x13)	# 392 
	slli	%x14 %x11 2	# 1880 
	add	%x13 %x13 %x14	# 1880 
	lw	%x13 0(%x13)	# 1880 
	slli	%x14 %x6 2	# 1888 
	add	%x14 %x8 %x14	# 1888 
	lw	%x14 0(%x14)	# 1888 
	lw	%x14 8(%x14)	# 392 
	slli	%x15 %x11 2	# 1880 
	add	%x14 %x14 %x15	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21228	# 1888 
	slli	%x14 %x6 2	# 1889 
	add	%x14 %x10 %x14	# 1889 
	lw	%x14 0(%x14)	# 1889 
	lw	%x14 8(%x14)	# 392 
	slli	%x15 %x11 2	# 1880 
	add	%x14 %x14 %x15	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21230	# 1889 
	addi	%x14 %x6 -1	# 1890 
	slli	%x14 %x14 2	# 1890 
	add	%x14 %x9 %x14	# 1890 
	lw	%x14 0(%x14)	# 1890 
	lw	%x14 8(%x14)	# 392 
	slli	%x15 %x11 2	# 1880 
	add	%x14 %x14 %x15	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21232	# 1890 
	addi	%x14 %x6 1	# 1891 
	slli	%x14 %x14 2	# 1891 
	add	%x14 %x9 %x14	# 1891 
	lw	%x14 0(%x14)	# 1891 
	lw	%x14 8(%x14)	# 392 
	slli	%x15 %x11 2	# 1880 
	add	%x14 %x14 %x15	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21234	# 1891 
	addi	%x13 %x0 1	# 1892
	j	beq_cont.21235	# 1891 
beq_else.21234:	# 1891 
	addi	%x13 %x0 0	# 1893
beq_cont.21235:	# 1891 
	j	beq_cont.21233	# 1890 
beq_else.21232:	# 1890 
	addi	%x13 %x0 0	# 1894
beq_cont.21233:	# 1890 
	j	beq_cont.21231	# 1889 
beq_else.21230:	# 1889 
	addi	%x13 %x0 0	# 1895
beq_cont.21231:	# 1889 
	j	beq_cont.21229	# 1888 
beq_else.21228:	# 1888 
	addi	%x13 %x0 0	# 1896
beq_cont.21229:	# 1888 
	bne	%x13 %x0 beq_else.21236	# 1910 
	slli	%x6 %x6 2	# 1922 
	add	%x6 %x9 %x6	# 1922 
	lw	%x6 0(%x6)	# 1922 
	addi	%x5 %x0 4	# 1852 
	blt	%x5 %x11 blt.21237	# 1852 
	lw	%x7 8(%x6)	# 392 
	slli	%x8 %x11 2	# 1855 
	add	%x7 %x7 %x8	# 1855 
	lw	%x7 0(%x7)	# 1855 
	blt	%x7 %x0 bge_else.21238	# 1855 
	lw	%x7 12(%x6)	# 399 
	slli	%x8 %x11 2	# 1857 
	add	%x7 %x7 %x8	# 1857 
	lw	%x7 0(%x7)	# 1857 
	sw	%x6 -0(%x2)	# 1857 
	sw	%x11 -4(%x2)	# 1857 
	bne	%x7 %x0 beq_else.21239	# 1857 
	j	beq_cont.21240	# 1857 
beq_else.21239:	# 1857 
	add	%x7 %x0 %x11	# 1858 
	sw	%x1 -8(%x2)	# 1858 
	addi	%x2 %x2 -12	# 1858 
	jal	 %x1 calc_diffuse_using_1point.3089	# 1858 
	addi	%x2 %x2 12	# 1858 
	lw	%x1 -8(%x2)	# 1858 
beq_cont.21240:	# 1857 
	lw	%x6 -4(%x2)	# 1860 
	addi	%x7 %x6 1	# 1860 
	lw	%x6 -0(%x2)	# 1860 
	j	do_without_neighbors.3098	# 1860 
bge_else.21238:	# 1855 
	jr	0(%x1)	# 1861 
blt.21237:	# 1852 
	jr	0(%x1)	# 1862 
beq_else.21236:	# 1910 
	lw	%x12 12(%x12)	# 399 
	slli	%x13 %x11 2	# 1914 
	add	%x12 %x12 %x13	# 1914 
	lw	%x12 0(%x12)	# 1914 
	sw	%x7 -8(%x2)	# 1914 
	sw	%x10 -12(%x2)	# 1914 
	sw	%x8 -16(%x2)	# 1914 
	sw	%x9 -20(%x2)	# 1914 
	sw	%x6 -24(%x2)	# 1914 
	sw	%x11 -4(%x2)	# 1914 
	bne	%x12 %x0 beq_else.21243	# 1914 
	j	beq_cont.21244	# 1914 
beq_else.21243:	# 1914 
	add	%x7 %x0 %x8	# 1915 
	add	%x8 %x0 %x9	# 1915 
	add	%x9 %x0 %x10	# 1915 
	add	%x10 %x0 %x11	# 1915 
	sw	%x1 -28(%x2)	# 1915 
	addi	%x2 %x2 -32	# 1915 
	jal	 %x1 calc_diffuse_using_5points.3092	# 1915 
	addi	%x2 %x2 32	# 1915 
	lw	%x1 -28(%x2)	# 1915 
beq_cont.21244:	# 1914 
	lw	%x6 -4(%x2)	# 1919 
	addi	%x7 %x6 1	# 1919 
	lw	%x6 -24(%x2)	# 1904 
	slli	%x8 %x6 2	# 1904 
	lw	%x9 -20(%x2)	# 1904 
	add	%x8 %x9 %x8	# 1904 
	lw	%x8 0(%x8)	# 1904 
	addi	%x5 %x0 4	# 1905 
	blt	%x5 %x7 blt.21245	# 1905 
	lw	%x10 8(%x8)	# 392 
	slli	%x11 %x7 2	# 1880 
	add	%x10 %x10 %x11	# 1880 
	lw	%x10 0(%x10)	# 1880 
	blt	%x10 %x0 bge_else.21246	# 1908 
	slli	%x10 %x6 2	# 1886 
	add	%x10 %x9 %x10	# 1886 
	lw	%x10 0(%x10)	# 1886 
	lw	%x10 8(%x10)	# 392 
	slli	%x11 %x7 2	# 1880 
	add	%x10 %x10 %x11	# 1880 
	lw	%x10 0(%x10)	# 1880 
	slli	%x11 %x6 2	# 1888 
	lw	%x12 -16(%x2)	# 1888 
	add	%x11 %x12 %x11	# 1888 
	lw	%x11 0(%x11)	# 1888 
	lw	%x11 8(%x11)	# 392 
	slli	%x13 %x7 2	# 1880 
	add	%x11 %x11 %x13	# 1880 
	lw	%x11 0(%x11)	# 1880 
	bne	%x11 %x10 beq_else.21247	# 1888 
	slli	%x11 %x6 2	# 1889 
	lw	%x13 -12(%x2)	# 1889 
	add	%x11 %x13 %x11	# 1889 
	lw	%x11 0(%x11)	# 1889 
	lw	%x11 8(%x11)	# 392 
	slli	%x14 %x7 2	# 1880 
	add	%x11 %x11 %x14	# 1880 
	lw	%x11 0(%x11)	# 1880 
	bne	%x11 %x10 beq_else.21249	# 1889 
	addi	%x11 %x6 -1	# 1890 
	slli	%x11 %x11 2	# 1890 
	add	%x11 %x9 %x11	# 1890 
	lw	%x11 0(%x11)	# 1890 
	lw	%x11 8(%x11)	# 392 
	slli	%x14 %x7 2	# 1880 
	add	%x11 %x11 %x14	# 1880 
	lw	%x11 0(%x11)	# 1880 
	bne	%x11 %x10 beq_else.21251	# 1890 
	addi	%x11 %x6 1	# 1891 
	slli	%x11 %x11 2	# 1891 
	add	%x11 %x9 %x11	# 1891 
	lw	%x11 0(%x11)	# 1891 
	lw	%x11 8(%x11)	# 392 
	slli	%x14 %x7 2	# 1880 
	add	%x11 %x11 %x14	# 1880 
	lw	%x11 0(%x11)	# 1880 
	bne	%x11 %x10 beq_else.21253	# 1891 
	addi	%x10 %x0 1	# 1892
	j	beq_cont.21254	# 1891 
beq_else.21253:	# 1891 
	addi	%x10 %x0 0	# 1893
beq_cont.21254:	# 1891 
	j	beq_cont.21252	# 1890 
beq_else.21251:	# 1890 
	addi	%x10 %x0 0	# 1894
beq_cont.21252:	# 1890 
	j	beq_cont.21250	# 1889 
beq_else.21249:	# 1889 
	addi	%x10 %x0 0	# 1895
beq_cont.21250:	# 1889 
	j	beq_cont.21248	# 1888 
beq_else.21247:	# 1888 
	addi	%x10 %x0 0	# 1896
beq_cont.21248:	# 1888 
	bne	%x10 %x0 beq_else.21255	# 1910 
	slli	%x6 %x6 2	# 1922 
	add	%x6 %x9 %x6	# 1922 
	lw	%x6 0(%x6)	# 1922 
	j	do_without_neighbors.3098	# 1922 
beq_else.21255:	# 1910 
	lw	%x8 12(%x8)	# 399 
	slli	%x10 %x7 2	# 1914 
	add	%x8 %x8 %x10	# 1914 
	lw	%x8 0(%x8)	# 1914 
	sw	%x7 -28(%x2)	# 1914 
	bne	%x8 %x0 beq_else.21256	# 1914 
	j	beq_cont.21257	# 1914 
beq_else.21256:	# 1914 
	lw	%x8 -12(%x2)	# 1915 
	add	%x10 %x0 %x7	# 1915 
	add	%x7 %x0 %x12	# 1915 
	add	%x5 %x0 %x9	# 1915 
	add	%x9 %x0 %x8	# 1915 
	add	%x8 %x0 %x5	# 1915 
	sw	%x1 -32(%x2)	# 1915 
	addi	%x2 %x2 -36	# 1915 
	jal	 %x1 calc_diffuse_using_5points.3092	# 1915 
	addi	%x2 %x2 36	# 1915 
	lw	%x1 -32(%x2)	# 1915 
beq_cont.21257:	# 1914 
	lw	%x6 -28(%x2)	# 1919 
	addi	%x11 %x6 1	# 1919 
	lw	%x6 -24(%x2)	# 1919 
	lw	%x7 -8(%x2)	# 1919 
	lw	%x8 -16(%x2)	# 1919 
	lw	%x9 -20(%x2)	# 1919 
	lw	%x10 -12(%x2)	# 1919 
	j	try_exploit_neighbors.3114	# 1919 
bge_else.21246:	# 1908 
	jr	0(%x1)	# 1923 
blt.21245:	# 1905 
	jr	0(%x1)	# 1924 
bge_else.21227:	# 1908 
	jr	0(%x1)	# 1923 
blt.21226:	# 1905 
	jr	0(%x1)	# 1924 
write_rgb.3125:	#- 42832
	lui	%x6 2098012	# 1951
	addi	%x6 %x6 860	# 1951
	addi	%x6 %x6 0	# 1951 
	lw	%f1 0(%x6)	# 1951 
	sw	%x1 0(%x2)	# 1945 
	addi	%x2 %x2 -4	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 4	# 1945 
	lw	%x1 0(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21262	# 1946 
	blt	%x6 %x0 bge.21264	# 1946 
	j	beq_cont.21265	# 1946 
bge.21264:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21265:	# 1946 
	j	blt_cont.21263	# 1946 
blt.21262:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21263:	# 1946 
	sw	%x1 0(%x2)	# 1947 
	addi	%x2 %x2 -4	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 4	# 1947 
	lw	%x1 0(%x2)	# 1947 
	addi	%x6 %x0 32	# 1952
	sw	%x1 0(%x2)	# 1952 
	addi	%x2 %x2 -4	# 1952 
	jal	 %x1 min_caml_print_char	# 1952 
	addi	%x2 %x2 4	# 1952 
	lw	%x1 0(%x2)	# 1952 
	lui	%x6 2098012	# 1953
	addi	%x6 %x6 860	# 1953
	addi	%x6 %x6 4	# 1953 
	lw	%f1 0(%x6)	# 1953 
	sw	%x1 0(%x2)	# 1945 
	addi	%x2 %x2 -4	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 4	# 1945 
	lw	%x1 0(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21266	# 1946 
	blt	%x6 %x0 bge.21268	# 1946 
	j	beq_cont.21269	# 1946 
bge.21268:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21269:	# 1946 
	j	blt_cont.21267	# 1946 
blt.21266:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21267:	# 1946 
	sw	%x1 0(%x2)	# 1947 
	addi	%x2 %x2 -4	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 4	# 1947 
	lw	%x1 0(%x2)	# 1947 
	addi	%x6 %x0 32	# 1954
	sw	%x1 0(%x2)	# 1954 
	addi	%x2 %x2 -4	# 1954 
	jal	 %x1 min_caml_print_char	# 1954 
	addi	%x2 %x2 4	# 1954 
	lw	%x1 0(%x2)	# 1954 
	lui	%x6 2098012	# 1955
	addi	%x6 %x6 860	# 1955
	addi	%x6 %x6 8	# 1955 
	lw	%f1 0(%x6)	# 1955 
	sw	%x1 0(%x2)	# 1945 
	addi	%x2 %x2 -4	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 4	# 1945 
	lw	%x1 0(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21270	# 1946 
	blt	%x6 %x0 bge.21272	# 1946 
	j	beq_cont.21273	# 1946 
bge.21272:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21273:	# 1946 
	j	blt_cont.21271	# 1946 
blt.21270:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21271:	# 1946 
	sw	%x1 0(%x2)	# 1947 
	addi	%x2 %x2 -4	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 4	# 1947 
	lw	%x1 0(%x2)	# 1947 
	addi	%x6 %x0 10	# 1956
	j	min_caml_print_char	# 1956 
pretrace_diffuse_rays.3127:	#- 43140
	addi	%x5 %x0 4	# 1968 
	blt	%x5 %x7 blt.21274	# 1968 
	lw	%x8 8(%x6)	# 392 
	slli	%x9 %x7 2	# 1880 
	add	%x8 %x8 %x9	# 1880 
	lw	%x8 0(%x8)	# 1880 
	blt	%x8 %x0 bge_else.21275	# 1972 
	lw	%x8 12(%x6)	# 399 
	slli	%x9 %x7 2	# 1975 
	add	%x8 %x8 %x9	# 1975 
	lw	%x8 0(%x8)	# 1975 
	sw	%x7 -0(%x2)	# 1975 
	bne	%x8 %x0 beq_else.21276	# 1975 
	j	beq_cont.21277	# 1975 
beq_else.21276:	# 1975 
	lw	%x8 24(%x6)	# 429 
	addi	%x8 %x8 0	# 431 
	lw	%x8 0(%x8)	# 431 
	lui	%x9 2098000	# 1977
	addi	%x9 %x9 848	# 1977
	lw	%f1 52(%x29)	# 75 
	addi	%x10 %x9 0	# 68 
	sw	%f1 0(%x10)	# 68 
	addi	%x10 %x9 4	# 69 
	sw	%f1 0(%x10)	# 69 
	addi	%x9 %x9 8	# 70 
	sw	%f1 0(%x9)	# 70 
	lw	%x9 4(%x6)	# 384 
	lui	%x10 2098116	# 1984
	addi	%x10 %x10 964	# 1984
	slli	%x8 %x8 2	# 1984 
	add	%x8 %x10 %x8	# 1984 
	lw	%x8 0(%x8)	# 1984 
	slli	%x10 %x7 2	# 1986 
	add	%x9 %x9 %x10	# 1986 
	lw	%x9 0(%x9)	# 1986 
	lui	%x10 2098056	# 1131
	addi	%x10 %x10 904	# 1131
	addi	%x11 %x9 0	# 80 
	lw	%f1 0(%x11)	# 80 
	addi	%x11 %x10 0	# 80 
	sw	%f1 0(%x11)	# 80 
	addi	%x11 %x9 4	# 81 
	lw	%f1 0(%x11)	# 81 
	addi	%x11 %x10 4	# 81 
	sw	%f1 0(%x11)	# 81 
	addi	%x11 %x9 8	# 82 
	lw	%f1 0(%x11)	# 82 
	addi	%x10 %x10 8	# 82 
	sw	%f1 0(%x10)	# 82 
	lui	%x10 2097408	# 1132
	addi	%x10 %x10 256	# 1132
	addi	%x10 %x10 0	# 1132 
	lw	%x10 0(%x10)	# 1132 
	addi	%x10 %x10 -1	# 1132 
	sw	%x6 -4(%x2)	# 1132 
	sw	%x9 -8(%x2)	# 1132 
	sw	%x8 -12(%x2)	# 1132 
	add	%x7 %x0 %x10	# 1132 
	add	%x6 %x0 %x9	# 1132 
	sw	%x1 -16(%x2)	# 1132 
	addi	%x2 %x2 -20	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 20	# 1132 
	lw	%x1 -16(%x2)	# 1132 
	lui	%x7 2097976	# 1781
	addi	%x7 %x7 824	# 1781
	addi	%x9 %x0 118	# 1781
	lw	%x6 -12(%x2)	# 1781 
	lw	%x8 -8(%x2)	# 1781 
	sw	%x1 -16(%x2)	# 1781 
	addi	%x2 %x2 -20	# 1781 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1781 
	addi	%x2 %x2 20	# 1781 
	lw	%x1 -16(%x2)	# 1781 
	lw	%x6 -4(%x2)	# 413 
	lw	%x7 20(%x6)	# 413 
	lw	%x8 -0(%x2)	# 1988 
	slli	%x9 %x8 2	# 1988 
	add	%x7 %x7 %x9	# 1988 
	lw	%x7 0(%x7)	# 1988 
	lui	%x9 2098000	# 1988
	addi	%x9 %x9 848	# 1988
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x7 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x7 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x9 %x9 8	# 82 
	lw	%f1 0(%x9)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
beq_cont.21277:	# 1975 
	lw	%x7 -0(%x2)	# 1990 
	addi	%x7 %x7 1	# 1990 
	addi	%x5 %x0 4	# 1968 
	blt	%x5 %x7 blt.21278	# 1968 
	lw	%x8 8(%x6)	# 392 
	slli	%x9 %x7 2	# 1880 
	add	%x8 %x8 %x9	# 1880 
	lw	%x8 0(%x8)	# 1880 
	blt	%x8 %x0 bge_else.21279	# 1972 
	lw	%x8 12(%x6)	# 399 
	slli	%x9 %x7 2	# 1975 
	add	%x8 %x8 %x9	# 1975 
	lw	%x8 0(%x8)	# 1975 
	sw	%x7 -16(%x2)	# 1975 
	bne	%x8 %x0 beq_else.21280	# 1975 
	j	beq_cont.21281	# 1975 
beq_else.21280:	# 1975 
	lw	%x8 24(%x6)	# 429 
	addi	%x8 %x8 0	# 431 
	lw	%x8 0(%x8)	# 431 
	lui	%x9 2098000	# 1977
	addi	%x9 %x9 848	# 1977
	lw	%f1 52(%x29)	# 75 
	addi	%x10 %x9 0	# 68 
	sw	%f1 0(%x10)	# 68 
	addi	%x10 %x9 4	# 69 
	sw	%f1 0(%x10)	# 69 
	addi	%x9 %x9 8	# 70 
	sw	%f1 0(%x9)	# 70 
	lw	%x9 4(%x6)	# 384 
	lui	%x10 2098116	# 1984
	addi	%x10 %x10 964	# 1984
	slli	%x8 %x8 2	# 1984 
	add	%x8 %x10 %x8	# 1984 
	lw	%x8 0(%x8)	# 1984 
	slli	%x10 %x7 2	# 1986 
	add	%x9 %x9 %x10	# 1986 
	lw	%x9 0(%x9)	# 1986 
	lui	%x10 2098056	# 1131
	addi	%x10 %x10 904	# 1131
	addi	%x11 %x9 0	# 80 
	lw	%f1 0(%x11)	# 80 
	addi	%x11 %x10 0	# 80 
	sw	%f1 0(%x11)	# 80 
	addi	%x11 %x9 4	# 81 
	lw	%f1 0(%x11)	# 81 
	addi	%x11 %x10 4	# 81 
	sw	%f1 0(%x11)	# 81 
	addi	%x11 %x9 8	# 82 
	lw	%f1 0(%x11)	# 82 
	addi	%x10 %x10 8	# 82 
	sw	%f1 0(%x10)	# 82 
	lui	%x10 2097408	# 1132
	addi	%x10 %x10 256	# 1132
	addi	%x10 %x10 0	# 1132 
	lw	%x10 0(%x10)	# 1132 
	addi	%x10 %x10 -1	# 1132 
	sw	%x6 -4(%x2)	# 1132 
	sw	%x9 -20(%x2)	# 1132 
	sw	%x8 -24(%x2)	# 1132 
	add	%x7 %x0 %x10	# 1132 
	add	%x6 %x0 %x9	# 1132 
	sw	%x1 -28(%x2)	# 1132 
	addi	%x2 %x2 -32	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 32	# 1132 
	lw	%x1 -28(%x2)	# 1132 
	lw	%x6 -24(%x2)	# 1762 
	addi	%x7 %x6 472	# 1762 
	lw	%x7 0(%x7)	# 1762 
	lw	%x7 0(%x7)	# 454 
	lui	%x8 2097976	# 1762
	addi	%x8 %x8 824	# 1762
	addi	%x9 %x7 0	# 109 
	lw	%f1 0(%x9)	# 109 
	addi	%x9 %x8 0	# 109 
	lw	%f2 0(%x9)	# 109 
	fmul	%f1 %f1 %f2	# 109 
	addi	%x9 %x7 4	# 109 
	lw	%f2 0(%x9)	# 109 
	addi	%x9 %x8 4	# 109 
	lw	%f3 0(%x9)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f2 0(%x7)	# 109 
	addi	%x7 %x8 8	# 109 
	lw	%f3 0(%x7)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	lw	%f2 52(%x29)	# 1766 
	fle	%x5 %f2 %f1	# 1766 
	bne	%x5 %x0 fle.21282	# 1766 
	addi	%x7 %x6 476	# 1767 
	lw	%x7 0(%x7)	# 1767 
	lw	%f2 192(%x29)	# 1767 
	fdiv	%f1 %f1 %f2	# 1767 
	add	%x6 %x0 %x7	# 1767 
	sw	%x1 -28(%x2)	# 1767 
	addi	%x2 %x2 -32	# 1767 
	jal	 %x1 trace_diffuse_ray.3076	# 1767 
	addi	%x2 %x2 32	# 1767 
	lw	%x1 -28(%x2)	# 1767 
	j	fle_cont.21283	# 1766 
fle.21282:	# 1766 
	addi	%x7 %x6 472	# 1769 
	lw	%x7 0(%x7)	# 1769 
	lw	%f2 196(%x29)	# 1769 
	fdiv	%f1 %f1 %f2	# 1769 
	add	%x6 %x0 %x7	# 1769 
	sw	%x1 -28(%x2)	# 1769 
	addi	%x2 %x2 -32	# 1769 
	jal	 %x1 trace_diffuse_ray.3076	# 1769 
	addi	%x2 %x2 32	# 1769 
	lw	%x1 -28(%x2)	# 1769 
fle_cont.21283:	# 1766 
	lui	%x7 2097976	# 1771
	addi	%x7 %x7 824	# 1771
	addi	%x9 %x0 116	# 1771
	lw	%x6 -24(%x2)	# 1771 
	lw	%x8 -20(%x2)	# 1771 
	sw	%x1 -28(%x2)	# 1771 
	addi	%x2 %x2 -32	# 1771 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1771 
	addi	%x2 %x2 32	# 1771 
	lw	%x1 -28(%x2)	# 1771 
	lw	%x6 -4(%x2)	# 413 
	lw	%x7 20(%x6)	# 413 
	lw	%x8 -16(%x2)	# 1988 
	slli	%x9 %x8 2	# 1988 
	add	%x7 %x7 %x9	# 1988 
	lw	%x7 0(%x7)	# 1988 
	lui	%x9 2098000	# 1988
	addi	%x9 %x9 848	# 1988
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x7 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x7 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x9 %x9 8	# 82 
	lw	%f1 0(%x9)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
beq_cont.21281:	# 1975 
	lw	%x7 -16(%x2)	# 1990 
	addi	%x7 %x7 1	# 1990 
	j	pretrace_diffuse_rays.3127	# 1990 
bge_else.21279:	# 1972 
	jr	0(%x1)	# 1991 
blt.21278:	# 1968 
	jr	0(%x1)	# 1992 
bge_else.21275:	# 1972 
	jr	0(%x1)	# 1991 
blt.21274:	# 1968 
	jr	0(%x1)	# 1992 
pretrace_pixels.3130:	#- 44116
	blt	%x7 %x0 bge_else.21288	# 1998 
	lui	%x9 2098040	# 2000
	addi	%x9 %x9 888	# 2000
	addi	%x9 %x9 0	# 2000 
	lw	%f4 0(%x9)	# 2000 
	lui	%x9 2098032	# 2000
	addi	%x9 %x9 880	# 2000
	addi	%x9 %x9 0	# 2000 
	lw	%x9 0(%x9)	# 2000 
	sub	%x9 %x7 %x9	# 2000 
	sw	%x8 -0(%x2)	# 2000 
	sw	%x6 -4(%x2)	# 2000 
	sw	%x7 -8(%x2)	# 2000 
	sw	%f3 -12(%x2)	# 2000 
	sw	%f2 -16(%x2)	# 2000 
	sw	%f1 -20(%x2)	# 2000 
	sw	%f4 -24(%x2)	# 2000 
	add	%x6 %x0 %x9	# 2000 
	sw	%x1 -28(%x2)	# 2000 
	addi	%x2 %x2 -32	# 2000 
	jal	 %x1 min_caml_float_of_int	# 2000 
	addi	%x2 %x2 32	# 2000 
	lw	%x1 -28(%x2)	# 2000 
	lw	%f2 -24(%x2)	# 2000 
	fmul	%f1 %f2 %f1	# 2000 
	lui	%x6 2098068	# 2001
	addi	%x6 %x6 916	# 2001
	addi	%x6 %x6 0	# 2001 
	lw	%f2 0(%x6)	# 2001 
	fmul	%f2 %f1 %f2	# 2001 
	lw	%f3 -20(%x2)	# 2001 
	fadd	%f2 %f2 %f3	# 2001 
	lui	%x6 2098104	# 2001
	addi	%x6 %x6 952	# 2001
	addi	%x6 %x6 0	# 2001 
	sw	%f2 0(%x6)	# 2001 
	lui	%x6 2098068	# 2002
	addi	%x6 %x6 916	# 2002
	addi	%x6 %x6 4	# 2002 
	lw	%f2 0(%x6)	# 2002 
	fmul	%f2 %f1 %f2	# 2002 
	lw	%f4 -16(%x2)	# 2002 
	fadd	%f2 %f2 %f4	# 2002 
	lui	%x6 2098104	# 2002
	addi	%x6 %x6 952	# 2002
	addi	%x6 %x6 4	# 2002 
	sw	%f2 0(%x6)	# 2002 
	lui	%x6 2098068	# 2003
	addi	%x6 %x6 916	# 2003
	addi	%x6 %x6 8	# 2003 
	lw	%f2 0(%x6)	# 2003 
	fmul	%f1 %f1 %f2	# 2003 
	lw	%f2 -12(%x2)	# 2003 
	fadd	%f1 %f1 %f2	# 2003 
	lui	%x6 2098104	# 2003
	addi	%x6 %x6 952	# 2003
	addi	%x6 %x6 8	# 2003 
	sw	%f1 0(%x6)	# 2003 
	lui	%x6 2098104	# 2004
	addi	%x6 %x6 952	# 2004
	addi	%x7 %x0 0	# 2004
	sw	%x1 -28(%x2)	# 2004 
	addi	%x2 %x2 -32	# 2004 
	jal	 %x1 vecunit_sgn.2761	# 2004 
	addi	%x2 %x2 32	# 2004 
	lw	%x1 -28(%x2)	# 2004 
	lui	%x6 2098012	# 2005
	addi	%x6 %x6 860	# 2005
	lw	%f1 52(%x29)	# 75 
	addi	%x7 %x6 0	# 68 
	sw	%f1 0(%x7)	# 68 
	addi	%x7 %x6 4	# 69 
	sw	%f1 0(%x7)	# 69 
	addi	%x6 %x6 8	# 70 
	sw	%f1 0(%x6)	# 70 
	lui	%x6 2098044	# 2006
	addi	%x6 %x6 892	# 2006
	lui	%x7 2097708	# 2006
	addi	%x7 %x7 556	# 2006
	addi	%x8 %x7 0	# 80 
	lw	%f1 0(%x8)	# 80 
	addi	%x8 %x6 0	# 80 
	sw	%f1 0(%x8)	# 80 
	addi	%x8 %x7 4	# 81 
	lw	%f1 0(%x8)	# 81 
	addi	%x8 %x6 4	# 81 
	sw	%f1 0(%x8)	# 81 
	addi	%x7 %x7 8	# 82 
	lw	%f1 0(%x7)	# 82 
	addi	%x6 %x6 8	# 82 
	sw	%f1 0(%x6)	# 82 
	addi	%x6 %x0 0	# 2009
	lw	%f1 16(%x29)	# 2009 
	lui	%x7 2098104	# 2009
	addi	%x7 %x7 952	# 2009
	lw	%x8 -8(%x2)	# 2009 
	slli	%x9 %x8 2	# 2009 
	lw	%x10 -4(%x2)	# 2009 
	add	%x9 %x10 %x9	# 2009 
	lw	%x9 0(%x9)	# 2009 
	lw	%f2 52(%x29)	# 2009 
	add	%x8 %x0 %x9	# 2009 
	sw	%x1 -28(%x2)	# 2009 
	addi	%x2 %x2 -32	# 2009 
	jal	 %x1 trace_ray.3070	# 2009 
	addi	%x2 %x2 32	# 2009 
	lw	%x1 -28(%x2)	# 2009 
	lw	%x6 -8(%x2)	# 2010 
	slli	%x7 %x6 2	# 2010 
	lw	%x8 -4(%x2)	# 2010 
	add	%x7 %x8 %x7	# 2010 
	lw	%x7 0(%x7)	# 2010 
	lw	%x7 0(%x7)	# 377 
	lui	%x9 2098012	# 2010
	addi	%x9 %x9 860	# 2010
	addi	%x10 %x9 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x7 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x9 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x7 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x9 %x9 8	# 82 
	lw	%f1 0(%x9)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
	slli	%x7 %x6 2	# 2011 
	add	%x7 %x8 %x7	# 2011 
	lw	%x7 0(%x7)	# 2011 
	lw	%x7 24(%x7)	# 436 
	addi	%x7 %x7 0	# 438 
	lw	%x9 -0(%x2)	# 438 
	sw	%x9 0(%x7)	# 438 
	slli	%x7 %x6 2	# 2014 
	add	%x7 %x8 %x7	# 2014 
	lw	%x7 0(%x7)	# 2014 
	lw	%x10 8(%x7)	# 392 
	addi	%x10 %x10 0	# 1880 
	lw	%x10 0(%x10)	# 1880 
	blt	%x10 %x0 bge.21289	# 1972 
	lw	%x10 12(%x7)	# 399 
	addi	%x10 %x10 0	# 1975 
	lw	%x10 0(%x10)	# 1975 
	sw	%x7 -28(%x2)	# 1975 
	bne	%x10 %x0 beq_else.21291	# 1975 
	j	beq_cont.21292	# 1975 
beq_else.21291:	# 1975 
	lw	%x10 24(%x7)	# 429 
	addi	%x10 %x10 0	# 431 
	lw	%x10 0(%x10)	# 431 
	lui	%x11 2098000	# 1977
	addi	%x11 %x11 848	# 1977
	lw	%f1 52(%x29)	# 75 
	addi	%x12 %x11 0	# 68 
	sw	%f1 0(%x12)	# 68 
	addi	%x12 %x11 4	# 69 
	sw	%f1 0(%x12)	# 69 
	addi	%x11 %x11 8	# 70 
	sw	%f1 0(%x11)	# 70 
	lw	%x11 4(%x7)	# 384 
	lui	%x12 2098116	# 1984
	addi	%x12 %x12 964	# 1984
	slli	%x10 %x10 2	# 1984 
	add	%x10 %x12 %x10	# 1984 
	lw	%x10 0(%x10)	# 1984 
	addi	%x11 %x11 0	# 1986 
	lw	%x11 0(%x11)	# 1986 
	lui	%x12 2098056	# 1131
	addi	%x12 %x12 904	# 1131
	addi	%x13 %x11 0	# 80 
	lw	%f1 0(%x13)	# 80 
	addi	%x13 %x12 0	# 80 
	sw	%f1 0(%x13)	# 80 
	addi	%x13 %x11 4	# 81 
	lw	%f1 0(%x13)	# 81 
	addi	%x13 %x12 4	# 81 
	sw	%f1 0(%x13)	# 81 
	addi	%x13 %x11 8	# 82 
	lw	%f1 0(%x13)	# 82 
	addi	%x12 %x12 8	# 82 
	sw	%f1 0(%x12)	# 82 
	lui	%x12 2097408	# 1132
	addi	%x12 %x12 256	# 1132
	addi	%x12 %x12 0	# 1132 
	lw	%x12 0(%x12)	# 1132 
	addi	%x12 %x12 -1	# 1132 
	sw	%x11 -32(%x2)	# 1132 
	sw	%x10 -36(%x2)	# 1132 
	add	%x7 %x0 %x12	# 1132 
	add	%x6 %x0 %x11	# 1132 
	sw	%x1 -40(%x2)	# 1132 
	addi	%x2 %x2 -44	# 1132 
	jal	 %x1 setup_startp_constants.2981	# 1132 
	addi	%x2 %x2 44	# 1132 
	lw	%x1 -40(%x2)	# 1132 
	lw	%x6 -36(%x2)	# 1762 
	addi	%x7 %x6 472	# 1762 
	lw	%x7 0(%x7)	# 1762 
	lw	%x7 0(%x7)	# 454 
	lui	%x8 2097976	# 1762
	addi	%x8 %x8 824	# 1762
	addi	%x9 %x7 0	# 109 
	lw	%f1 0(%x9)	# 109 
	addi	%x9 %x8 0	# 109 
	lw	%f2 0(%x9)	# 109 
	fmul	%f1 %f1 %f2	# 109 
	addi	%x9 %x7 4	# 109 
	lw	%f2 0(%x9)	# 109 
	addi	%x9 %x8 4	# 109 
	lw	%f3 0(%x9)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	addi	%x7 %x7 8	# 109 
	lw	%f2 0(%x7)	# 109 
	addi	%x7 %x8 8	# 109 
	lw	%f3 0(%x7)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	fadd	%f1 %f1 %f2	# 109 
	lw	%f2 52(%x29)	# 1766 
	fle	%x5 %f2 %f1	# 1766 
	bne	%x5 %x0 fle.21293	# 1766 
	addi	%x7 %x6 476	# 1767 
	lw	%x7 0(%x7)	# 1767 
	lw	%f2 192(%x29)	# 1767 
	fdiv	%f1 %f1 %f2	# 1767 
	add	%x6 %x0 %x7	# 1767 
	sw	%x1 -40(%x2)	# 1767 
	addi	%x2 %x2 -44	# 1767 
	jal	 %x1 trace_diffuse_ray.3076	# 1767 
	addi	%x2 %x2 44	# 1767 
	lw	%x1 -40(%x2)	# 1767 
	j	fle_cont.21294	# 1766 
fle.21293:	# 1766 
	addi	%x7 %x6 472	# 1769 
	lw	%x7 0(%x7)	# 1769 
	lw	%f2 196(%x29)	# 1769 
	fdiv	%f1 %f1 %f2	# 1769 
	add	%x6 %x0 %x7	# 1769 
	sw	%x1 -40(%x2)	# 1769 
	addi	%x2 %x2 -44	# 1769 
	jal	 %x1 trace_diffuse_ray.3076	# 1769 
	addi	%x2 %x2 44	# 1769 
	lw	%x1 -40(%x2)	# 1769 
fle_cont.21294:	# 1766 
	lui	%x7 2097976	# 1771
	addi	%x7 %x7 824	# 1771
	addi	%x9 %x0 116	# 1771
	lw	%x6 -36(%x2)	# 1771 
	lw	%x8 -32(%x2)	# 1771 
	sw	%x1 -40(%x2)	# 1771 
	addi	%x2 %x2 -44	# 1771 
	jal	 %x1 iter_trace_diffuse_rays.3079	# 1771 
	addi	%x2 %x2 44	# 1771 
	lw	%x1 -40(%x2)	# 1771 
	lw	%x6 -28(%x2)	# 413 
	lw	%x7 20(%x6)	# 413 
	addi	%x7 %x7 0	# 1988 
	lw	%x7 0(%x7)	# 1988 
	lui	%x8 2098000	# 1988
	addi	%x8 %x8 848	# 1988
	addi	%x9 %x8 0	# 80 
	lw	%f1 0(%x9)	# 80 
	addi	%x9 %x7 0	# 80 
	sw	%f1 0(%x9)	# 80 
	addi	%x9 %x8 4	# 81 
	lw	%f1 0(%x9)	# 81 
	addi	%x9 %x7 4	# 81 
	sw	%f1 0(%x9)	# 81 
	addi	%x8 %x8 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
beq_cont.21292:	# 1975 
	addi	%x7 %x0 1	# 1990
	lw	%x6 -28(%x2)	# 1990 
	sw	%x1 -40(%x2)	# 1990 
	addi	%x2 %x2 -44	# 1990 
	jal	 %x1 pretrace_diffuse_rays.3127	# 1990 
	addi	%x2 %x2 44	# 1990 
	lw	%x1 -40(%x2)	# 1990 
	j	beq_cont.21290	# 1972 
bge.21289:	# 1972 
beq_cont.21290:	# 1972 
	lw	%x6 -8(%x2)	# 2016 
	addi	%x7 %x6 -1	# 2016 
	lw	%x6 -0(%x2)	# 45 
	addi	%x6 %x6 1	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x6 %x5 bge.21295	# 46 
	addi	%x8 %x6 -5	# 46 
	j	beq_cont.21296	# 46 
bge.21295:	# 46 
	add	%x8 %x0 %x6	# 46 
beq_cont.21296:	# 46 
	lw	%f1 -20(%x2)	# 2016 
	lw	%f2 -16(%x2)	# 2016 
	lw	%f3 -12(%x2)	# 2016 
	lw	%x6 -4(%x2)	# 2016 
	j	pretrace_pixels.3130	# 2016 
bge_else.21288:	# 1998 
	jr	0(%x1)	# 2018 
pretrace_line.3137:	#- 45288
	lui	%x9 2098040	# 2023
	addi	%x9 %x9 888	# 2023
	addi	%x9 %x9 0	# 2023 
	lw	%f1 0(%x9)	# 2023 
	lui	%x9 2098032	# 2023
	addi	%x9 %x9 880	# 2023
	addi	%x9 %x9 4	# 2023 
	lw	%x9 0(%x9)	# 2023 
	sub	%x7 %x7 %x9	# 2023 
	sw	%x8 -0(%x2)	# 2023 
	sw	%x6 -4(%x2)	# 2023 
	sw	%f1 -8(%x2)	# 2023 
	add	%x6 %x0 %x7	# 2023 
	sw	%x1 -12(%x2)	# 2023 
	addi	%x2 %x2 -16	# 2023 
	jal	 %x1 min_caml_float_of_int	# 2023 
	addi	%x2 %x2 16	# 2023 
	lw	%x1 -12(%x2)	# 2023 
	lw	%f2 -8(%x2)	# 2023 
	fmul	%f1 %f2 %f1	# 2023 
	lui	%x6 2098080	# 2026
	addi	%x6 %x6 928	# 2026
	addi	%x6 %x6 0	# 2026 
	lw	%f2 0(%x6)	# 2026 
	fmul	%f2 %f1 %f2	# 2026 
	lui	%x6 2098092	# 2026
	addi	%x6 %x6 940	# 2026
	addi	%x6 %x6 0	# 2026 
	lw	%f3 0(%x6)	# 2026 
	fadd	%f2 %f2 %f3	# 2026 
	lui	%x6 2098080	# 2027
	addi	%x6 %x6 928	# 2027
	addi	%x6 %x6 4	# 2027 
	lw	%f3 0(%x6)	# 2027 
	fmul	%f3 %f1 %f3	# 2027 
	lui	%x6 2098092	# 2027
	addi	%x6 %x6 940	# 2027
	addi	%x6 %x6 4	# 2027 
	lw	%f4 0(%x6)	# 2027 
	fadd	%f3 %f3 %f4	# 2027 
	lui	%x6 2098080	# 2028
	addi	%x6 %x6 928	# 2028
	addi	%x6 %x6 8	# 2028 
	lw	%f4 0(%x6)	# 2028 
	fmul	%f1 %f1 %f4	# 2028 
	lui	%x6 2098092	# 2028
	addi	%x6 %x6 940	# 2028
	addi	%x6 %x6 8	# 2028 
	lw	%f4 0(%x6)	# 2028 
	fadd	%f1 %f1 %f4	# 2028 
	lui	%x6 2098024	# 2029
	addi	%x6 %x6 872	# 2029
	addi	%x6 %x6 0	# 2029 
	lw	%x6 0(%x6)	# 2029 
	addi	%x7 %x6 -1	# 2029 
	lw	%x6 -4(%x2)	# 2029 
	lw	%x8 -0(%x2)	# 2029 
	fadd	%x5 %f0 %f3	# 2029 
	fadd	%f3 %f0 %f1	# 2029 
	fadd	%f1 %f0 %f2	# 2029 
	fadd	%f2 %f0 %x5	# 2029 
	j	pretrace_pixels.3130	# 2029 
scan_pixel.3141:	#- 45536
	lui	%x11 2098024	# 2039
	addi	%x11 %x11 872	# 2039
	addi	%x11 %x11 0	# 2039 
	lw	%x11 0(%x11)	# 2039 
	blt	%x6 %x11 blt.21298	# 2039 
	jr	0(%x1)	# 2054 
blt.21298:	# 2039 
	lui	%x11 2098012	# 2042
	addi	%x11 %x11 860	# 2042
	slli	%x12 %x6 2	# 2042 
	add	%x12 %x9 %x12	# 2042 
	lw	%x12 0(%x12)	# 2042 
	lw	%x12 0(%x12)	# 377 
	addi	%x13 %x12 0	# 80 
	lw	%f1 0(%x13)	# 80 
	addi	%x13 %x11 0	# 80 
	sw	%f1 0(%x13)	# 80 
	addi	%x13 %x12 4	# 81 
	lw	%f1 0(%x13)	# 81 
	addi	%x13 %x11 4	# 81 
	sw	%f1 0(%x13)	# 81 
	addi	%x12 %x12 8	# 82 
	lw	%f1 0(%x12)	# 82 
	addi	%x11 %x11 8	# 82 
	sw	%f1 0(%x11)	# 82 
	lui	%x11 2098024	# 1867
	addi	%x11 %x11 872	# 1867
	addi	%x11 %x11 4	# 1867 
	lw	%x11 0(%x11)	# 1867 
	addi	%x12 %x7 1	# 1867 
	blt	%x12 %x11 blt.21300	# 1867 
	addi	%x11 %x0 0	# 1875
	j	blt_cont.21301	# 1867 
blt.21300:	# 1867 
	blt	%x0 %x7 blt.21302	# 1868 
	addi	%x11 %x0 0	# 1874
	j	blt_cont.21303	# 1868 
blt.21302:	# 1868 
	lui	%x11 2098024	# 1869
	addi	%x11 %x11 872	# 1869
	addi	%x11 %x11 0	# 1869 
	lw	%x11 0(%x11)	# 1869 
	addi	%x12 %x6 1	# 1869 
	blt	%x12 %x11 blt.21304	# 1869 
	addi	%x11 %x0 0	# 1873
	j	blt_cont.21305	# 1869 
blt.21304:	# 1869 
	blt	%x0 %x6 blt.21306	# 1870 
	addi	%x11 %x0 0	# 1872
	j	blt_cont.21307	# 1870 
blt.21306:	# 1870 
	addi	%x11 %x0 1	# 1871
blt_cont.21307:	# 1870 
blt_cont.21305:	# 1869 
blt_cont.21303:	# 1868 
blt_cont.21301:	# 1867 
	sw	%x10 -0(%x2)	# 2045 
	sw	%x8 -4(%x2)	# 2045 
	sw	%x7 -8(%x2)	# 2045 
	sw	%x9 -12(%x2)	# 2045 
	sw	%x6 -16(%x2)	# 2045 
	bne	%x11 %x0 beq_else.21308	# 2045 
	slli	%x11 %x6 2	# 2048 
	add	%x11 %x9 %x11	# 2048 
	lw	%x11 0(%x11)	# 2048 
	addi	%x12 %x0 0	# 2048
	lw	%x13 8(%x11)	# 392 
	addi	%x13 %x13 0	# 1855 
	lw	%x13 0(%x13)	# 1855 
	blt	%x13 %x0 bge.21310	# 1855 
	lw	%x13 12(%x11)	# 399 
	addi	%x13 %x13 0	# 1857 
	lw	%x13 0(%x13)	# 1857 
	sw	%x11 -20(%x2)	# 1857 
	bne	%x13 %x0 beq_else.21312	# 1857 
	j	beq_cont.21313	# 1857 
beq_else.21312:	# 1857 
	add	%x7 %x0 %x12	# 1858 
	add	%x6 %x0 %x11	# 1858 
	sw	%x1 -24(%x2)	# 1858 
	addi	%x2 %x2 -28	# 1858 
	jal	 %x1 calc_diffuse_using_1point.3089	# 1858 
	addi	%x2 %x2 28	# 1858 
	lw	%x1 -24(%x2)	# 1858 
beq_cont.21313:	# 1857 
	addi	%x7 %x0 1	# 1860
	lw	%x6 -20(%x2)	# 1860 
	sw	%x1 -24(%x2)	# 1860 
	addi	%x2 %x2 -28	# 1860 
	jal	 %x1 do_without_neighbors.3098	# 1860 
	addi	%x2 %x2 28	# 1860 
	lw	%x1 -24(%x2)	# 1860 
	j	beq_cont.21311	# 1855 
bge.21310:	# 1855 
beq_cont.21311:	# 1855 
	j	beq_cont.21309	# 2045 
beq_else.21308:	# 2045 
	addi	%x11 %x0 0	# 2046
	slli	%x12 %x6 2	# 1904 
	add	%x12 %x9 %x12	# 1904 
	lw	%x12 0(%x12)	# 1904 
	lw	%x13 8(%x12)	# 392 
	addi	%x13 %x13 0	# 1880 
	lw	%x13 0(%x13)	# 1880 
	blt	%x13 %x0 bge.21314	# 1908 
	slli	%x13 %x6 2	# 1886 
	add	%x13 %x9 %x13	# 1886 
	lw	%x13 0(%x13)	# 1886 
	lw	%x13 8(%x13)	# 392 
	addi	%x13 %x13 0	# 1880 
	lw	%x13 0(%x13)	# 1880 
	slli	%x14 %x6 2	# 1888 
	add	%x14 %x8 %x14	# 1888 
	lw	%x14 0(%x14)	# 1888 
	lw	%x14 8(%x14)	# 392 
	addi	%x14 %x14 0	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21316	# 1888 
	slli	%x14 %x6 2	# 1889 
	add	%x14 %x10 %x14	# 1889 
	lw	%x14 0(%x14)	# 1889 
	lw	%x14 8(%x14)	# 392 
	addi	%x14 %x14 0	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21318	# 1889 
	addi	%x14 %x6 -1	# 1890 
	slli	%x14 %x14 2	# 1890 
	add	%x14 %x9 %x14	# 1890 
	lw	%x14 0(%x14)	# 1890 
	lw	%x14 8(%x14)	# 392 
	addi	%x14 %x14 0	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21320	# 1890 
	addi	%x14 %x6 1	# 1891 
	slli	%x14 %x14 2	# 1891 
	add	%x14 %x9 %x14	# 1891 
	lw	%x14 0(%x14)	# 1891 
	lw	%x14 8(%x14)	# 392 
	addi	%x14 %x14 0	# 1880 
	lw	%x14 0(%x14)	# 1880 
	bne	%x14 %x13 beq_else.21322	# 1891 
	addi	%x13 %x0 1	# 1892
	j	beq_cont.21323	# 1891 
beq_else.21322:	# 1891 
	addi	%x13 %x0 0	# 1893
beq_cont.21323:	# 1891 
	j	beq_cont.21321	# 1890 
beq_else.21320:	# 1890 
	addi	%x13 %x0 0	# 1894
beq_cont.21321:	# 1890 
	j	beq_cont.21319	# 1889 
beq_else.21318:	# 1889 
	addi	%x13 %x0 0	# 1895
beq_cont.21319:	# 1889 
	j	beq_cont.21317	# 1888 
beq_else.21316:	# 1888 
	addi	%x13 %x0 0	# 1896
beq_cont.21317:	# 1888 
	bne	%x13 %x0 beq_else.21324	# 1910 
	slli	%x12 %x6 2	# 1922 
	add	%x12 %x9 %x12	# 1922 
	lw	%x12 0(%x12)	# 1922 
	add	%x7 %x0 %x11	# 1922 
	add	%x6 %x0 %x12	# 1922 
	sw	%x1 -24(%x2)	# 1922 
	addi	%x2 %x2 -28	# 1922 
	jal	 %x1 do_without_neighbors.3098	# 1922 
	addi	%x2 %x2 28	# 1922 
	lw	%x1 -24(%x2)	# 1922 
	j	beq_cont.21325	# 1910 
beq_else.21324:	# 1910 
	lw	%x12 12(%x12)	# 399 
	addi	%x12 %x12 0	# 1914 
	lw	%x12 0(%x12)	# 1914 
	bne	%x12 %x0 beq_else.21326	# 1914 
	j	beq_cont.21327	# 1914 
beq_else.21326:	# 1914 
	add	%x7 %x0 %x8	# 1915 
	add	%x8 %x0 %x9	# 1915 
	add	%x9 %x0 %x10	# 1915 
	add	%x10 %x0 %x11	# 1915 
	sw	%x1 -24(%x2)	# 1915 
	addi	%x2 %x2 -28	# 1915 
	jal	 %x1 calc_diffuse_using_5points.3092	# 1915 
	addi	%x2 %x2 28	# 1915 
	lw	%x1 -24(%x2)	# 1915 
beq_cont.21327:	# 1914 
	addi	%x11 %x0 1	# 1919
	lw	%x6 -16(%x2)	# 1919 
	lw	%x7 -8(%x2)	# 1919 
	lw	%x8 -4(%x2)	# 1919 
	lw	%x9 -12(%x2)	# 1919 
	lw	%x10 -0(%x2)	# 1919 
	sw	%x1 -24(%x2)	# 1919 
	addi	%x2 %x2 -28	# 1919 
	jal	 %x1 try_exploit_neighbors.3114	# 1919 
	addi	%x2 %x2 28	# 1919 
	lw	%x1 -24(%x2)	# 1919 
beq_cont.21325:	# 1910 
	j	beq_cont.21315	# 1908 
bge.21314:	# 1908 
beq_cont.21315:	# 1908 
beq_cont.21309:	# 2045 
	lui	%x6 2098012	# 1951
	addi	%x6 %x6 860	# 1951
	addi	%x6 %x6 0	# 1951 
	lw	%f1 0(%x6)	# 1951 
	sw	%x1 -24(%x2)	# 1945 
	addi	%x2 %x2 -28	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 28	# 1945 
	lw	%x1 -24(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21328	# 1946 
	blt	%x6 %x0 bge.21330	# 1946 
	j	beq_cont.21331	# 1946 
bge.21330:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21331:	# 1946 
	j	blt_cont.21329	# 1946 
blt.21328:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21329:	# 1946 
	sw	%x1 -24(%x2)	# 1947 
	addi	%x2 %x2 -28	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 28	# 1947 
	lw	%x1 -24(%x2)	# 1947 
	addi	%x6 %x0 32	# 1952
	sw	%x1 -24(%x2)	# 1952 
	addi	%x2 %x2 -28	# 1952 
	jal	 %x1 min_caml_print_char	# 1952 
	addi	%x2 %x2 28	# 1952 
	lw	%x1 -24(%x2)	# 1952 
	lui	%x6 2098012	# 1953
	addi	%x6 %x6 860	# 1953
	addi	%x6 %x6 4	# 1953 
	lw	%f1 0(%x6)	# 1953 
	sw	%x1 -24(%x2)	# 1945 
	addi	%x2 %x2 -28	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 28	# 1945 
	lw	%x1 -24(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21332	# 1946 
	blt	%x6 %x0 bge.21334	# 1946 
	j	beq_cont.21335	# 1946 
bge.21334:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21335:	# 1946 
	j	blt_cont.21333	# 1946 
blt.21332:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21333:	# 1946 
	sw	%x1 -24(%x2)	# 1947 
	addi	%x2 %x2 -28	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 28	# 1947 
	lw	%x1 -24(%x2)	# 1947 
	addi	%x6 %x0 32	# 1954
	sw	%x1 -24(%x2)	# 1954 
	addi	%x2 %x2 -28	# 1954 
	jal	 %x1 min_caml_print_char	# 1954 
	addi	%x2 %x2 28	# 1954 
	lw	%x1 -24(%x2)	# 1954 
	lui	%x6 2098012	# 1955
	addi	%x6 %x6 860	# 1955
	addi	%x6 %x6 8	# 1955 
	lw	%f1 0(%x6)	# 1955 
	sw	%x1 -24(%x2)	# 1945 
	addi	%x2 %x2 -28	# 1945 
	jal	 %x1 min_caml_int_of_float	# 1945 
	addi	%x2 %x2 28	# 1945 
	lw	%x1 -24(%x2)	# 1945 
	addi	%x5 %x0 255	# 1946 
	blt	%x5 %x6 blt.21336	# 1946 
	blt	%x6 %x0 bge.21338	# 1946 
	j	beq_cont.21339	# 1946 
bge.21338:	# 1946 
	addi	%x6 %x0 0	# 1946
beq_cont.21339:	# 1946 
	j	blt_cont.21337	# 1946 
blt.21336:	# 1946 
	addi	%x6 %x0 255	# 1946
blt_cont.21337:	# 1946 
	sw	%x1 -24(%x2)	# 1947 
	addi	%x2 %x2 -28	# 1947 
	jal	 %x1 print_int.2730	# 1947 
	addi	%x2 %x2 28	# 1947 
	lw	%x1 -24(%x2)	# 1947 
	addi	%x6 %x0 10	# 1956
	sw	%x1 -24(%x2)	# 1956 
	addi	%x2 %x2 -28	# 1956 
	jal	 %x1 min_caml_print_char	# 1956 
	addi	%x2 %x2 28	# 1956 
	lw	%x1 -24(%x2)	# 1956 
	lw	%x6 -16(%x2)	# 2053 
	addi	%x6 %x6 1	# 2053 
	lui	%x7 2098024	# 2039
	addi	%x7 %x7 872	# 2039
	addi	%x7 %x7 0	# 2039 
	lw	%x7 0(%x7)	# 2039 
	blt	%x6 %x7 blt.21340	# 2039 
	jr	0(%x1)	# 2054 
blt.21340:	# 2039 
	lui	%x7 2098012	# 2042
	addi	%x7 %x7 860	# 2042
	slli	%x8 %x6 2	# 2042 
	lw	%x9 -12(%x2)	# 2042 
	add	%x8 %x9 %x8	# 2042 
	lw	%x8 0(%x8)	# 2042 
	lw	%x8 0(%x8)	# 377 
	addi	%x10 %x8 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x7 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x7 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x8 %x8 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
	lui	%x7 2098024	# 1867
	addi	%x7 %x7 872	# 1867
	addi	%x7 %x7 4	# 1867 
	lw	%x7 0(%x7)	# 1867 
	lw	%x8 -8(%x2)	# 1867 
	addi	%x10 %x8 1	# 1867 
	blt	%x10 %x7 blt.21342	# 1867 
	addi	%x7 %x0 0	# 1875
	j	blt_cont.21343	# 1867 
blt.21342:	# 1867 
	blt	%x0 %x8 blt.21344	# 1868 
	addi	%x7 %x0 0	# 1874
	j	blt_cont.21345	# 1868 
blt.21344:	# 1868 
	lui	%x7 2098024	# 1869
	addi	%x7 %x7 872	# 1869
	addi	%x7 %x7 0	# 1869 
	lw	%x7 0(%x7)	# 1869 
	addi	%x10 %x6 1	# 1869 
	blt	%x10 %x7 blt.21346	# 1869 
	addi	%x7 %x0 0	# 1873
	j	blt_cont.21347	# 1869 
blt.21346:	# 1869 
	blt	%x0 %x6 blt.21348	# 1870 
	addi	%x7 %x0 0	# 1872
	j	blt_cont.21349	# 1870 
blt.21348:	# 1870 
	addi	%x7 %x0 1	# 1871
blt_cont.21349:	# 1870 
blt_cont.21347:	# 1869 
blt_cont.21345:	# 1868 
blt_cont.21343:	# 1867 
	sw	%x6 -24(%x2)	# 2045 
	bne	%x7 %x0 beq_else.21350	# 2045 
	slli	%x7 %x6 2	# 2048 
	add	%x7 %x9 %x7	# 2048 
	lw	%x7 0(%x7)	# 2048 
	addi	%x10 %x0 0	# 2048
	add	%x6 %x0 %x7	# 2048 
	add	%x7 %x0 %x10	# 2048 
	sw	%x1 -28(%x2)	# 2048 
	addi	%x2 %x2 -32	# 2048 
	jal	 %x1 do_without_neighbors.3098	# 2048 
	addi	%x2 %x2 32	# 2048 
	lw	%x1 -28(%x2)	# 2048 
	j	beq_cont.21351	# 2045 
beq_else.21350:	# 2045 
	addi	%x11 %x0 0	# 2046
	lw	%x7 -4(%x2)	# 2046 
	lw	%x10 -0(%x2)	# 2046 
	add	%x5 %x0 %x8	# 2046 
	add	%x8 %x0 %x7	# 2046 
	add	%x7 %x0 %x5	# 2046 
	sw	%x1 -28(%x2)	# 2046 
	addi	%x2 %x2 -32	# 2046 
	jal	 %x1 try_exploit_neighbors.3114	# 2046 
	addi	%x2 %x2 32	# 2046 
	lw	%x1 -28(%x2)	# 2046 
beq_cont.21351:	# 2045 
	sw	%x1 -28(%x2)	# 2051 
	addi	%x2 %x2 -32	# 2051 
	jal	 %x1 write_rgb.3125	# 2051 
	addi	%x2 %x2 32	# 2051 
	lw	%x1 -28(%x2)	# 2051 
	lw	%x6 -24(%x2)	# 2053 
	addi	%x6 %x6 1	# 2053 
	lw	%x7 -8(%x2)	# 2053 
	lw	%x8 -4(%x2)	# 2053 
	lw	%x9 -12(%x2)	# 2053 
	lw	%x10 -0(%x2)	# 2053 
	j	scan_pixel.3141	# 2053 
scan_line.3147:	#- 46908
	lui	%x11 2098024	# 2060
	addi	%x11 %x11 872	# 2060
	addi	%x11 %x11 4	# 2060 
	lw	%x11 0(%x11)	# 2060 
	blt	%x6 %x11 blt.21352	# 2060 
	jr	0(%x1)	# 2067 
blt.21352:	# 2060 
	lui	%x11 2098024	# 2062
	addi	%x11 %x11 872	# 2062
	addi	%x11 %x11 4	# 2062 
	lw	%x11 0(%x11)	# 2062 
	addi	%x11 %x11 -1	# 2062 
	sw	%x10 -0(%x2)	# 2062 
	sw	%x9 -4(%x2)	# 2062 
	sw	%x7 -8(%x2)	# 2062 
	sw	%x6 -12(%x2)	# 2062 
	sw	%x8 -16(%x2)	# 2062 
	blt	%x6 %x11 blt.21354	# 2062 
	j	blt_cont.21355	# 2062 
blt.21354:	# 2062 
	addi	%x11 %x6 1	# 2063 
	add	%x8 %x0 %x10	# 2063 
	add	%x7 %x0 %x11	# 2063 
	add	%x6 %x0 %x9	# 2063 
	sw	%x1 -20(%x2)	# 2063 
	addi	%x2 %x2 -24	# 2063 
	jal	 %x1 pretrace_line.3137	# 2063 
	addi	%x2 %x2 24	# 2063 
	lw	%x1 -20(%x2)	# 2063 
blt_cont.21355:	# 2062 
	addi	%x6 %x0 0	# 2065
	lui	%x7 2098024	# 2039
	addi	%x7 %x7 872	# 2039
	addi	%x7 %x7 0	# 2039 
	lw	%x7 0(%x7)	# 2039 
	blt	%x0 %x7 blt.21356	# 2039 
	j	blt_cont.21357	# 2039 
blt.21356:	# 2039 
	lui	%x7 2098012	# 2042
	addi	%x7 %x7 860	# 2042
	lw	%x9 -16(%x2)	# 2042 
	addi	%x8 %x9 0	# 2042 
	lw	%x8 0(%x8)	# 2042 
	lw	%x8 0(%x8)	# 377 
	addi	%x10 %x8 0	# 80 
	lw	%f1 0(%x10)	# 80 
	addi	%x10 %x7 0	# 80 
	sw	%f1 0(%x10)	# 80 
	addi	%x10 %x8 4	# 81 
	lw	%f1 0(%x10)	# 81 
	addi	%x10 %x7 4	# 81 
	sw	%f1 0(%x10)	# 81 
	addi	%x8 %x8 8	# 82 
	lw	%f1 0(%x8)	# 82 
	addi	%x7 %x7 8	# 82 
	sw	%f1 0(%x7)	# 82 
	lui	%x7 2098024	# 1867
	addi	%x7 %x7 872	# 1867
	addi	%x7 %x7 4	# 1867 
	lw	%x7 0(%x7)	# 1867 
	lw	%x8 -12(%x2)	# 1867 
	addi	%x10 %x8 1	# 1867 
	blt	%x10 %x7 blt.21358	# 1867 
	addi	%x7 %x0 0	# 1875
	j	blt_cont.21359	# 1867 
blt.21358:	# 1867 
	blt	%x0 %x8 blt.21360	# 1868 
	addi	%x7 %x0 0	# 1874
	j	blt_cont.21361	# 1868 
blt.21360:	# 1868 
	lui	%x7 2098024	# 1869
	addi	%x7 %x7 872	# 1869
	addi	%x7 %x7 0	# 1869 
	lw	%x7 0(%x7)	# 1869 
	addi	%x5 %x0 1	# 1869 
	blt	%x5 %x7 blt.21362	# 1869 
	addi	%x7 %x0 0	# 1873
	j	blt_cont.21363	# 1869 
blt.21362:	# 1869 
	addi	%x7 %x0 0	# 1872
blt_cont.21363:	# 1869 
blt_cont.21361:	# 1868 
blt_cont.21359:	# 1867 
	bne	%x7 %x0 beq_else.21364	# 2045 
	addi	%x6 %x9 0	# 2048 
	lw	%x6 0(%x6)	# 2048 
	addi	%x7 %x0 0	# 2048
	sw	%x1 -20(%x2)	# 2048 
	addi	%x2 %x2 -24	# 2048 
	jal	 %x1 do_without_neighbors.3098	# 2048 
	addi	%x2 %x2 24	# 2048 
	lw	%x1 -20(%x2)	# 2048 
	j	beq_cont.21365	# 2045 
beq_else.21364:	# 2045 
	addi	%x11 %x0 0	# 2046
	lw	%x7 -8(%x2)	# 2046 
	lw	%x10 -4(%x2)	# 2046 
	add	%x5 %x0 %x8	# 2046 
	add	%x8 %x0 %x7	# 2046 
	add	%x7 %x0 %x5	# 2046 
	sw	%x1 -20(%x2)	# 2046 
	addi	%x2 %x2 -24	# 2046 
	jal	 %x1 try_exploit_neighbors.3114	# 2046 
	addi	%x2 %x2 24	# 2046 
	lw	%x1 -20(%x2)	# 2046 
beq_cont.21365:	# 2045 
	sw	%x1 -20(%x2)	# 2051 
	addi	%x2 %x2 -24	# 2051 
	jal	 %x1 write_rgb.3125	# 2051 
	addi	%x2 %x2 24	# 2051 
	lw	%x1 -20(%x2)	# 2051 
	addi	%x6 %x0 1	# 2053
	lw	%x7 -12(%x2)	# 2053 
	lw	%x8 -8(%x2)	# 2053 
	lw	%x9 -16(%x2)	# 2053 
	lw	%x10 -4(%x2)	# 2053 
	sw	%x1 -20(%x2)	# 2053 
	addi	%x2 %x2 -24	# 2053 
	jal	 %x1 scan_pixel.3141	# 2053 
	addi	%x2 %x2 24	# 2053 
	lw	%x1 -20(%x2)	# 2053 
blt_cont.21357:	# 2039 
	lw	%x6 -12(%x2)	# 2066 
	addi	%x7 %x6 1	# 2066 
	lw	%x6 -0(%x2)	# 45 
	addi	%x6 %x6 2	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x6 %x5 bge.21366	# 46 
	addi	%x8 %x6 -5	# 46 
	j	beq_cont.21367	# 46 
bge.21366:	# 46 
	add	%x8 %x0 %x6	# 46 
beq_cont.21367:	# 46 
	lui	%x6 2098024	# 2060
	addi	%x6 %x6 872	# 2060
	addi	%x6 %x6 4	# 2060 
	lw	%x6 0(%x6)	# 2060 
	blt	%x7 %x6 blt.21368	# 2060 
	jr	0(%x1)	# 2067 
blt.21368:	# 2060 
	lui	%x6 2098024	# 2062
	addi	%x6 %x6 872	# 2062
	addi	%x6 %x6 4	# 2062 
	lw	%x6 0(%x6)	# 2062 
	addi	%x6 %x6 -1	# 2062 
	sw	%x8 -20(%x2)	# 2062 
	sw	%x7 -24(%x2)	# 2062 
	blt	%x7 %x6 blt.21370	# 2062 
	j	blt_cont.21371	# 2062 
blt.21370:	# 2062 
	addi	%x6 %x7 1	# 2063 
	lw	%x9 -8(%x2)	# 2063 
	add	%x7 %x0 %x6	# 2063 
	add	%x6 %x0 %x9	# 2063 
	sw	%x1 -28(%x2)	# 2063 
	addi	%x2 %x2 -32	# 2063 
	jal	 %x1 pretrace_line.3137	# 2063 
	addi	%x2 %x2 32	# 2063 
	lw	%x1 -28(%x2)	# 2063 
blt_cont.21371:	# 2062 
	addi	%x6 %x0 0	# 2065
	lw	%x7 -24(%x2)	# 2065 
	lw	%x8 -16(%x2)	# 2065 
	lw	%x9 -4(%x2)	# 2065 
	lw	%x10 -8(%x2)	# 2065 
	sw	%x1 -28(%x2)	# 2065 
	addi	%x2 %x2 -32	# 2065 
	jal	 %x1 scan_pixel.3141	# 2065 
	addi	%x2 %x2 32	# 2065 
	lw	%x1 -28(%x2)	# 2065 
	lw	%x6 -24(%x2)	# 2066 
	addi	%x6 %x6 1	# 2066 
	lw	%x7 -20(%x2)	# 45 
	addi	%x7 %x7 2	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x7 %x5 bge.21372	# 46 
	addi	%x10 %x7 -5	# 46 
	j	beq_cont.21373	# 46 
bge.21372:	# 46 
	add	%x10 %x0 %x7	# 46 
beq_cont.21373:	# 46 
	lw	%x7 -4(%x2)	# 2066 
	lw	%x8 -8(%x2)	# 2066 
	lw	%x9 -16(%x2)	# 2066 
	j	scan_line.3147	# 2066 
create_pixel.3155:	#- 47568
	addi	%x6 %x0 3	# 2089
	lw	%f1 52(%x29)	# 2089 
	sw	%x1 0(%x2)	# 2089 
	addi	%x2 %x2 -4	# 2089 
	jal	 %x1 min_caml_create_float_array	# 2089 
	addi	%x2 %x2 4	# 2089 
	lw	%x1 0(%x2)	# 2089 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -0(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -4(%x2)	# 2077 
	addi	%x2 %x2 -8	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 8	# 2077 
	lw	%x1 -4(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -4(%x2)	# 2078 
	addi	%x2 %x2 -8	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 8	# 2078 
	lw	%x1 -4(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -4(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -8(%x2)	# 2079 
	addi	%x2 %x2 -12	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 12	# 2079 
	lw	%x1 -8(%x2)	# 2079 
	lw	%x7 -4(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -8(%x2)	# 2080 
	addi	%x2 %x2 -12	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 12	# 2080 
	lw	%x1 -8(%x2)	# 2080 
	lw	%x7 -4(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -8(%x2)	# 2081 
	addi	%x2 %x2 -12	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 12	# 2081 
	lw	%x1 -8(%x2)	# 2081 
	lw	%x7 -4(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -8(%x2)	# 2082 
	addi	%x2 %x2 -12	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 12	# 2082 
	lw	%x1 -8(%x2)	# 2082 
	lw	%x7 -4(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 5	# 2091
	addi	%x8 %x0 0	# 2091
	add	%x7 %x0 %x8	# 2091 
	sw	%x1 -8(%x2)	# 2091 
	addi	%x2 %x2 -12	# 2091 
	jal	 %x1 min_caml_create_array	# 2091 
	addi	%x2 %x2 12	# 2091 
	lw	%x1 -8(%x2)	# 2091 
	addi	%x7 %x0 5	# 2092
	addi	%x8 %x0 0	# 2092
	sw	%x6 -8(%x2)	# 2092 
	add	%x6 %x0 %x7	# 2092 
	add	%x7 %x0 %x8	# 2092 
	sw	%x1 -12(%x2)	# 2092 
	addi	%x2 %x2 -16	# 2092 
	jal	 %x1 min_caml_create_array	# 2092 
	addi	%x2 %x2 16	# 2092 
	lw	%x1 -12(%x2)	# 2092 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -12(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -16(%x2)	# 2077 
	addi	%x2 %x2 -20	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 20	# 2077 
	lw	%x1 -16(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -16(%x2)	# 2078 
	addi	%x2 %x2 -20	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 20	# 2078 
	lw	%x1 -16(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -16(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -20(%x2)	# 2079 
	addi	%x2 %x2 -24	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 24	# 2079 
	lw	%x1 -20(%x2)	# 2079 
	lw	%x7 -16(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -20(%x2)	# 2080 
	addi	%x2 %x2 -24	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 24	# 2080 
	lw	%x1 -20(%x2)	# 2080 
	lw	%x7 -16(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -20(%x2)	# 2081 
	addi	%x2 %x2 -24	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 24	# 2081 
	lw	%x1 -20(%x2)	# 2081 
	lw	%x7 -16(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -20(%x2)	# 2082 
	addi	%x2 %x2 -24	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 24	# 2082 
	lw	%x1 -20(%x2)	# 2082 
	lw	%x7 -16(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x1 -20(%x2)	# 2077 
	addi	%x2 %x2 -24	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 24	# 2077 
	lw	%x1 -20(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -20(%x2)	# 2078 
	addi	%x2 %x2 -24	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 24	# 2078 
	lw	%x1 -20(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -20(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -24(%x2)	# 2079 
	addi	%x2 %x2 -28	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 28	# 2079 
	lw	%x1 -24(%x2)	# 2079 
	lw	%x7 -20(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -24(%x2)	# 2080 
	addi	%x2 %x2 -28	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 28	# 2080 
	lw	%x1 -24(%x2)	# 2080 
	lw	%x7 -20(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -24(%x2)	# 2081 
	addi	%x2 %x2 -28	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 28	# 2081 
	lw	%x1 -24(%x2)	# 2081 
	lw	%x7 -20(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -24(%x2)	# 2082 
	addi	%x2 %x2 -28	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 28	# 2082 
	lw	%x1 -24(%x2)	# 2082 
	lw	%x7 -20(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 1	# 2095
	addi	%x8 %x0 0	# 2095
	add	%x7 %x0 %x8	# 2095 
	sw	%x1 -24(%x2)	# 2095 
	addi	%x2 %x2 -28	# 2095 
	jal	 %x1 min_caml_create_array	# 2095 
	addi	%x2 %x2 28	# 2095 
	lw	%x1 -24(%x2)	# 2095 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -24(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -28(%x2)	# 2077 
	addi	%x2 %x2 -32	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 32	# 2077 
	lw	%x1 -28(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -28(%x2)	# 2078 
	addi	%x2 %x2 -32	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 32	# 2078 
	lw	%x1 -28(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -28(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -32(%x2)	# 2079 
	addi	%x2 %x2 -36	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 36	# 2079 
	lw	%x1 -32(%x2)	# 2079 
	lw	%x7 -28(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -32(%x2)	# 2080 
	addi	%x2 %x2 -36	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 36	# 2080 
	lw	%x1 -32(%x2)	# 2080 
	lw	%x7 -28(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -32(%x2)	# 2081 
	addi	%x2 %x2 -36	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 36	# 2081 
	lw	%x1 -32(%x2)	# 2081 
	lw	%x7 -28(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -32(%x2)	# 2082 
	addi	%x2 %x2 -36	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 36	# 2082 
	lw	%x1 -32(%x2)	# 2082 
	lw	%x7 -28(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	add	%x6 %x0 %x3	# 2097 
	addi	%x3 %x3 32	# 2097 
	sw	%x7 28(%x6)	# 2097 
	lw	%x7 -24(%x2)	# 2097 
	sw	%x7 24(%x6)	# 2097 
	lw	%x7 -20(%x2)	# 2097 
	sw	%x7 20(%x6)	# 2097 
	lw	%x7 -16(%x2)	# 2097 
	sw	%x7 16(%x6)	# 2097 
	lw	%x7 -12(%x2)	# 2097 
	sw	%x7 12(%x6)	# 2097 
	lw	%x7 -8(%x2)	# 2097 
	sw	%x7 8(%x6)	# 2097 
	lw	%x7 -4(%x2)	# 2097 
	sw	%x7 4(%x6)	# 2097 
	lw	%x7 -0(%x2)	# 2097 
	sw	%x7 0(%x6)	# 2097 
	jr	0(%x1)	# 2097 
init_line_elements.3157:	#- 48692
	blt	%x7 %x0 bge_else.21374	# 2102 
	addi	%x8 %x0 3	# 2089
	lw	%f1 52(%x29)	# 2089 
	sw	%x6 -0(%x2)	# 2089 
	sw	%x7 -4(%x2)	# 2089 
	add	%x6 %x0 %x8	# 2089 
	sw	%x1 -8(%x2)	# 2089 
	addi	%x2 %x2 -12	# 2089 
	jal	 %x1 min_caml_create_float_array	# 2089 
	addi	%x2 %x2 12	# 2089 
	lw	%x1 -8(%x2)	# 2089 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -8(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -12(%x2)	# 2077 
	addi	%x2 %x2 -16	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 16	# 2077 
	lw	%x1 -12(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -12(%x2)	# 2078 
	addi	%x2 %x2 -16	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 16	# 2078 
	lw	%x1 -12(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -12(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -16(%x2)	# 2079 
	addi	%x2 %x2 -20	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 20	# 2079 
	lw	%x1 -16(%x2)	# 2079 
	lw	%x7 -12(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -16(%x2)	# 2080 
	addi	%x2 %x2 -20	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 20	# 2080 
	lw	%x1 -16(%x2)	# 2080 
	lw	%x7 -12(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -16(%x2)	# 2081 
	addi	%x2 %x2 -20	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 20	# 2081 
	lw	%x1 -16(%x2)	# 2081 
	lw	%x7 -12(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -16(%x2)	# 2082 
	addi	%x2 %x2 -20	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 20	# 2082 
	lw	%x1 -16(%x2)	# 2082 
	lw	%x7 -12(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 5	# 2091
	addi	%x8 %x0 0	# 2091
	add	%x7 %x0 %x8	# 2091 
	sw	%x1 -16(%x2)	# 2091 
	addi	%x2 %x2 -20	# 2091 
	jal	 %x1 min_caml_create_array	# 2091 
	addi	%x2 %x2 20	# 2091 
	lw	%x1 -16(%x2)	# 2091 
	addi	%x7 %x0 5	# 2092
	addi	%x8 %x0 0	# 2092
	sw	%x6 -16(%x2)	# 2092 
	add	%x6 %x0 %x7	# 2092 
	add	%x7 %x0 %x8	# 2092 
	sw	%x1 -20(%x2)	# 2092 
	addi	%x2 %x2 -24	# 2092 
	jal	 %x1 min_caml_create_array	# 2092 
	addi	%x2 %x2 24	# 2092 
	lw	%x1 -20(%x2)	# 2092 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -20(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -24(%x2)	# 2077 
	addi	%x2 %x2 -28	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 28	# 2077 
	lw	%x1 -24(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -24(%x2)	# 2078 
	addi	%x2 %x2 -28	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 28	# 2078 
	lw	%x1 -24(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -24(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -28(%x2)	# 2079 
	addi	%x2 %x2 -32	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 32	# 2079 
	lw	%x1 -28(%x2)	# 2079 
	lw	%x7 -24(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -28(%x2)	# 2080 
	addi	%x2 %x2 -32	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 32	# 2080 
	lw	%x1 -28(%x2)	# 2080 
	lw	%x7 -24(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -28(%x2)	# 2081 
	addi	%x2 %x2 -32	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 32	# 2081 
	lw	%x1 -28(%x2)	# 2081 
	lw	%x7 -24(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -28(%x2)	# 2082 
	addi	%x2 %x2 -32	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 32	# 2082 
	lw	%x1 -28(%x2)	# 2082 
	lw	%x7 -24(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x1 -28(%x2)	# 2077 
	addi	%x2 %x2 -32	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 32	# 2077 
	lw	%x1 -28(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -28(%x2)	# 2078 
	addi	%x2 %x2 -32	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 32	# 2078 
	lw	%x1 -28(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -28(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -32(%x2)	# 2079 
	addi	%x2 %x2 -36	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 36	# 2079 
	lw	%x1 -32(%x2)	# 2079 
	lw	%x7 -28(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -32(%x2)	# 2080 
	addi	%x2 %x2 -36	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 36	# 2080 
	lw	%x1 -32(%x2)	# 2080 
	lw	%x7 -28(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -32(%x2)	# 2081 
	addi	%x2 %x2 -36	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 36	# 2081 
	lw	%x1 -32(%x2)	# 2081 
	lw	%x7 -28(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -32(%x2)	# 2082 
	addi	%x2 %x2 -36	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 36	# 2082 
	lw	%x1 -32(%x2)	# 2082 
	lw	%x7 -28(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	addi	%x6 %x0 1	# 2095
	addi	%x8 %x0 0	# 2095
	add	%x7 %x0 %x8	# 2095 
	sw	%x1 -32(%x2)	# 2095 
	addi	%x2 %x2 -36	# 2095 
	jal	 %x1 min_caml_create_array	# 2095 
	addi	%x2 %x2 36	# 2095 
	lw	%x1 -32(%x2)	# 2095 
	addi	%x7 %x0 3	# 2077
	lw	%f1 52(%x29)	# 2077 
	sw	%x6 -32(%x2)	# 2077 
	add	%x6 %x0 %x7	# 2077 
	sw	%x1 -36(%x2)	# 2077 
	addi	%x2 %x2 -40	# 2077 
	jal	 %x1 min_caml_create_float_array	# 2077 
	addi	%x2 %x2 40	# 2077 
	lw	%x1 -36(%x2)	# 2077 
	add	%x7 %x0 %x6	# 2077 
	addi	%x6 %x0 5	# 2078
	sw	%x1 -36(%x2)	# 2078 
	addi	%x2 %x2 -40	# 2078 
	jal	 %x1 min_caml_create_array	# 2078 
	addi	%x2 %x2 40	# 2078 
	lw	%x1 -36(%x2)	# 2078 
	addi	%x7 %x0 3	# 2079
	lw	%f1 52(%x29)	# 2079 
	sw	%x6 -36(%x2)	# 2079 
	add	%x6 %x0 %x7	# 2079 
	sw	%x1 -40(%x2)	# 2079 
	addi	%x2 %x2 -44	# 2079 
	jal	 %x1 min_caml_create_float_array	# 2079 
	addi	%x2 %x2 44	# 2079 
	lw	%x1 -40(%x2)	# 2079 
	lw	%x7 -36(%x2)	# 2079 
	addi	%x8 %x7 4	# 2079 
	sw	%x6 0(%x8)	# 2079 
	addi	%x6 %x0 3	# 2080
	lw	%f1 52(%x29)	# 2080 
	sw	%x1 -40(%x2)	# 2080 
	addi	%x2 %x2 -44	# 2080 
	jal	 %x1 min_caml_create_float_array	# 2080 
	addi	%x2 %x2 44	# 2080 
	lw	%x1 -40(%x2)	# 2080 
	lw	%x7 -36(%x2)	# 2080 
	addi	%x8 %x7 8	# 2080 
	sw	%x6 0(%x8)	# 2080 
	addi	%x6 %x0 3	# 2081
	lw	%f1 52(%x29)	# 2081 
	sw	%x1 -40(%x2)	# 2081 
	addi	%x2 %x2 -44	# 2081 
	jal	 %x1 min_caml_create_float_array	# 2081 
	addi	%x2 %x2 44	# 2081 
	lw	%x1 -40(%x2)	# 2081 
	lw	%x7 -36(%x2)	# 2081 
	addi	%x8 %x7 12	# 2081 
	sw	%x6 0(%x8)	# 2081 
	addi	%x6 %x0 3	# 2082
	lw	%f1 52(%x29)	# 2082 
	sw	%x1 -40(%x2)	# 2082 
	addi	%x2 %x2 -44	# 2082 
	jal	 %x1 min_caml_create_float_array	# 2082 
	addi	%x2 %x2 44	# 2082 
	lw	%x1 -40(%x2)	# 2082 
	lw	%x7 -36(%x2)	# 2082 
	addi	%x8 %x7 16	# 2082 
	sw	%x6 0(%x8)	# 2082 
	add	%x6 %x0 %x3	# 2097 
	addi	%x3 %x3 32	# 2097 
	sw	%x7 28(%x6)	# 2097 
	lw	%x7 -32(%x2)	# 2097 
	sw	%x7 24(%x6)	# 2097 
	lw	%x7 -28(%x2)	# 2097 
	sw	%x7 20(%x6)	# 2097 
	lw	%x7 -24(%x2)	# 2097 
	sw	%x7 16(%x6)	# 2097 
	lw	%x7 -20(%x2)	# 2097 
	sw	%x7 12(%x6)	# 2097 
	lw	%x7 -16(%x2)	# 2097 
	sw	%x7 8(%x6)	# 2097 
	lw	%x7 -12(%x2)	# 2097 
	sw	%x7 4(%x6)	# 2097 
	lw	%x7 -8(%x2)	# 2097 
	sw	%x7 0(%x6)	# 2097 
	lw	%x7 -4(%x2)	# 2103 
	slli	%x8 %x7 2	# 2103 
	lw	%x9 -0(%x2)	# 2103 
	add	%x8 %x9 %x8	# 2103 
	sw	%x6 0(%x8)	# 2103 
	addi	%x6 %x7 -1	# 2104 
	blt	%x6 %x0 bge_else.21375	# 2102 
	sw	%x6 -40(%x2)	# 2103 
	sw	%x1 -44(%x2)	# 2103 
	addi	%x2 %x2 -48	# 2103 
	jal	 %x1 create_pixel.3155	# 2103 
	addi	%x2 %x2 48	# 2103 
	lw	%x1 -44(%x2)	# 2103 
	lw	%x7 -40(%x2)	# 2103 
	slli	%x8 %x7 2	# 2103 
	lw	%x9 -0(%x2)	# 2103 
	add	%x8 %x9 %x8	# 2103 
	sw	%x6 0(%x8)	# 2103 
	addi	%x7 %x7 -1	# 2104 
	add	%x6 %x0 %x9	# 2104 
	j	init_line_elements.3157	# 2104 
bge_else.21375:	# 2102 
	add	%x6 %x0 %x9	# 2106 
	jr	0(%x1)	# 2106 
bge_else.21374:	# 2102 
	jr	0(%x1)	# 2106 
calc_dirvec.3167:	#- 49924
	addi	%x5 %x0 5	# 2139 
	blt	%x6 %x5 bge_else.21376	# 2139 
	fmul	%f3 %f1 %f1	# 2140 
	fmul	%f4 %f2 %f2	# 2140 
	fadd	%f3 %f3 %f4	# 2140 
	lw	%f4 16(%x29)	# 2140 
	fadd	%f3 %f3 %f4	# 2140 
	fsqrt	%f3 %f3	# 2140 
	fdiv	%f1 %f1 %f3	# 2141 
	fdiv	%f2 %f2 %f3	# 2142 
	lw	%f4 16(%x29)	# 2143 
	fdiv	%f3 %f4 %f3	# 2143 
	lui	%x6 2098116	# 2146
	addi	%x6 %x6 964	# 2146
	slli	%x7 %x7 2	# 2146 
	add	%x6 %x6 %x7	# 2146 
	lw	%x6 0(%x6)	# 2146 
	slli	%x7 %x8 2	# 2147 
	add	%x7 %x6 %x7	# 2147 
	lw	%x7 0(%x7)	# 2147 
	lw	%x7 0(%x7)	# 454 
	addi	%x9 %x7 0	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x7 4	# 62 
	sw	%f2 0(%x9)	# 62 
	addi	%x7 %x7 8	# 63 
	sw	%f3 0(%x7)	# 63 
	addi	%x7 %x8 40	# 2148 
	slli	%x7 %x7 2	# 2148 
	add	%x7 %x6 %x7	# 2148 
	lw	%x7 0(%x7)	# 2148 
	lw	%x7 0(%x7)	# 454 
	lw	%f4 48(%x29)	# 2148 
	fmul	%f4 %f4 %f2	# 2148 
	addi	%x9 %x7 0	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x7 4	# 62 
	sw	%f3 0(%x9)	# 62 
	addi	%x7 %x7 8	# 63 
	sw	%f4 0(%x7)	# 63 
	addi	%x7 %x8 80	# 2149 
	slli	%x7 %x7 2	# 2149 
	add	%x7 %x6 %x7	# 2149 
	lw	%x7 0(%x7)	# 2149 
	lw	%x7 0(%x7)	# 454 
	lw	%f4 48(%x29)	# 2149 
	fmul	%f4 %f4 %f1	# 2149 
	lw	%f5 48(%x29)	# 2149 
	fmul	%f5 %f5 %f2	# 2149 
	addi	%x9 %x7 0	# 61 
	sw	%f3 0(%x9)	# 61 
	addi	%x9 %x7 4	# 62 
	sw	%f4 0(%x9)	# 62 
	addi	%x7 %x7 8	# 63 
	sw	%f5 0(%x7)	# 63 
	addi	%x7 %x8 1	# 2150 
	slli	%x7 %x7 2	# 2150 
	add	%x7 %x6 %x7	# 2150 
	lw	%x7 0(%x7)	# 2150 
	lw	%x7 0(%x7)	# 454 
	lw	%f4 48(%x29)	# 2150 
	fmul	%f4 %f4 %f1	# 2150 
	lw	%f5 48(%x29)	# 2150 
	fmul	%f5 %f5 %f2	# 2150 
	lw	%f6 48(%x29)	# 2150 
	fmul	%f6 %f6 %f3	# 2150 
	addi	%x9 %x7 0	# 61 
	sw	%f4 0(%x9)	# 61 
	addi	%x9 %x7 4	# 62 
	sw	%f5 0(%x9)	# 62 
	addi	%x7 %x7 8	# 63 
	sw	%f6 0(%x7)	# 63 
	addi	%x7 %x8 41	# 2151 
	slli	%x7 %x7 2	# 2151 
	add	%x7 %x6 %x7	# 2151 
	lw	%x7 0(%x7)	# 2151 
	lw	%x7 0(%x7)	# 454 
	lw	%f4 48(%x29)	# 2151 
	fmul	%f4 %f4 %f1	# 2151 
	lw	%f5 48(%x29)	# 2151 
	fmul	%f5 %f5 %f3	# 2151 
	addi	%x9 %x7 0	# 61 
	sw	%f4 0(%x9)	# 61 
	addi	%x9 %x7 4	# 62 
	sw	%f5 0(%x9)	# 62 
	addi	%x7 %x7 8	# 63 
	sw	%f2 0(%x7)	# 63 
	addi	%x7 %x8 81	# 2152 
	slli	%x7 %x7 2	# 2152 
	add	%x6 %x6 %x7	# 2152 
	lw	%x6 0(%x6)	# 2152 
	lw	%x6 0(%x6)	# 454 
	lw	%f4 48(%x29)	# 2152 
	fmul	%f3 %f4 %f3	# 2152 
	addi	%x7 %x6 0	# 61 
	sw	%f3 0(%x7)	# 61 
	addi	%x7 %x6 4	# 62 
	sw	%f1 0(%x7)	# 62 
	addi	%x6 %x6 8	# 63 
	sw	%f2 0(%x6)	# 63 
	jr	0(%x1)	# 63 
bge_else.21376:	# 2139 
	fmul	%f1 %f2 %f2	# 2130 
	lw	%f2 188(%x29)	# 2130 
	fadd	%f1 %f1 %f2	# 2130 
	fsqrt	%f1 %f1	# 2130 
	lw	%f2 16(%x29)	# 2131 
	fdiv	%f2 %f2 %f1	# 2131 
	sw	%x8 -0(%x2)	# 2132 
	sw	%x7 -4(%x2)	# 2132 
	sw	%f4 -8(%x2)	# 2132 
	sw	%x6 -12(%x2)	# 2132 
	sw	%f1 -16(%x2)	# 2132 
	sw	%f3 -20(%x2)	# 2132 
	fadd	%f1 %f0 %f2	# 2132 
	sw	%x1 -24(%x2)	# 2132 
	addi	%x2 %x2 -28	# 2132 
	jal	 %x1 atan.2722	# 2132 
	addi	%x2 %x2 28	# 2132 
	lw	%x1 -24(%x2)	# 2132 
	lw	%f2 -20(%x2)	# 2133 
	fmul	%f1 %f1 %f2	# 2133 
	sw	%f1 -24(%x2)	# 2125 
	sw	%x1 -28(%x2)	# 2125 
	addi	%x2 %x2 -32	# 2125 
	jal	 %x1 sin.2718	# 2125 
	addi	%x2 %x2 32	# 2125 
	lw	%x1 -28(%x2)	# 2125 
	lw	%f2 -24(%x2)	# 2125 
	sw	%f1 -28(%x2)	# 2125 
	fadd	%f1 %f0 %f2	# 2125 
	sw	%x1 -32(%x2)	# 2125 
	addi	%x2 %x2 -36	# 2125 
	jal	 %x1 cos.2720	# 2125 
	addi	%x2 %x2 36	# 2125 
	lw	%x1 -32(%x2)	# 2125 
	lw	%f2 -28(%x2)	# 2125 
	fdiv	%f1 %f2 %f1	# 2125 
	lw	%f2 -16(%x2)	# 2134 
	fmul	%f1 %f1 %f2	# 2134 
	lw	%x6 -12(%x2)	# 2155 
	addi	%x6 %x6 1	# 2155 
	fmul	%f2 %f1 %f1	# 2130 
	lw	%f3 188(%x29)	# 2130 
	fadd	%f2 %f2 %f3	# 2130 
	fsqrt	%f2 %f2	# 2130 
	lw	%f3 16(%x29)	# 2131 
	fdiv	%f3 %f3 %f2	# 2131 
	sw	%f1 -32(%x2)	# 2132 
	sw	%x6 -36(%x2)	# 2132 
	sw	%f2 -40(%x2)	# 2132 
	fadd	%f1 %f0 %f3	# 2132 
	sw	%x1 -44(%x2)	# 2132 
	addi	%x2 %x2 -48	# 2132 
	jal	 %x1 atan.2722	# 2132 
	addi	%x2 %x2 48	# 2132 
	lw	%x1 -44(%x2)	# 2132 
	lw	%f2 -8(%x2)	# 2133 
	fmul	%f1 %f1 %f2	# 2133 
	sw	%f1 -44(%x2)	# 2125 
	sw	%x1 -48(%x2)	# 2125 
	addi	%x2 %x2 -52	# 2125 
	jal	 %x1 sin.2718	# 2125 
	addi	%x2 %x2 52	# 2125 
	lw	%x1 -48(%x2)	# 2125 
	lw	%f2 -44(%x2)	# 2125 
	sw	%f1 -48(%x2)	# 2125 
	fadd	%f1 %f0 %f2	# 2125 
	sw	%x1 -52(%x2)	# 2125 
	addi	%x2 %x2 -56	# 2125 
	jal	 %x1 cos.2720	# 2125 
	addi	%x2 %x2 56	# 2125 
	lw	%x1 -52(%x2)	# 2125 
	lw	%f2 -48(%x2)	# 2125 
	fdiv	%f1 %f2 %f1	# 2125 
	lw	%f2 -40(%x2)	# 2134 
	fmul	%f2 %f1 %f2	# 2134 
	lw	%f1 -32(%x2)	# 2155 
	lw	%f3 -20(%x2)	# 2155 
	lw	%f4 -8(%x2)	# 2155 
	lw	%x6 -36(%x2)	# 2155 
	lw	%x7 -4(%x2)	# 2155 
	lw	%x8 -0(%x2)	# 2155 
	j	calc_dirvec.3167	# 2155 
calc_dirvecs.3175:	#- 50656
	blt	%x6 %x0 bge_else.21378	# 2160 
	sw	%x6 -0(%x2)	# 2162 
	sw	%f1 -4(%x2)	# 2162 
	sw	%x8 -8(%x2)	# 2162 
	sw	%x7 -12(%x2)	# 2162 
	sw	%x1 -16(%x2)	# 2162 
	addi	%x2 %x2 -20	# 2162 
	jal	 %x1 min_caml_float_of_int	# 2162 
	addi	%x2 %x2 20	# 2162 
	lw	%x1 -16(%x2)	# 2162 
	lw	%f2 80(%x29)	# 2162 
	fmul	%f1 %f1 %f2	# 2162 
	lw	%f2 200(%x29)	# 2162 
	fsub	%f3 %f1 %f2	# 2162 
	addi	%x6 %x0 0	# 2163
	lw	%f1 52(%x29)	# 2163 
	lw	%f2 52(%x29)	# 2163 
	lw	%f4 -4(%x2)	# 2163 
	lw	%x7 -12(%x2)	# 2163 
	lw	%x8 -8(%x2)	# 2163 
	sw	%x1 -16(%x2)	# 2163 
	addi	%x2 %x2 -20	# 2163 
	jal	 %x1 calc_dirvec.3167	# 2163 
	addi	%x2 %x2 20	# 2163 
	lw	%x1 -16(%x2)	# 2163 
	lw	%x6 -0(%x2)	# 2165 
	sw	%x1 -16(%x2)	# 2165 
	addi	%x2 %x2 -20	# 2165 
	jal	 %x1 min_caml_float_of_int	# 2165 
	addi	%x2 %x2 20	# 2165 
	lw	%x1 -16(%x2)	# 2165 
	lw	%f2 80(%x29)	# 2165 
	fmul	%f1 %f1 %f2	# 2165 
	lw	%f2 188(%x29)	# 2165 
	fadd	%f3 %f1 %f2	# 2165 
	addi	%x6 %x0 0	# 2166
	lw	%f1 52(%x29)	# 2166 
	lw	%f2 52(%x29)	# 2166 
	lw	%x7 -8(%x2)	# 2166 
	addi	%x8 %x7 2	# 2166 
	lw	%f4 -4(%x2)	# 2166 
	lw	%x9 -12(%x2)	# 2166 
	add	%x7 %x0 %x9	# 2166 
	sw	%x1 -16(%x2)	# 2166 
	addi	%x2 %x2 -20	# 2166 
	jal	 %x1 calc_dirvec.3167	# 2166 
	addi	%x2 %x2 20	# 2166 
	lw	%x1 -16(%x2)	# 2166 
	lw	%x6 -0(%x2)	# 2168 
	addi	%x6 %x6 -1	# 2168 
	lw	%x7 -12(%x2)	# 45 
	addi	%x7 %x7 1	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x7 %x5 bge.21379	# 46 
	addi	%x7 %x7 -5	# 46 
	j	beq_cont.21380	# 46 
bge.21379:	# 46 
beq_cont.21380:	# 46 
	blt	%x6 %x0 bge_else.21381	# 2160 
	sw	%x6 -16(%x2)	# 2162 
	sw	%x7 -20(%x2)	# 2162 
	sw	%x1 -24(%x2)	# 2162 
	addi	%x2 %x2 -28	# 2162 
	jal	 %x1 min_caml_float_of_int	# 2162 
	addi	%x2 %x2 28	# 2162 
	lw	%x1 -24(%x2)	# 2162 
	lw	%f2 80(%x29)	# 2162 
	fmul	%f1 %f1 %f2	# 2162 
	lw	%f2 200(%x29)	# 2162 
	fsub	%f3 %f1 %f2	# 2162 
	addi	%x6 %x0 0	# 2163
	lw	%f1 52(%x29)	# 2163 
	lw	%f2 52(%x29)	# 2163 
	lw	%f4 -4(%x2)	# 2163 
	lw	%x7 -20(%x2)	# 2163 
	lw	%x8 -8(%x2)	# 2163 
	sw	%x1 -24(%x2)	# 2163 
	addi	%x2 %x2 -28	# 2163 
	jal	 %x1 calc_dirvec.3167	# 2163 
	addi	%x2 %x2 28	# 2163 
	lw	%x1 -24(%x2)	# 2163 
	lw	%x6 -16(%x2)	# 2165 
	sw	%x1 -24(%x2)	# 2165 
	addi	%x2 %x2 -28	# 2165 
	jal	 %x1 min_caml_float_of_int	# 2165 
	addi	%x2 %x2 28	# 2165 
	lw	%x1 -24(%x2)	# 2165 
	lw	%f2 80(%x29)	# 2165 
	fmul	%f1 %f1 %f2	# 2165 
	lw	%f2 188(%x29)	# 2165 
	fadd	%f3 %f1 %f2	# 2165 
	addi	%x6 %x0 0	# 2166
	lw	%f1 52(%x29)	# 2166 
	lw	%f2 52(%x29)	# 2166 
	lw	%x7 -8(%x2)	# 2166 
	addi	%x8 %x7 2	# 2166 
	lw	%f4 -4(%x2)	# 2166 
	lw	%x9 -20(%x2)	# 2166 
	add	%x7 %x0 %x9	# 2166 
	sw	%x1 -24(%x2)	# 2166 
	addi	%x2 %x2 -28	# 2166 
	jal	 %x1 calc_dirvec.3167	# 2166 
	addi	%x2 %x2 28	# 2166 
	lw	%x1 -24(%x2)	# 2166 
	lw	%x6 -16(%x2)	# 2168 
	addi	%x6 %x6 -1	# 2168 
	lw	%x7 -20(%x2)	# 45 
	addi	%x7 %x7 1	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x7 %x5 bge.21382	# 46 
	addi	%x7 %x7 -5	# 46 
	j	beq_cont.21383	# 46 
bge.21382:	# 46 
beq_cont.21383:	# 46 
	lw	%f1 -4(%x2)	# 2168 
	lw	%x8 -8(%x2)	# 2168 
	j	calc_dirvecs.3175	# 2168 
bge_else.21381:	# 2160 
	jr	0(%x1)	# 2169 
bge_else.21378:	# 2160 
	jr	0(%x1)	# 2169 
calc_dirvec_rows.3180:	#- 51116
	blt	%x6 %x0 bge_else.21386	# 2174 
	sw	%x6 -0(%x2)	# 2175 
	sw	%x8 -4(%x2)	# 2175 
	sw	%x7 -8(%x2)	# 2175 
	sw	%x1 -12(%x2)	# 2175 
	addi	%x2 %x2 -16	# 2175 
	jal	 %x1 min_caml_float_of_int	# 2175 
	addi	%x2 %x2 16	# 2175 
	lw	%x1 -12(%x2)	# 2175 
	lw	%f2 80(%x29)	# 2175 
	fmul	%f1 %f1 %f2	# 2175 
	lw	%f2 200(%x29)	# 2175 
	fsub	%f1 %f1 %f2	# 2175 
	addi	%x6 %x0 4	# 2176
	sw	%x6 -12(%x2)	# 2162 
	sw	%f1 -16(%x2)	# 2162 
	sw	%x1 -20(%x2)	# 2162 
	addi	%x2 %x2 -24	# 2162 
	jal	 %x1 min_caml_float_of_int	# 2162 
	addi	%x2 %x2 24	# 2162 
	lw	%x1 -20(%x2)	# 2162 
	lw	%f2 80(%x29)	# 2162 
	fmul	%f1 %f1 %f2	# 2162 
	lw	%f2 200(%x29)	# 2162 
	fsub	%f3 %f1 %f2	# 2162 
	addi	%x6 %x0 0	# 2163
	lw	%f1 52(%x29)	# 2163 
	lw	%f2 52(%x29)	# 2163 
	lw	%f4 -16(%x2)	# 2163 
	lw	%x7 -8(%x2)	# 2163 
	lw	%x8 -4(%x2)	# 2163 
	sw	%x1 -20(%x2)	# 2163 
	addi	%x2 %x2 -24	# 2163 
	jal	 %x1 calc_dirvec.3167	# 2163 
	addi	%x2 %x2 24	# 2163 
	lw	%x1 -20(%x2)	# 2163 
	lw	%x6 -12(%x2)	# 2165 
	sw	%x1 -20(%x2)	# 2165 
	addi	%x2 %x2 -24	# 2165 
	jal	 %x1 min_caml_float_of_int	# 2165 
	addi	%x2 %x2 24	# 2165 
	lw	%x1 -20(%x2)	# 2165 
	lw	%f2 80(%x29)	# 2165 
	fmul	%f1 %f1 %f2	# 2165 
	lw	%f2 188(%x29)	# 2165 
	fadd	%f3 %f1 %f2	# 2165 
	addi	%x6 %x0 0	# 2166
	lw	%f1 52(%x29)	# 2166 
	lw	%f2 52(%x29)	# 2166 
	lw	%x7 -4(%x2)	# 2166 
	addi	%x8 %x7 2	# 2166 
	lw	%f4 -16(%x2)	# 2166 
	lw	%x9 -8(%x2)	# 2166 
	add	%x7 %x0 %x9	# 2166 
	sw	%x1 -20(%x2)	# 2166 
	addi	%x2 %x2 -24	# 2166 
	jal	 %x1 calc_dirvec.3167	# 2166 
	addi	%x2 %x2 24	# 2166 
	lw	%x1 -20(%x2)	# 2166 
	addi	%x6 %x0 3	# 2168
	lw	%x7 -8(%x2)	# 45 
	addi	%x8 %x7 1	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x8 %x5 bge.21387	# 46 
	addi	%x8 %x8 -5	# 46 
	j	beq_cont.21388	# 46 
bge.21387:	# 46 
beq_cont.21388:	# 46 
	lw	%f1 -16(%x2)	# 2168 
	lw	%x9 -4(%x2)	# 2168 
	add	%x7 %x0 %x8	# 2168 
	add	%x8 %x0 %x9	# 2168 
	sw	%x1 -20(%x2)	# 2168 
	addi	%x2 %x2 -24	# 2168 
	jal	 %x1 calc_dirvecs.3175	# 2168 
	addi	%x2 %x2 24	# 2168 
	lw	%x1 -20(%x2)	# 2168 
	lw	%x6 -0(%x2)	# 2177 
	addi	%x6 %x6 -1	# 2177 
	lw	%x7 -8(%x2)	# 45 
	addi	%x7 %x7 2	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x7 %x5 bge.21389	# 46 
	addi	%x7 %x7 -5	# 46 
	j	beq_cont.21390	# 46 
bge.21389:	# 46 
beq_cont.21390:	# 46 
	lw	%x8 -4(%x2)	# 2177 
	addi	%x8 %x8 4	# 2177 
	blt	%x6 %x0 bge_else.21391	# 2174 
	sw	%x6 -20(%x2)	# 2175 
	sw	%x8 -24(%x2)	# 2175 
	sw	%x7 -28(%x2)	# 2175 
	sw	%x1 -32(%x2)	# 2175 
	addi	%x2 %x2 -36	# 2175 
	jal	 %x1 min_caml_float_of_int	# 2175 
	addi	%x2 %x2 36	# 2175 
	lw	%x1 -32(%x2)	# 2175 
	lw	%f2 80(%x29)	# 2175 
	fmul	%f1 %f1 %f2	# 2175 
	lw	%f2 200(%x29)	# 2175 
	fsub	%f1 %f1 %f2	# 2175 
	addi	%x6 %x0 4	# 2176
	lw	%x7 -28(%x2)	# 2176 
	lw	%x8 -24(%x2)	# 2176 
	sw	%x1 -32(%x2)	# 2176 
	addi	%x2 %x2 -36	# 2176 
	jal	 %x1 calc_dirvecs.3175	# 2176 
	addi	%x2 %x2 36	# 2176 
	lw	%x1 -32(%x2)	# 2176 
	lw	%x6 -20(%x2)	# 2177 
	addi	%x6 %x6 -1	# 2177 
	lw	%x7 -28(%x2)	# 45 
	addi	%x7 %x7 2	# 45 
	addi	%x5 %x0 5	# 46 
	blt	%x7 %x5 bge.21392	# 46 
	addi	%x7 %x7 -5	# 46 
	j	beq_cont.21393	# 46 
bge.21392:	# 46 
beq_cont.21393:	# 46 
	lw	%x8 -24(%x2)	# 2177 
	addi	%x8 %x8 4	# 2177 
	j	calc_dirvec_rows.3180	# 2177 
bge_else.21391:	# 2174 
	jr	0(%x1)	# 2178 
bge_else.21386:	# 2174 
	jr	0(%x1)	# 2178 
create_dirvec_elements.3186:	#- 51592
	blt	%x7 %x0 bge_else.21396	# 2193 
	addi	%x8 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -0(%x2)	# 2187 
	sw	%x7 -4(%x2)	# 2187 
	add	%x6 %x0 %x8	# 2187 
	sw	%x1 -8(%x2)	# 2187 
	addi	%x2 %x2 -12	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 12	# 2187 
	lw	%x1 -8(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -8(%x2)	# 2188 
	sw	%x1 -12(%x2)	# 2188 
	addi	%x2 %x2 -16	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 16	# 2188 
	lw	%x1 -12(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -8(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -4(%x2)	# 2194 
	slli	%x8 %x7 2	# 2194 
	lw	%x9 -0(%x2)	# 2194 
	add	%x8 %x9 %x8	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x7 -1	# 2195 
	blt	%x6 %x0 bge_else.21397	# 2193 
	addi	%x7 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -12(%x2)	# 2187 
	add	%x6 %x0 %x7	# 2187 
	sw	%x1 -16(%x2)	# 2187 
	addi	%x2 %x2 -20	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 20	# 2187 
	lw	%x1 -16(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -16(%x2)	# 2188 
	sw	%x1 -20(%x2)	# 2188 
	addi	%x2 %x2 -24	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 24	# 2188 
	lw	%x1 -20(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -16(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -12(%x2)	# 2194 
	slli	%x8 %x7 2	# 2194 
	lw	%x9 -0(%x2)	# 2194 
	add	%x8 %x9 %x8	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x7 -1	# 2195 
	blt	%x6 %x0 bge_else.21398	# 2193 
	addi	%x7 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -20(%x2)	# 2187 
	add	%x6 %x0 %x7	# 2187 
	sw	%x1 -24(%x2)	# 2187 
	addi	%x2 %x2 -28	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 28	# 2187 
	lw	%x1 -24(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -24(%x2)	# 2188 
	sw	%x1 -28(%x2)	# 2188 
	addi	%x2 %x2 -32	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 32	# 2188 
	lw	%x1 -28(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -24(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -20(%x2)	# 2194 
	slli	%x8 %x7 2	# 2194 
	lw	%x9 -0(%x2)	# 2194 
	add	%x8 %x9 %x8	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x7 -1	# 2195 
	blt	%x6 %x0 bge_else.21399	# 2193 
	addi	%x7 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -28(%x2)	# 2187 
	add	%x6 %x0 %x7	# 2187 
	sw	%x1 -32(%x2)	# 2187 
	addi	%x2 %x2 -36	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 36	# 2187 
	lw	%x1 -32(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -32(%x2)	# 2188 
	sw	%x1 -36(%x2)	# 2188 
	addi	%x2 %x2 -40	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 40	# 2188 
	lw	%x1 -36(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -32(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -28(%x2)	# 2194 
	slli	%x8 %x7 2	# 2194 
	lw	%x9 -0(%x2)	# 2194 
	add	%x8 %x9 %x8	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x7 %x7 -1	# 2195 
	add	%x6 %x0 %x9	# 2195 
	j	create_dirvec_elements.3186	# 2195 
bge_else.21399:	# 2193 
	jr	0(%x1)	# 2196 
bge_else.21398:	# 2193 
	jr	0(%x1)	# 2196 
bge_else.21397:	# 2193 
	jr	0(%x1)	# 2196 
bge_else.21396:	# 2193 
	jr	0(%x1)	# 2196 
create_dirvecs.3189:	#- 52148
	blt	%x6 %x0 bge_else.21404	# 2200 
	addi	%x7 %x0 120	# 2201
	addi	%x8 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -0(%x2)	# 2187 
	sw	%x7 -4(%x2)	# 2187 
	add	%x6 %x0 %x8	# 2187 
	sw	%x1 -8(%x2)	# 2187 
	addi	%x2 %x2 -12	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 12	# 2187 
	lw	%x1 -8(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -8(%x2)	# 2188 
	sw	%x1 -12(%x2)	# 2188 
	addi	%x2 %x2 -16	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 16	# 2188 
	lw	%x1 -12(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -8(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	lw	%x6 -4(%x2)	# 2201 
	sw	%x1 -12(%x2)	# 2201 
	addi	%x2 %x2 -16	# 2201 
	jal	 %x1 min_caml_create_array	# 2201 
	addi	%x2 %x2 16	# 2201 
	lw	%x1 -12(%x2)	# 2201 
	lui	%x7 2098116	# 2201
	addi	%x7 %x7 964	# 2201
	lw	%x8 -0(%x2)	# 2201 
	slli	%x9 %x8 2	# 2201 
	add	%x7 %x7 %x9	# 2201 
	sw	%x6 0(%x7)	# 2201 
	lui	%x6 2098116	# 2202
	addi	%x6 %x6 964	# 2202
	slli	%x7 %x8 2	# 2202 
	add	%x6 %x6 %x7	# 2202 
	lw	%x6 0(%x6)	# 2202 
	addi	%x7 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -12(%x2)	# 2187 
	add	%x6 %x0 %x7	# 2187 
	sw	%x1 -16(%x2)	# 2187 
	addi	%x2 %x2 -20	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 20	# 2187 
	lw	%x1 -16(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -16(%x2)	# 2188 
	sw	%x1 -20(%x2)	# 2188 
	addi	%x2 %x2 -24	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 24	# 2188 
	lw	%x1 -20(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -16(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -12(%x2)	# 2194 
	addi	%x8 %x7 472	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x1 -20(%x2)	# 2187 
	addi	%x2 %x2 -24	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 24	# 2187 
	lw	%x1 -20(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -20(%x2)	# 2188 
	sw	%x1 -24(%x2)	# 2188 
	addi	%x2 %x2 -28	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 28	# 2188 
	lw	%x1 -24(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -20(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -12(%x2)	# 2194 
	addi	%x8 %x7 468	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x1 -24(%x2)	# 2187 
	addi	%x2 %x2 -28	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 28	# 2187 
	lw	%x1 -24(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -24(%x2)	# 2188 
	sw	%x1 -28(%x2)	# 2188 
	addi	%x2 %x2 -32	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 32	# 2188 
	lw	%x1 -28(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -24(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -12(%x2)	# 2194 
	addi	%x8 %x7 464	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x0 115	# 2195
	add	%x5 %x0 %x7	# 2195 
	add	%x7 %x0 %x6	# 2195 
	add	%x6 %x0 %x5	# 2195 
	sw	%x1 -28(%x2)	# 2195 
	addi	%x2 %x2 -32	# 2195 
	jal	 %x1 create_dirvec_elements.3186	# 2195 
	addi	%x2 %x2 32	# 2195 
	lw	%x1 -28(%x2)	# 2195 
	lw	%x6 -0(%x2)	# 2203 
	addi	%x6 %x6 -1	# 2203 
	blt	%x6 %x0 bge_else.21405	# 2200 
	addi	%x7 %x0 120	# 2201
	addi	%x8 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -28(%x2)	# 2187 
	sw	%x7 -32(%x2)	# 2187 
	add	%x6 %x0 %x8	# 2187 
	sw	%x1 -36(%x2)	# 2187 
	addi	%x2 %x2 -40	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 40	# 2187 
	lw	%x1 -36(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -36(%x2)	# 2188 
	sw	%x1 -40(%x2)	# 2188 
	addi	%x2 %x2 -44	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 44	# 2188 
	lw	%x1 -40(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -36(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	lw	%x6 -32(%x2)	# 2201 
	sw	%x1 -40(%x2)	# 2201 
	addi	%x2 %x2 -44	# 2201 
	jal	 %x1 min_caml_create_array	# 2201 
	addi	%x2 %x2 44	# 2201 
	lw	%x1 -40(%x2)	# 2201 
	lui	%x7 2098116	# 2201
	addi	%x7 %x7 964	# 2201
	lw	%x8 -28(%x2)	# 2201 
	slli	%x9 %x8 2	# 2201 
	add	%x7 %x7 %x9	# 2201 
	sw	%x6 0(%x7)	# 2201 
	lui	%x6 2098116	# 2202
	addi	%x6 %x6 964	# 2202
	slli	%x7 %x8 2	# 2202 
	add	%x6 %x6 %x7	# 2202 
	lw	%x6 0(%x6)	# 2202 
	addi	%x7 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x6 -40(%x2)	# 2187 
	add	%x6 %x0 %x7	# 2187 
	sw	%x1 -44(%x2)	# 2187 
	addi	%x2 %x2 -48	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 48	# 2187 
	lw	%x1 -44(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -44(%x2)	# 2188 
	sw	%x1 -48(%x2)	# 2188 
	addi	%x2 %x2 -52	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 52	# 2188 
	lw	%x1 -48(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -44(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -40(%x2)	# 2194 
	addi	%x8 %x7 472	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x0 3	# 2187
	lw	%f1 52(%x29)	# 2187 
	sw	%x1 -48(%x2)	# 2187 
	addi	%x2 %x2 -52	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 52	# 2187 
	lw	%x1 -48(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -48(%x2)	# 2188 
	sw	%x1 -52(%x2)	# 2188 
	addi	%x2 %x2 -56	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 56	# 2188 
	lw	%x1 -52(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x6 -48(%x2)	# 2189 
	sw	%x6 0(%x7)	# 2189 
	add	%x6 %x0 %x7	# 2189 
	lw	%x7 -40(%x2)	# 2194 
	addi	%x8 %x7 468	# 2194 
	sw	%x6 0(%x8)	# 2194 
	addi	%x6 %x0 116	# 2195
	add	%x5 %x0 %x7	# 2195 
	add	%x7 %x0 %x6	# 2195 
	add	%x6 %x0 %x5	# 2195 
	sw	%x1 -52(%x2)	# 2195 
	addi	%x2 %x2 -56	# 2195 
	jal	 %x1 create_dirvec_elements.3186	# 2195 
	addi	%x2 %x2 56	# 2195 
	lw	%x1 -52(%x2)	# 2195 
	lw	%x6 -28(%x2)	# 2203 
	addi	%x6 %x6 -1	# 2203 
	j	create_dirvecs.3189	# 2203 
bge_else.21405:	# 2200 
	jr	0(%x1)	# 2204 
bge_else.21404:	# 2200 
	jr	0(%x1)	# 2204 
init_dirvec_constants.3191:	#- 53164
	blt	%x7 %x0 bge_else.21408	# 2212 
	slli	%x8 %x7 2	# 2213 
	add	%x8 %x6 %x8	# 2213 
	lw	%x8 0(%x8)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -0(%x2)	# 1104 
	sw	%x7 -4(%x2)	# 1104 
	add	%x7 %x0 %x9	# 1104 
	add	%x6 %x0 %x8	# 1104 
	sw	%x1 -8(%x2)	# 1104 
	addi	%x2 %x2 -12	# 1104 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1104 
	addi	%x2 %x2 12	# 1104 
	lw	%x1 -8(%x2)	# 1104 
	lw	%x6 -4(%x2)	# 2214 
	addi	%x6 %x6 -1	# 2214 
	blt	%x6 %x0 bge_else.21409	# 2212 
	slli	%x7 %x6 2	# 2213 
	lw	%x8 -0(%x2)	# 2213 
	add	%x7 %x8 %x7	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -8(%x2)	# 1087 
	blt	%x9 %x0 bge.21410	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x7)	# 460 
	lw	%x12 0(%x7)	# 454 
	lw	%x13 4(%x10)	# 168 
	sw	%x7 -12(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x13 %x5 beq_else.21412	# 1092 
	sw	%x11 -16(%x2)	# 1093 
	sw	%x9 -20(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x12	# 1093 
	sw	%x1 -24(%x2)	# 1093 
	addi	%x2 %x2 -28	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 28	# 1093 
	lw	%x1 -24(%x2)	# 1093 
	lw	%x7 -20(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -16(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21413	# 1092 
beq_else.21412:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x13 %x5 beq_else.21414	# 1094 
	sw	%x11 -16(%x2)	# 1095 
	sw	%x9 -20(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x12	# 1095 
	sw	%x1 -24(%x2)	# 1095 
	addi	%x2 %x2 -28	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 28	# 1095 
	lw	%x1 -24(%x2)	# 1095 
	lw	%x7 -20(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -16(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21415	# 1094 
beq_else.21414:	# 1094 
	sw	%x11 -16(%x2)	# 1097 
	sw	%x9 -20(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x12	# 1097 
	sw	%x1 -24(%x2)	# 1097 
	addi	%x2 %x2 -28	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 28	# 1097 
	lw	%x1 -24(%x2)	# 1097 
	lw	%x7 -20(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -16(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21415:	# 1094 
beq_cont.21413:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -12(%x2)	# 1099 
	sw	%x1 -24(%x2)	# 1099 
	addi	%x2 %x2 -28	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 28	# 1099 
	lw	%x1 -24(%x2)	# 1099 
	j	beq_cont.21411	# 1087 
bge.21410:	# 1087 
beq_cont.21411:	# 1087 
	lw	%x6 -8(%x2)	# 2214 
	addi	%x6 %x6 -1	# 2214 
	blt	%x6 %x0 bge_else.21416	# 2212 
	slli	%x7 %x6 2	# 2213 
	lw	%x8 -0(%x2)	# 2213 
	add	%x7 %x8 %x7	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -24(%x2)	# 1104 
	add	%x6 %x0 %x7	# 1104 
	add	%x7 %x0 %x9	# 1104 
	sw	%x1 -28(%x2)	# 1104 
	addi	%x2 %x2 -32	# 1104 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1104 
	addi	%x2 %x2 32	# 1104 
	lw	%x1 -28(%x2)	# 1104 
	lw	%x6 -24(%x2)	# 2214 
	addi	%x6 %x6 -1	# 2214 
	blt	%x6 %x0 bge_else.21417	# 2212 
	slli	%x7 %x6 2	# 2213 
	lw	%x8 -0(%x2)	# 2213 
	add	%x7 %x8 %x7	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -28(%x2)	# 1087 
	blt	%x9 %x0 bge.21418	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x7)	# 460 
	lw	%x12 0(%x7)	# 454 
	lw	%x13 4(%x10)	# 168 
	sw	%x7 -32(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x13 %x5 beq_else.21420	# 1092 
	sw	%x11 -36(%x2)	# 1093 
	sw	%x9 -40(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x12	# 1093 
	sw	%x1 -44(%x2)	# 1093 
	addi	%x2 %x2 -48	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 48	# 1093 
	lw	%x1 -44(%x2)	# 1093 
	lw	%x7 -40(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -36(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21421	# 1092 
beq_else.21420:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x13 %x5 beq_else.21422	# 1094 
	sw	%x11 -36(%x2)	# 1095 
	sw	%x9 -40(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x12	# 1095 
	sw	%x1 -44(%x2)	# 1095 
	addi	%x2 %x2 -48	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 48	# 1095 
	lw	%x1 -44(%x2)	# 1095 
	lw	%x7 -40(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -36(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21423	# 1094 
beq_else.21422:	# 1094 
	sw	%x11 -36(%x2)	# 1097 
	sw	%x9 -40(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x12	# 1097 
	sw	%x1 -44(%x2)	# 1097 
	addi	%x2 %x2 -48	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 48	# 1097 
	lw	%x1 -44(%x2)	# 1097 
	lw	%x7 -40(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -36(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21423:	# 1094 
beq_cont.21421:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -32(%x2)	# 1099 
	sw	%x1 -44(%x2)	# 1099 
	addi	%x2 %x2 -48	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 48	# 1099 
	lw	%x1 -44(%x2)	# 1099 
	j	beq_cont.21419	# 1087 
bge.21418:	# 1087 
beq_cont.21419:	# 1087 
	lw	%x6 -28(%x2)	# 2214 
	addi	%x7 %x6 -1	# 2214 
	lw	%x6 -0(%x2)	# 2214 
	j	init_dirvec_constants.3191	# 2214 
bge_else.21417:	# 2212 
	jr	0(%x1)	# 2215 
bge_else.21416:	# 2212 
	jr	0(%x1)	# 2215 
bge_else.21409:	# 2212 
	jr	0(%x1)	# 2215 
bge_else.21408:	# 2212 
	jr	0(%x1)	# 2215 
init_vecset_constants.3194:	#- 53980
	blt	%x6 %x0 bge_else.21428	# 2219 
	lui	%x7 2098116	# 2220
	addi	%x7 %x7 964	# 2220
	slli	%x8 %x6 2	# 2220 
	add	%x7 %x7 %x8	# 2220 
	lw	%x7 0(%x7)	# 2220 
	addi	%x8 %x7 476	# 2213 
	lw	%x8 0(%x8)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -0(%x2)	# 1087 
	sw	%x7 -4(%x2)	# 1087 
	blt	%x9 %x0 bge.21429	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x8)	# 460 
	lw	%x12 0(%x8)	# 454 
	lw	%x13 4(%x10)	# 168 
	sw	%x8 -8(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x13 %x5 beq_else.21431	# 1092 
	sw	%x11 -12(%x2)	# 1093 
	sw	%x9 -16(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x12	# 1093 
	sw	%x1 -20(%x2)	# 1093 
	addi	%x2 %x2 -24	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 24	# 1093 
	lw	%x1 -20(%x2)	# 1093 
	lw	%x7 -16(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -12(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21432	# 1092 
beq_else.21431:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x13 %x5 beq_else.21433	# 1094 
	sw	%x11 -12(%x2)	# 1095 
	sw	%x9 -16(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x12	# 1095 
	sw	%x1 -20(%x2)	# 1095 
	addi	%x2 %x2 -24	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 24	# 1095 
	lw	%x1 -20(%x2)	# 1095 
	lw	%x7 -16(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -12(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21434	# 1094 
beq_else.21433:	# 1094 
	sw	%x11 -12(%x2)	# 1097 
	sw	%x9 -16(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x12	# 1097 
	sw	%x1 -20(%x2)	# 1097 
	addi	%x2 %x2 -24	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 24	# 1097 
	lw	%x1 -20(%x2)	# 1097 
	lw	%x7 -16(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -12(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21434:	# 1094 
beq_cont.21432:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -8(%x2)	# 1099 
	sw	%x1 -20(%x2)	# 1099 
	addi	%x2 %x2 -24	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 24	# 1099 
	lw	%x1 -20(%x2)	# 1099 
	j	beq_cont.21430	# 1087 
bge.21429:	# 1087 
beq_cont.21430:	# 1087 
	lw	%x6 -4(%x2)	# 2213 
	addi	%x7 %x6 472	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x8 2097408	# 1104
	addi	%x8 %x8 256	# 1104
	addi	%x8 %x8 0	# 1104 
	lw	%x8 0(%x8)	# 1104 
	addi	%x8 %x8 -1	# 1104 
	add	%x6 %x0 %x7	# 1104 
	add	%x7 %x0 %x8	# 1104 
	sw	%x1 -20(%x2)	# 1104 
	addi	%x2 %x2 -24	# 1104 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1104 
	addi	%x2 %x2 24	# 1104 
	lw	%x1 -20(%x2)	# 1104 
	lw	%x6 -4(%x2)	# 2213 
	addi	%x7 %x6 468	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x8 2097408	# 1104
	addi	%x8 %x8 256	# 1104
	addi	%x8 %x8 0	# 1104 
	lw	%x8 0(%x8)	# 1104 
	addi	%x8 %x8 -1	# 1104 
	blt	%x8 %x0 bge.21435	# 1087 
	lui	%x9 2097456	# 1088
	addi	%x9 %x9 304	# 1088
	slli	%x10 %x8 2	# 1088 
	add	%x9 %x9 %x10	# 1088 
	lw	%x9 0(%x9)	# 1088 
	lw	%x10 4(%x7)	# 460 
	lw	%x11 0(%x7)	# 454 
	lw	%x12 4(%x9)	# 168 
	sw	%x7 -20(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x12 %x5 beq_else.21437	# 1092 
	sw	%x10 -24(%x2)	# 1093 
	sw	%x8 -28(%x2)	# 1093 
	add	%x7 %x0 %x9	# 1093 
	add	%x6 %x0 %x11	# 1093 
	sw	%x1 -32(%x2)	# 1093 
	addi	%x2 %x2 -36	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 36	# 1093 
	lw	%x1 -32(%x2)	# 1093 
	lw	%x7 -28(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -24(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21438	# 1092 
beq_else.21437:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x12 %x5 beq_else.21439	# 1094 
	sw	%x10 -24(%x2)	# 1095 
	sw	%x8 -28(%x2)	# 1095 
	add	%x7 %x0 %x9	# 1095 
	add	%x6 %x0 %x11	# 1095 
	sw	%x1 -32(%x2)	# 1095 
	addi	%x2 %x2 -36	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 36	# 1095 
	lw	%x1 -32(%x2)	# 1095 
	lw	%x7 -28(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -24(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21440	# 1094 
beq_else.21439:	# 1094 
	sw	%x10 -24(%x2)	# 1097 
	sw	%x8 -28(%x2)	# 1097 
	add	%x7 %x0 %x9	# 1097 
	add	%x6 %x0 %x11	# 1097 
	sw	%x1 -32(%x2)	# 1097 
	addi	%x2 %x2 -36	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 36	# 1097 
	lw	%x1 -32(%x2)	# 1097 
	lw	%x7 -28(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -24(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21440:	# 1094 
beq_cont.21438:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -20(%x2)	# 1099 
	sw	%x1 -32(%x2)	# 1099 
	addi	%x2 %x2 -36	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 36	# 1099 
	lw	%x1 -32(%x2)	# 1099 
	j	beq_cont.21436	# 1087 
bge.21435:	# 1087 
beq_cont.21436:	# 1087 
	addi	%x7 %x0 116	# 2214
	lw	%x6 -4(%x2)	# 2214 
	sw	%x1 -32(%x2)	# 2214 
	addi	%x2 %x2 -36	# 2214 
	jal	 %x1 init_dirvec_constants.3191	# 2214 
	addi	%x2 %x2 36	# 2214 
	lw	%x1 -32(%x2)	# 2214 
	lw	%x6 -0(%x2)	# 2221 
	addi	%x6 %x6 -1	# 2221 
	blt	%x6 %x0 bge_else.21441	# 2219 
	lui	%x7 2098116	# 2220
	addi	%x7 %x7 964	# 2220
	slli	%x8 %x6 2	# 2220 
	add	%x7 %x7 %x8	# 2220 
	lw	%x7 0(%x7)	# 2220 
	addi	%x8 %x7 476	# 2213 
	lw	%x8 0(%x8)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -32(%x2)	# 1104 
	sw	%x7 -36(%x2)	# 1104 
	add	%x7 %x0 %x9	# 1104 
	add	%x6 %x0 %x8	# 1104 
	sw	%x1 -40(%x2)	# 1104 
	addi	%x2 %x2 -44	# 1104 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1104 
	addi	%x2 %x2 44	# 1104 
	lw	%x1 -40(%x2)	# 1104 
	lw	%x6 -36(%x2)	# 2213 
	addi	%x7 %x6 472	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x8 2097408	# 1104
	addi	%x8 %x8 256	# 1104
	addi	%x8 %x8 0	# 1104 
	lw	%x8 0(%x8)	# 1104 
	addi	%x8 %x8 -1	# 1104 
	blt	%x8 %x0 bge.21442	# 1087 
	lui	%x9 2097456	# 1088
	addi	%x9 %x9 304	# 1088
	slli	%x10 %x8 2	# 1088 
	add	%x9 %x9 %x10	# 1088 
	lw	%x9 0(%x9)	# 1088 
	lw	%x10 4(%x7)	# 460 
	lw	%x11 0(%x7)	# 454 
	lw	%x12 4(%x9)	# 168 
	sw	%x7 -40(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x12 %x5 beq_else.21444	# 1092 
	sw	%x10 -44(%x2)	# 1093 
	sw	%x8 -48(%x2)	# 1093 
	add	%x7 %x0 %x9	# 1093 
	add	%x6 %x0 %x11	# 1093 
	sw	%x1 -52(%x2)	# 1093 
	addi	%x2 %x2 -56	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 56	# 1093 
	lw	%x1 -52(%x2)	# 1093 
	lw	%x7 -48(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -44(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21445	# 1092 
beq_else.21444:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x12 %x5 beq_else.21446	# 1094 
	sw	%x10 -44(%x2)	# 1095 
	sw	%x8 -48(%x2)	# 1095 
	add	%x7 %x0 %x9	# 1095 
	add	%x6 %x0 %x11	# 1095 
	sw	%x1 -52(%x2)	# 1095 
	addi	%x2 %x2 -56	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 56	# 1095 
	lw	%x1 -52(%x2)	# 1095 
	lw	%x7 -48(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -44(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21447	# 1094 
beq_else.21446:	# 1094 
	sw	%x10 -44(%x2)	# 1097 
	sw	%x8 -48(%x2)	# 1097 
	add	%x7 %x0 %x9	# 1097 
	add	%x6 %x0 %x11	# 1097 
	sw	%x1 -52(%x2)	# 1097 
	addi	%x2 %x2 -56	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 56	# 1097 
	lw	%x1 -52(%x2)	# 1097 
	lw	%x7 -48(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -44(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21447:	# 1094 
beq_cont.21445:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -40(%x2)	# 1099 
	sw	%x1 -52(%x2)	# 1099 
	addi	%x2 %x2 -56	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 56	# 1099 
	lw	%x1 -52(%x2)	# 1099 
	j	beq_cont.21443	# 1087 
bge.21442:	# 1087 
beq_cont.21443:	# 1087 
	addi	%x7 %x0 117	# 2214
	lw	%x6 -36(%x2)	# 2214 
	sw	%x1 -52(%x2)	# 2214 
	addi	%x2 %x2 -56	# 2214 
	jal	 %x1 init_dirvec_constants.3191	# 2214 
	addi	%x2 %x2 56	# 2214 
	lw	%x1 -52(%x2)	# 2214 
	lw	%x6 -32(%x2)	# 2221 
	addi	%x6 %x6 -1	# 2221 
	blt	%x6 %x0 bge_else.21448	# 2219 
	lui	%x7 2098116	# 2220
	addi	%x7 %x7 964	# 2220
	slli	%x8 %x6 2	# 2220 
	add	%x7 %x7 %x8	# 2220 
	lw	%x7 0(%x7)	# 2220 
	addi	%x8 %x7 476	# 2213 
	lw	%x8 0(%x8)	# 2213 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x6 -52(%x2)	# 1087 
	sw	%x7 -56(%x2)	# 1087 
	blt	%x9 %x0 bge.21449	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x8)	# 460 
	lw	%x12 0(%x8)	# 454 
	lw	%x13 4(%x10)	# 168 
	sw	%x8 -60(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x13 %x5 beq_else.21451	# 1092 
	sw	%x11 -64(%x2)	# 1093 
	sw	%x9 -68(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x12	# 1093 
	sw	%x1 -72(%x2)	# 1093 
	addi	%x2 %x2 -76	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 76	# 1093 
	lw	%x1 -72(%x2)	# 1093 
	lw	%x7 -68(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -64(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21452	# 1092 
beq_else.21451:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x13 %x5 beq_else.21453	# 1094 
	sw	%x11 -64(%x2)	# 1095 
	sw	%x9 -68(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x12	# 1095 
	sw	%x1 -72(%x2)	# 1095 
	addi	%x2 %x2 -76	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 76	# 1095 
	lw	%x1 -72(%x2)	# 1095 
	lw	%x7 -68(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -64(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21454	# 1094 
beq_else.21453:	# 1094 
	sw	%x11 -64(%x2)	# 1097 
	sw	%x9 -68(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x12	# 1097 
	sw	%x1 -72(%x2)	# 1097 
	addi	%x2 %x2 -76	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 76	# 1097 
	lw	%x1 -72(%x2)	# 1097 
	lw	%x7 -68(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -64(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21454:	# 1094 
beq_cont.21452:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -60(%x2)	# 1099 
	sw	%x1 -72(%x2)	# 1099 
	addi	%x2 %x2 -76	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 76	# 1099 
	lw	%x1 -72(%x2)	# 1099 
	j	beq_cont.21450	# 1087 
bge.21449:	# 1087 
beq_cont.21450:	# 1087 
	addi	%x7 %x0 118	# 2214
	lw	%x6 -56(%x2)	# 2214 
	sw	%x1 -72(%x2)	# 2214 
	addi	%x2 %x2 -76	# 2214 
	jal	 %x1 init_dirvec_constants.3191	# 2214 
	addi	%x2 %x2 76	# 2214 
	lw	%x1 -72(%x2)	# 2214 
	lw	%x6 -52(%x2)	# 2221 
	addi	%x6 %x6 -1	# 2221 
	blt	%x6 %x0 bge_else.21455	# 2219 
	lui	%x7 2098116	# 2220
	addi	%x7 %x7 964	# 2220
	slli	%x8 %x6 2	# 2220 
	add	%x7 %x7 %x8	# 2220 
	lw	%x7 0(%x7)	# 2220 
	addi	%x8 %x0 119	# 2220
	sw	%x6 -72(%x2)	# 2220 
	add	%x6 %x0 %x7	# 2220 
	add	%x7 %x0 %x8	# 2220 
	sw	%x1 -76(%x2)	# 2220 
	addi	%x2 %x2 -80	# 2220 
	jal	 %x1 init_dirvec_constants.3191	# 2220 
	addi	%x2 %x2 80	# 2220 
	lw	%x1 -76(%x2)	# 2220 
	lw	%x6 -72(%x2)	# 2221 
	addi	%x6 %x6 -1	# 2221 
	j	init_vecset_constants.3194	# 2221 
bge_else.21455:	# 2219 
	jr	0(%x1)	# 2222 
bge_else.21448:	# 2219 
	jr	0(%x1)	# 2222 
bge_else.21441:	# 2219 
	jr	0(%x1)	# 2222 
bge_else.21428:	# 2219 
	jr	0(%x1)	# 2222 
setup_rect_reflection.3205:	#- 55564
	addi	%x8 %x0 2	# 120
	sw	%x7 -0(%x2)	# 120 
	add	%x7 %x0 %x8	# 120 
	sw	%x1 -4(%x2)	# 120 
	addi	%x2 %x2 -8	# 120 
	jal	 %x1 min_caml_sll	# 120 
	addi	%x2 %x2 8	# 120 
	lw	%x1 -4(%x2)	# 120 
	lui	%x7 2099136	# 2247
	addi	%x7 %x7 1984	# 2247
	addi	%x7 %x7 0	# 2247 
	lw	%x7 0(%x7)	# 2247 
	lw	%f1 16(%x29)	# 2248 
	lw	%x8 -0(%x2)	# 276 
	lw	%x8 28(%x8)	# 276 
	addi	%x8 %x8 0	# 281 
	lw	%f2 0(%x8)	# 281 
	fsub	%f1 %f1 %f2	# 2248 
	lw	%f2 48(%x29)	# 2249 
	lui	%x8 2097720	# 2249
	addi	%x8 %x8 568	# 2249
	addi	%x8 %x8 0	# 2249 
	lw	%f3 0(%x8)	# 2249 
	fmul	%f2 %f2 %f3	# 2249 
	lw	%f3 48(%x29)	# 2250 
	lui	%x8 2097720	# 2250
	addi	%x8 %x8 568	# 2250
	addi	%x8 %x8 4	# 2250 
	lw	%f4 0(%x8)	# 2250 
	fmul	%f3 %f3 %f4	# 2250 
	lw	%f4 48(%x29)	# 2251 
	lui	%x8 2097720	# 2251
	addi	%x8 %x8 568	# 2251
	addi	%x8 %x8 8	# 2251 
	lw	%f5 0(%x8)	# 2251 
	fmul	%f4 %f4 %f5	# 2251 
	addi	%x8 %x6 1	# 2252 
	lui	%x9 2097720	# 2252
	addi	%x9 %x9 568	# 2252
	addi	%x9 %x9 0	# 2252 
	lw	%f5 0(%x9)	# 2252 
	addi	%x9 %x0 3	# 2187
	lw	%f6 52(%x29)	# 2187 
	sw	%f2 -4(%x2)	# 2187 
	sw	%x6 -8(%x2)	# 2187 
	sw	%x7 -12(%x2)	# 2187 
	sw	%x8 -16(%x2)	# 2187 
	sw	%f1 -20(%x2)	# 2187 
	sw	%f4 -24(%x2)	# 2187 
	sw	%f3 -28(%x2)	# 2187 
	sw	%f5 -32(%x2)	# 2187 
	add	%x6 %x0 %x9	# 2187 
	fadd	%f1 %f0 %f6	# 2187 
	sw	%x1 -36(%x2)	# 2187 
	addi	%x2 %x2 -40	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 40	# 2187 
	lw	%x1 -36(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -36(%x2)	# 2188 
	sw	%x1 -40(%x2)	# 2188 
	addi	%x2 %x2 -44	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 44	# 2188 
	lw	%x1 -40(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x8 -36(%x2)	# 2189 
	sw	%x8 0(%x7)	# 2189 
	addi	%x9 %x8 0	# 61 
	lw	%f1 -32(%x2)	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x8 4	# 62 
	lw	%f1 -28(%x2)	# 62 
	sw	%f1 0(%x9)	# 62 
	addi	%x9 %x8 8	# 63 
	lw	%f2 -24(%x2)	# 63 
	sw	%f2 0(%x9)	# 63 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x7 -40(%x2)	# 1087 
	blt	%x9 %x0 bge.21460	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x10)	# 168 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.21462	# 1092 
	sw	%x6 -44(%x2)	# 1093 
	sw	%x9 -48(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x8	# 1093 
	sw	%x1 -52(%x2)	# 1093 
	addi	%x2 %x2 -56	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 56	# 1093 
	lw	%x1 -52(%x2)	# 1093 
	lw	%x7 -48(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -44(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21463	# 1092 
beq_else.21462:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.21464	# 1094 
	sw	%x6 -44(%x2)	# 1095 
	sw	%x9 -48(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x8	# 1095 
	sw	%x1 -52(%x2)	# 1095 
	addi	%x2 %x2 -56	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 56	# 1095 
	lw	%x1 -52(%x2)	# 1095 
	lw	%x7 -48(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -44(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21465	# 1094 
beq_else.21464:	# 1094 
	sw	%x6 -44(%x2)	# 1097 
	sw	%x9 -48(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x8	# 1097 
	sw	%x1 -52(%x2)	# 1097 
	addi	%x2 %x2 -56	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 56	# 1097 
	lw	%x1 -52(%x2)	# 1097 
	lw	%x7 -48(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -44(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21465:	# 1094 
beq_cont.21463:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -40(%x2)	# 1099 
	sw	%x1 -52(%x2)	# 1099 
	addi	%x2 %x2 -56	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 56	# 1099 
	lw	%x1 -52(%x2)	# 1099 
	j	beq_cont.21461	# 1087 
bge.21460:	# 1087 
beq_cont.21461:	# 1087 
	add	%x6 %x0 %x3	# 2241 
	addi	%x3 %x3 12	# 2241 
	lw	%f1 -20(%x2)	# 2241 
	sw	%f1 8(%x6)	# 2241 
	lw	%x7 -40(%x2)	# 2241 
	sw	%x7 4(%x6)	# 2241 
	lw	%x7 -16(%x2)	# 2241 
	sw	%x7 0(%x6)	# 2241 
	lui	%x7 2098416	# 2241
	addi	%x7 %x7 1264	# 2241
	lw	%x8 -12(%x2)	# 2241 
	slli	%x9 %x8 2	# 2241 
	add	%x7 %x7 %x9	# 2241 
	sw	%x6 0(%x7)	# 2241 
	addi	%x6 %x8 1	# 2253 
	lw	%x7 -8(%x2)	# 2253 
	addi	%x9 %x7 2	# 2253 
	lui	%x10 2097720	# 2253
	addi	%x10 %x10 568	# 2253
	addi	%x10 %x10 4	# 2253 
	lw	%f2 0(%x10)	# 2253 
	addi	%x10 %x0 3	# 2187
	lw	%f3 52(%x29)	# 2187 
	sw	%x6 -52(%x2)	# 2187 
	sw	%x9 -56(%x2)	# 2187 
	sw	%f2 -60(%x2)	# 2187 
	add	%x6 %x0 %x10	# 2187 
	fadd	%f1 %f0 %f3	# 2187 
	sw	%x1 -64(%x2)	# 2187 
	addi	%x2 %x2 -68	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 68	# 2187 
	lw	%x1 -64(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -64(%x2)	# 2188 
	sw	%x1 -68(%x2)	# 2188 
	addi	%x2 %x2 -72	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 72	# 2188 
	lw	%x1 -68(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x8 -64(%x2)	# 2189 
	sw	%x8 0(%x7)	# 2189 
	addi	%x9 %x8 0	# 61 
	lw	%f1 -4(%x2)	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x8 4	# 62 
	lw	%f2 -60(%x2)	# 62 
	sw	%f2 0(%x9)	# 62 
	addi	%x9 %x8 8	# 63 
	lw	%f2 -24(%x2)	# 63 
	sw	%f2 0(%x9)	# 63 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x7 -68(%x2)	# 1087 
	blt	%x9 %x0 bge.21466	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x10)	# 168 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.21468	# 1092 
	sw	%x6 -72(%x2)	# 1093 
	sw	%x9 -76(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x8	# 1093 
	sw	%x1 -80(%x2)	# 1093 
	addi	%x2 %x2 -84	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 84	# 1093 
	lw	%x1 -80(%x2)	# 1093 
	lw	%x7 -76(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -72(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21469	# 1092 
beq_else.21468:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.21470	# 1094 
	sw	%x6 -72(%x2)	# 1095 
	sw	%x9 -76(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x8	# 1095 
	sw	%x1 -80(%x2)	# 1095 
	addi	%x2 %x2 -84	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 84	# 1095 
	lw	%x1 -80(%x2)	# 1095 
	lw	%x7 -76(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -72(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21471	# 1094 
beq_else.21470:	# 1094 
	sw	%x6 -72(%x2)	# 1097 
	sw	%x9 -76(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x8	# 1097 
	sw	%x1 -80(%x2)	# 1097 
	addi	%x2 %x2 -84	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 84	# 1097 
	lw	%x1 -80(%x2)	# 1097 
	lw	%x7 -76(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -72(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21471:	# 1094 
beq_cont.21469:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -68(%x2)	# 1099 
	sw	%x1 -80(%x2)	# 1099 
	addi	%x2 %x2 -84	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 84	# 1099 
	lw	%x1 -80(%x2)	# 1099 
	j	beq_cont.21467	# 1087 
bge.21466:	# 1087 
beq_cont.21467:	# 1087 
	add	%x6 %x0 %x3	# 2241 
	addi	%x3 %x3 12	# 2241 
	lw	%f1 -20(%x2)	# 2241 
	sw	%f1 8(%x6)	# 2241 
	lw	%x7 -68(%x2)	# 2241 
	sw	%x7 4(%x6)	# 2241 
	lw	%x7 -56(%x2)	# 2241 
	sw	%x7 0(%x6)	# 2241 
	lui	%x7 2098416	# 2241
	addi	%x7 %x7 1264	# 2241
	lw	%x8 -52(%x2)	# 2241 
	slli	%x8 %x8 2	# 2241 
	add	%x7 %x7 %x8	# 2241 
	sw	%x6 0(%x7)	# 2241 
	lw	%x6 -12(%x2)	# 2254 
	addi	%x7 %x6 2	# 2254 
	lw	%x8 -8(%x2)	# 2254 
	addi	%x8 %x8 3	# 2254 
	lui	%x9 2097720	# 2254
	addi	%x9 %x9 568	# 2254
	addi	%x9 %x9 8	# 2254 
	lw	%f2 0(%x9)	# 2254 
	addi	%x9 %x0 3	# 2187
	lw	%f3 52(%x29)	# 2187 
	sw	%x7 -80(%x2)	# 2187 
	sw	%x8 -84(%x2)	# 2187 
	sw	%f2 -88(%x2)	# 2187 
	add	%x6 %x0 %x9	# 2187 
	fadd	%f1 %f0 %f3	# 2187 
	sw	%x1 -92(%x2)	# 2187 
	addi	%x2 %x2 -96	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 96	# 2187 
	lw	%x1 -92(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -92(%x2)	# 2188 
	sw	%x1 -96(%x2)	# 2188 
	addi	%x2 %x2 -100	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 100	# 2188 
	lw	%x1 -96(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x8 -92(%x2)	# 2189 
	sw	%x8 0(%x7)	# 2189 
	addi	%x9 %x8 0	# 61 
	lw	%f1 -4(%x2)	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x8 4	# 62 
	lw	%f1 -28(%x2)	# 62 
	sw	%f1 0(%x9)	# 62 
	addi	%x9 %x8 8	# 63 
	lw	%f1 -88(%x2)	# 63 
	sw	%f1 0(%x9)	# 63 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x7 -96(%x2)	# 1087 
	blt	%x9 %x0 bge.21472	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x10)	# 168 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.21474	# 1092 
	sw	%x6 -100(%x2)	# 1093 
	sw	%x9 -104(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x8	# 1093 
	sw	%x1 -108(%x2)	# 1093 
	addi	%x2 %x2 -112	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 112	# 1093 
	lw	%x1 -108(%x2)	# 1093 
	lw	%x7 -104(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -100(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21475	# 1092 
beq_else.21474:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.21476	# 1094 
	sw	%x6 -100(%x2)	# 1095 
	sw	%x9 -104(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x8	# 1095 
	sw	%x1 -108(%x2)	# 1095 
	addi	%x2 %x2 -112	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 112	# 1095 
	lw	%x1 -108(%x2)	# 1095 
	lw	%x7 -104(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -100(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21477	# 1094 
beq_else.21476:	# 1094 
	sw	%x6 -100(%x2)	# 1097 
	sw	%x9 -104(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x8	# 1097 
	sw	%x1 -108(%x2)	# 1097 
	addi	%x2 %x2 -112	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 112	# 1097 
	lw	%x1 -108(%x2)	# 1097 
	lw	%x7 -104(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -100(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21477:	# 1094 
beq_cont.21475:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -96(%x2)	# 1099 
	sw	%x1 -108(%x2)	# 1099 
	addi	%x2 %x2 -112	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 112	# 1099 
	lw	%x1 -108(%x2)	# 1099 
	j	beq_cont.21473	# 1087 
bge.21472:	# 1087 
beq_cont.21473:	# 1087 
	add	%x6 %x0 %x3	# 2241 
	addi	%x3 %x3 12	# 2241 
	lw	%f1 -20(%x2)	# 2241 
	sw	%f1 8(%x6)	# 2241 
	lw	%x7 -96(%x2)	# 2241 
	sw	%x7 4(%x6)	# 2241 
	lw	%x7 -84(%x2)	# 2241 
	sw	%x7 0(%x6)	# 2241 
	lui	%x7 2098416	# 2241
	addi	%x7 %x7 1264	# 2241
	lw	%x8 -80(%x2)	# 2241 
	slli	%x8 %x8 2	# 2241 
	add	%x7 %x7 %x8	# 2241 
	sw	%x6 0(%x7)	# 2241 
	lw	%x6 -12(%x2)	# 2255 
	addi	%x6 %x6 3	# 2255 
	lui	%x7 2099136	# 2255
	addi	%x7 %x7 1984	# 2255
	addi	%x7 %x7 0	# 2255 
	sw	%x6 0(%x7)	# 2255 
	jr	0(%x1)	# 2255 
setup_surface_reflection.3208:	#- 57276
	addi	%x8 %x0 2	# 120
	sw	%x7 -0(%x2)	# 120 
	add	%x7 %x0 %x8	# 120 
	sw	%x1 -4(%x2)	# 120 
	addi	%x2 %x2 -8	# 120 
	jal	 %x1 min_caml_sll	# 120 
	addi	%x2 %x2 8	# 120 
	lw	%x1 -4(%x2)	# 120 
	addi	%x6 %x6 1	# 2260 
	lui	%x7 2099136	# 2261
	addi	%x7 %x7 1984	# 2261
	addi	%x7 %x7 0	# 2261 
	lw	%x7 0(%x7)	# 2261 
	lw	%f1 16(%x29)	# 2262 
	lw	%x8 -0(%x2)	# 276 
	lw	%x9 28(%x8)	# 276 
	addi	%x9 %x9 0	# 281 
	lw	%f2 0(%x9)	# 281 
	fsub	%f1 %f1 %f2	# 2262 
	lui	%x9 2097720	# 2263
	addi	%x9 %x9 568	# 2263
	lw	%x10 16(%x8)	# 236 
	addi	%x11 %x9 0	# 109 
	lw	%f2 0(%x11)	# 109 
	addi	%x11 %x10 0	# 109 
	lw	%f3 0(%x11)	# 109 
	fmul	%f2 %f2 %f3	# 109 
	addi	%x11 %x9 4	# 109 
	lw	%f3 0(%x11)	# 109 
	addi	%x11 %x10 4	# 109 
	lw	%f4 0(%x11)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	addi	%x9 %x9 8	# 109 
	lw	%f3 0(%x9)	# 109 
	addi	%x9 %x10 8	# 109 
	lw	%f4 0(%x9)	# 109 
	fmul	%f3 %f3 %f4	# 109 
	fadd	%f2 %f2 %f3	# 109 
	lw	%f3 4(%x29)	# 2266 
	lw	%x9 16(%x8)	# 206 
	addi	%x9 %x9 0	# 211 
	lw	%f4 0(%x9)	# 211 
	fmul	%f3 %f3 %f4	# 2266 
	fmul	%f3 %f3 %f2	# 2266 
	lui	%x9 2097720	# 2266
	addi	%x9 %x9 568	# 2266
	addi	%x9 %x9 0	# 2266 
	lw	%f4 0(%x9)	# 2266 
	fsub	%f3 %f3 %f4	# 2266 
	lw	%f4 4(%x29)	# 2267 
	lw	%x9 16(%x8)	# 216 
	addi	%x9 %x9 4	# 221 
	lw	%f5 0(%x9)	# 221 
	fmul	%f4 %f4 %f5	# 2267 
	fmul	%f4 %f4 %f2	# 2267 
	lui	%x9 2097720	# 2267
	addi	%x9 %x9 568	# 2267
	addi	%x9 %x9 4	# 2267 
	lw	%f5 0(%x9)	# 2267 
	fsub	%f4 %f4 %f5	# 2267 
	lw	%f5 4(%x29)	# 2268 
	lw	%x8 16(%x8)	# 226 
	addi	%x8 %x8 8	# 231 
	lw	%f6 0(%x8)	# 231 
	fmul	%f5 %f5 %f6	# 2268 
	fmul	%f2 %f5 %f2	# 2268 
	lui	%x8 2097720	# 2268
	addi	%x8 %x8 568	# 2268
	addi	%x8 %x8 8	# 2268 
	lw	%f5 0(%x8)	# 2268 
	fsub	%f2 %f2 %f5	# 2268 
	addi	%x8 %x0 3	# 2187
	lw	%f5 52(%x29)	# 2187 
	sw	%x7 -4(%x2)	# 2187 
	sw	%x6 -8(%x2)	# 2187 
	sw	%f1 -12(%x2)	# 2187 
	sw	%f2 -16(%x2)	# 2187 
	sw	%f4 -20(%x2)	# 2187 
	sw	%f3 -24(%x2)	# 2187 
	add	%x6 %x0 %x8	# 2187 
	fadd	%f1 %f0 %f5	# 2187 
	sw	%x1 -28(%x2)	# 2187 
	addi	%x2 %x2 -32	# 2187 
	jal	 %x1 min_caml_create_float_array	# 2187 
	addi	%x2 %x2 32	# 2187 
	lw	%x1 -28(%x2)	# 2187 
	add	%x7 %x0 %x6	# 2187 
	lui	%x6 2097408	# 2188
	addi	%x6 %x6 256	# 2188
	addi	%x6 %x6 0	# 2188 
	lw	%x6 0(%x6)	# 2188 
	sw	%x7 -28(%x2)	# 2188 
	sw	%x1 -32(%x2)	# 2188 
	addi	%x2 %x2 -36	# 2188 
	jal	 %x1 min_caml_create_array	# 2188 
	addi	%x2 %x2 36	# 2188 
	lw	%x1 -32(%x2)	# 2188 
	add	%x7 %x0 %x3	# 2189 
	addi	%x3 %x3 8	# 2189 
	sw	%x6 4(%x7)	# 2189 
	lw	%x8 -28(%x2)	# 2189 
	sw	%x8 0(%x7)	# 2189 
	addi	%x9 %x8 0	# 61 
	lw	%f1 -24(%x2)	# 61 
	sw	%f1 0(%x9)	# 61 
	addi	%x9 %x8 4	# 62 
	lw	%f1 -20(%x2)	# 62 
	sw	%f1 0(%x9)	# 62 
	addi	%x9 %x8 8	# 63 
	lw	%f1 -16(%x2)	# 63 
	sw	%f1 0(%x9)	# 63 
	lui	%x9 2097408	# 1104
	addi	%x9 %x9 256	# 1104
	addi	%x9 %x9 0	# 1104 
	lw	%x9 0(%x9)	# 1104 
	addi	%x9 %x9 -1	# 1104 
	sw	%x7 -32(%x2)	# 1087 
	blt	%x9 %x0 bge.21479	# 1087 
	lui	%x10 2097456	# 1088
	addi	%x10 %x10 304	# 1088
	slli	%x11 %x9 2	# 1088 
	add	%x10 %x10 %x11	# 1088 
	lw	%x10 0(%x10)	# 1088 
	lw	%x11 4(%x10)	# 168 
	addi	%x5 %x0 1	# 1092 
	bne	%x11 %x5 beq_else.21481	# 1092 
	sw	%x6 -36(%x2)	# 1093 
	sw	%x9 -40(%x2)	# 1093 
	add	%x7 %x0 %x10	# 1093 
	add	%x6 %x0 %x8	# 1093 
	sw	%x1 -44(%x2)	# 1093 
	addi	%x2 %x2 -48	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 48	# 1093 
	lw	%x1 -44(%x2)	# 1093 
	lw	%x7 -40(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -36(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21482	# 1092 
beq_else.21481:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x11 %x5 beq_else.21483	# 1094 
	sw	%x6 -36(%x2)	# 1095 
	sw	%x9 -40(%x2)	# 1095 
	add	%x7 %x0 %x10	# 1095 
	add	%x6 %x0 %x8	# 1095 
	sw	%x1 -44(%x2)	# 1095 
	addi	%x2 %x2 -48	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 48	# 1095 
	lw	%x1 -44(%x2)	# 1095 
	lw	%x7 -40(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -36(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21484	# 1094 
beq_else.21483:	# 1094 
	sw	%x6 -36(%x2)	# 1097 
	sw	%x9 -40(%x2)	# 1097 
	add	%x7 %x0 %x10	# 1097 
	add	%x6 %x0 %x8	# 1097 
	sw	%x1 -44(%x2)	# 1097 
	addi	%x2 %x2 -48	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 48	# 1097 
	lw	%x1 -44(%x2)	# 1097 
	lw	%x7 -40(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -36(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21484:	# 1094 
beq_cont.21482:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -32(%x2)	# 1099 
	sw	%x1 -44(%x2)	# 1099 
	addi	%x2 %x2 -48	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 48	# 1099 
	lw	%x1 -44(%x2)	# 1099 
	j	beq_cont.21480	# 1087 
bge.21479:	# 1087 
beq_cont.21480:	# 1087 
	add	%x6 %x0 %x3	# 2241 
	addi	%x3 %x3 12	# 2241 
	lw	%f1 -12(%x2)	# 2241 
	sw	%f1 8(%x6)	# 2241 
	lw	%x7 -32(%x2)	# 2241 
	sw	%x7 4(%x6)	# 2241 
	lw	%x7 -8(%x2)	# 2241 
	sw	%x7 0(%x6)	# 2241 
	lui	%x7 2098416	# 2241
	addi	%x7 %x7 1264	# 2241
	lw	%x8 -4(%x2)	# 2241 
	slli	%x9 %x8 2	# 2241 
	add	%x7 %x7 %x9	# 2241 
	sw	%x6 0(%x7)	# 2241 
	addi	%x6 %x8 1	# 2269 
	lui	%x7 2099136	# 2269
	addi	%x7 %x7 1984	# 2269
	addi	%x7 %x7 0	# 2269 
	sw	%x6 0(%x7)	# 2269 
	jr	0(%x1)	# 2269 
rt.3213:	#- 58080
	lui	%x8 2098024	# 2298
	addi	%x8 %x8 872	# 2298
	addi	%x8 %x8 0	# 2298 
	sw	%x6 0(%x8)	# 2298 
	lui	%x8 2098024	# 2299
	addi	%x8 %x8 872	# 2299
	addi	%x8 %x8 4	# 2299 
	sw	%x7 0(%x8)	# 2299 
	addi	%x8 %x0 1	# 123
	sw	%x6 -0(%x2)	# 123 
	sw	%x7 -4(%x2)	# 123 
	add	%x7 %x0 %x8	# 123 
	sw	%x1 -8(%x2)	# 123 
	addi	%x2 %x2 -12	# 123 
	jal	 %x1 min_caml_sra	# 123 
	addi	%x2 %x2 12	# 123 
	lw	%x1 -8(%x2)	# 123 
	lui	%x7 2098032	# 2300
	addi	%x7 %x7 880	# 2300
	addi	%x7 %x7 0	# 2300 
	sw	%x6 0(%x7)	# 2300 
	addi	%x7 %x0 1	# 123
	lw	%x6 -4(%x2)	# 123 
	sw	%x1 -8(%x2)	# 123 
	addi	%x2 %x2 -12	# 123 
	jal	 %x1 min_caml_sra	# 123 
	addi	%x2 %x2 12	# 123 
	lw	%x1 -8(%x2)	# 123 
	lui	%x7 2098032	# 2301
	addi	%x7 %x7 880	# 2301
	addi	%x7 %x7 4	# 2301 
	sw	%x6 0(%x7)	# 2301 
	lw	%f1 204(%x29)	# 2302 
	lw	%x6 -0(%x2)	# 2302 
	sw	%f1 -8(%x2)	# 2302 
	sw	%x1 -12(%x2)	# 2302 
	addi	%x2 %x2 -16	# 2302 
	jal	 %x1 min_caml_float_of_int	# 2302 
	addi	%x2 %x2 16	# 2302 
	lw	%x1 -12(%x2)	# 2302 
	lw	%f2 -8(%x2)	# 2302 
	fdiv	%f1 %f2 %f1	# 2302 
	lui	%x6 2098040	# 2302
	addi	%x6 %x6 888	# 2302
	addi	%x6 %x6 0	# 2302 
	sw	%f1 0(%x6)	# 2302 
	lui	%x6 2098024	# 2111
	addi	%x6 %x6 872	# 2111
	addi	%x6 %x6 0	# 2111 
	lw	%x6 0(%x6)	# 2111 
	sw	%x6 -12(%x2)	# 2111 
	sw	%x1 -16(%x2)	# 2111 
	addi	%x2 %x2 -20	# 2111 
	jal	 %x1 create_pixel.3155	# 2111 
	addi	%x2 %x2 20	# 2111 
	lw	%x1 -16(%x2)	# 2111 
	add	%x7 %x0 %x6	# 2111 
	lw	%x6 -12(%x2)	# 2111 
	sw	%x1 -16(%x2)	# 2111 
	addi	%x2 %x2 -20	# 2111 
	jal	 %x1 min_caml_create_array	# 2111 
	addi	%x2 %x2 20	# 2111 
	lw	%x1 -16(%x2)	# 2111 
	lui	%x7 2098024	# 2112
	addi	%x7 %x7 872	# 2112
	addi	%x7 %x7 0	# 2112 
	lw	%x7 0(%x7)	# 2112 
	addi	%x7 %x7 -2	# 2112 
	sw	%x1 -16(%x2)	# 2112 
	addi	%x2 %x2 -20	# 2112 
	jal	 %x1 init_line_elements.3157	# 2112 
	addi	%x2 %x2 20	# 2112 
	lw	%x1 -16(%x2)	# 2112 
	lui	%x7 2098024	# 2111
	addi	%x7 %x7 872	# 2111
	addi	%x7 %x7 0	# 2111 
	lw	%x7 0(%x7)	# 2111 
	sw	%x6 -16(%x2)	# 2111 
	sw	%x7 -20(%x2)	# 2111 
	sw	%x1 -24(%x2)	# 2111 
	addi	%x2 %x2 -28	# 2111 
	jal	 %x1 create_pixel.3155	# 2111 
	addi	%x2 %x2 28	# 2111 
	lw	%x1 -24(%x2)	# 2111 
	add	%x7 %x0 %x6	# 2111 
	lw	%x6 -20(%x2)	# 2111 
	sw	%x1 -24(%x2)	# 2111 
	addi	%x2 %x2 -28	# 2111 
	jal	 %x1 min_caml_create_array	# 2111 
	addi	%x2 %x2 28	# 2111 
	lw	%x1 -24(%x2)	# 2111 
	lui	%x7 2098024	# 2112
	addi	%x7 %x7 872	# 2112
	addi	%x7 %x7 0	# 2112 
	lw	%x7 0(%x7)	# 2112 
	addi	%x7 %x7 -2	# 2112 
	sw	%x1 -24(%x2)	# 2112 
	addi	%x2 %x2 -28	# 2112 
	jal	 %x1 init_line_elements.3157	# 2112 
	addi	%x2 %x2 28	# 2112 
	lw	%x1 -24(%x2)	# 2112 
	lui	%x7 2098024	# 2111
	addi	%x7 %x7 872	# 2111
	addi	%x7 %x7 0	# 2111 
	lw	%x7 0(%x7)	# 2111 
	sw	%x6 -24(%x2)	# 2111 
	sw	%x7 -28(%x2)	# 2111 
	sw	%x1 -32(%x2)	# 2111 
	addi	%x2 %x2 -36	# 2111 
	jal	 %x1 create_pixel.3155	# 2111 
	addi	%x2 %x2 36	# 2111 
	lw	%x1 -32(%x2)	# 2111 
	add	%x7 %x0 %x6	# 2111 
	lw	%x6 -28(%x2)	# 2111 
	sw	%x1 -32(%x2)	# 2111 
	addi	%x2 %x2 -36	# 2111 
	jal	 %x1 min_caml_create_array	# 2111 
	addi	%x2 %x2 36	# 2111 
	lw	%x1 -32(%x2)	# 2111 
	lui	%x7 2098024	# 2112
	addi	%x7 %x7 872	# 2112
	addi	%x7 %x7 0	# 2112 
	lw	%x7 0(%x7)	# 2112 
	addi	%x7 %x7 -2	# 2112 
	sw	%x1 -32(%x2)	# 2112 
	addi	%x2 %x2 -36	# 2112 
	jal	 %x1 init_line_elements.3157	# 2112 
	addi	%x2 %x2 36	# 2112 
	lw	%x1 -32(%x2)	# 2112 
	sw	%x6 -32(%x2)	# 719 
	sw	%x1 -36(%x2)	# 719 
	addi	%x2 %x2 -40	# 719 
	jal	 %x1 read_screen_settings.2862	# 719 
	addi	%x2 %x2 40	# 719 
	lw	%x1 -36(%x2)	# 719 
	sw	%x1 -36(%x2)	# 720 
	addi	%x2 %x2 -40	# 720 
	jal	 %x1 read_light.2864	# 720 
	addi	%x2 %x2 40	# 720 
	lw	%x1 -36(%x2)	# 720 
	addi	%x6 %x0 0	# 685
	sw	%x6 -36(%x2)	# 677 
	sw	%x1 -40(%x2)	# 677 
	addi	%x2 %x2 -44	# 677 
	jal	 %x1 read_nth_object.2869	# 677 
	addi	%x2 %x2 44	# 677 
	lw	%x1 -40(%x2)	# 677 
	bne	%x6 %x0 beq_else.21486	# 677 
	lui	%x6 2097408	# 680
	addi	%x6 %x6 256	# 680
	addi	%x6 %x6 0	# 680 
	lw	%x7 -36(%x2)	# 680 
	sw	%x7 0(%x6)	# 680 
	j	beq_cont.21487	# 677 
beq_else.21486:	# 677 
	addi	%x6 %x0 1	# 678
	sw	%x1 -40(%x2)	# 678 
	addi	%x2 %x2 -44	# 678 
	jal	 %x1 read_object.2871	# 678 
	addi	%x2 %x2 44	# 678 
	lw	%x1 -40(%x2)	# 678 
beq_cont.21487:	# 677 
	sw	%x1 -40(%x2)	# 692 
	addi	%x2 %x2 -44	# 692 
	jal	 %x1 min_caml_read_int	# 692 
	addi	%x2 %x2 44	# 692 
	lw	%x1 -40(%x2)	# 692 
	addi	%x5 %x0 -1	# 693 
	bne	%x6 %x5 beq_else.21488	# 693 
	addi	%x6 %x0 1	# 693
	addi	%x7 %x0 -1	# 693
	sw	%x1 -40(%x2)	# 693 
	addi	%x2 %x2 -44	# 693 
	jal	 %x1 min_caml_create_array	# 693 
	addi	%x2 %x2 44	# 693 
	lw	%x1 -40(%x2)	# 693 
	j	beq_cont.21489	# 693 
beq_else.21488:	# 693 
	addi	%x7 %x0 1	# 695
	sw	%x6 -40(%x2)	# 695 
	add	%x6 %x0 %x7	# 695 
	sw	%x1 -44(%x2)	# 695 
	addi	%x2 %x2 -48	# 695 
	jal	 %x1 read_net_item.2875	# 695 
	addi	%x2 %x2 48	# 695 
	lw	%x1 -44(%x2)	# 695 
	addi	%x7 %x6 0	# 696 
	lw	%x8 -40(%x2)	# 696 
	sw	%x8 0(%x7)	# 696 
beq_cont.21489:	# 693 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.21490	# 710 
	j	beq_cont.21491	# 710 
beq_else.21490:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	addi	%x7 %x7 0	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x0 0	# 709
	sw	%x1 -44(%x2)	# 709 
	addi	%x2 %x2 -48	# 709 
	jal	 %x1 read_net_item.2875	# 709 
	addi	%x2 %x2 48	# 709 
	lw	%x1 -44(%x2)	# 709 
	addi	%x7 %x6 0	# 710 
	lw	%x7 0(%x7)	# 710 
	addi	%x5 %x0 -1	# 710 
	bne	%x7 %x5 beq_else.21492	# 710 
	j	beq_cont.21493	# 710 
beq_else.21492:	# 710 
	lui	%x7 2097740	# 712
	addi	%x7 %x7 588	# 712
	addi	%x7 %x7 4	# 712 
	sw	%x6 0(%x7)	# 712 
	addi	%x6 %x0 2	# 713
	sw	%x1 -44(%x2)	# 713 
	addi	%x2 %x2 -48	# 713 
	jal	 %x1 read_and_network.2879	# 713 
	addi	%x2 %x2 48	# 713 
	lw	%x1 -44(%x2)	# 713 
beq_cont.21493:	# 710 
beq_cont.21491:	# 710 
	addi	%x6 %x0 0	# 723
	sw	%x1 -44(%x2)	# 723 
	addi	%x2 %x2 -48	# 723 
	jal	 %x1 read_or_network.2877	# 723 
	addi	%x2 %x2 48	# 723 
	lw	%x1 -44(%x2)	# 723 
	lui	%x7 2097944	# 723
	addi	%x7 %x7 792	# 723
	addi	%x7 %x7 0	# 723 
	sw	%x6 0(%x7)	# 723 
	addi	%x6 %x0 80	# 1932
	sw	%x1 -44(%x2)	# 1932 
	addi	%x2 %x2 -48	# 1932 
	jal	 %x1 min_caml_print_char	# 1932 
	addi	%x2 %x2 48	# 1932 
	lw	%x1 -44(%x2)	# 1932 
	addi	%x6 %x0 51	# 1933
	sw	%x1 -44(%x2)	# 1933 
	addi	%x2 %x2 -48	# 1933 
	jal	 %x1 min_caml_print_char	# 1933 
	addi	%x2 %x2 48	# 1933 
	lw	%x1 -44(%x2)	# 1933 
	addi	%x6 %x0 10	# 1934
	sw	%x1 -44(%x2)	# 1934 
	addi	%x2 %x2 -48	# 1934 
	jal	 %x1 min_caml_print_char	# 1934 
	addi	%x2 %x2 48	# 1934 
	lw	%x1 -44(%x2)	# 1934 
	lui	%x6 2098024	# 1935
	addi	%x6 %x6 872	# 1935
	addi	%x6 %x6 0	# 1935 
	lw	%x6 0(%x6)	# 1935 
	sw	%x1 -44(%x2)	# 1935 
	addi	%x2 %x2 -48	# 1935 
	jal	 %x1 print_int.2730	# 1935 
	addi	%x2 %x2 48	# 1935 
	lw	%x1 -44(%x2)	# 1935 
	addi	%x6 %x0 32	# 1936
	sw	%x1 -44(%x2)	# 1936 
	addi	%x2 %x2 -48	# 1936 
	jal	 %x1 min_caml_print_char	# 1936 
	addi	%x2 %x2 48	# 1936 
	lw	%x1 -44(%x2)	# 1936 
	lui	%x6 2098024	# 1937
	addi	%x6 %x6 872	# 1937
	addi	%x6 %x6 4	# 1937 
	lw	%x6 0(%x6)	# 1937 
	sw	%x1 -44(%x2)	# 1937 
	addi	%x2 %x2 -48	# 1937 
	jal	 %x1 print_int.2730	# 1937 
	addi	%x2 %x2 48	# 1937 
	lw	%x1 -44(%x2)	# 1937 
	addi	%x6 %x0 32	# 1938
	sw	%x1 -44(%x2)	# 1938 
	addi	%x2 %x2 -48	# 1938 
	jal	 %x1 min_caml_print_char	# 1938 
	addi	%x2 %x2 48	# 1938 
	lw	%x1 -44(%x2)	# 1938 
	addi	%x6 %x0 50	# 1939
	addi	%x7 %x0 53	# 1939
	addi	%x8 %x0 53	# 1939
	sw	%x8 -44(%x2)	# 1939 
	sw	%x7 -48(%x2)	# 1939 
	sw	%x1 -52(%x2)	# 1939 
	addi	%x2 %x2 -56	# 1939 
	jal	 %x1 min_caml_print_char	# 1939 
	addi	%x2 %x2 56	# 1939 
	lw	%x1 -52(%x2)	# 1939 
	lw	%x6 -48(%x2)	# 1939 
	sw	%x1 -52(%x2)	# 1939 
	addi	%x2 %x2 -56	# 1939 
	jal	 %x1 min_caml_print_char	# 1939 
	addi	%x2 %x2 56	# 1939 
	lw	%x1 -52(%x2)	# 1939 
	lw	%x6 -44(%x2)	# 1939 
	sw	%x1 -52(%x2)	# 1939 
	addi	%x2 %x2 -56	# 1939 
	jal	 %x1 min_caml_print_char	# 1939 
	addi	%x2 %x2 56	# 1939 
	lw	%x1 -52(%x2)	# 1939 
	addi	%x6 %x0 10	# 1940
	sw	%x1 -52(%x2)	# 1940 
	addi	%x2 %x2 -56	# 1940 
	jal	 %x1 min_caml_print_char	# 1940 
	addi	%x2 %x2 56	# 1940 
	lw	%x1 -52(%x2)	# 1940 
	addi	%x6 %x0 4	# 2226
	sw	%x1 -52(%x2)	# 2226 
	addi	%x2 %x2 -56	# 2226 
	jal	 %x1 create_dirvecs.3189	# 2226 
	addi	%x2 %x2 56	# 2226 
	lw	%x1 -52(%x2)	# 2226 
	addi	%x6 %x0 9	# 2227
	addi	%x7 %x0 0	# 2227
	addi	%x8 %x0 0	# 2227
	sw	%x1 -52(%x2)	# 2227 
	addi	%x2 %x2 -56	# 2227 
	jal	 %x1 calc_dirvec_rows.3180	# 2227 
	addi	%x2 %x2 56	# 2227 
	lw	%x1 -52(%x2)	# 2227 
	lui	%x6 2098116	# 2220
	addi	%x6 %x6 964	# 2220
	addi	%x6 %x6 16	# 2220 
	lw	%x6 0(%x6)	# 2220 
	addi	%x7 %x6 476	# 2213 
	lw	%x7 0(%x7)	# 2213 
	lui	%x8 2097408	# 1104
	addi	%x8 %x8 256	# 1104
	addi	%x8 %x8 0	# 1104 
	lw	%x8 0(%x8)	# 1104 
	addi	%x8 %x8 -1	# 1104 
	sw	%x6 -52(%x2)	# 1087 
	blt	%x8 %x0 bge.21494	# 1087 
	lui	%x9 2097456	# 1088
	addi	%x9 %x9 304	# 1088
	slli	%x10 %x8 2	# 1088 
	add	%x9 %x9 %x10	# 1088 
	lw	%x9 0(%x9)	# 1088 
	lw	%x10 4(%x7)	# 460 
	lw	%x11 0(%x7)	# 454 
	lw	%x12 4(%x9)	# 168 
	sw	%x7 -56(%x2)	# 1092 
	addi	%x5 %x0 1	# 1092 
	bne	%x12 %x5 beq_else.21496	# 1092 
	sw	%x10 -60(%x2)	# 1093 
	sw	%x8 -64(%x2)	# 1093 
	add	%x7 %x0 %x9	# 1093 
	add	%x6 %x0 %x11	# 1093 
	sw	%x1 -68(%x2)	# 1093 
	addi	%x2 %x2 -72	# 1093 
	jal	 %x1 setup_rect_table.2967	# 1093 
	addi	%x2 %x2 72	# 1093 
	lw	%x1 -68(%x2)	# 1093 
	lw	%x7 -64(%x2)	# 1093 
	slli	%x8 %x7 2	# 1093 
	lw	%x9 -60(%x2)	# 1093 
	add	%x8 %x9 %x8	# 1093 
	sw	%x6 0(%x8)	# 1093 
	j	beq_cont.21497	# 1092 
beq_else.21496:	# 1092 
	addi	%x5 %x0 2	# 1094 
	bne	%x12 %x5 beq_else.21498	# 1094 
	sw	%x10 -60(%x2)	# 1095 
	sw	%x8 -64(%x2)	# 1095 
	add	%x7 %x0 %x9	# 1095 
	add	%x6 %x0 %x11	# 1095 
	sw	%x1 -68(%x2)	# 1095 
	addi	%x2 %x2 -72	# 1095 
	jal	 %x1 setup_surface_table.2970	# 1095 
	addi	%x2 %x2 72	# 1095 
	lw	%x1 -68(%x2)	# 1095 
	lw	%x7 -64(%x2)	# 1095 
	slli	%x8 %x7 2	# 1095 
	lw	%x9 -60(%x2)	# 1095 
	add	%x8 %x9 %x8	# 1095 
	sw	%x6 0(%x8)	# 1095 
	j	beq_cont.21499	# 1094 
beq_else.21498:	# 1094 
	sw	%x10 -60(%x2)	# 1097 
	sw	%x8 -64(%x2)	# 1097 
	add	%x7 %x0 %x9	# 1097 
	add	%x6 %x0 %x11	# 1097 
	sw	%x1 -68(%x2)	# 1097 
	addi	%x2 %x2 -72	# 1097 
	jal	 %x1 setup_second_table.2973	# 1097 
	addi	%x2 %x2 72	# 1097 
	lw	%x1 -68(%x2)	# 1097 
	lw	%x7 -64(%x2)	# 1097 
	slli	%x8 %x7 2	# 1097 
	lw	%x9 -60(%x2)	# 1097 
	add	%x8 %x9 %x8	# 1097 
	sw	%x6 0(%x8)	# 1097 
beq_cont.21499:	# 1094 
beq_cont.21497:	# 1092 
	addi	%x7 %x7 -1	# 1099 
	lw	%x6 -56(%x2)	# 1099 
	sw	%x1 -68(%x2)	# 1099 
	addi	%x2 %x2 -72	# 1099 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1099 
	addi	%x2 %x2 72	# 1099 
	lw	%x1 -68(%x2)	# 1099 
	j	beq_cont.21495	# 1087 
bge.21494:	# 1087 
beq_cont.21495:	# 1087 
	addi	%x7 %x0 118	# 2214
	lw	%x6 -52(%x2)	# 2214 
	sw	%x1 -68(%x2)	# 2214 
	addi	%x2 %x2 -72	# 2214 
	jal	 %x1 init_dirvec_constants.3191	# 2214 
	addi	%x2 %x2 72	# 2214 
	lw	%x1 -68(%x2)	# 2214 
	lui	%x6 2098116	# 2220
	addi	%x6 %x6 964	# 2220
	addi	%x6 %x6 12	# 2220 
	lw	%x6 0(%x6)	# 2220 
	addi	%x7 %x0 119	# 2220
	sw	%x1 -68(%x2)	# 2220 
	addi	%x2 %x2 -72	# 2220 
	jal	 %x1 init_dirvec_constants.3191	# 2220 
	addi	%x2 %x2 72	# 2220 
	lw	%x1 -68(%x2)	# 2220 
	addi	%x6 %x0 2	# 2221
	sw	%x1 -68(%x2)	# 2221 
	addi	%x2 %x2 -72	# 2221 
	jal	 %x1 init_vecset_constants.3194	# 2221 
	addi	%x2 %x2 72	# 2221 
	lw	%x1 -68(%x2)	# 2221 
	lui	%x6 2098388	# 2309
	addi	%x6 %x6 1236	# 2309
	lw	%x6 0(%x6)	# 454 
	lui	%x7 2097720	# 2309
	addi	%x7 %x7 568	# 2309
	addi	%x8 %x7 0	# 80 
	lw	%f1 0(%x8)	# 80 
	addi	%x8 %x6 0	# 80 
	sw	%f1 0(%x8)	# 80 
	addi	%x8 %x7 4	# 81 
	lw	%f1 0(%x8)	# 81 
	addi	%x8 %x6 4	# 81 
	sw	%f1 0(%x8)	# 81 
	addi	%x7 %x7 8	# 82 
	lw	%f1 0(%x7)	# 82 
	addi	%x6 %x6 8	# 82 
	sw	%f1 0(%x6)	# 82 
	lui	%x6 2098388	# 2310
	addi	%x6 %x6 1236	# 2310
	lui	%x7 2097408	# 1104
	addi	%x7 %x7 256	# 1104
	addi	%x7 %x7 0	# 1104 
	lw	%x7 0(%x7)	# 1104 
	addi	%x7 %x7 -1	# 1104 
	sw	%x1 -68(%x2)	# 1104 
	addi	%x2 %x2 -72	# 1104 
	jal	 %x1 iter_setup_dirvec_constants.2976	# 1104 
	addi	%x2 %x2 72	# 1104 
	lw	%x1 -68(%x2)	# 1104 
	lui	%x6 2097408	# 2311
	addi	%x6 %x6 256	# 2311
	addi	%x6 %x6 0	# 2311 
	lw	%x6 0(%x6)	# 2311 
	addi	%x6 %x6 -1	# 2311 
	blt	%x6 %x0 bge.21500	# 2275 
	lui	%x7 2097456	# 2276
	addi	%x7 %x7 304	# 2276
	slli	%x8 %x6 2	# 2276 
	add	%x7 %x7 %x8	# 2276 
	lw	%x7 0(%x7)	# 2276 
	lw	%x8 8(%x7)	# 178 
	addi	%x5 %x0 2	# 2277 
	bne	%x8 %x5 beq_else.21502	# 2277 
	lw	%f1 16(%x29)	# 2278 
	lw	%x8 28(%x7)	# 276 
	addi	%x8 %x8 0	# 281 
	lw	%f2 0(%x8)	# 281 
	fle	%x5 %f1 %f2	# 2278 
	bne	%x5 %x0 fle.21504	# 2278 
	lw	%x8 4(%x7)	# 168 
	addi	%x5 %x0 1	# 2281 
	bne	%x8 %x5 beq_else.21506	# 2281 
	sw	%x1 -68(%x2)	# 2282 
	addi	%x2 %x2 -72	# 2282 
	jal	 %x1 setup_rect_reflection.3205	# 2282 
	addi	%x2 %x2 72	# 2282 
	lw	%x1 -68(%x2)	# 2282 
	j	beq_cont.21507	# 2281 
beq_else.21506:	# 2281 
	addi	%x5 %x0 2	# 2283 
	bne	%x8 %x5 beq_else.21508	# 2283 
	sw	%x1 -68(%x2)	# 2284 
	addi	%x2 %x2 -72	# 2284 
	jal	 %x1 setup_surface_reflection.3208	# 2284 
	addi	%x2 %x2 72	# 2284 
	lw	%x1 -68(%x2)	# 2284 
	j	beq_cont.21509	# 2283 
beq_else.21508:	# 2283 
beq_cont.21509:	# 2283 
beq_cont.21507:	# 2281 
	j	fle_cont.21505	# 2278 
fle.21504:	# 2278 
fle_cont.21505:	# 2278 
	j	beq_cont.21503	# 2277 
beq_else.21502:	# 2277 
beq_cont.21503:	# 2277 
	j	beq_cont.21501	# 2275 
bge.21500:	# 2275 
beq_cont.21501:	# 2275 
	addi	%x7 %x0 0	# 2312
	addi	%x8 %x0 0	# 2312
	lw	%x6 -24(%x2)	# 2312 
	sw	%x1 -68(%x2)	# 2312 
	addi	%x2 %x2 -72	# 2312 
	jal	 %x1 pretrace_line.3137	# 2312 
	addi	%x2 %x2 72	# 2312 
	lw	%x1 -68(%x2)	# 2312 
	addi	%x7 %x0 0	# 2313
	addi	%x8 %x0 2	# 2313
	lui	%x6 2098024	# 2060
	addi	%x6 %x6 872	# 2060
	addi	%x6 %x6 4	# 2060 
	lw	%x6 0(%x6)	# 2060 
	blt	%x0 %x6 blt.21510	# 2060 
	jr	0(%x1)	# 2067 
blt.21510:	# 2060 
	lui	%x6 2098024	# 2062
	addi	%x6 %x6 872	# 2062
	addi	%x6 %x6 4	# 2062 
	lw	%x6 0(%x6)	# 2062 
	addi	%x6 %x6 -1	# 2062 
	sw	%x7 -68(%x2)	# 2062 
	blt	%x0 %x6 blt.21512	# 2062 
	j	blt_cont.21513	# 2062 
blt.21512:	# 2062 
	addi	%x6 %x0 1	# 2063
	lw	%x9 -32(%x2)	# 2063 
	add	%x7 %x0 %x6	# 2063 
	add	%x6 %x0 %x9	# 2063 
	sw	%x1 -72(%x2)	# 2063 
	addi	%x2 %x2 -76	# 2063 
	jal	 %x1 pretrace_line.3137	# 2063 
	addi	%x2 %x2 76	# 2063 
	lw	%x1 -72(%x2)	# 2063 
blt_cont.21513:	# 2062 
	addi	%x6 %x0 0	# 2065
	lw	%x7 -68(%x2)	# 2065 
	lw	%x8 -16(%x2)	# 2065 
	lw	%x9 -24(%x2)	# 2065 
	lw	%x10 -32(%x2)	# 2065 
	sw	%x1 -72(%x2)	# 2065 
	addi	%x2 %x2 -76	# 2065 
	jal	 %x1 scan_pixel.3141	# 2065 
	addi	%x2 %x2 76	# 2065 
	lw	%x1 -72(%x2)	# 2065 
	addi	%x6 %x0 1	# 2066
	addi	%x10 %x0 4	# 46
	lw	%x7 -24(%x2)	# 2066 
	lw	%x8 -32(%x2)	# 2066 
	lw	%x9 -16(%x2)	# 2066 
	j	scan_line.3147	# 2066 
min_caml_start2:
	lui	%x2 2097148
	addi	%x2 %x2 2044
	lui	%x3 2097408
	addi	%x3 %x3 256
	addi	%x28 %x0 2
	addi	%x6 %x0 1	# 1
	addi	%x7 %x0 0	# 1
	sw	%x1 0(%x2)	# 1 
	addi	%x2 %x2 -4	# 1 
	jal	 %x1 min_caml_create_array	# 1 
	addi	%x2 %x2 4	# 1 
	lw	%x1 0(%x2)	# 1 
	addi	%x6 %x0 0	# 5
	lw	%f1 52(%x29)	# 5 
	sw	%x1 0(%x2)	# 5 
	addi	%x2 %x2 -4	# 5 
	jal	 %x1 min_caml_create_float_array	# 5 
	addi	%x2 %x2 4	# 5 
	lw	%x1 0(%x2)	# 5 
	addi	%x7 %x0 60	# 6
	addi	%x8 %x0 0	# 6
	addi	%x9 %x0 0	# 6
	addi	%x10 %x0 0	# 6
	addi	%x11 %x0 0	# 6
	addi	%x12 %x0 0	# 6
	add	%x13 %x0 %x3	# 6 
	addi	%x3 %x3 44	# 6 
	sw	%x6 40(%x13)	# 6 
	sw	%x6 36(%x13)	# 6 
	sw	%x6 32(%x13)	# 6 
	sw	%x6 28(%x13)	# 6 
	sw	%x12 24(%x13)	# 6 
	sw	%x6 20(%x13)	# 6 
	sw	%x6 16(%x13)	# 6 
	sw	%x11 12(%x13)	# 6 
	sw	%x10 8(%x13)	# 6 
	sw	%x9 4(%x13)	# 6 
	sw	%x8 0(%x13)	# 6 
	add	%x6 %x0 %x13	# 6 
	add	%x5 %x0 %x7	# 6 
	add	%x7 %x0 %x6	# 6 
	add	%x6 %x0 %x5	# 6 
	sw	%x1 0(%x2)	# 6 
	addi	%x2 %x2 -4	# 6 
	jal	 %x1 min_caml_create_array	# 6 
	addi	%x2 %x2 4	# 6 
	lw	%x1 0(%x2)	# 6 
	addi	%x6 %x0 3	# 9
	lw	%f1 52(%x29)	# 9 
	sw	%x1 0(%x2)	# 9 
	addi	%x2 %x2 -4	# 9 
	jal	 %x1 min_caml_create_float_array	# 9 
	addi	%x2 %x2 4	# 9 
	lw	%x1 0(%x2)	# 9 
	addi	%x6 %x0 3	# 12
	lw	%f1 52(%x29)	# 12 
	sw	%x1 0(%x2)	# 12 
	addi	%x2 %x2 -4	# 12 
	jal	 %x1 min_caml_create_float_array	# 12 
	addi	%x2 %x2 4	# 12 
	lw	%x1 0(%x2)	# 12 
	addi	%x6 %x0 3	# 15
	lw	%f1 52(%x29)	# 15 
	sw	%x1 0(%x2)	# 15 
	addi	%x2 %x2 -4	# 15 
	jal	 %x1 min_caml_create_float_array	# 15 
	addi	%x2 %x2 4	# 15 
	lw	%x1 0(%x2)	# 15 
	addi	%x6 %x0 1	# 18
	lw	%f1 148(%x29)	# 18 
	sw	%x1 0(%x2)	# 18 
	addi	%x2 %x2 -4	# 18 
	jal	 %x1 min_caml_create_float_array	# 18 
	addi	%x2 %x2 4	# 18 
	lw	%x1 0(%x2)	# 18 
	addi	%x6 %x0 50	# 21
	addi	%x7 %x0 1	# 21
	addi	%x8 %x0 -1	# 21
	sw	%x6 -0(%x2)	# 21 
	add	%x6 %x0 %x7	# 21 
	add	%x7 %x0 %x8	# 21 
	sw	%x1 -4(%x2)	# 21 
	addi	%x2 %x2 -8	# 21 
	jal	 %x1 min_caml_create_array	# 21 
	addi	%x2 %x2 8	# 21 
	lw	%x1 -4(%x2)	# 21 
	add	%x7 %x0 %x6	# 21 
	lw	%x6 -0(%x2)	# 21 
	sw	%x1 -4(%x2)	# 21 
	addi	%x2 %x2 -8	# 21 
	jal	 %x1 min_caml_create_array	# 21 
	addi	%x2 %x2 8	# 21 
	lw	%x1 -4(%x2)	# 21 
	addi	%x6 %x0 1	# 24
	addi	%x7 %x0 1	# 24
	lui	%x8 2097740	# 24
	addi	%x8 %x8 588	# 24
	addi	%x8 %x8 0	# 24 
	lw	%x8 0(%x8)	# 24 
	sw	%x6 -4(%x2)	# 24 
	add	%x6 %x0 %x7	# 24 
	add	%x7 %x0 %x8	# 24 
	sw	%x1 -8(%x2)	# 24 
	addi	%x2 %x2 -12	# 24 
	jal	 %x1 min_caml_create_array	# 24 
	addi	%x2 %x2 12	# 24 
	lw	%x1 -8(%x2)	# 24 
	add	%x7 %x0 %x6	# 24 
	lw	%x6 -4(%x2)	# 24 
	sw	%x1 -8(%x2)	# 24 
	addi	%x2 %x2 -12	# 24 
	jal	 %x1 min_caml_create_array	# 24 
	addi	%x2 %x2 12	# 24 
	lw	%x1 -8(%x2)	# 24 
	addi	%x6 %x0 1	# 29
	lw	%f1 52(%x29)	# 29 
	sw	%x1 -8(%x2)	# 29 
	addi	%x2 %x2 -12	# 29 
	jal	 %x1 min_caml_create_float_array	# 29 
	addi	%x2 %x2 12	# 29 
	lw	%x1 -8(%x2)	# 29 
	addi	%x6 %x0 1	# 32
	addi	%x7 %x0 0	# 32
	sw	%x1 -8(%x2)	# 32 
	addi	%x2 %x2 -12	# 32 
	jal	 %x1 min_caml_create_array	# 32 
	addi	%x2 %x2 12	# 32 
	lw	%x1 -8(%x2)	# 32 
	addi	%x6 %x0 1	# 35
	lw	%f1 172(%x29)	# 35 
	sw	%x1 -8(%x2)	# 35 
	addi	%x2 %x2 -12	# 35 
	jal	 %x1 min_caml_create_float_array	# 35 
	addi	%x2 %x2 12	# 35 
	lw	%x1 -8(%x2)	# 35 
	addi	%x6 %x0 3	# 38
	lw	%f1 52(%x29)	# 38 
	sw	%x1 -8(%x2)	# 38 
	addi	%x2 %x2 -12	# 38 
	jal	 %x1 min_caml_create_float_array	# 38 
	addi	%x2 %x2 12	# 38 
	lw	%x1 -8(%x2)	# 38 
	addi	%x6 %x0 1	# 41
	addi	%x7 %x0 0	# 41
	sw	%x1 -8(%x2)	# 41 
	addi	%x2 %x2 -12	# 41 
	jal	 %x1 min_caml_create_array	# 41 
	addi	%x2 %x2 12	# 41 
	lw	%x1 -8(%x2)	# 41 
	addi	%x6 %x0 3	# 44
	lw	%f1 52(%x29)	# 44 
	sw	%x1 -8(%x2)	# 44 
	addi	%x2 %x2 -12	# 44 
	jal	 %x1 min_caml_create_float_array	# 44 
	addi	%x2 %x2 12	# 44 
	lw	%x1 -8(%x2)	# 44 
	addi	%x6 %x0 3	# 47
	lw	%f1 52(%x29)	# 47 
	sw	%x1 -8(%x2)	# 47 
	addi	%x2 %x2 -12	# 47 
	jal	 %x1 min_caml_create_float_array	# 47 
	addi	%x2 %x2 12	# 47 
	lw	%x1 -8(%x2)	# 47 
	addi	%x6 %x0 3	# 51
	lw	%f1 52(%x29)	# 51 
	sw	%x1 -8(%x2)	# 51 
	addi	%x2 %x2 -12	# 51 
	jal	 %x1 min_caml_create_float_array	# 51 
	addi	%x2 %x2 12	# 51 
	lw	%x1 -8(%x2)	# 51 
	addi	%x6 %x0 3	# 54
	lw	%f1 52(%x29)	# 54 
	sw	%x1 -8(%x2)	# 54 
	addi	%x2 %x2 -12	# 54 
	jal	 %x1 min_caml_create_float_array	# 54 
	addi	%x2 %x2 12	# 54 
	lw	%x1 -8(%x2)	# 54 
	addi	%x6 %x0 2	# 58
	addi	%x7 %x0 0	# 58
	sw	%x1 -8(%x2)	# 58 
	addi	%x2 %x2 -12	# 58 
	jal	 %x1 min_caml_create_array	# 58 
	addi	%x2 %x2 12	# 58 
	lw	%x1 -8(%x2)	# 58 
	addi	%x6 %x0 2	# 61
	addi	%x7 %x0 0	# 61
	sw	%x1 -8(%x2)	# 61 
	addi	%x2 %x2 -12	# 61 
	jal	 %x1 min_caml_create_array	# 61 
	addi	%x2 %x2 12	# 61 
	lw	%x1 -8(%x2)	# 61 
	addi	%x6 %x0 1	# 64
	lw	%f1 52(%x29)	# 64 
	sw	%x1 -8(%x2)	# 64 
	addi	%x2 %x2 -12	# 64 
	jal	 %x1 min_caml_create_float_array	# 64 
	addi	%x2 %x2 12	# 64 
	lw	%x1 -8(%x2)	# 64 
	addi	%x6 %x0 3	# 68
	lw	%f1 52(%x29)	# 68 
	sw	%x1 -8(%x2)	# 68 
	addi	%x2 %x2 -12	# 68 
	jal	 %x1 min_caml_create_float_array	# 68 
	addi	%x2 %x2 12	# 68 
	lw	%x1 -8(%x2)	# 68 
	addi	%x6 %x0 3	# 71
	lw	%f1 52(%x29)	# 71 
	sw	%x1 -8(%x2)	# 71 
	addi	%x2 %x2 -12	# 71 
	jal	 %x1 min_caml_create_float_array	# 71 
	addi	%x2 %x2 12	# 71 
	lw	%x1 -8(%x2)	# 71 
	addi	%x6 %x0 3	# 75
	lw	%f1 52(%x29)	# 75 
	sw	%x1 -8(%x2)	# 75 
	addi	%x2 %x2 -12	# 75 
	jal	 %x1 min_caml_create_float_array	# 75 
	addi	%x2 %x2 12	# 75 
	lw	%x1 -8(%x2)	# 75 
	addi	%x6 %x0 3	# 77
	lw	%f1 52(%x29)	# 77 
	sw	%x1 -8(%x2)	# 77 
	addi	%x2 %x2 -12	# 77 
	jal	 %x1 min_caml_create_float_array	# 77 
	addi	%x2 %x2 12	# 77 
	lw	%x1 -8(%x2)	# 77 
	addi	%x6 %x0 3	# 79
	lw	%f1 52(%x29)	# 79 
	sw	%x1 -8(%x2)	# 79 
	addi	%x2 %x2 -12	# 79 
	jal	 %x1 min_caml_create_float_array	# 79 
	addi	%x2 %x2 12	# 79 
	lw	%x1 -8(%x2)	# 79 
	addi	%x6 %x0 3	# 83
	lw	%f1 52(%x29)	# 83 
	sw	%x1 -8(%x2)	# 83 
	addi	%x2 %x2 -12	# 83 
	jal	 %x1 min_caml_create_float_array	# 83 
	addi	%x2 %x2 12	# 83 
	lw	%x1 -8(%x2)	# 83 
	addi	%x6 %x0 0	# 88
	lw	%f1 52(%x29)	# 88 
	sw	%x1 -8(%x2)	# 88 
	addi	%x2 %x2 -12	# 88 
	jal	 %x1 min_caml_create_float_array	# 88 
	addi	%x2 %x2 12	# 88 
	lw	%x1 -8(%x2)	# 88 
	add	%x7 %x0 %x6	# 88 
	addi	%x6 %x0 0	# 89
	sw	%x7 -8(%x2)	# 89 
	sw	%x1 -12(%x2)	# 89 
	addi	%x2 %x2 -16	# 89 
	jal	 %x1 min_caml_create_array	# 89 
	addi	%x2 %x2 16	# 89 
	lw	%x1 -12(%x2)	# 89 
	addi	%x7 %x0 0	# 90
	add	%x8 %x0 %x3	# 90 
	addi	%x3 %x3 8	# 90 
	sw	%x6 4(%x8)	# 90 
	lw	%x6 -8(%x2)	# 90 
	sw	%x6 0(%x8)	# 90 
	add	%x6 %x0 %x8	# 90 
	add	%x5 %x0 %x7	# 90 
	add	%x7 %x0 %x6	# 90 
	add	%x6 %x0 %x5	# 90 
	sw	%x1 -12(%x2)	# 90 
	addi	%x2 %x2 -16	# 90 
	jal	 %x1 min_caml_create_array	# 90 
	addi	%x2 %x2 16	# 90 
	lw	%x1 -12(%x2)	# 90 
	add	%x7 %x0 %x6	# 90 
	addi	%x6 %x0 5	# 91
	sw	%x1 -12(%x2)	# 91 
	addi	%x2 %x2 -16	# 91 
	jal	 %x1 min_caml_create_array	# 91 
	addi	%x2 %x2 16	# 91 
	lw	%x1 -12(%x2)	# 91 
	addi	%x6 %x0 0	# 95
	lw	%f1 52(%x29)	# 95 
	sw	%x1 -12(%x2)	# 95 
	addi	%x2 %x2 -16	# 95 
	jal	 %x1 min_caml_create_float_array	# 95 
	addi	%x2 %x2 16	# 95 
	lw	%x1 -12(%x2)	# 95 
	addi	%x7 %x0 3	# 96
	lw	%f1 52(%x29)	# 96 
	sw	%x6 -12(%x2)	# 96 
	add	%x6 %x0 %x7	# 96 
	sw	%x1 -16(%x2)	# 96 
	addi	%x2 %x2 -20	# 96 
	jal	 %x1 min_caml_create_float_array	# 96 
	addi	%x2 %x2 20	# 96 
	lw	%x1 -16(%x2)	# 96 
	addi	%x6 %x0 60	# 97
	lw	%x7 -12(%x2)	# 97 
	sw	%x1 -16(%x2)	# 97 
	addi	%x2 %x2 -20	# 97 
	jal	 %x1 min_caml_create_array	# 97 
	addi	%x2 %x2 20	# 97 
	lw	%x1 -16(%x2)	# 97 
	addi	%x6 %x0 0	# 102
	lw	%f1 52(%x29)	# 102 
	sw	%x1 -16(%x2)	# 102 
	addi	%x2 %x2 -20	# 102 
	jal	 %x1 min_caml_create_float_array	# 102 
	addi	%x2 %x2 20	# 102 
	lw	%x1 -16(%x2)	# 102 
	add	%x7 %x0 %x6	# 102 
	addi	%x6 %x0 0	# 103
	sw	%x7 -16(%x2)	# 103 
	sw	%x1 -20(%x2)	# 103 
	addi	%x2 %x2 -24	# 103 
	jal	 %x1 min_caml_create_array	# 103 
	addi	%x2 %x2 24	# 103 
	lw	%x1 -20(%x2)	# 103 
	add	%x7 %x0 %x3	# 104 
	addi	%x3 %x3 8	# 104 
	sw	%x6 4(%x7)	# 104 
	lw	%x6 -16(%x2)	# 104 
	sw	%x6 0(%x7)	# 104 
	add	%x6 %x0 %x7	# 104 
	addi	%x7 %x0 180	# 105
	addi	%x8 %x0 0	# 105
	lw	%f1 52(%x29)	# 105 
	add	%x9 %x0 %x3	# 105 
	addi	%x3 %x3 12	# 105 
	sw	%f1 8(%x9)	# 105 
	sw	%x6 4(%x9)	# 105 
	sw	%x8 0(%x9)	# 105 
	add	%x6 %x0 %x9	# 105 
	add	%x5 %x0 %x7	# 105 
	add	%x7 %x0 %x6	# 105 
	add	%x6 %x0 %x5	# 105 
	sw	%x1 -20(%x2)	# 105 
	addi	%x2 %x2 -24	# 105 
	jal	 %x1 min_caml_create_array	# 105 
	addi	%x2 %x2 24	# 105 
	lw	%x1 -20(%x2)	# 105 
	addi	%x6 %x0 1	# 109
	addi	%x7 %x0 0	# 109
	sw	%x1 -20(%x2)	# 109 
	addi	%x2 %x2 -24	# 109 
	jal	 %x1 min_caml_create_array	# 109 
	addi	%x2 %x2 24	# 109 
	lw	%x1 -20(%x2)	# 109 
	addi	%x6 %x0 128	# 2317
	addi	%x7 %x0 128	# 2317
	sw	%x1 -20(%x2)	# 2317 
	addi	%x2 %x2 -24	# 2317 
	jal	 %x1 rt.3213	# 2317 
	addi	%x2 %x2 24	# 2317 
	lw	%x1 -20(%x2)	# 2317 
