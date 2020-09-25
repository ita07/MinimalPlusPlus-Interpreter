/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KEYWORD_PROGRAM = 258,
    KEYWORD_DECLARE = 259,
    KEYWORD_PROCEDURE = 260,
    KEYWORD_IN = 261,
    KEYWORD_ELSE = 262,
    KEYWORD_LOOP = 263,
    KEYWORD_DEFAULT = 264,
    KEYWORD_EXIT = 265,
    KEYWORD_INPUT = 266,
    KEYWORD_IF = 267,
    KEYWORD_OR = 268,
    KEYWORD_AND = 269,
    KEYWORD_NOT = 270,
    KEYWORD_FUNCTION = 271,
    KEYWORD_INOUT = 272,
    KEYWORD_WHILE = 273,
    KEYWORD_DOUBLEWHILE = 274,
    KEYWORD_FORCASE = 275,
    KEYWORD_INCASE = 276,
    OP_COLON = 277,
    OP_COMMA = 278,
    OP_SEMICOLON = 279,
    KEYWORD_WHEN = 280,
    KEYWORD_RETURN = 281,
    KEYWORD_PRINT = 282,
    KEYWORD_CALL = 283,
    STRING_LITERAL = 284,
    CHAR = 285,
    const_num = 286,
    BR_OPEN = 287,
    BR_CLOSURE = 288,
    FUN_PROC_OPEN = 289,
    FUN_PROC_CLOSURE = 290,
    OP_PLUS = 291,
    OP_MINUS = 292,
    OP_DIV = 293,
    OP_MULT = 294,
    PAR_OPEN = 295,
    PAR_CLOSURE = 296,
    OP_GT = 297,
    OP_LT = 298,
    OP_GTEQ = 299,
    OP_LTEQ = 300,
    OP_NEQ = 301,
    OP_EQ = 302,
    OP_ASSIGN = 303,
    IDENTIFIER = 304
  };
#endif
/* Tokens.  */
#define KEYWORD_PROGRAM 258
#define KEYWORD_DECLARE 259
#define KEYWORD_PROCEDURE 260
#define KEYWORD_IN 261
#define KEYWORD_ELSE 262
#define KEYWORD_LOOP 263
#define KEYWORD_DEFAULT 264
#define KEYWORD_EXIT 265
#define KEYWORD_INPUT 266
#define KEYWORD_IF 267
#define KEYWORD_OR 268
#define KEYWORD_AND 269
#define KEYWORD_NOT 270
#define KEYWORD_FUNCTION 271
#define KEYWORD_INOUT 272
#define KEYWORD_WHILE 273
#define KEYWORD_DOUBLEWHILE 274
#define KEYWORD_FORCASE 275
#define KEYWORD_INCASE 276
#define OP_COLON 277
#define OP_COMMA 278
#define OP_SEMICOLON 279
#define KEYWORD_WHEN 280
#define KEYWORD_RETURN 281
#define KEYWORD_PRINT 282
#define KEYWORD_CALL 283
#define STRING_LITERAL 284
#define CHAR 285
#define const_num 286
#define BR_OPEN 287
#define BR_CLOSURE 288
#define FUN_PROC_OPEN 289
#define FUN_PROC_CLOSURE 290
#define OP_PLUS 291
#define OP_MINUS 292
#define OP_DIV 293
#define OP_MULT 294
#define PAR_OPEN 295
#define PAR_CLOSURE 296
#define OP_GT 297
#define OP_LT 298
#define OP_GTEQ 299
#define OP_LTEQ 300
#define OP_NEQ 301
#define OP_EQ 302
#define OP_ASSIGN 303
#define IDENTIFIER 304

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "src/grammar.y" /* yacc.c:1909  */

char *name;

#line 156 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
