% Paradigms

% Declarative

functional(python).
functional(haskell).
functional(erlang).
functional(ocaml).
functional(scilab).

logic(swiprolog).
logic(datalog).

query(mysql).
query(datalog).

% Imperative

object(python).
object(cpp).
object(r).
object(java).
object(javascript).
object(fortran).
object(ocaml).
object(scilab).

procedural(c).
procedural(r).
procedural(ada).
procedural(fortran).
procedural(scilab).

% Type System

% Untyped (TO-DO)

untyped(swiprolog).
untyped(assembler).
untyped(mysql).
untyped(datalog).

% Type checking

tdynamic(python).
tdynamic(r).
tdynamic(erlang).
tdynamic(javascript).
tdynamic(scilab).

tstatic(haskell).
tstatic(c).
tstatic(cpp).
tstatic(java).
tstatic(ada).
tstatic(fortran).
tstatic(ocaml).

% Type level

tstrong(python).
tstrong(haskell).
tstrong(erlang).
tstrong(java).
tstrong(ada).
tstrong(ocaml).

tweak(c).
tweak(cpp).
tweak(r).
tweak(javascript).
tweak(fortran).
tweak(scilab).

% Domain

generic(python).
generic(haskell).
generic(c).
generic(cpp).
generic(erlang).
generic(java).
generic(javascript).
generic(ada).
generic(fortran).
generic(ocaml).

specific(swi-prolog).
specific(mysql).
specific(r).
specific(scilab).
specific(datalog).

% Level

high(python).
high(haskell).
high(swi-prolog).
high(mysql).
high(r).
high(erlang).
high(javascript).
high(ada).
high(ocaml).
high(datalog).
high(scilab).

medium(c).
medium(cpp).
medium(java).
medium(fortran).

low(assembler).


typed(X) :- tstrong(X).
typed(X) :- tweak(X).

% untyped(X) :- not(typed(X)).

% pure function (Funcional solo)
% multiparadigm

% pure(X) :- 

declarative(X) :- functional(X).
declarative(X) :- logic(X).
declarative(X) :- query(X).

imperative(X) :- object(X).
imperative(X) :- procedural(X).

multiparadigm(X) :- imperative(X), declarative(X).
