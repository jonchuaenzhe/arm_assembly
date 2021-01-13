/*
 * asm_func.s
 *
 *  Created on: 2020/8/30
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global asm_func

@ Start of executable code
asm_func:
	PUSH {R4-R9, R14}
	@ load F x R into R4 (total number of rooms)
	LDR R4, [R3, #0x0]
	LDR R5, [R3, #0x4]
	MUL R4, R5
	@ load RM_MAX in R5
	LDR R5, [R3, #0x8]

	@ set R6 = 7 to count down number of days
	MOV R6, #7
	@ set R7 = 0 as sum for send_in patients
	MOV R7, #0

	BL SUM_PATIENTS
	@ now R7 = 35 (sum of send_in patients)

	@ set R6 = F x R to count down rooms
	MOV R6, R4

	BL DISCHARGE_AND_ADMIT

	POP {R4-R9, R14}
	BX LR @ yay :)

SUM_PATIENTS:
@ R8: holding register for send_in patients
	LDR R8, [R2], #0x4
	ADD R7, R8 @ add to the sum for send_in patients

	SUBS R6, #1
	BNE SUM_PATIENTS

	BX LR

DISCHARGE_AND_ADMIT:
@ R8: initial number of patients in room -> free space in room
@ R9: number of discharged patients from room

	LDR R8, [R0], #0x4
	LDR R9, [R1], #0x4

	SUB R8, R9
	@ now R8 is number of patients after discharge

	SUB R8, R5, R8
	@ now R8 is free space in room

	CMP R7, R8

	BMI IF_NOT_ENOUGH_PATIENTS@ this means too few send_in patients to fill up this room

	@ if there are enough patients:
	SUB R7, R8 @ subtract free space in room from send_in patients
	STR R5, [R3], #0x4 @ room will have RM_MAX number of patients
	B SKIP_NOT_ENOUGH_PATIENTS

IF_NOT_ENOUGH_PATIENTS:
	SUB R8, R5, R8 @ R8 is now number of original patients in room after discharge
	ADD R8, R7 @ add the last few patients to the room
	MOV R7, #0 @ set remaining number of patients to 0
	STR R8, [R3], #0x4 @ room will have original patients + last few patients, store to result

SKIP_NOT_ENOUGH_PATIENTS:
	SUBS R6, #1
	BNE DISCHARGE_AND_ADMIT

	BX LR
