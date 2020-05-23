
% Sat functions:

:- dynamic si/1,no/1.
sat(Atributo,_) :- (si(Atributo) -> true ; ( no(Atributo) -> fail ; pregunta(Atributo))).

satIf(AtributoNO,AtributoSI,_) :- si(AtributoSI) -> true ; (no(AtributoSI) -> fail ; 
    (si(AtributoNO) -> fail ; (no(AtributoNO) -> true ; pregunta(AtributoSI)))).

pregunta(A) :- write('¿Are you looking for a language with the following property?: '), write(A), write(' '), nl, read(Resp), nl,
((Resp == s ; Resp == si ; Resp == sí) -> assert(si(A)); assert(no(A)), fail).


% Typing rules:

ttyped(X) :- satIf(untyped, typed, X).
tuntyped(X) :- satIf(typed, untyped, X).

tdynamic(X) :- ttyped(X), satIf(staticTyped, dynamicTyped, X).
tstatic(X) :- ttyped(X), satIf(dynamicTyped, staticTyped, X).
tstrong(X) :- ttyped(X), satIf(weaklyTyped, stronglyTyped, X).
tweak(X) :- ttyped(X), satIf(stronglyTyped, weaklyTyped, X).


% Level rules:

lhigh(X) :- (si(lowLevel) -> fail ; si(mediumLevel) -> fail ; (no(lowLevel), no(mediumLevel)) -> true ; sat(highLevel,X)). 
llow(X) :- (si(highLevel) -> fail ; si(mediumLevel) -> fail ; (no(highLevel), no(mediumLevel)) -> true ; sat(lowLevel,X)).
lmedium(X) :- (si(highLevel) -> fail ; si(lowLevel) -> fail ; (no(highLevel), no(lowLevel)) -> true ; sat(mediumLevel,X)). 


% Paradigm rules:

pfunctional(X) :- sat(declarative, X), sat(functional, X).
plogic(X) :- sat(declarative, X), sat(logic, X).
pquery(X) :- sat(declarative, X), sat(query, X).

pobject(X) :- sat(imperative, X), sat(objectOriented, X).
pprocedural(X) :- sat(imperative, X), sat(procedural, X).


% Domain rules:

dgeneric(X) :- satIf(specificDomain, genericDomain, X).
dspecific(X) :- satIf(genericDomain, specificDomain, X).


% Languages and properties in order:

assembler(X) :- tuntyped(X), llow(X).
swiprolog(X) :- lhigh(X), tuntyped(X), dspecific(X), plogic(X).
datalog(X) :- lhigh(X), tuntyped(X), dspecific(X), plogic(X), pquery(X).
mysql(X) :- lhigh(X), tuntyped(X), dspecific(X), pquery(X).
java(X) :- lmedium(X), tstatic(X), tstrong(X), dgeneric(X), pobject(X), pdeclarative(X).
fortran(X) :- lmedium(X), tstatic(X), tweak(X), dgeneric(X), pobject(X), pprocedural(X).
c(x) :- lmedium(X), tstatic(X), tweak(X), dgeneric(X), pprocedural(X).
cpp(X) :- lmedium(X), tstatic(X), tweak(X), dgeneric(X), pobject(X).
python(X) :- lhigh(X), dgeneric(X), tdynamic(X), tstrong(X), pfunctional(X), pobject(X).
erlang(X) :- lhigh(X),  dgeneric(X), tdynamic(X), tstrong(X), pfunctional(X).
javascript(X) :- lhigh(X), dgeneric(X), tdynamic(X), tweak(X), pobject(X).
ocaml(X) :- lhigh(X), dgeneric(X), tstatic(X), tstrong(X), pfunctional(X), pobject(X).
haskell(X) :- lhigh(X), dgeneric(X), tstatic(X), tstrong(X),  pfunctional(X).
ada(X) :- lhigh(X),  dgeneric(X), tstatic(X), tstrong(X), pprocedural(X).
scilab(X) :- lhigh(X), dspecific(X), tdynamic(X), tweak(X), pobject(X), pprocedural(X), pfunctional(X).
r(X) :- lhigh(X), dspecific(X), tdynamic(X), tweak(X), pobject(X), pprocedural(X).


% Recomend function:

recomienda(assembler,X) :- assembler(X).
recomienda(swiprolog, X) :- swiprolog(X).
recomienda(datalog, X) :- datalog(X).
recomienda(mysql, X) :- mysql(X).
recomienda(java, X) :- java(X).
recomienda(fortran, X) :- fortran(X).
recomienda(c, X) :- c(X).
recomienda(cpp, X) :- cpp(X).
recomienda(python,X) :- python(X).
recomienda(erlang, X) :- erlang(X).
recomienda(javascript, X) :- javascript(X).
recomienda(ocaml, X) :- ocaml(X).
recomienda(haskell, X) :- haskell(X).
recomienda(ada, X) :- ada(X).
recomienda(scilab, X) :- scilab(X).
recomienda(r, X) :- r(X).
recomienda(desconocido, _).


borraResp :- retractall(si(_)), retractall(no(_)).

recomendar :- recomienda(Language,_), write('You can use the following language: '), nl, write(Language), nl, borraResp. 


