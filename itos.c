#include <stdlib.h>

/* Return malloc-ed string representing (non-zero) 'val' in decimal.
 * Parameter 'depth' is the depth of recursion and the
 * number of additional digits to be appended by the caller.
 * One position beyond the last character written so far is
 * put in '*end'.
 */
static char* itos_recur(long val, int depth, char** end) {
	long quot = val / 10;
	long mod = labs(val % 10);
	char* start;
	if (quot != 0) {
		start = itos_recur(quot, depth + 1, end);
	} else {
		int len = depth + (val < 0 ? 3 : 2);
		start = malloc(len);
		*end = &start[0];
		if (val < 0) {
			*(*end)++ = '-';
		}
	}
	*(*end)++ = '0' + mod;
	return start;
}

/* Return malloc-ed string representing value in decimal. */
char* itos(long val) {
	char* start;
	char* end;
	if (val == 0) {
		start = malloc(2);
		start[0] = '0';
		end = &start[1];
	} else {
		start = itos_recur(val, 0, &end);
	}
	*end = '\0';
	return start;
}
