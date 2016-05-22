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

% Operator definitions to help define the 'syntax' of the pseudo-nl-sentences

%-------------------------------------------------------------------------------
% OPERATORS FOR DATABASE MANIPULATION AND VIEWING
%-------------------------------------------------------------------------------

%%
% The '??' operator ('queries') has the highest precedence in our 'language'.
%
% This operator is of the postfix operator type.
%%
:- op(700, xf, ??).

%%
% The '#' operator ('asserts') has the highest precedence in our 'language'
% (the same precedence as the ?? operator).
%
% This operator is of the prefix operator type.
%%
:- op(700, fx, #).

%-------------------------------------------------------------------------------
% OPERATORS FOR PSEUDO-NL-SENTENCES STRUCTURE
%-------------------------------------------------------------------------------

%%
% The 'from' operator has the lowest precedence in our 'language'.
% (Has lower precedence than 'to'.)
%
% This operator is of the prefix operator type.
%%
:- op(450, fx, from).

%%
% The 'her' operator has the lowest precedence in our 'language'.
% (Has lower precedence than 'visited'.)
%
% This operator is of the prefix operator type.
%%
:- op(450, fx, her).

%%
% The 'to' operator has medium-low precedence in our 'language'.
% (Has higher precedence than 'from' but lower precedence than 'traveled'.)
%
% This operator is of the non-associative operator type.
%%
:- op(475, xfx, to).

%%
% The 'visited' operator has medium precedence in our 'language'.
% (Has higher precedence than 'her' and lower precedence than 'where'.)
%
% This operator is of the non-associative operator type.
%%
:- op(500, xfx, visited).

%%
% The 'traveled' operator has medium precedence in our 'language'.
% (Has higher precedence than 'to' and 'from' and lower precedence than 'where'.)
%
% This operator is of the non-associative operator type.
%%
:- op(500, xfx, traveled).

%%
% The 'where' operator has high precedence in our 'language'.
% (Has higher precedence than both 'visited' and 'traveled' but
% lower precedence than any database manipulation/viewing operators.)
%
% This operator is of the non-associative operator type.
%%
:- op(600, xfx, where).

%-------------------------------------------------------------------------------
% OPERATOR PREDICATES
%
% NOTE: Most of the operators for our pseudo-nl-sentences do not need predicates
% because they only define a structure. The only exception is 'where'.
%-------------------------------------------------------------------------------

% Necessary to change the predicate definition while the code is running.
:- dynamic(facts/1).

%%
% +X where +Y - takes two facts and asserts them into our database
% using the 'facts' predicate, then prints each fact on its own line.
%
% +X - the first fact
% +Y - the second fact
%%
X where Y :-
    asserta(facts(X)),
    asserta(facts(Y)),
    display(X), nl,
    display(Y), nl.

%%
% # +X - adds facts to the database
%
% +X - the fact being asserted
%%
# X :- X.

%%
% +X ?? - queries the facts already in the database
%
% +X - the fact being queried
%%
X ?? :- facts(X).
%-------------------------------------------------------------------------------

% this line will be processed as if it were entered as a query:
:- # mary traveled from berlin to hamburg where she visited her brother.
