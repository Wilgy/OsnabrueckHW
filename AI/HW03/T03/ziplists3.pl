% ziplists3.pl - Prolog file for HW03, Task 3
% Defines a predicate that checks the contents of two lists and compares
% them to the contents of a third in various ways
%
% Author: T. Wilgenbusch, K. Hipkin, T, Fairman, B. Dell

/*
Define a predicate:

   zip_lists3(L, L1, L2)

- L1 and L2 contain together all elements of L,
  but L1 (at least) three times as many as L2.
  (|L2|*3>=|L1|)

- the sequential order should be maintained

- every fourth element of L should be in L2
 

Examples:
   zip_lists3([1,2,3,4],[1,2,3],[4]).
     yes
   zip_lists3([1,2,3,4,5],[1,2,3,5],[4]).
     yes
   zip_lists3([1,2,3,4,5,6,7,8],[1,2,3,5,6,7],[4,8]).
     yes
   zip_lists3([],[],[]).
     yes

Order should be maintained!

   zip_lists3([1,2,3,4,5,6,7,8],[7,6,5,3,2,1],[4,8]).
     no

Try:
   zip_lists3(L,[1,2,3,4,5,6,7,8],[a,b]).
and
   zip_lists3(L,L1,L2).

Hint:
you have to consider all cases where the number
of elements of L cannot be divided by 4 without rest, too!
*/