%{
	#include "Compiler.tab.h"
%}
%option yylineno

%x multi_comment
%x single_comment

digit       [0-9]
integer     {digit}+
float		{integer}\.{integer}
letter      [A-Za-z]   
id          {letter}+({letter}|{digit})*

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

"int"			{printf("<%s>", yytext); return INT;}
"float"			{printf("<%s>", yytext); return FLOAT;}
"void" 			{printf("<%s>", yytext); return VOID;}
"while"			{printf("<%s>", yytext); return WHILE;}
"if"			{printf("<%s>", yytext); return IF;}
"else"			{printf("<%s>", yytext); return ELSE;}
"case"			{printf("<%s>", yytext); return CASE;}
"break"			{printf("<%s>", yytext); return BREAK;}
"switch"		{printf("<%s>", yytext); return SWITCH;}
"default" 		{printf("<%s>", yytext); return DEFAULT;}

{integer}    	{printf("<INT, %s>", yytext); return NUM;}
{float}			{printf("<FLOAT, %s>", yytext); return DNUM;}
{id}			{printf("<ID, %s>", yytext); return ID;}

"="     		{printf("<ASSOP, %s>", yytext); return ASGN;}
"<="    		{printf("<RELOP, %s>", yytext); return LE;}
">="    		{printf("<RELOP, %s>", yytext); return GE;}
"=="    		{printf("<RELOP, %s>", yytext); return EQ;}
"!="    		{printf("<RELOP, %s>", yytext); return NE;}
">"				{printf("<RELOP, %s>", yytext); return GT;}
"<"				{printf("<RELOP, %s>", yytext); return LT;}
"||" 			{printf("<LOGICOP, %s>", yytext); return LOR;}
"&&"  			{printf("<LOGICOP, %s>", yytext); return LAND;}
"|" 			{printf("<BOOLOP, %s>", yytext); return BOR;}
"&"				{printf("<BOOLOP, %s>", yytext); return BAND;}
"^"				{printf("<BOOLOP, %s>", yytext); return BXOR;}
"++"			{printf("<INCOP, %s>", yytext); return INC;}
"--"			{printf("<INCOP, %s>", yytext); return DEC;}

[ \t]		;
[ \n]   	;
.       		return yytext[0];
%%
