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

% ~ operator: (for 'not')
%		low precedence
%		prefix operator type
:- op(400,fx,~).
~ X :- not(X). % map ~ to prolog's not operator

% && operator: (for 'and')
%		medium precedence
%		left associative operator type
:- op(500,yfx,&&).
X && Y :- X, Y. % true if X and Y are true

% v operator: (for 'or')
%		high precedence
%		left associative operator type
:- op(600,yfx,v).
X v Y :- X ; Y. % true if X is true, otherwise if Y is true

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
