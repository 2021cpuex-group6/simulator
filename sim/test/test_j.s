test:
    j test3
test2:
    j test
test3:
    jal %x2 test
test4:
    j test2
    jal %x1 test5
test5:
    j test