% nimm_game.pl - File for HW04, T02
% defines a predicate that is true if a change from S1 to S2 being made
% is a valid move in Nimmspiel
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
define a predicate:

    move(S1,S2)

which is true, if the change from S1 to S2 is a correct move
for the 'Nimmspiel':

There are heaps of matches, e.g.:

     iiiii iiii iii ii i

Each player selects a heap and removes at least one match.
The one who must take the last match wins.

Hint: represent the state as a list of lists containing the
a symbol 'i' for each match.

Hint: you may use 'subst_element'
*/
subst_element(E1, E2, [E1|R1], [E2|R1]).

subst_element(E1, E2, [H|R1], [H|R2]) :-
	subst_element(E1, E2, R1, R2).


move(S1, S2) :-
	subst_element(L1, L2, S1, S2),
	take_from(L1, L2).

take_from([i|R], R).
take_from([i|R1], R2) :-
	take_from(R1, R2).
