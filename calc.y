%{
/*

  	Title:	    Interpreter for simple calculator
	Filename:   calc.y
	Author:	    Masami Noro

	Copyright (C) Masami Noro

	All rights reserved. No part of this software may be sold or
	distributed in any form or by any means without the prior 
	written permission of Masami Noro.

	Function: Yacc code to interpret integer experssion

									*/

#include	<stdio.h>
#include "yyerror.h"
#include "actions.h"

#ifdef DEBUG
#include	"dump.h"
#define		YYDEBUG	1
#endif

extern int yylex(void);
/**/
/* int Calculated_Value; */
%}
/**/	    
/*    value								*/
%token <doubleValue>	TC_DB_VAL //added

%token <intValue>	TC_INT_VAL
%token                  TC_PLUS
%token                  TC_MINUS
%token                  TC_MULT
%token                  TC_DIV
%token                  TC_MOD
%token                  TC_LPAR
%token                  TC_RPAR
%token                  TC_EQUAL

/*     non terminals							*/
%type  <expValue>			command
%type  <expValue>			expression
%type  <expValue>			term
%type  <expValue>			factor
/**/
/**
	union fields for noterminals
**/
/**/
%union	{
   /*  integer value for token */
   int intValue;
   
   /*  double value for token */
   double doubleValue;


   /*  expression value for non terminals */
   double expValue;
}

%start command

%%
command
   : expression TC_EQUAL { 
      /* $$ = Calculated_Value = $1; */
      printf("%f\n", $1);
   }
   | command expression TC_EQUAL { printf("%f\n", $2); }
   ;

expression
   : term { $$ = $1; }
   | expression TC_PLUS term { $$ = ACAdd($1, $3);  }
   | expression TC_MINUS term { $$ = ACSubtract($1, $3); }
   ;

term: factor { $$ = $1; }
   | term TC_MULT factor { $$ = ACMultiply($1, $3); }
   | term TC_DIV factor { $$ = ACDivide($1, $3); }
   | term TC_MOD factor { $$ = ACMake_Modular($1, $3); }
   ;

factor
   : TC_INT_VAL { $$ = $1; }
   | TC_LPAR expression TC_RPAR { $$ = $2; }
   | TC_MINUS TC_INT_VAL { $$ = -$2;}  
   | TC_PLUS TC_INT_VAL { $$ = $2;}   //added
   | TC_DB_VAL { $$ = $1; }           //added
   | TC_MINUS TC_DB_VAL { $$ = -$2;}  //added
   | TC_PLUS TC_DB_VAL { $$ = $2;}    //added
   ;
