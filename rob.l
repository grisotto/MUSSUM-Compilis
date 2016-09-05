%{

#include "node.h"
#include "bison.hpp"

extern void unescape(char *s);

%}

%option yylineno
%x COMMENT

%%

[ \t\n\r]				{ /* espaços */ }
"/*"					{ yymore(); BEGIN COMMENT; }
<COMMENT>[^*]			{ yymore(); }
<COMMENT>"*"/[^/]		{ yymore(); }
<COMMENT>"*/"			{ BEGIN(INITIAL); }

"//".*$					{ fprintf(stderr, "Comentario: %s\n", yytext); /* comentario de linha */}

"discrevis"					{ return(TOK_PRINT); }

"incasis"[0-9]+				{ yylval.port = strndup(yytext+2, yyleng-2);
						  return(TOK_IN);
						}

"macumbis"[0-9]+				{ yylval.port = strndup(yytext+3, yyleng-3);
						  return(TOK_OUT);
						}

"mundo_vai_girarzis"					{ return(TOK_DELAY); }
"que_isso_rapa"							{ return(TOK_IF); }
"que_azari_e_agora"						{ return(TOK_ELSE); }
"forevis"								{ return(TOK_WHILE); }
"a_ordem_dos_tratores_nao_altera_o_pao_duris"					{ return(EQ_OP); }
"sarava"									{ return(NE_OP); }
"<="							{ return(LE_OP); }
">="						{ return(GE_OP); }
">"							{ return(GT_OP); }
"<"							{ return(LT_OP); }
"and"						{ return(TOK_AND); }
"or"						{ return(TOK_OR); }

"suco_de_cevadiss"					{ return(TOK_BOTAO);}
"tombis_que_eu_levo"				{ return(TOK_ABAIXA); }
"quebra_um_gais"					{ return(TOK_LIGA_IMA); }
"negadis_hoje_e_sexta_feris"		{ return(TOK_LEVANTA); }
"pe_sem_cair"				   		 { return(TOK_SOBE); }
"pra_la"							{ return(TOK_DIREITA); }
"pra_ca"							{ return(TOK_ESQUERDA); }
"mais_meh"							{ return(TOK_MEH); }
	



"soma_na_contis"						{ return('+'); }

[a-zA-Z_][a-zA-Z0-9_]*	{ yylval.ident = strndup(yytext, yyleng); 
						  return(TOK_IDENT); }

"("						{ return('('); }
")"						{ return(')'); }
"{"						{ return('{'); }
"}"						{ return('}'); }

"ampola_do_diuretico"-?[0-9]+\.[0-9]+		{ yylval.nfloat = atof(yytext); 
						  return(TOK_FLOAT); }

"preto_inteiris "-?[0-9]+		 {yylval.nint = atoi(yytext+15);		
						  return(TOK_INTEIRO); }

"*"						{ return('*'); }
"/"						{ return('/'); }

"-"						{ return('-'); }
"="						{ return('='); }
";"						{ return(';'); }

\"([^\\\"]|\\.)*\"		{ yylval.str = strndup(yytext+1, yyleng-2);
						  unescape(yylval.str);
						  return(TOK_STRING); }

%%


