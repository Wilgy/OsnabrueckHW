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

%%
% subst_element(?E1, ?E2, +L1, ?L2) - given a list determine if the secondary 
% list can be produced by replacing the first occurrence of E2 with E1
%
% ?E1 - the element to be searched for in L1
% ?E2 - the element replacing E1 to produce L2
% +L1 - the original list being searched through
% ?L2 - the final produced list
%
% NOTE: This predicate was copied from Task 1 
%%

subst_element(E1, E2, L1, L2) :-
	append(A,[E1|B],L1),
	append(A,[E2|B],L2).

%%
% move(?S1, ?S2) - determines if S1 can be turned into S2 through a valid move 
% in Nimmspiel
%
% ?S1 - the starting board state (i.e. the current state of the heaps)
% ?S2 - the ending board state after one valid board move
%%

% Recursive calls - For every heap that is on the board, we generate all 
% possible 'sub-heaps' (i.e. we remove one element from one heap, then another)
% and call those the possible moves
move(S1, S2) :-
    % L1 is all the possible sub-lists of S1, and L2 is the sub-lists of S2
	subst_element(L1, L2, S1, S2),
	take_from(L1, L2).

%%
% take_from(+R1, ?R2) - given a list, produces another list that has one or 
% more 'i' elements removed from the original list; This predicate is a helper
% for the 'move' predicate
%
% +R1 - the original list     (i.e. [i, i, i])
% ?R2 - the new, smaller list (i.e. [i, i] OR [i] OR [])
%%

% Base Case: We remove one 'i' element and set R2 as the resulting list
take_from([i|R], R).

% Recursive Case: While R1 still has at least one element, keep removing 
% elements
take_from([i|R1], R2) :-
	take_from(R1, R2).
