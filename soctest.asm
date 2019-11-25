
gpio_loop:	lw $t1, 0x900($0)
		lw $t2, 0x904($0)
		j gpio_loop 
	
	

