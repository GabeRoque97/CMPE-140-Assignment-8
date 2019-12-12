main: 	addi $t0, $0, 0x0F
	addi $t1, $0, 1
	sll $t4, $t1, 4

fact:	lw $t2, 0x0900($0)
	nop
	and $t3, $t2, $t0
	sw $t3, 0x0800($0)
	sw $t1, 0x0804($0)
	
poll: 	lw $t5, 0x0808($0)
	nop
	
	beq $t5, $0, poll
	nop
	nop
	nop
	nop
	
	srl $t5, $t5, 1
	and $t5, $t5, $t1
	and $t3, $t2, $t4
	or $t3, $t3, $t5
	
	lw $t5 0x080C($0)
	nop
	sw $t3, 0x0908($0) 
	nop
	sw $t5, 0x090C($0) 
	nop
	
done: 	j fact
	nop
	nop
	nop
	nop
	
