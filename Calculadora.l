%option yylineno
%{
#include "Calculadora.tab.h"
%}
DIGITO [0-9]
ID [a-zA-Z][a-zA-Z0-9_]*
%%
{DIGITO}+("."{DIGITO}+)?   {yylval.real=atof(yytext); return(TKN_NUM);}
";"			{return(TKN_PTOCOMA);}
"+"     	{return(TKN_MAS);}
"-"     	{return(TKN_MENOS);}
"="     	{return(TKN_IGUAL);}
"*"     	{return(TKN_MULT);}
"/"    	 	{return(TKN_DIV);}
"("     	{return(TKN_PAA);}
")"     	{return(TKN_PAC);}
"cos"   	{return(TKN_COS);}
"sen"   	{return(TKN_SEN);}
"tan"   	{return(TKN_TAN);}
"^"     	{return(TKN_EXP);}
raiz    	{return(TKN_SQRT);}
modulo  	{return(TKN_MODULO);}
"imprimir" 	{return (TKN_IMPRIMIR);}
{ID}	{return(TKN_ID);}
\n  	{}
%%
