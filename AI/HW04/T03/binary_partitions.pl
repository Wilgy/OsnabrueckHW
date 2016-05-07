% binary_partitions.pl - File for HW04, T03
% defines a predicate that is true if a 'partition list' is a valid binary 
% partition list
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
In natural languages, compound of more than two terms have more than one 
possible interpretation.

Examples:
- blue sky law ->
	Law about the blue sky or a blue sky-law ->
    might be written as (blue (sky law)) or ((blue sky) law)
- red light district ->
	((red light) district) or (red (light district))
- left engine fuel pump ->
	((left engine) (fuel pump)) or (left (engine (fuel pump)) or
    (left ((engine fuel) pump)) or ((left (engine fuel)) pump) or
    ((left engine) fuel) pump)
- left engine fuel pump engineer -> 14 possibilities
- left engine fuel pump engineer school -> 42 possibilities

All possibilities can be regarded as binary partitions of a list:
At each level, the list has two elements.

Define a predicate binpart(?List, ?PartitionList) that is true if PartitionList
is a valid binary partition of List. Used as a generator, binpart/2 will
generate all possible binary partitions of a list.

Example:
?- binpart([blue,sky,law], L).
L = [[blue, sky], law];
L = [blue, [sky, law]];
false

*/

%%
% binpart(+List, ?PartitionList) - predicate that verifies/generates
% valid binary partitions of a natural language 'flat' input list
%
% +List - the natural language list to be parsed
% ?PartitionList - a valid binary partition of the list
%%

% Base Case:
%	Binary partition of a list with exactly 2 elements is that same list.
binpart([E1, E2], [E1, E2]).

% Recursive Option 1:
%	Leave first element at top level, recurse with the rest.
binpart([H|T], [H|[RT]]) :- binpart(T, RT).

% Recursive Option 2:
%	Divide the list into two parts (with at least 2 elements in each part)
% 	and recurse with both parts.
binpart(L, RL) :-
    append([A1,A2|AT], [B1,B2|BT], L),	% break input list into two parts
    binpart([A1,A2|AT], RA),			% recurse with first part
    binpart([B1,B2|BT], RB),			% recurse with second part
    append([RA], [RB], RL).				% recombine with each part nested

% Recursive Option 3:
%	Recurse with all but last element, leave last element at top level.
binpart(L, RL) :-
    append(A, [E|[]], L),
    binpart(A, RA),
    append([RA], [E], RL).
