/*
        Question 1
	
	Name : Vishnu Varma V
        Roll No : EE19B059

OS : Linux Ubuntu 18.04.5
Procedure to Compile :
main.c - main C program which passes Array A and number of elements n as arguments
function_q1.s - Code for question 1
In terminal : 
For first question :
	$ Arm-linux-gnueabi-gcc -static -g -o question1 main.c function_q1.s 
$ ./question1 


r0 - initially address of A[0] , at last to return the minimum index value
r1 - n - the number of elements in the array A
r2 - initially S[0] and then the minimum value of S[]
r3 - S[i]
r4 - initially to load A[0] and then the value of A[i] for every iteration
r5 - initially to load A[1] and then the value of A[i+1] for every iteration
r6 - initially to load A[2] and then the value of A[i+2] for every iteration
r7 - initially to load A[3] and then the value of A[i+3] for every iteration
r8 - initially to load A[4] and then the value of A[i+4] for every iteration
r9 - initially to load A[5] and then the value of A[i+5] for every iteration
r10 - Loop variable i to iterate
r12 - index of the minimum value of S : The final answer which passes to r0
*/   
	.arch armv5t
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"temp.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.global	low
	.syntax unified
	.arm
	.fpu softvfp
	.type	low, %function
low:
.LFB0:
	.file 1 "temp.c"
	.loc 1 3 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	.cfi_def_cfa_offset 4
	.cfi_offset 11, -4
	add	fp, sp, #0
	.cfi_def_cfa_register 11
	sub	sp, sp, #12
	str	r0, [fp, #-8]	// Address of A[0]
	str	r1, [fp, #-12]	// n : the number of elements in the array A[]

//Start of Code
 	
	push {r4-r10}	// pushing registers r4 to r10 into stack
	ldr r4,[r0],#4	// loading r4 with the value of A[0], and incrementing r0 which now points to A[1]
	ldr r5,[r0],#4	// loading r5 with the value of A[1], and incrementing r0 which now points to A[2]
	ldr r6,[r0],#4	// loading r6 with the value of A[2], and incrementing r0 which now points to A[3]
	ldr r7,[r0],#4	// loading r7 with the value of A[3], and incrementing r0 which now points to A[4]
	ldr r8,[r0],#4	// loading r8 with the value of A[4], and incrementing r0 which now points to A[5]
	ldr r9,[r0],#4	// loading r9 with the value of A[5], and incrementing r0 which now points to A[6]
	sub r2,r5,r4	//  r2 = A[1] - A[0]
	sub r2,r2,r6	//  r2 = r2 - A[2] = A[1] - A[0] -A[2]
	add r2,r2,r7	//  r2 = r2 + A[3] = A[1] - A[0] -A[2] + A[3]
	sub r2,r2,r8	//  r2 = r2 - A[4] = A[1] - A[0] -A[2] + A[3] - A[4]
	add r2,r2,r9	//  r2 = r2 + A[5] = A[1] - A[0] -A[2] + A[3] - A[4] + A[5]
			//Now r2 contains S[0]
	sub r12,r12,r12	//r12 is the index of the minimum value of S, initialised to zero
	mov r10,#1	// loop variable(i) set to 1
	sub r1,r1,#5	//replacing n by (n-5) in r1, because in the loop (n-5) is used as S is defined for indices till (n-5) only

.Loop:
	mov r4,r5	// Shifting the the value in r5 A[i] into r4 
	mov r5,r6	//Shifting the the value in r6 A[i+1] into r5
	mov r6,r7	//Shifting the the value in r7 A[i+2] into r6
	mov r7,r8	//Shifting the the value in r8 A[i+3] into r7
	mov r8,r9	//Shifting the the value in r9 A[i+4] into r8
	ldr r9,[r0],#4	//loading the new element A[i+5] into r9
	sub r3,r5,r4	//r3 = r5 - r4 = A[i+1] - A[i]
	sub r3,r3,r6	//r3 = r3 -r6 = A[i+1] - A[i] - A[i+2]
	add r3,r3,r7	//r3 = r3 + r7 = A[i+1] - A[i] - A[i+2] + A[i+3]
	sub r3,r3,r8	//r3 = r3 - r8 = A[i+1] - A[i] - A[i+2] + A[i+3] -A[i+4]
	add r3,r3,r9	//r3 = r3 + r9 = A[i+1] - A[i] - A[i+2] + A[i+3] -A[i+4] + A[i+5]
			// r3 contains the value of S[i]
	cmp r2,r3	// Comparing the value of S[i] with the minimum value of S till the ith iteration
	movgt r2,r3	// if min(S[i] till ith iteration) > S[i] , then the minimum value becomes S[i]
	movgt r12,r10	// if min(S[i] till ith iteration) > S[i] , then the value of the index at minimum value becomes i(r10)	
	add r10,r10,#1	// increment the value of i by 1, for next iteration
	cmp r10,r1	// compare the value of i with n-5
	bne .Loop	// until i=n-5 repeat the loop	
	mov r0, r12	// The minimum value of index which was in r12 is now put into r0 to return to the calling function
	pop {r4-r10}	// popping back the registers pushed initally


//End of Code
	
	.loc 1 4 0
	nop
	add	sp, fp, #0
	.cfi_def_cfa_register 13
	@ sp needed
	ldr	fp, [sp], #4
	.cfi_restore 11
	.cfi_def_cfa_offset 0
	bx	lr
	.cfi_endproc
.LFE0:
	.size	low, .-low
.Letext0:
	.file 2 "/usr/lib/gcc-cross/arm-linux-gnueabi/7/include/stddef.h"
	.file 3 "/usr/arm-linux-gnueabi/include/bits/types.h"
	.file 4 "/usr/arm-linux-gnueabi/include/bits/libio.h"
	.file 5 "/usr/arm-linux-gnueabi/include/stdio.h"
	.file 6 "/usr/arm-linux-gnueabi/include/bits/sys_errlist.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x345
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF56
	.byte	0xc
	.4byte	.LASF57
	.4byte	.LASF58
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF8
	.byte	0x2
	.byte	0xd8
	.4byte	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.4byte	.LASF9
	.byte	0x3
	.byte	0x37
	.4byte	0x61
	.uleb128 0x2
	.4byte	.LASF10
	.byte	0x3
	.byte	0x8c
	.4byte	0x85
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF11
	.uleb128 0x2
	.4byte	.LASF12
	.byte	0x3
	.byte	0x8d
	.4byte	0x6f
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.byte	0x4
	.4byte	0x9f
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF13
	.uleb128 0x7
	.4byte	0x9f
	.uleb128 0x8
	.4byte	.LASF43
	.byte	0x98
	.byte	0x4
	.byte	0xf5
	.4byte	0x22b
	.uleb128 0x9
	.4byte	.LASF14
	.byte	0x4
	.byte	0xf6
	.4byte	0x5a
	.byte	0
	.uleb128 0x9
	.4byte	.LASF15
	.byte	0x4
	.byte	0xfb
	.4byte	0x99
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x4
	.byte	0xfc
	.4byte	0x99
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF17
	.byte	0x4
	.byte	0xfd
	.4byte	0x99
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF18
	.byte	0x4
	.byte	0xfe
	.4byte	0x99
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF19
	.byte	0x4
	.byte	0xff
	.4byte	0x99
	.byte	0x14
	.uleb128 0xa
	.4byte	.LASF20
	.byte	0x4
	.2byte	0x100
	.4byte	0x99
	.byte	0x18
	.uleb128 0xa
	.4byte	.LASF21
	.byte	0x4
	.2byte	0x101
	.4byte	0x99
	.byte	0x1c
	.uleb128 0xa
	.4byte	.LASF22
	.byte	0x4
	.2byte	0x102
	.4byte	0x99
	.byte	0x20
	.uleb128 0xa
	.4byte	.LASF23
	.byte	0x4
	.2byte	0x104
	.4byte	0x99
	.byte	0x24
	.uleb128 0xa
	.4byte	.LASF24
	.byte	0x4
	.2byte	0x105
	.4byte	0x99
	.byte	0x28
	.uleb128 0xa
	.4byte	.LASF25
	.byte	0x4
	.2byte	0x106
	.4byte	0x99
	.byte	0x2c
	.uleb128 0xa
	.4byte	.LASF26
	.byte	0x4
	.2byte	0x108
	.4byte	0x263
	.byte	0x30
	.uleb128 0xa
	.4byte	.LASF27
	.byte	0x4
	.2byte	0x10a
	.4byte	0x269
	.byte	0x34
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x4
	.2byte	0x10c
	.4byte	0x5a
	.byte	0x38
	.uleb128 0xa
	.4byte	.LASF29
	.byte	0x4
	.2byte	0x110
	.4byte	0x5a
	.byte	0x3c
	.uleb128 0xa
	.4byte	.LASF30
	.byte	0x4
	.2byte	0x112
	.4byte	0x7a
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF31
	.byte	0x4
	.2byte	0x116
	.4byte	0x3e
	.byte	0x44
	.uleb128 0xa
	.4byte	.LASF32
	.byte	0x4
	.2byte	0x117
	.4byte	0x4c
	.byte	0x46
	.uleb128 0xa
	.4byte	.LASF33
	.byte	0x4
	.2byte	0x118
	.4byte	0x26f
	.byte	0x47
	.uleb128 0xa
	.4byte	.LASF34
	.byte	0x4
	.2byte	0x11c
	.4byte	0x27f
	.byte	0x48
	.uleb128 0xa
	.4byte	.LASF35
	.byte	0x4
	.2byte	0x125
	.4byte	0x8c
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF36
	.byte	0x4
	.2byte	0x12d
	.4byte	0x97
	.byte	0x58
	.uleb128 0xa
	.4byte	.LASF37
	.byte	0x4
	.2byte	0x12e
	.4byte	0x97
	.byte	0x5c
	.uleb128 0xa
	.4byte	.LASF38
	.byte	0x4
	.2byte	0x12f
	.4byte	0x97
	.byte	0x60
	.uleb128 0xa
	.4byte	.LASF39
	.byte	0x4
	.2byte	0x130
	.4byte	0x97
	.byte	0x64
	.uleb128 0xa
	.4byte	.LASF40
	.byte	0x4
	.2byte	0x132
	.4byte	0x25
	.byte	0x68
	.uleb128 0xa
	.4byte	.LASF41
	.byte	0x4
	.2byte	0x133
	.4byte	0x5a
	.byte	0x6c
	.uleb128 0xa
	.4byte	.LASF42
	.byte	0x4
	.2byte	0x135
	.4byte	0x285
	.byte	0x70
	.byte	0
	.uleb128 0xb
	.4byte	.LASF59
	.byte	0x4
	.byte	0x9a
	.uleb128 0x8
	.4byte	.LASF44
	.byte	0xc
	.byte	0x4
	.byte	0xa0
	.4byte	0x263
	.uleb128 0x9
	.4byte	.LASF45
	.byte	0x4
	.byte	0xa1
	.4byte	0x263
	.byte	0
	.uleb128 0x9
	.4byte	.LASF46
	.byte	0x4
	.byte	0xa2
	.4byte	0x269
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF47
	.byte	0x4
	.byte	0xa6
	.4byte	0x5a
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.4byte	0x232
	.uleb128 0x6
	.byte	0x4
	.4byte	0xab
	.uleb128 0xc
	.4byte	0x9f
	.4byte	0x27f
	.uleb128 0xd
	.4byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.4byte	0x22b
	.uleb128 0xc
	.4byte	0x9f
	.4byte	0x295
	.uleb128 0xd
	.4byte	0x30
	.byte	0x27
	.byte	0
	.uleb128 0xe
	.4byte	.LASF60
	.uleb128 0xf
	.4byte	.LASF48
	.byte	0x4
	.2byte	0x13f
	.4byte	0x295
	.uleb128 0xf
	.4byte	.LASF49
	.byte	0x4
	.2byte	0x140
	.4byte	0x295
	.uleb128 0xf
	.4byte	.LASF50
	.byte	0x4
	.2byte	0x141
	.4byte	0x295
	.uleb128 0x6
	.byte	0x4
	.4byte	0xa6
	.uleb128 0x7
	.4byte	0x2be
	.uleb128 0x10
	.4byte	.LASF51
	.byte	0x5
	.byte	0x87
	.4byte	0x269
	.uleb128 0x10
	.4byte	.LASF52
	.byte	0x5
	.byte	0x88
	.4byte	0x269
	.uleb128 0x10
	.4byte	.LASF53
	.byte	0x5
	.byte	0x89
	.4byte	0x269
	.uleb128 0x10
	.4byte	.LASF54
	.byte	0x6
	.byte	0x1a
	.4byte	0x5a
	.uleb128 0xc
	.4byte	0x2c4
	.4byte	0x300
	.uleb128 0x11
	.byte	0
	.uleb128 0x7
	.4byte	0x2f5
	.uleb128 0x10
	.4byte	.LASF55
	.byte	0x6
	.byte	0x1b
	.4byte	0x300
	.uleb128 0x12
	.ascii	"low\000"
	.byte	0x1
	.byte	0x2
	.4byte	0x5a
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x342
	.uleb128 0x13
	.ascii	"a\000"
	.byte	0x1
	.byte	0x2
	.4byte	0x342
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x13
	.ascii	"n\000"
	.byte	0x1
	.byte	0x2
	.4byte	0x5a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.4byte	0x5a
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF22:
	.ascii	"_IO_buf_end\000"
.LASF9:
	.ascii	"__quad_t\000"
.LASF30:
	.ascii	"_old_offset\000"
.LASF58:
	.ascii	"/home/vishnu/midterm\000"
.LASF54:
	.ascii	"sys_nerr\000"
.LASF25:
	.ascii	"_IO_save_end\000"
.LASF5:
	.ascii	"short int\000"
.LASF8:
	.ascii	"size_t\000"
.LASF35:
	.ascii	"_offset\000"
.LASF19:
	.ascii	"_IO_write_ptr\000"
.LASF14:
	.ascii	"_flags\000"
.LASF21:
	.ascii	"_IO_buf_base\000"
.LASF26:
	.ascii	"_markers\000"
.LASF16:
	.ascii	"_IO_read_end\000"
.LASF53:
	.ascii	"stderr\000"
.LASF6:
	.ascii	"long long int\000"
.LASF34:
	.ascii	"_lock\000"
.LASF11:
	.ascii	"long int\000"
.LASF31:
	.ascii	"_cur_column\000"
.LASF57:
	.ascii	"temp.c\000"
.LASF60:
	.ascii	"_IO_FILE_plus\000"
.LASF47:
	.ascii	"_pos\000"
.LASF46:
	.ascii	"_sbuf\000"
.LASF43:
	.ascii	"_IO_FILE\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF4:
	.ascii	"signed char\000"
.LASF7:
	.ascii	"long long unsigned int\000"
.LASF48:
	.ascii	"_IO_2_1_stdin_\000"
.LASF0:
	.ascii	"unsigned int\000"
.LASF44:
	.ascii	"_IO_marker\000"
.LASF33:
	.ascii	"_shortbuf\000"
.LASF36:
	.ascii	"__pad1\000"
.LASF18:
	.ascii	"_IO_write_base\000"
.LASF42:
	.ascii	"_unused2\000"
.LASF15:
	.ascii	"_IO_read_ptr\000"
.LASF2:
	.ascii	"short unsigned int\000"
.LASF13:
	.ascii	"char\000"
.LASF45:
	.ascii	"_next\000"
.LASF56:
	.ascii	"GNU C11 7.5.0 -march=armv5t -mfloat-abi=soft -mtls-"
	.ascii	"dialect=gnu -g -fstack-protector-strong\000"
.LASF37:
	.ascii	"__pad2\000"
.LASF38:
	.ascii	"__pad3\000"
.LASF39:
	.ascii	"__pad4\000"
.LASF40:
	.ascii	"__pad5\000"
.LASF50:
	.ascii	"_IO_2_1_stderr_\000"
.LASF3:
	.ascii	"long unsigned int\000"
.LASF20:
	.ascii	"_IO_write_end\000"
.LASF12:
	.ascii	"__off64_t\000"
.LASF10:
	.ascii	"__off_t\000"
.LASF27:
	.ascii	"_chain\000"
.LASF24:
	.ascii	"_IO_backup_base\000"
.LASF51:
	.ascii	"stdin\000"
.LASF29:
	.ascii	"_flags2\000"
.LASF41:
	.ascii	"_mode\000"
.LASF17:
	.ascii	"_IO_read_base\000"
.LASF32:
	.ascii	"_vtable_offset\000"
.LASF23:
	.ascii	"_IO_save_base\000"
.LASF55:
	.ascii	"sys_errlist\000"
.LASF28:
	.ascii	"_fileno\000"
.LASF52:
	.ascii	"stdout\000"
.LASF49:
	.ascii	"_IO_2_1_stdout_\000"
.LASF59:
	.ascii	"_IO_lock_t\000"
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",%progbits
