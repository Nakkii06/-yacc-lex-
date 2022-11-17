/*

        Action routines for simple calculator
        Filename: actions.c
	Author:	    Masami Noro

	Copyright (C) Masami Noro

	All rights reserved. No part of this software may be sold or
	distributed in any form or by any means without the prior 
	written permission of Masami Noro.

	Function: Yacc code to interpret integer experssion

									*/

/* function to do addition                                              */
#include <stdio.h>

double ACAdd(double l, double r) { return l + r; }

/* function to do subtraction                                           */

double ACSubtract(double l, double r) { return l - r; }

/* function to do multiplication                                        */

double ACMultiply(double l, double r) { return l * r; }

/* function to do division                                              */

double ACDivide(double l, double r) { return l / r; }

/* function to make modulation                                          */

int ACMake_Modular(double l, double r) { return (int)l % (int)r; }
