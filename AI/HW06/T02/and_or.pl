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

%% Example:

%% visit(City) :-
%%		(poi(City,beach) v poi(City,mountain)) && ~poi(City, nuclear_power_plant).

% Operation definitions for the boolean operators
%-------------------------------------------------------------------------------
% The ~ (NOT) operator has low precedence and
% is of the prefix operator type.
:- op(400, fx, ~).

% The && (AND) operator has medium precedence and
% is of the left associative operator type.
:- op(500, yfx, &&).

% The v (OR) operator has high precedence and
% is of the left associative operator type.
:- op(600, yfx, v).
%-------------------------------------------------------------------------------

% Predicates for the boolean operators
%-------------------------------------------------------------------------------
%%
% ~ +X - maps to prolog's not operator; true if the expression is not provable.
%
% +X - the expression being tested
%%
~ X :- not(X).

%%
% +X && +Y - true if both X and Y are true
%
% +X - the first (left-side) expression being evaluated
% +Y - the second (right-side) expression being evaluated
%%
X && Y :- X, Y.

%%
% +X v +Y - true if X is true, otherwise if Y is true
%
% +X - the first (left-side) expression being evaluated
% +Y - the second (right-side) expression being evaluated
%%
X v Y :- X ; Y.
%-------------------------------------------------------------------------------

/*
Test queries:

	true && true && true && false. // false
	false v false v false v true. // true
	~ true. // false
	~ false. // true
	~ true && false. // false
	~ (true && false). // true

	display(x v y && ~ z). // v(x, &&(y, ~(z)))
	display(~ x && y v ~ z). // v(&&(~(x), y), ~(z))
	display(~ (x && y) v ~ z). // v(~(&&(x, y)), ~(z))
*/
