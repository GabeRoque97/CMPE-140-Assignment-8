
# Extended CPU test code

main: 
	addi $sp, $0, 48
	addi $a0, $0, 15
	
	jal factorial
	nop
	nop
	nop
	nop
	
	
	add $s0, $v0, $0
	
	j end
	nop
	nop
	nop
	nop
	
	
factorial:
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	addi $t0, $0, 2
	slt $t0, $a0, $t0 
	beq $t0, $0, else
	nop
	nop
	nop
	nop
	addi $v0, $0, 1
	addi $sp, $sp, 8
	jr $ra
	nop
	nop
	nop
	nop
else: 
	addi $a0, $a0, -1	
	jal factorial
	nop
	nop
	nop
	nop
	lw $ra, 0($sp)
	nop
	lw $a0, 4($sp)
	nop
	addi $sp, $sp, 8
	multu $a0, $v0
	mflo $v0
	jr $ra
	nop
	nop
	nop
	nop
end: 
	
