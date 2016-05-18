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
