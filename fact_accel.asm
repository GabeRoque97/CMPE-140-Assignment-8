main: 	addi $t0, $0, 0x0F
	addi $t1, $0, 1
	sll $t4, $t1, 4

fact:	lw $t2, 0x0900($0)
	and $t3, $t2, $t0
	sw $t3, 0x0800($0)
	sw $t1, 0x0804($0)
	
poll: 	lw $t2, 0x0808($0)
	beq $t5, $0, poll
	
	srl $t5, $t5, 1
	and $t5, $t5, $t1
	and $t5, $t5, $t4
	or $t3, $t2, $t4
	lw $t5, 0x080c($0)
	sw $t3, 0x0908($0)
	sw $t5, 0x090c($0)

done: 	j fact