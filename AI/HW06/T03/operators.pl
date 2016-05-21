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
% DATABASE MANIPULATION AND VIEWING
%-------------------------------------------------------------------------------

%%
% The '??' operator 'queries' has the highest precedence of our 'language';
%
% The expression being evaluated appears on the left of the functor
%%
:- op(700, yf, ??).

%%
% The '#' operator h
% Has the highest precedence in our 'language' (equal to the ??
% operator, meaning that # and ?? cannot be used at the same time); 
%
% The expression being evaluated appears on the right of the functor
%%
:- op(700, fy, #).
%-------------------------------------------------------------------------------
% PSEUDO-NL-SENTENCES STRUCTURE DEFINITIONS
%-------------------------------------------------------------------------------

%%
% The 'her' functor has less precedence than 'visited'; 
%
% The expression appears  at the right of the functor (i.e. 'brother')
%%
:- op(450, fx, her).

%%
% The 'visited' functor 
% Has higher precedence than 'her'; 
%
% The expression on the right is the person doing the visiting (i.e. 'she'), 
% the expression on the right is the person being visited (i.e. 'her brother');
%%
:- op(500, xfy, visited).

%-------------------------------------------------------------------------------

%%
% The 'where' functor 
% Has higher precedence than both 'visited' and 'traveled'; 
%
% The expression on the left is the 'traveled' fact being added and 
% the expression on the right is the 'visited' fact being added
%%
:- op(600, xfx, where). 
%-------------------------------------------------------------------------------

%%
% The 'from' functor 
% Has lower precedence than 'to'; 
%
% The expression is on the the right of the functor (i.e. 'berlin')
%%
:- op(450, fx, from).

%%
% The 'to' operator
% Has higher precedence than 'from', but lower precedence than 'traveled'
%
% The expression on the left original location (i.e 'from berlin') and 
% the expression on the right is the destination (i.e. 'hamburg') 
%%
:- op(475, xfx, to).

%%
% The 'traveled' operator
% Has higher precedence than 'to' and  'from'
%
% The expression on the right is the person traveling (i.e. 'mary') and 
% The expression on the left is the travel plan (i.e. 'from berlin to hamburg')
%%
:- op(500, xfy, traveled).
%-------------------------------------------------------------------------------

% Operator declarations (what the operators actually do);
% NOTE: The operators for our pseudo-nl-sentences do not need to be declared, 
% since they do not do anything other than define a structure that our 'facts' 
% database has (excluding 'where', which breaks up the facts)
%-------------------------------------------------------------------------------
%%
% +X where +Y - takes two facts and asserts them into our database, then 
% displays the new facts to the user, separated by new lines;
%
% +X - the first fact being asserted (i.e. 'traveled(...)')
% +Y - the second fact being asserted (i.e. 'visited(...)')
%%
X where Y :- 
    assert(facts(X)), 
    assert(facts(Y)), 
    display(X), nl, 
    display(Y), nl.

%%
% # +X where +Y - 'helper' function to assert two new facts
% 
% +X - the first fact being asserted (i.e. 'traveled(...)')
% +Y - the second fact being asserted (i.e. 'visited(...)')
%%
# X where Y :- where(X, Y).

%%
% +Action ?? - displays information about a fact that is already in our 
% database
%
% +Action - the fact being queried (i.e. 'Who visited her brother ??')
%%
Action ?? :- facts(Action).
%-------------------------------------------------------------------------------

% this line will be processed as if it were entered as a query:
:- # mary traveled from berlin to hamburg where she visited her brother.
