    addi x5 x0 5
    addi x4 x0 4
    addi x3 x0 3
    addi x2 x0 2
    addi x1 x0 1
    addi x6 x5 x4
    addi x6 x6 x3 # dec と exのstall
    addi x0 x0 x0
    addi x6 x6 x3 # decと maのstall
    addi x0 x0 x0
    addi x0 x0 x0
    addi x6 x6 x3 # stallなし 