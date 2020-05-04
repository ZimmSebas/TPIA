assembler(X) :- sat(low, X), sat(untyped, X).
python(X) :- sat(functional,X), sat(object,X), sat(tdynamic,X), sat(tstrong,X), sat(generic, python), sat(high,python).
% hay que definir todos los lenguajes asi


:- dynamic si/1,no/1.
sat(Atributo,_) :- (si(Atributo) -> true ; ( no(Atributo) -> fail ; pregunta(Atributo))).

pregunta(A) :- write('¿Are you looking for a language with the following property?: '), write(A), write(' '), nl, read(Resp), nl,
((Resp == s ; Resp == si ; Resp == sí) -> assert(si(A)); assert(no(A))), fail.

recomienda(python,X) :- python(X).
recomienda(assembler,X) :- assembler(X).

% hay que poner uno por cada lenguaje

recomienda(_,noHay).

recomendar :- recomienda(Language,_), write('You can use the following languages: '), nl, write(Language), nl. 
% falta implementar un borraResp al final para poder hacer otra consulta despues, esta explicado en la consigna
% y queda asi recomendar :- recomienda(Language,_), write('You can use the following languages: '), write(Language), nl, borraResp. 
