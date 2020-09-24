%{
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <stdlib.h>
#include "sym_tab.h"
#include "y.tab.h"
extern char *yytext;
#define YYERROR_VERBOSE
#define YYPRINT(file, type, value)   yyprint (file, type, value) 

%}

%union
{
char *name;
} 

%token KEYWORD_PROGRAM KEYWORD_DECLARE KEYWORD_PROCEDURE KEYWORD_IN KEYWORD_ELSE 

%token KEYWORD_LOOP KEYWORD_DEFAULT KEYWORD_EXIT KEYWORD_INPUT KEYWORD_IF

%token KEYWORD_OR KEYWORD_AND KEYWORD_NOT 

%token KEYWORD_FUNCTION KEYWORD_INOUT KEYWORD_WHILE 

%token KEYWORD_DOUBLEWHILE KEYWORD_FORCASE KEYWORD_INCASE 

%token OP_COLON OP_COMMA OP_SEMICOLON

%token KEYWORD_WHEN KEYWORD_RETURN KEYWORD_PRINT KEYWORD_CALL  

%token STRING_LITERAL CHAR const_num

%token BR_OPEN BR_CLOSURE FUN_PROC_OPEN FUN_PROC_CLOSURE

%token OP_PLUS OP_MINUS OP_DIV OP_MULT

%token PAR_OPEN PAR_CLOSURE

%token OP_GT OP_LT OP_GTEQ OP_LTEQ OP_NEQ OP_EQ OP_ASSIGN

%token IDENTIFIER 

%type <name> identifier

%start program

%%


program 
        :KEYWORD_PROGRAM identifier block 
        ;

identifier
	:IDENTIFIER
	;

block
        : FUN_PROC_OPEN declarations subprograms sequence FUN_PROC_CLOSURE
		;

declarations
        : KEYWORD_DECLARE varlist OP_SEMICOLON  decloop	
	;

decloop
	:declarations decloop
	| // empty
        ;



varlist
        : identifier varloop
		;


varloop
	: OP_COMMA identifier varloop
	| //empty
	;

subprograms
	:subloop
	;
	
subloop 
		: func
		| /* empty */
		;	

func    
        :KEYWORD_PROCEDURE identifier funcbody
        |KEYWORD_FUNCTION identifier funcbody
        ;

funcbody
        :formalpars block
        ;

formalpars
        :PAR_OPEN PAR_CLOSURE
        |PAR_OPEN formalparlist PAR_CLOSURE
        ;

formalparlist
		:formalparitem formalparlist_loop
		;

formalparlist_loop
		: OP_COMMA formalparitem formalparlist_loop
		| //empty
		;

formalparitem
        :KEYWORD_IN identifier
        |KEYWORD_INOUT identifier
        ;

brack_or_stat
        :brackets_seq
        |statement
        ;

brackets_seq
        :FUN_PROC_OPEN sequence FUN_PROC_CLOSURE 
        ;

sequence
        :statement sequence_loop
        ;

sequence_loop
        :OP_SEMICOLON statement sequence_loop
        |
        ;

statement 
        :
        |assignment_stat
        |if_stat
        |while_stat
        |double_while_stat
        |loop_stat
        |forcase_stat
        |incase_stat
        |exit_stat
        |return_stat
        |print_stat
        |input_stat
        |call_stat
        ;

assignment_stat 
        :identifier OP_ASSIGN expression
        ;

if_stat 
        :KEYWORD_IF PAR_OPEN condition PAR_CLOSURE brack_or_stat else_stat
        ;

else_stat
        :KEYWORD_ELSE brack_or_stat
        | //empty
        ;

while_stat
        :KEYWORD_WHILE PAR_OPEN condition PAR_CLOSURE brack_or_stat
        ;

double_while_stat
        :KEYWORD_DOUBLEWHILE PAR_OPEN condition PAR_CLOSURE brack_or_stat KEYWORD_ELSE brack_or_stat
        ;

loop_stat 
        : KEYWORD_LOOP brack_or_stat
        ;

forcase_stat 
        : KEYWORD_FORCASE loop_when KEYWORD_DEFAULT OP_COLON brack_or_stat
        ;
        
incase_stat
        :KEYWORD_INCASE loop_when
        ;

loop_when
        :when_stat loop_when
	|
        ;

when_stat
        :KEYWORD_WHEN OP_COLON PAR_OPEN condition PAR_CLOSURE OP_COLON brack_or_stat
        ;

exit_stat
        :KEYWORD_EXIT
        ;

return_stat
        :KEYWORD_RETURN PAR_OPEN expression PAR_CLOSURE
        ;

print_stat
        :KEYWORD_PRINT PAR_OPEN expression PAR_CLOSURE
        ;

input_stat
        : KEYWORD_INPUT PAR_CLOSURE identifier PAR_CLOSURE
        ;

call_stat
        :KEYWORD_CALL identifier actualpars
        ;

actualpars
        :PAR_OPEN PAR_CLOSURE
        |PAR_OPEN actualparlist PAR_CLOSURE
        ;

actualparlist
        :actualparitem loop_actualparitem
        ;

loop_actualparitem
        : OP_COMMA actualparitem loop_actualparitem
	|
        ;

actualparitem
        :KEYWORD_INPUT expression
        |KEYWORD_INOUT identifier
        ;

condition
        :boolterm loop_condition
        ;

loop_condition
        :KEYWORD_OR boolterm
        |
        ;

boolterm
        :boolfactor loop_boolterm
        ;

loop_boolterm
        :KEYWORD_AND boolfactor
        |
        ;

boolfactor
        :KEYWORD_NOT BR_OPEN condition BR_CLOSURE
        |BR_OPEN condition BR_CLOSURE
        |expression relational_oper expression
        ;

expression
        :optional_sign term loop_add_term
        ;

loop_add_term
        :add_oper term loop_add_term
	|
        ;

term
        :factor loop_mul_factor
        ;

loop_mul_factor
        :mul_oper factor loop_mul_factor
	|
        ;

factor
        :const_num
        |PAR_OPEN expression PAR_CLOSURE
        |identifier idtail
        ;

idtail
        :actualpars
        |
	;

relational_oper
        :OP_EQ
        |OP_LT 
        |OP_LTEQ
        |OP_NEQ
        |OP_GTEQ
        |OP_GT
        ;

add_oper
        :OP_PLUS
        |OP_MINUS
        ;

mul_oper
        :OP_MULT
        |OP_DIV
        ;

optional_sign
        :add_oper
        |       
        ;

%%

int column;
extern int column;
extern void yyrestart( FILE *input_file );
extern FILE *new_file; 
int yydebug;




int main(int argc, char *argv[]){
	if (argc!=2) printf("\nUsage: ph_2 <input file name> \n");
	else
		if ((new_file=fopen(argv[1],"r"))==NULL) 
			printf("\n<%s> not found.\n",argv[1]);
		else 
			{
				yyrestart(new_file); 
				return yyparse();
				fclose(new_file);
			}

int yydebug=1;
return yyparse();


}
int yyerror(s)
char *s;
{
        fflush(stdout);
        printf("\n%*s\n%*s\n", column, "^", column, s);
		return 1;
}

static int
yyprint (file, type, value)
     FILE *file;
     int type;
     YYSTYPE value;
{
  if (type == IDENTIFIER)
    fprintf (stderr," = %s", value.name);
  return 1;
}