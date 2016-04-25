% ziplist.pl - Prolog file for HW03, Task 2
% Defines a predicate that 'zips' two lists together into one 
%
% Author: T. Wilgenbusch, K. Hipkin, T, Fairman, B. Dell

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

L1 and L2 need not to be of equal length.
If 'zip_list' is called with uninstantiated L,
the elements of the longer list of L1 and L2 should be
all present in L.
This has effects to calls with L instantiated.
Which?

Examples:
   zip_list(L,[1,2,3],[a,b,c,d]).
       L=[1, a, 2, b, 3, c, d]
   zip_list(L,[1,2,3,4,5],[a,b,c]).
       L=[1, a, 2, b, 3, c, 4, 5]
   zip_list([1,2,1,2,1,2],[1,1,1],L).
       L=[2, 2, 2]


Hints:
Use two predicates which call each other alternately
if one of L1 or L2 is empty return the other
else add the element to L and call the other predicate

to see the problems with instantiated first argument try 

      zip_list([1,2,3,4,5],X,Y)

and discuss the result
*/