assembler(X) :- tuntyped(X), sat(low, X).
python(X) :- sat(high, X), pfunctional(X), pobject(X), dgeneric(X), tdynamic(X), tstrong(X).
c(x) :- sat(medium,X), tstatic(X), tweak(X), dgeneric(X), pprocedural(X).
haskell(X) :- sat(high, X), tstatic(X), tstrong(X), dgeneric(X), pure(X).
erlang(X) :- sat(high, X), tdynamic(X), tstrong(X), dgeneric(X), pfunctional(X).
ocaml(X) :- sat(high, X), tstatic(X), tstrong(X), dgeneric(X), pfunctional(X), pobject(X).
scilab(X) :- sat(high, X), tdynamic(X), tweak(X), dspecific(X), pfunctional(X), pobject(X), pprocedural(X).
swiprolog(X) :- sat(high, X), tuntyped(X), dspecific(X), plogic(X).
datalog(X) :- sat(high, X), tuntyped(X), dspecific(X), plogic(X), pquery(X).
mysql(X) :- sat(high, X), tuntyped(X), dspecific(X), pquery(X).
cpp(X) :- sat(medium, X), tstatic(X), tweak(X), dgeneric(X), pobject(X).
r(X) :- sat(high, X), tdynamic(X), tweak(X), dspecific(X), pobject(X), pprocedural(X).
java(X) :- sat(medium, X), tstatic(X), tstrong(X), dgeneric(X), pobject(X), pdeclarative(X).
javascript(X) :- sat(high, X), tdynamic(X), tweak(X), dgeneric(X), pobject(X).
ada(X) :- sat(high, X), tstatic(X), tstrong(X), dgeneric(X), pprocedural(X).
fortran(X) :- sat(medium, X), tstatic(X), tweak(X), dgeneric(X), pobject(X), pprocedural(X).


  
% hay que definir todos los lenguajes asi


:- dynamic si/1,no/1.
sat(Atributo,_) :- (si(Atributo) -> true ; ( no(Atributo) -> fail ; pregunta(Atributo))).

pregunta(A) :- write('¿Are you looking for a language with the following property?: '), write(A), write(' '), nl, read(Resp), nl,
((Resp == s ; Resp == si ; Resp == sí) -> assert(si(A)); assert(no(A)), fail).

recomienda(python,X) :- python(X).
recomienda(assembler,X) :- assembler(X).

% hay que poner uno por cada lenguaje

recomienda(_,noHay).

recomendar :- recomienda(Language,_), write('You can use the following languages: '), nl, write(Language), nl. 
% falta implementar un borraResp al final para poder hacer otra consulta despues, esta explicado en la consigna
% y queda asi recomendar :- recomienda(Language,_), write('You can use the following languages: '), write(Language), nl, borraResp. 
