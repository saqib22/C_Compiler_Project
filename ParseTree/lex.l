%{
#include <stdlib.h>
#include <string.h>
#include "grammar.tab.h"
%}

%x multi_comment
%x single_comment

%%

^"#include ".+ ;
^"#define ".+ ;

"/*"                        BEGIN(multi_comment);
<multi_comment>[^*]*        ;
<multi_comment>"*"+[^*/]*   ;
<multi_comment>"*/"         BEGIN(0);

"//"                        BEGIN(single_comment);
<single_comment>[^\n]*      ;
<single_comment>\n          BEGIN(0);


"bool"				{return BOOL;}
"char"				{return CHAR;}
"else"				{return ELSE;}
"for"				{return FOR;}
"if"				{return IF;}
"int"				{return INT;}
"printf"			{return PRINTF;}
"return"			{return RETURN;}
"string"			{return STRING;}
"void"				{return VOID;}
"while"				{return WHILE;}
[\n]				;
[\t]				;			
" "					;
"0x"{1}[A-F0-9]+	{return INTCONSTANT;}
"0X"{1}[A-F0-9]+	{return INTCONSTANT;}
[0-9]+				{yylval.intVal = atoi(yytext);return INTCONSTANT;}
"\""[^\n"\""]*"\""	{return STRINGCONSTANT;}
"true"				{return BOOLCONSTANT;}
"false"				{return BOOLCONSTANT;}
"+"					{return ADD;}
"-"					{return SUB;}
"*"					{return MUL;}
"/"					{return DIV;}
"%"					{return MOD;}
"<"					{return LTHAN;}
"<="				{return LETHAN;}
">"					{return GTHAN;}
">="				{return GETHAN;}
"=="				{return EQUALEQUAL;}
"!="				{return NOTEQUAL;}
"="					{return EQUAL;}
";"					{return SEMICOLON;}
","					{return COMMA;}
"("					{return LPAREN;}
")"					{return RPAREN;}
"{"					{return LBRACE;}
"}"					{return RBRACE;}
[a-zA-Z][a-zA-Z0-9_]*		{yylval.intVal = atoi(yytext);return ID;}
'([^'\\\n]|\\.)'	{return CHARCONSTANT;}

%%