% operators.pl - File for HW06, T03
% Defines operators and predicates # and ?? such that several pseudo-nl-sentences
% can be read and processed
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
Define operators and the predicate # and ?? such that

- the following input can be read by prolog without an error message:
    -- # mary traveled from berlin to hamburg where she visited her brother.

- at the prolog command line, prolog will perform the following action:
    -- print the terms (one per line):
            traveled(mary, to(from(berlin), hamburg))
            visited(she, her(brother))
    -- add the above two facts into the prolog knowledge base
       as clauses for a predicate 'facts'

?- # mary traveled from berlin to hamburg where she visited her brother.

define an operator ?? such that 

?- Who traveled from Pos1 to Pos2 ?? .
gives the answer:
Who = mary
Pos1 = berlin
Pos2 = hamburg

and
?- Who visited her brother ?? .
gives the answer:
Who = she
*/

:- op(700, yf, ??).
:- op(700, fy, #).


:- op(450, fx, her).
:- op(500, xfy, visited).

:- op(600, xfx, where).

:- op(450, fx, from).
:- op(475, xfx, to).
:- op(500, xfy, traveled).

X where Y :- 
    assert(facts(X)), 
    assert(facts(Y)), 
    display(X), nl, 
    display(Y), nl.

# X where Y :- where(X, Y).

Action ?? :- facts(Action).

%% SomeOne traveled SomeWhere :- 
%%     SomeOne, 
%%     SomeWhere.

%% FromSomeWhere to SomePlace :- 
%%     FromSomeWhere, 
%%     SomePlace.

%% from SomePlace :- SomePlace.


%% SomeOne visited SomeOneElse :- 
%%     SomeOne, 
%%     SomeOneElse.

%% her Relative :- Relative.

% this line will be processed as if it were entered as a query:
:- # mary traveled from berlin to hamburg where she visited her brother.

% now the above queries should be processed correctly
