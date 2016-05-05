% binary_partitions.pl - File for HW04, T03
% defines a predicate that is true if a 'partition list' is a valid binary 
% partition list
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
In natural languages, compound of more than two terms have more than one possible interpretation.

Examples:
- blue sky law -> Law about the blue sky or a blue sky-law -> might be written as (blue (sky law)) or ((blue sky) law)
- red light district -> ((red light) district) or (red (light disctrict))
- left engine fuel pump -> ((left engine) (fuel pump)) or (left (engine (fuel pump)) or (left ((engine fuel) pump)) or ((left (engine fuel)) pump) or ((left engine) fuel) pump)
- left engine fuel pump engineer -> 14 possibilities
- left engine fuel pump engineer school -> 42 possibilities

All possibilities can be regarded as binary partitions of a list: At each level, the list has two elements.

Define a predicate binpart(?List, ?PartitionList) that is true if PartitionList is a valid binary partition of List. Used as a generator, binpart/2 will generate all possible binary partitions of a list.

Example:
?- binpart([blue,sky,law], L).
L = [[blue, sky], law];
L = [blue, [sky, law]];
false

*/

binpart(A, [B1, B2]) :-
	append(A1, A2, A),
	A1 \= [],
	A2 \= [],
	binhelper(A1, B1),
	binhelper(A2, B2).



binhelper([B], B) :- atom(B).
binhelper(A, [B1, B2]) :-
	append(A1, A2, A),
	A1 \= [],
	A2 \= [],
	binhelper(A1, B1),
	binhelper(A2, B2).

