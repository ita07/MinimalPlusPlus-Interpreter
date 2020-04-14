%{
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include "sym_hashing.h"
#include "defines.h"


FILE *new_file; 
void count();
void parse_const_num(char* yycopy);
void parse_identifier(char* yycopy);
void multi_line_comment();
void single_line_comment();
void debugLog(const char* type, const char* value);
void add_ident_number();
void reduce_ident_number();

%}

L                       [A-Za-z] 
D                       [0-9]
N                       [1-9]
C               "!"|"@"|"#"|"$"|"%"|"^"|"&"|"_"|"-"


identifier     	        {L}({L}|{D})*
const_num               ((-?{N}){D}*)|0
whitespace_char         [\t\r ]+
const_string	        \"(\\.|[^"\\])*\"


invalid_identifier    {D}|{C}(({L}|{D})*|{L})
invalid_keyword         {C}({L}|{D})+

%%

"if"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "if"); 
                          addsym( yycopy, idents ); return(KEYWORD_IF);}

"else"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "else"); 
                          addsym( yycopy, idents ); return(KEYWORD_ELSE); }

"while"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "while"); 
                          addsym( yycopy, idents ); return(KEYWORD_WHILE); }

"doublewhile"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "doublewhile"); 
                          addsym( yycopy, idents ); return(KEYWORD_DOUBLEWHILE); }

"loop"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "loop"); 
                          addsym( yycopy, idents ); return(KEYWORD_LOOP); }

"exit"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "exit"); 
                          addsym( yycopy, idents ); return(KEYWORD_EXIT); }

"forcase"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "forcase"); 
                          addsym( yycopy, idents ); return(KEYWORD_FORCASE); }

"incase"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "incase"); 
                          addsym( yycopy, idents ); return(KEYWORD_INCASE); }

"when"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "when"); 
                          addsym( yycopy, idents ); return(KEYWORD_WHEN); }

"default"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "default"); 
                          addsym( yycopy, idents ); return(KEYWORD_DEFAULT); }

"program"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "program"); 
                          addsym( yycopy, idents ); return(KEYWORD_PROGRAM); }

"declare"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "declare"); 
                          addsym( yycopy, idents ); return(KEYWORD_DECLARE); }

"function"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "function"); 
                          addsym( yycopy, idents ); return(KEYWORD_FUNCTION); }

"procedure"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "procedure"); 
                          addsym( yycopy, idents ); return(KEYWORD_PROCEDURE); }

"call"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "call"); 
                          addsym( yycopy, idents ); return(KEYWORD_CALL); }

"return"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "return"); 
                          addsym( yycopy, idents ); return(KEYWORD_RETURN); }

"in"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "in"); 
                          addsym( yycopy, idents ); return(KEYWORD_IN); }

"inout"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "inout"); 
                          addsym( yycopy, idents ); return(KEYWORD_INOUT); }

"input"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "input"); 
                          addsym( yycopy, idents ); return(KEYWORD_INPUT); }

"print"			{ count();char *yycopy=strdup(yytext); debugLog("keyword", "print"); 
                          addsym( yycopy, idents ); return(KEYWORD_PRINT); }

"("				{ count(); return(PAR_OPEN); }
"["				{ count(); return(BR_OPEN); }
")"				{ count(); return(PAR_CLOSURE); }
"]"				{ count(); return(BR_CLOSURE); }
"{"				{ count(); void add_ident_number(); return(FUN_PROC_OPEN); }
"}"				{ count(); void reduce_ident_number(); return(FUN_PROC_CLOSURE); }

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
"\n"            {char *yycopy=strdup(yytext); count(); return(ENDL);}


"/*"            { multi_line_comment();}
"//"			{ single_line_comment(); }

{const_string}		{char *yycopy=strdup(yytext); count(); printf("found literal string %s at line %d\n" ,yycopy, line); 
                           addsym( yycopy, idents ); return(STRING_LITERAL); }

{whitespace_char}           {count(); }

{identifier}            { count(); char *yycopy=strdup(yytext);
                            if(strlen(yycopy)>30){
						        printf("identifier %s in line %d not valid(longer than 30 characters)\n",yycopy,line);
						    } else {
                                debugLog("keyword", "identifier"); 
                                addsym( yycopy, idents );
                            }
                        }

{const_num}               { count(); char *yycopy=strdup(yytext); parse_const_num(yycopy); }

{invalid_keyword}         {char *yycopy=strdup(yytext); count();debugLog("keyword", "invalid_keyword"); addsym( yycopy, idents );}


{invalid_identifier}     {char *yycopy=strdup(yytext); count();debugLog("keyword", "invalid_identifier");addsym( yycopy, idents );}

.                        {char *yycopy=strdup(yytext); count(); debugLog("keyword", "unexpected identifier");addsym( yycopy, idents );}

%%

int yywrap() {
	return 1;
}

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

void count()
{
        int i;

        for(i=0;yytext[i]!='\0';i++) {
            if(yytext[i]=='\n') {
                line++;
            }
        }
}


void parse_const_num(char* yycopy) {

    int yyparsed = atoi(yycopy);
    if ((yyparsed < -65535) || (yyparsed > 65535)) {
        printf("Found %d which cant be accepted as a number\n", yyparsed);
        return;
    }

    debugLog("numeric constant", yycopy);
	addsym(yycopy, idents);
}

void multi_line_comment()
{
    int c;
    for (;;)
        {
    while((c=input())!='*' && c!=EOF)
        { 
        if (c=='\n') 
            {
            line++;
            }
        }
            if (c=='*')
            {
            while ((c=input()) =='*')
                { 
                if (c=='\n') 
                {
                        line++;
                    }
            }
            if (c=='/')
                {
                break;
                }
            }
        if (c==EOF)
            {
            printf("ERROR: eof in comment\n");
            break;
            }
        }
}

void single_line_comment() {
    int c;
    while(c=input()!='\n') {

    }
    line++;
 

}

void add_ident_number() {
    
    idents += 1;

} 

void reduce_ident_number() {

    idents -= 1;

}

void debugLog(const char* type, const char* value) {

	printf("Detected %s %s L:%d\n", type, value, line);

}