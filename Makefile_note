CC=clang++

LLVMFLAGS=$(shell llvm-config-3.8 --cxxflags)
LLVMLIBS=$(shell llvm-config-3.8 --ldflags --libs all) -lpthread -ldl -lncurses

COMPILER_NAME=$(shell basename "${PWD}")
 
FLAGS=-O3 -DYYERROR_VERBOSE -fexceptions
#DFLAGS=-ggdb -O0

CPPS=$(patsubst %.cpp,%.o,$(wildcard *.cpp))
YACS=$(patsubst %.y,%_y.o,$(wildcard *.y))
LEXS=$(patsubst %.l,%_l.o,$(wildcard *.l))

all: $(COMPILER_NAME)



%_l.cpp: %.l
	lex -o $@ $<
	

%_y.cpp: %.y
	bison --defines=bison.hpp -o $@ $<

$(COMPILER_NAME): ${YACS} ${LEXS} ${CPPS}
	${CC} ${FLAGS} ${DFLAGS} *.o ${LLVMLIBS} -o $@

%.o: %.cpp node.h
	${CC} ${LLVMFLAGS} ${FLAGS} ${DFLAGS} -c $< -o $@



clean:
	rm -f *_y.cpp *_l.cpp bison.hpp *.o

meh: clean all
	clear
	./robcmp meh.txt > meh.ll
	llc-3.8 meh.ll -o meh.o -filetype=obj
	clang -c debug.c
	clang meh.o debug.o -o meh -lncurses
	./meh


.SILENT:

