#include <stdio.h>
#include <inttypes.h>

/* Print stack frame and that of recursive callers. */
static void print_recur(int64_t ret, int64_t rbp, int64_t next_rbp) {
	int64_t this_ret;
	asm("movq 8(%1), %0;" : "=r"(this_ret) : "r"(rbp));
	if (this_ret == ret) {
		long prev_rbp;
		asm("movq (%1), %0;" : "=r"(prev_rbp) : "r"(rbp));
		//every time a new function called, the rbp and rsp will be changed.
		print_recur(ret, prev_rbp, rbp);
		
		int stop = (int)(next_rbp - rbp);
		int offset = 0;

		// this while loop will change 8 bytes for every iteration until it reaches "stop"
		while(offset > stop){
			int64_t quadword;
			int32_t doublewordOne;
			int32_t doublewordTwo;
			// for every 8 bytes, load two doublewords and one quadword
			asm("movq (%1), %0;" : "=r"(quadword) : "r"(rbp + offset));
			asm("movl (%1), %0;" : "=r"(doublewordOne) : "r"(rbp + offset + 4));
			asm("movl (%1), %0;" : "=r"(doublewordTwo) : "r"(rbp + offset));
			// print two doublewords first and the quadword at last
			printf("@ %li | offset: %d | (doubleword) value is: %d\n", (long)(rbp + offset + 4), offset + 4, (int)doublewordOne);
			printf("@ %li | offset: %d | (doubleword) value is: %d\n", (long)(rbp + offset), offset, (int)doublewordTwo);
			printf("@ %li | offset: %d | (quadword) value is: %li\n", (long)(rbp + offset), offset, (long)quadword);
			printf("-------------------------\n");
			offset = offset - 8;
		}
		printf("=============================================================\n");
	}
}

/* Print stack frames of sequence of callers that have same return address. */
void print_stack() {
	int64_t rbp;
	int64_t prev_rbp;
	int64_t prev_ret;
	asm("movq %%rbp, %0;" : "=r"(rbp));
	asm("movq (%1), %0;" : "=r"(prev_rbp) : "r"(rbp));
	asm("movq 8(%1), %0;" : "=r"(prev_ret) : "r"(prev_rbp));
	print_recur(prev_ret, prev_rbp, rbp);
}