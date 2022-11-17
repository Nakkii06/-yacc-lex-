#include <stdio.h>
#include <setjmp.h>

extern jmp_buf This_Environment;

void yyerror(char *aMessage) {
   fprintf(stderr, "Parsing error in processing %s\n", aMessage);
   longjmp(This_Environment, -1);
}

