CC = clang
CFLAGS = -c -Wall -Wextra -O0
AFLAGS = -c -S -Wall -Wextra -fno-verbose-asm
LFLAGS = -Wall -Wextra
AFLAGSARM = -target arm-linux-gnueabihf

all: main main-stack itos0.s itos1.s itos2.s itos3.s itos-stack.s itos-arm.s itos-mips.s
clean:
	rm -f main main-stack *.o itos0.s itos1.s itos2.s itos3.s itos-stack.s itos-arm.s itos-mips.s

main: main.o itos.o 
	${CC} ${LFLAGS} main.o itos.o -o main

main-stack: main.o itos-stack.o stack.o
	${CC} ${LFLAGS} main.o itos-stack.o stack.o -o main-stack

itos.o: itos.c
	${CC} ${CFLAGS} itos.c -o itos.o

itos-stack.o: itos-stack.c
	${CC} ${CFLAGS} itos-stack.c -o itos-stack.o

stack.o: stack.c
	${CC} ${CFLAGS} stack.c -o stack.o

itos0.s: itos.c
	${CC} ${AFLAGS} -O0 itos.c -o itos0.s

itos1.s: itos.c
	${CC} ${AFLAGS} -O1 itos.c -o itos1.s

itos2.s: itos.c
	${CC} ${AFLAGS} -O2 itos.c -o itos2.s

itos3.s: itos.c
	${CC} ${AFLAGS} -O3 itos.c -o itos3.s

itos-stack.s: itos-stack.c
	${CC} ${AFLAGS} -O0 itos-stack.c -o itos-stack.s
# extension
itos-arm.s: itos.c
	${CC} -S itos.c -o itos-arm.s -target arm
itos-mips.s: itos.c
	${CC} -S itos.c -o itos-mips.s -target mips
