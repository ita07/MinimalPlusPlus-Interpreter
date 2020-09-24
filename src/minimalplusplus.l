%{
#include <stdio.h>
#include <stdlib.h> /* for exit */
#include <malloc.h> /* for malloc */
#include <string.h>
#include "sym_tab.h"
#include "y.tab.h"
int line = 1;
int column=0;
FILE *new_file; 
int yycopy;
void count();
void multi_line_comment();
void single_line_comment();

%}

L                       [A-Za-z] 
D                       [0-9]
N                       [1-9]
C               "!"|"@"|"#"|"$"|"%"|"^"|"&"|"_"|"-"



identifier     	        {L}({L}|{D})*
const_num               ((-?{N}){D}*)|0
whitespace				[ \t\v\n\f]+


%%

"if"			{ count(); return(KEYWORD_IF);}

"else"			{ count(); return(KEYWORD_ELSE); }

"while"			{ count(); return(KEYWORD_WHILE); }

"doublewhile"	{ count(); return(KEYWORD_DOUBLEWHILE); }

"loop"			{ count(); return(KEYWORD_LOOP); }

"exit"			{ count(); return(KEYWORD_EXIT); }

"forcase"		{ count(); return(KEYWORD_FORCASE); }

"incase"		{ count(); return(KEYWORD_INCASE); }

"when"			{ count(); return(KEYWORD_WHEN); }

"default"		{ count(); return(KEYWORD_DEFAULT); }

"program"		{ count(); return(KEYWORD_PROGRAM); }

"declare"		{ count(); return(KEYWORD_DECLARE); }

"function"		{ count(); return(KEYWORD_FUNCTION); }

"procedure"		{ count(); return(KEYWORD_PROCEDURE); }

"call"			{ count(); return(KEYWORD_CALL); }

"return"		{ count(); return(KEYWORD_RETURN); }

"in"			{ count(); return(KEYWORD_IN); }

"inout"			{ count(); return(KEYWORD_INOUT); }

"input"			{ count(); return(KEYWORD_INPUT); }

"print"			{ count(); return(KEYWORD_PRINT); }

"("				{ count(); return(PAR_OPEN); }
"["				{ count(); return(BR_OPEN); }
")"				{ count(); return(PAR_CLOSURE); }
"]"				{ count(); return(BR_CLOSURE); }
"{"				{ count(); return(FUN_PROC_OPEN); }
"}"				{ count(); return(FUN_PROC_CLOSURE); }

"="				{ count(); return(OP_EQ); }
"<"				{ count(); return(OP_LT); }
">"				{ count(); return(OP_GT); }
","				{ count(); return(OP_COMMA); }
":"				{ count(); return(OP_COLON); }
";"				{ count(); return(OP_SEMICOLON); }
"<="			{ count(); return(OP_LTEQ); }
">="			{ count(); return(OP_GTEQ); }
"+"				{ count(); return(OP_PLUS); }
"-"				{ count(); return(OP_MINUS); }
"*"				{ count(); return(OP_MULT); }
"/"				{ count(); return(OP_DIV); }
"and"			{ count(); return(KEYWORD_AND); }
"or"			{ count(); return(KEYWORD_OR); }
"not"			{ count(); return(KEYWORD_NOT); }
"<>"			{ count(); return(OP_NEQ); }
":="			{ count(); return(OP_ASSIGN); }


"/*"            { multi_line_comment();}
"//"			{ single_line_comment(); }



{whitespace}           {count(); }

{identifier}            { count(); char *yycopy=strdup(yytext);
                            if(strlen(yycopy)>30){
						        printf("identifier %s not valid(longer than 30 characters)\n",yycopy);
						    } else {
                                
                                return(IDENTIFIER);
                            }
                        }

{const_num}              { count(); char *yycopy=strdup(yytext);   
                            int yyparsed = atoi(yycopy);
                            if ((yyparsed < -65535) || (yyparsed > 65535)) {
                                printf("Found %d which cant be accepted as a number\n", yyparsed);
                            } else {
                                return(const_num);
                            }
                        }

%%

int yywrap() {
	return 1;
}

/*
void main(int argc, char *argv[]){
	int ret_val=1;

    if (argc!=2) {

        printf("\nUsage: lexyy <input file name> \n");
    } 
    else {

		if ((new_file=fopen(argv[1],"r"))==NULL) {

			printf("\n<%s> not found.\n",argv[1]);
        }
		else{
			yyrestart(new_file); 
			while(ret_val!=0){
				ret_val=yylex();
			}
			fclose(new_file);
		}
    }
}
*/
void count() {
        int i;
        for(i=0;yytext[i]!='\0';i++)
        if(yytext[i]=='\n')
        {
                line++;
                column=0;
        }
        else if(yytext[i]=='\t')
                column += 8-(column % 8);
                else column++;
}

void multi_line_comment() {
	char c, c1;
loop:
	while ((c = input()) != '*' && c != 0);
	if (c != 0 && (c1 = input()) != '/') {
		unput(c1);
		goto loop;
	}
	if (c==0) unput(c);
}

void single_line_comment() {
    int c;
    while(c=input()!='\n' && c != EOF) {

    }
    line++;                                                   

}