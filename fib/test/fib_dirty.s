# こんな汚くても一応動く
# コード自体はfib.sと同じです
 addi %x1 zero 10 #10番目のフィボナッチ数を計算
                      nop
    addi %x5 x0 1
 addi x3 zero 3 
    blt  x1           x3                ret
                 addi x3 zero 1
    addi %x4            zero 1
              addi                 x2 zero 3   
loop.i             :               #x2は今何番目のフィボナッチ数を計算しているか
#わーい       add addi zero 
  
    
                                
   add x5 x3 x4    #x3, x4は前回、前々回のフィボナッチ数を保持
           addi x3 x4 0
 addi x4 x5 0
    beq  x2 x1 ret
                                      addi x2 x2 1
                j    loop.i
ret     :         
# これで完了。x1に結果が出力される
    addi x1 x5 0

