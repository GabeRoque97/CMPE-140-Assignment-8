main: 	addi $t0, $0, 0x0F
	addi $t1, $0, 1
	sll $t4, $t1, 4

fact:	addi $t2, $0, 5
	and $t3, $t2, $t0
	sw $t3, 0x0800($0)
	sw $t1, 0x0804($0)
	
poll: 	lw $t5, 0x0808($0)
	beq $t5, $0, poll
	nop
	nop
	nop
	nop
	nop
	
	
	lw $t5 0x080C($0)

done: 	j fact
	nop
	nop
	nop
	nop
	nop
	
