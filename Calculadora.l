%option yylineno
%{
#include "calculadora_simple.tab.h"
%}
DIGITO [0-9]
ID [a-zA-Z][a-zA-Z0-9_]*
%%
{DIGITO}+("."{DIGITO}+)?   {yylval.real=atof(yytext); return(TKN_NUM);}
";"		{return(TKN_PTOCOMA);}
"+"     {return(TKN_MAS);}
"-"     {return(TKN_MENOS);}
"="     {return(TKN_IGUAL);}
{ID}	{return(TKN_ID);}
\n  	{}
%%
