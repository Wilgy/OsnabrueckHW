% and_or.pl - File for HW06, T02
% defines several boolean logic operators in prolog
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

%% Define the operators:
%%		~ (for 'not', low precedence)
%%		&& (for 'and', medium precedence)
%%		v (for 'or', high precedence)
%% so that they can be used for prolog queries and clauses.
%% Parentheses for overriding precedence should work!


% Operation definitions for the boolean operators
%-------------------------------------------------------------------------------
% The NOT operator has the lowest precedence;  The functor comes before the 
% variable/expression being evaluated
:- op(100, fx, ~).

% The AND operator has higher precedence than NOT, but less than OR; The 
% expressions being evaluated are on the left and right of the functor
:- op(200, xfx, &&).

% The OR operator has the highest precedence; The expressions being evaluated 
% are on the left and right of the functor
:- op(300, xfx, v).
%-------------------------------------------------------------------------------


% Operator declarations (what the operators actually do)
%-------------------------------------------------------------------------------
%%
% ~ +X - predicate will evaluate to true if the expression being evaluated 
% cannot be proven true
%
% +X - the expression being 'negated'
%%
~ X:- not(X).
%%
% +X1 && +X2 - predicate will evaluate to true when both X1 and X2 are true
%
% +X1 - the first (left-side) expression being evaluated
% +X2 - the second (right-side) expression being evaluated
%%
X1 && X2 :- X1, X2.

%%
% +X1 v +X2 - predicate will evaluate to true when either X1 is true or X2 is 
% true (or both are true)
%
% +X1 - the first (left-side) expression being evaluated
% +X2 - the second (right-side) expression being evaluated
%%
X1 v X2 :- X1; X2.
%-------------------------------------------------------------------------------
