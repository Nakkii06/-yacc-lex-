/*
	MAIN.C

	main module for a simple calculator
									*/

#include <stdio.h>
#include <setjmp.h>

extern int yyparse();

/* extern int Calculated_Value; */

jmp_buf This_Environment;

int main(int noArgs, char **argImgs) {
   extern int yydebug;

   int errCode, y;
   int message;

   if ((errCode = setjmp(This_Environment)) == 0) {
					/* normal return		*/
      printf("******* Interpretation starts. *******\n");
      if ((errCode = yyparse()) == 0) {
	 /* fprintf(stdout, " %d\n", Calculated_Value); */
         printf("******* Interpretation terminated. *******\n");
      }
   }
   return errCode;
}
