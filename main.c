#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include "itos.h"

void test_itos(int val) {
	char* str = itos(val);
	printf("%d = %s\n", val, str);
	free(str);
}

int main(void) {
	//test_itos(0);
	//test_itos(1);
	//test_itos(-1);
	//test_itos(12345);
	test_itos(-123);
	//test_itos(INT_MAX);
	//test_itos(INT_MIN);
}
