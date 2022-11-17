#
#	Makefile for building parser object file
#

#
#	Denug flag
#
# DFLAGS	= -g
DFLAGS	=

#	for local modifications
#
# DEFS	= -DDEBUG $(VHDL93)
DEFS	=

#
#	Include pathes and special definitions (always needed)
#
#		Caution: Do not remove -DARCHSYN in any time
#
GENINCS	= 

INCS	= $(GENINCS) -I.

CFLAGS 	= $(INCS) -c

HFILES 	= 

#
#	For gcc use
#
# GCC	= gcc -DGNU -DANSI -S
GCC	= gcc -DGNU -DANSI

#
#	C compiler
#
# CC	= cc 
CC	= ${GCC}

#
#	yacc
#
YACC	= bison -yvd
# YACC	= yacc -vd

#
#	lex
#
LEX	= flex
# LEX	= lex


OFILES	=	main.o		actions.o	yyerror.o


all 	: calc

calc	: y.tab.h lex.yy.o y.tab.o ${OFILES}
		${CC} -o calc lex.yy.o y.tab.o ${OFILES}

y.tab.h: calc.y
		${YACC} calc.y

lex.yy.o: y.tab.h	lex.yy.c
		${CC} ${DFLAGS} ${CFLAGS} lex.yy.c

lex.yy.c: calc.l
		${LEX} calc.l

y.tab.o	: y.tab.c	lex.yy.c
		${CC} ${DFLAGS} ${CFLAGS} y.tab.c

.c.o	:
		${CC} ${CFLAGS} ${DEFS} ${DFLAGS} -c $*.c

clean	:
		${RM} calc *.o lex.yy.c y.tab.c y.tab.h y.output \#*\# *~
