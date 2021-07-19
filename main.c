/*
Name : Vishnu Varma V
Roll No : EE19B059

OS : Linux Ubuntu 18.04.5
Procedure to Compile :
main.c - main C program which passes Array A and number of elements n as arguments
function_q1.s - Code for question 1
function_q2.s - Code for question 2
In terminal : 
For first question :
	$ Arm-linux-gnueabi-gcc -static -g -o question1 main.c function_q1.s 
$ ./question1 
For Second  question :
	$ Arm-linux-gnueabi-gcc -static -g -o question2 main.c function_q2.s 
$ ./question2 
*/
// MAIN PROGRAM TO PASS THE ARGUMENTS FOR THE FUNCTIONS
#include<stdio.h>
int A[15]={20,40,47,56,68,72,76,84,90,95,99,104,150,173,200};//1,4,6,8,9,10,13,15,16,19,22,25,27,29,33//0,0,0,0,0,0,0,0,0,0,0,0,0,1,0	
//20,40,47,56,68,72,76,84,90,95,99,104,150,173,200: These values were used for verification
int low(int *a,int n);
void main()
{
printf("final : %d\n",low(A,15));
}

