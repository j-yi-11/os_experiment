.section .text.entry

.extern test
.global trap_s
.extern handler_s
.equ reg_size, 0x8
.align 2

trap_s:
	# save the caller saved registers and sepc
	addi sp, sp, -reg_size*17

	sd ra, 0*reg_size(sp)
	sd t0, 1*reg_size(sp)
	sd t1, 2*reg_size(sp)
	sd t2, 3*reg_size(sp)
	sd a0, 4*reg_size(sp)
	sd a1, 5*reg_size(sp)
	sd a2, 6*reg_size(sp)
	sd a3, 7*reg_size(sp)
	sd a4, 8*reg_size(sp)
	sd a5, 9*reg_size(sp)
	sd a6, 10*reg_size(sp)
	sd a7, 11*reg_size(sp)
	sd t3, 12*reg_size(sp)
	sd t4, 13*reg_size(sp)
	sd t5, 14*reg_size(sp)
	sd t6, 15*reg_size(sp)
	csrr a0, sepc
	sd a0, 16*reg_size(sp)

	# call handler_s(scause)
	csrr a0, scause
	jal handler_s
	
	# load sepc and caller saved registers
	ld ra, 0*reg_size(sp)
	ld t0, 1*reg_size(sp)
	ld t1, 2*reg_size(sp)
	ld t2, 3*reg_size(sp)
	ld a0, 4*reg_size(sp)
	ld a1, 5*reg_size(sp)
	ld a2, 6*reg_size(sp)
	ld a3, 7*reg_size(sp)
	ld a4, 8*reg_size(sp)
	ld a5, 9*reg_size(sp)
	ld a6, 10*reg_size(sp)
	ld a7, 11*reg_size(sp)
	ld t3, 12*reg_size(sp)
	ld t4, 13*reg_size(sp)
	ld t5, 14*reg_size(sp)
	ld t6, 16*reg_size(sp)
	csrw sepc, t6
	ld t6, 15*reg_size(sp)

	addi sp, sp, reg_size*17

	sret



.globl __switch_to
__switch_to:
	li    a4,  40 
	add   a3, a0, a4
	add   a4, a1, a4
	# TODO: Save context into prev->thread

  
	# TODO: Restore context from next->thread

  
	# return to ra
	ret


.globl __init_sepc
__init_sepc:
  	# TODO

	sret
