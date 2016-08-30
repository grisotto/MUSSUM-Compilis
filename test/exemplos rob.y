exemplos rob.y

| TOK_LIGA TOK_LED     { $$ = new OutPort("3", new Int16("255")); } 
     | TOK_PISCA TOK_LED    {
								Int16 alto = new Int16("10");
								Int16 zero = new Int16("0");
								Int16 delaydefault = new Int16("1000");
								Stmts comms = new Stmts(new OutPort("3", alto));
								comms->append(new Delay(delaydefault));
								comms->append(new OutPort("3", zero));
								comms->append(new Delay(delaydefault));
								comms->append(new OutPort("3", alto));
								comms->append(new Delay(delaydefault));
								$$ = comms;
							}

	 | TOK_VARIAS TOK_PISCA TOK_LED '(''TOK_INTEIRO ')'' {

								Variable i = new Variable("i", new Int16("0"));
								CmpOp log = new CmpOp(i, LT_OP, new Int16( $5 ));
								
								Stmts comms = new Stmts(new OutPort("3", alto));
								comms->append(new Delay(delaydefault));
								comms->append(new OutPort("3", zero));
								comms->append(new Delay(delaydefault));

								Variable i2 = new Variable("i",
									new BinaryOp(new Load("i"), '+', new Int16("1"))
								);
								comms->append(i2);



								While w = new While(log, comms);
								$$ = w;



							}

	 ;


$: make
$: ./robcmp medalha.txt > medalha.ll
$: llc-3.8 medalha.ll medalha.o -filetype=obj
$: clang -c /debug.c
$: clang medalha.o debug.o -o medalha -lncurses﻿

	abaixa;
	liga_ima;
	levanta;
	sobe;
	while(botao){
		print "CACIlDIS";
		direita;
		esquerda;
		}