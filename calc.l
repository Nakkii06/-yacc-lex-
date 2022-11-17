%{
#include        <stdio.h>
#include	<y.tab.h>

int yywrap(void) { return 1; }
%}

letter			[A-Za-z]
digit			[0-9]
positive                [1-9]

realNumber              []

graph_char		[A-Za-z0-9 #&')*+,\-./:;<=>_|!$%@?\[\\\]\^`{}~]

/* digits			{digit}{digit}* */

%%

{positive}{digit}* {
            int y;

	    yytext[yyleng] = (char) 0;
            for (y = yylval.intValue = 0; yytext[y] != (char) 0; ++y) {
               yylval.intValue *= 10;
               yylval.intValue += (int) yytext[y] - (int) '0';
            }
	    return TC_INT_VAL;
        }
        
{positive}*\.{digit}* {          
		    
            yylval.doubleValue =atof(yytext);        
            
	    return TC_DB_VAL;
        }       


0       { yylval.intValue = 0; return TC_INT_VAL; }

\+	{ return TC_PLUS; }

\-	{ return TC_MINUS; }

\*	{ return TC_MULT; }

\/	{ return TC_DIV; }

\%	{ return TC_MOD; }

=	{ return TC_EQUAL; }

\(	{ return TC_LPAR; }

\)	{ return TC_RPAR; }

\       ;

.	{
	    yytext[1] = '\0';
	    fprintf(stderr, "Invalid character '%s', ignorede.",
		    yytext);
	}
%%
