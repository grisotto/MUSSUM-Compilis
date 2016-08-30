%{
#include "node.h"

Int16 *delaycompleto = new Int16(1500);
Int16 *delaymeio = new Int16(750);
Int16 *zero = new Int16(0);

class Node;
class Stmts;
%}

%token TOK_IDENT TOK_IN TOK_OUT TOK_FLOAT TOK_INTEIRO TOK_PRINT TOK_DELAY 
%token TOK_IF TOK_ELSE TOK_WHILE
%token EQ_OP NE_OP LT_OP GT_OP LE_OP GE_OP TOK_AND TOK_OR
%token TOK_STRING TOK_ABAIXA TOK_LEVANTA TOK_SOBE TOK_DIREITA TOK_ESQUERDA TOK_LIGA_IMA
%token TOK_BOTAO

%union {
	char *port;
	char *ident;
	char *str;
	int nint;
	float nfloat;
	Node *node;
	Stmts *stmt;
}

%type <node> term expr factor stmt condblock elseblock whileblock logicexpr logicterm logicfactor TOK_AND TOK_OR printstmt
%type <stmt> stmts
%type <port> TOK_OUT TOK_IN
%type <nint> TOK_INTEIRO
%type <nfloat> TOK_FLOAT
%type <ident> TOK_IDENT
%type <str> TOK_STRING

%nonassoc IFX
%nonassoc TOK_ELSE
%start programa

%%

programa : stmts    { Program p;
                      p.generate($1); }
		 ;

stmts : stmts stmt			{ $$->append($2); }
	  | stmt				{ $$ = new Stmts($1); }
	  ;

stmt : TOK_OUT '=' expr ';'				{ $$ = new OutPort($1, $3); } 
	 | TOK_IDENT '=' expr ';'			{ $$ = new Variable($1, $3); }
	 | TOK_DELAY expr';'					{ $$ = new Delay($2); }
	 | condblock						{ $$ = new Capsule($1); }
	 | whileblock						{ $$ = new Capsule($1); }
	 | printstmt ';'						{ $$ = $1; }
	 | TOK_ABAIXA ';'					{
		 									Int16 *abaixa = new Int16(10);
		 								    
		 									Stmts *comms = new Stmts(new OutPort("3", abaixa));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("3", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
		 								}

	 | TOK_LEVANTA	';'					{

		 									Int16 *alto = new Int16(10);

		 									  
		 									Stmts *comms = new Stmts(new OutPort("3", alto));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("3", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
		 								}
	 | TOK_SOBE	 ';'					{
	 										Int16 *levanta = new Int16(10);
	 										  
		 									Stmts *comms = new Stmts(new OutPort("4", levanta));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("4", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
	 									}
	 | TOK_DIREITA	';'					{
	 										Int16 *direita = new Int16(100);
	 										  
		 									Stmts *comms = new Stmts(new OutPort("1", direita));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("1", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
	 									}
	 | TOK_ESQUERDA	';'					{
	 										Int16 *esquerda = new Int16(100);
	 										  
		 									Stmts *comms = new Stmts(new OutPort("1", esquerda));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("1", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
	 									}

	 | TOK_LIGA_IMA	';' 				{
	 										Int16 *liga = new Int16(255);
	 										  
		 									Stmts *comms = new Stmts(new OutPort("5", liga));
											comms->append(new Delay(delaycompleto));
											comms->append(new OutPort("5", zero));
											comms->append(new Delay(delaycompleto));

											$$ = comms;
	 									}
	 

condblock : TOK_IF '(' logicexpr ')' stmt %prec IFX				{ $$ = new If($3, $5, NULL); }
		  | TOK_IF '(' logicexpr ')' stmt elseblock				{ $$ = new If($3, $5, $6); }
		  | TOK_IF '(' logicexpr ')' '{' stmts '}' %prec IFX		{ $$ = new If($3, $6, NULL); }
		  | TOK_IF '(' logicexpr ')' '{' stmts '}' elseblock		{ $$ = new If($3, $6, $8); }
		  ;

elseblock : TOK_ELSE stmt				{ $$ = $2; }
		  | TOK_ELSE '{' stmts '}'		{ $$ = $3; }
		  ;

whileblock : TOK_WHILE '(' logicexpr ')' '{' stmts '}' { $$ = new While($3, $6); }
		   ;

logicexpr : logicexpr TOK_OR logicterm		{  }
		  | logicterm						{ $$ = new Capsule($1); }
		  ;

logicterm : logicterm TOK_AND logicfactor	{  }
		  | logicfactor						{ $$ = new Capsule($1); }
		  ;

logicfactor : '(' logicexpr ')'		{ $$ = new Capsule($2); }
			| expr EQ_OP expr		{ $$ = new CmpOp($1, EQ_OP, $3); }
			| expr NE_OP expr		{ $$ = new CmpOp($1, NE_OP, $3); }
			| expr LE_OP expr		{ $$ = new CmpOp($1, LE_OP, $3); }
			| expr GE_OP expr		{ $$ = new CmpOp($1, GE_OP, $3); }
			| expr LT_OP expr		{ $$ = new CmpOp($1, LT_OP, $3); }
			| expr GT_OP expr		{ $$ = new CmpOp($1, GT_OP, $3); }
			| TOK_BOTAO 						{
	 										
	 										CmpOp* apertou = new CmpOp(new InPort("2"), EQ_OP, new Int16(0));

	 										//Int16 *delaydefault = new Int16(10);

		//									Stmts *comms = new Stmts(new Delay(delaydefault));
		
		//									While *w = new While(apertou, comms);
											$$ = apertou;

	 										
	 									}
			;

expr : expr '+' term			{ $$ = new BinaryOp($1, '+', $3); }
	 | expr '-' term			{ $$ = new BinaryOp($1, '-', $3); }
	 | term					{ $$ = $1; }
	 ;

term : term '*' factor		{ $$ = new BinaryOp($1, '*', $3); }
	 | term '/' factor		{ $$ = new BinaryOp($1, '/', $3); }
	 | factor				{ $$ = $1; }
	 ;

factor : '(' expr ')'		{ $$ = $2; }
	   | TOK_IDENT			{ $$ = new Load($1); }
	   | TOK_INTEIRO		{ $$ = new Int16($1); }
	   | TOK_FLOAT			{ $$ = new Float($1); }
	   | TOK_IN				{ $$ = new InPort($1); }
	   ;

printstmt : TOK_PRINT TOK_STRING		{ $$ = new Print(new String($2)); }
		  | TOK_PRINT expr				{ $$ = new Print($2); }
%%

extern int yylineno;
extern char *yytext;
extern char *build_filename;

void yyerror(const char *s)
{
	fprintf(stderr, "%s:%d: error: %s %s\n", 
		build_filename, yylineno, s, yytext);
	exit(1);
}

extern "C" int yywrap() {
	return 1;
}

