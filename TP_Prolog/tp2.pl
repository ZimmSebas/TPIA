<<<<<<< HEAD
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


  
=======
% typing

ttyped(X) :- satIf(untyped, typed, X).
tuntyped(X) :- satIf(typed, untyped, X).

tdynamic(X) :- ttyped(X), si(staticTyped) -> false ; (no(staticTyped) -> true ; sat(dynamicTyped, X)).
tstatic(X) :- ttyped(X), si(dynamicTyped)-> false ; (no(dynamicTyped) -> true ; sat(staticTyped, X)).
tstrong(X) :- ttyped(X), si(weakTyped) -> false ; (no(weakTyped) -> true ; sat(strongTyped, X)).
tweak(X) :- ttyped(X), si(strongTyped) -> false ; (no(strongTyped) -> true; sat(weakTyped, X)).


% paradigm

pfunctional(X) :- sat(declarative, X), sat(functional, X).
plogic(X) :- sat(declarative, X), sat(logic, X).
pquery(X) :- sat(declarative, X), sat(query, X).

pobject(X) :- sat(imperative, X), sat(objectOriented, X).
pprocedural(X) :- sat(imperative, X), sat(procedural, X).

pure(X) :- pfunctional(X), noSat(imperative, X), noSat(logic, X), noSat(query, X).

% domain

dgeneric(X) :- si(specificDomain) -> false ; (no(specificDomain) -> true ; sat(genericDomain, X)).
dspecific(X) :- si(genericDomain) -> false ; (no(genericDomain) -> true ; sat(specificDomain, X)).


assembler(X) :- tuntyped(X), sat(low, X).
python(X) :- sat(high, X), ttyped(X), tstrong(X), tdynamic(X), pfunctional(X), pobject(X), sat(generic, X).
c(X) :- sat(medium, X), sat(tweak, X).
>>>>>>> bbe96144ed678c04ee8bddb5a8a50dbf4047e968
% hay que definir todos los lenguajes asi


:- dynamic si/1,no/1.
sat(Atributo,_) :- (si(Atributo) -> true ; ( no(Atributo) -> fail ; pregunta(Atributo))).

satIf(AtributoNO,AtributoSI,_) :- si(AtributoSI) -> true ; (no(AtributoSI) -> fail ; 
    (si(AtributoNO) -> fail ; (no(AtributoNO) -> true ; pregunta(AtributoSI)))).

noSat(Atributo,_) :- (si(Atributo) -> fail ; (no(Atributo) -> true ; preguntaNO(Atributo))).

pregunta(A) :- write('¿Are you looking for a language with the following property?: '), write(A), write(' '), nl, read(Resp), nl,
((Resp == s ; Resp == si ; Resp == sí) -> assert(si(A)); assert(no(A)), fail).
<<<<<<< HEAD
=======

preguntaNO(A) :- write('¿Are you looking for a language with the following property?: '), write(A), write(' '), nl, read(Resp), nl,
((Resp == s ; Resp == si ; Resp == sí) -> assert(si(A)), fail; assert(no(A))).

>>>>>>> bbe96144ed678c04ee8bddb5a8a50dbf4047e968

recomienda(assembler,X) :- assembler(X).
recomienda(python,X) :- python(X).
recomienda(c, X) :- c(X).
recomienda(haskell, X) :- haskell(X).
recomienda(cpp, X) :- cpp(X).
recomienda(mysql, X) :- mysql(X).
recomienda(java, X) :- java(X).
recomienda(ada, X) :- ada(X).
recomienda(fortran, X) :- fortran(X).
recomienda(erlang, X) :- erlang(X).
recomienda(scilab, X) :- scilab(X).
recomienda(javascript, X) :- javascript(X).
recomienda(r, X) :- r(X).
recomienda(datalog, X) :- datalog(X).
recomienda(swiprolog, X) :- swiprolog(X).
recomienda(ocaml, X) :- ocaml(X).


% hay que poner uno por cada lenguaje

recomienda(desconocido, _).

recomendar :- recomienda(Language,_), write('You can use the following languages: '), nl, write(Language), nl. 
% falta implementar un borraResp al final para poder hacer otra consulta despues, esta explicado en la consigna
% y queda asi recomendar :- recomienda(Language,_), write('You can use the following languages: '), write(Language), nl, borraResp. 
