correspond(E1, [Head1|Tail1], E2, [Head2|Tail2]):-
correspond(E1, Tail1, E2, Tail2);
E1=Head1,E2=Head2.

interleave1([],[]).

interleave1([[A|B]],[A|B]).

interleave1([[A|B],C|D], [A|F]):-
	sameelements([[A|B],C|D], [A|F]),
	(
		B\=[]->
		append([C|D],[B],List),
		interleave1(List,F)
		;
		interleave1([C|D],F)
	).
interleave(A, B):-
	
	interleave1(A,B),samelength1(A).

samelength1([]).
samelength1([_A]).
samelength1([[A|B],C|D]):-
	samelength([A|B],C),
	samelength1([C|D]).

samelength([], []). 
samelength([_|Xs], [_|Ys]) :-
samelength(Xs, Ys).

countnumber([],0).
	countnumber([A|B],N):-
	length(A,M),
	countnumber(B,O),
	N is O+M.

sameelements([],[]).
sameelements([[]|Tail],L):-
	sameelements(Tail,L).
sameelements([[_A|B]|Tail], [_E|F]):-
	sameelements([B|Tail],F).
	
checkvarval(Var,Val):-
atom(Var),
number(Val).

partial_eval(Expr0, Var, Val, Expr):-
number(Expr0),
checkvarval(Var,Val),
Expr = Expr0.


partial_eval(Expr0, Var, Val, Expr):-
atom(Expr0),
checkvarval(Var,Val),
(Expr0=Var->
	Val=Expr
	;
	Expr0=Expr
).

partial_eval(Expr0+Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, NewExpr0),
	partial_eval(Expr1,Var, Val, NewExpr1),
	checkvarval(Var,Val),
	(number(NewExpr0),number(NewExpr1)->
		Expr2 is NewExpr0+NewExpr1
		;
		Expr2=NewExpr0+NewExpr1
		).


partial_eval(Expr0-Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, NewExpr0),
	partial_eval(Expr1,Var, Val, NewExpr1),
	checkvarval(Var,Val),
	(number(NewExpr0),number(NewExpr1)->
		Expr2 is NewExpr0-NewExpr1
		;
		Expr2=NewExpr0-NewExpr1
		).
partial_eval(Expr0*Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, NewExpr0),
	partial_eval(Expr1,Var, Val, NewExpr1),
	checkvarval(Var,Val),
	(number(NewExpr0),number(NewExpr1)->
		Expr2 is NewExpr0*NewExpr1
		;
		Expr2=NewExpr0*NewExpr1
		).
partial_eval(Expr0/Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, NewExpr0),
	partial_eval(Expr1,Var, Val, NewExpr1),
	checkvarval(Var,Val),
	(number(NewExpr0),number(NewExpr1)->
		Expr2 is NewExpr0/NewExpr1
		;
		Expr2=NewExpr0/NewExpr1
		).
partial_eval(Expr0//Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, NewExpr0),
	partial_eval(Expr1,Var, Val, NewExpr1),
	checkvarval(Var,Val),
	(number(NewExpr0),number(NewExpr1)->
		Expr2 is NewExpr0//NewExpr1
		;
		Expr2=NewExpr0//NewExpr1
		).

