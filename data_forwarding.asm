
addi $t0, $0, 8
sw $t0, 0x000($0)

addi $t0, $0, 2
lw $t0, 0x000($0) 
nop
addi $t1, $t0, 10
add $t2, $t1, $t0
multu $t0, $t1
mflo $t3

