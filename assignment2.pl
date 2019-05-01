
find_the_position(X,[X|_],1).
find_the_position(X,[_|List1],Z):-find_the_position(X,List1,F),Z is (F+1).

find_the_word(X,[X|_],1).
find_the_word(X,[_|L],T) :-find_the_word(X,L,T1), T is T1 + 1.


correspond(X,[X|_],Y,[Y|_]).
correspond(X,[Y|List1],Z,[T|List2]):-find_the_position(X,[Y|List1],N),find_the_word(Z,[T|List2],N).



interleave1([],[]).

interleave1([[A|B]],[A|B]).

interleave1([[A|B],C|D], [A|F]):-
	same_elements([[A|B],C|D], [A|F]),
	(
		B\=[]->
		append([C|D],[B],List),
		interleave1(List,F)
		;
		interleave1([C|D],F)
	).
interleave(A, B):-
	
	interleave1(A,B),same_length1(A).

same_length1([]).
same_length1([_A]).
same_length1([[A|B],C|D]):-
	same_length([A|B],C),
	same_length1([C|D]).

same_length([], []). 
same_length([_|Xs], [_|Ys]) :-
same_length(Xs, Ys).

same_elements([],[]).
same_elements([[]|Tail],L):-
	same_elements(Tail,L).
same_elements([[_A|B]|Tail], [_E|F]):-
	same_elements([B|Tail],F).





check(Var,Val):-
atom(Var),
number(Val).

partial_eval(Expr0, Var, Val, Expr):-
number(Expr0),
check(Var,Val),
Expr = Expr0.


partial_eval(Expr0, Var, Val, Expr):-
atom(Expr0),
check(Var,Val),
(Expr0=Var->
	Val=Expr
	;
	Expr0=Expr
).

partial_eval(Expr0+Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, Expr3),
	partial_eval(Expr1,Var, Val, Expr4),
	check(Var,Val),
	(number(Expr3),number(Expr4)->
		Expr2 is Expr3+Expr4
		;
		Expr2=Expr3+Expr4
		).


partial_eval(Expr0-Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, Expr3),
	partial_eval(Expr1,Var, Val, Expr4),
	check(Var,Val),
	(number(Expr3),number(Expr4)->
		Expr2 is Expr3-Expr4
		;
		Expr2=Expr3-Expr4
		).
partial_eval(Expr0*Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, Expr3),
	partial_eval(Expr1,Var, Val, Expr4),
	check(Var,Val),
	(number(Expr3),number(Expr4)->
		Expr2 is Expr3*Expr4
		;
		Expr2=Expr3*Expr4
		).
partial_eval(Expr0/Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, Expr3),
	partial_eval(Expr1,Var, Val, Expr4),
	check(Var,Val),
	(number(Expr3),number(Expr4)->
		Expr2 is Expr3E/xpr4
		;
		Expr2=Expr3/Expr4
		).
partial_eval(Expr0//Expr1, Var, Val, Expr2):-
	partial_eval(Expr0,Var, Val, Expr3),
	partial_eval(Expr1,Var, Val, Expr4),
	check(Var,Val),
	(number(Expr3),number(Expr4)->
		Expr2 is Expr3//Expr4
		;
		Expr2=Expr3//Expr4
		).