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
% valid_nim_heap(?H) - true if the heap is a list of zero or more 'i's.
%
% ?H - the list
%%
valid_nim_heap([]).
valid_nim_heap([i|R]) :-
	valid_nim_heap(R).

%%
% valid_nim_state(?S) - true if the state is a list of zero or more valid heaps.
%
% ?S - the list
%%
valid_nim_state([]).
valid_nim_state([H|T]) :-
	valid_nim_heap(H),
	valid_nim_state(T).

%%
% take_from(+R1, ?R2) - given a list, produces another list that has one or
% more 'i' elements removed from the original list; This predicate is a helper
% for the 'move' predicate
%
% +R1 - the original list     (i.e. [i, i, i])
% ?R2 - the new, smaller list (i.e. [i, i] OR [i] OR [])
%%

% Base Case: R1 is one 'i' element shorter than R2
take_from([i|R], R).

% Recursive Case: R1 is more than one 'i' element shorter than R2
take_from([i|R1], R2) :-
	take_from(R1, R2).

%%
% move(?S1, ?S2) - true if S1 can be turned into S2 through a valid move
% in Nimmspiel
%
% ?S1 - the starting board state (i.e. the current state of the heaps)
% ?S2 - the ending board state after one valid board move
%%

% Recursive calls - For every heap that is on the board, we generate all
% possible 'sub-heaps' (i.e. remove one or more elements from that heap)
% and substitute each sub-heap for the original heap to generate
% all possible moves
move(S1, S2) :-
	% L1 is a heap in S1, and L2 is a heap in the same position of S2
	subst_element(L1, L2, S1, S2),
	% L2 is some sub-heap of L1
	take_from(L1, L2),
	% both S2 and S2 must be valid Nim states
	valid_nim_state(S1),
	valid_nim_state(S2).
