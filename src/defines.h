#define IDENTIFIER          101

#define OP_PLUS             102     // +
#define OP_MINUS            103     // -
#define OP_DIV              104     // /
#define OP_MULT             105     // *

#define OP_GT               106     // >
#define OP_LT               107     // <
#define OP_GTEQ             108     // >=
#define OP_LTEQ             109     // <=
#define OP_NEQ              110     // <>
#define OP_EQ               111     // =

#define OP_ASSIGN           112     // :=

#define OP_COLON            113     // :
#define OP_COMMA            114     // ,
#define OP_SEMICOLON        115     // ;

#define PAR_OPEN              116     // (
#define PAR_CLOSURE           117     // )

#define FUN_PROC_OPEN       118     // { 
#define FUN_PROC_CLOSURE    119     // }

#define KEYWORD_PROGRAM     120     // program
#define KEYWORD_DECLARE     121     // declare

#define KEYWORD_IF          122     // if
#define KEYWORD_ELSE        123     // else

#define KEYWORD_WHILE       124     // while
#define KEYWORD_DOUBLEWHILE 125     // doublewhile
#define KEYWORD_LOOP        126     // loop
#define KEYWORD_EXIT        127     // exit

#define KEYWORD_FORCASE     128     // forcase
#define KEYWORD_INCASE      129     // incase
#define KEYWORD_WHEN        130     // when
#define KEYWORD_DEFAULT     131     // default

#define KEYWORD_NOT         132      // not
#define KEYWORD_AND         133      // and
#define KEYWORD_OR          134      // or

#define KEYWORD_FUNCTION    135      // function
#define KEYWORD_PROCEDURE   136      // procedure
#define KEYWORD_CALL        137      // call
#define KEYWORD_RETURN      138      // return
#define KEYWORD_IN          139      // in
#define KEYWORD_INOUT       140      // inout

#define KEYWORD_INPUT       141      // input
#define KEYWORD_PRINT       142      // print

#define CHAR                143      // [a-zA-Z]
#define CONST               144      // [0-9]

#define BR_OPEN             145      // [
#define BR_CLOSURE          146      // ]

#define ENDL                147     // \n

#define STRING_LITERAL      148     // string literal