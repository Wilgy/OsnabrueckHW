% binary_partitions.pl - File for HW04, T03
% defines a predicate that is true if a 'partition list' is a valid binary 
% partition list
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
In natural languages, compound of more than two terms have more than one 
possible interpretation.

Examples:
- blue sky law -> Law about the blue sky or a blue sky-law -> might be written 
  as (blue (sky law)) or ((blue sky) law)
- red light district -> ((red light) district) or (red (light disctrict))
- left engine fuel pump -> ((left engine) (fuel pump)) or 
  (left (engine (fuel pump)) or (left ((engine fuel) pump)) or 
  ((left (engine fuel)) pump) or ((left engine) fuel) pump)
- left engine fuel pump engineer -> 14 possibilities
- left engine fuel pump engineer school -> 42 possibilities

All possibilities can be regarded as binary partitions of a list: At each 
level, the list has two elements.

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
% binpart(+List, ?PartitionList) - predicate that generates valid binary 
% partitions of a natural language 'flat' input list
%
% +List - the natural language list to be parsed
% ?PartitionList - the resulting partition list(s)
%%

% Recursive Calls: start the initial partition and then call the binhelper to 
% handle the repeating recursive calls; this allows for distinct solutions
binpart(List, [PList1, PList2]) :-
    % Generate two sub-lists of List
	append(SubList1, SubList2, List),
	
    %Both SubList1 and SubList2 should have at least one element
    SubList1 \= [],
	SubList2 \= [],

    % Recursively break up the sub-lists and put the two results in 
    % the resulting partition list (keeping the order the same)
	binhelper(SubList1, PList1),
	binhelper(SubList2, PList2).

%%
% binhelper(+List, ?PartitionList) - helper function for binpart
%
% +List - the list to partition
% ?PartitionList - the resulting partition list
%%

% Base Case: Stop partitioning when the element is a single, 'atomic' value
binhelper([PListElem], PListElem) :- atomic(PListElem).

% Recursive Case: Break the original list into further sub-lists
binhelper(List, [PList1, PList2]) :-
	append(SubList1, SubList2, List),
	SubList1 \= [],
	SubList2 \= [],
	binhelper(SubList1, PList1),
	binhelper(SubList2, PList2).

