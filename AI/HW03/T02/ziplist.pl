% ziplist.pl - Prolog file for HW03, Task 2
% Defines a predicate that 'zips' two lists together into one 
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
Define a predicate:

   zip_list(L,L1,L2)

L is a list containing all elements from L1 and L2.
The first element of L should be the first of L1 ,
the second of L should be the first of L2,
the third of L should be the second of L1,
etc.
Example:
   zip_list(L,[1,2,3],[a,b,c]).
       L=[1, a, 2, b, 3, c]

L1 and L2 need not be of equal length.
If 'zip_list' is called with uninstantiated L,
the elements of the longer list of L1 and L2 should all be present in L.
This affects calls with L instantiated.
Which?

Examples:
   zip_list(L,[1,2,3],[a,b,c,d]).
       L=[1, a, 2, b, 3, c, d]
   zip_list(L,[1,2,3,4,5],[a,b,c]).
       L=[1, a, 2, b, 3, c, 4, 5]
   zip_list([1,2,1,2,1,2],[1,1,1],L).
       L=[2, 2, 2]


Hints:
Use two predicates which call each other alternately.
If one of L1 or L2 is empty, return the other.
Else add the element to L and call the other predicate.

To see the problems with instantiated first argument, try:

      zip_list([1,2,3,4,5],X,Y)

and discuss the result
*/

%%
% zip_list(-L, +L1, +L2) - given to lists, 'zips' the contents of both lists 
% and put the result in a final list
%
% -L : The resulting zip list
% +L1 : The first list
% +L2 : The second list
%%
zip_list(L, L1, L2 ) :-
    zip_list_left(L, L1, L2). %Start with the first element of the first list

% Base case, if L2 is empty, put the rest of L1 into the result list and end
zip_list_left(L, L, []).

% The recursive call that grabs the first element of L1, places it at the head 
% of the return list and then calls zip_list_right
zip_list_left([H1|R],  [H1|R1], L2) :-
    zip_list_right(R, R1, L2).

% Base case, if L1 is empty, put the rest of L2 into the result list end end
zip_list_right(L, [], L).

% The recursive call that grabs the first element of L2, places it at the head 
% of the return list and then calls zip_list_right
zip_list_right([H2|R], L1, [H2|R2]) :-
    zip_list_left(R, L1, R2).
