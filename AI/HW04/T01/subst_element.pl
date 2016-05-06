% subst_element.pl - File for HW04, T01
% defines a predicate that determines if an element of a list can be 
% substituted by replacing exactly one occurrence of it in another 
% list
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
define a predicate:

    subst_element(?E1,?E2,+L1,?L2)

which is true if E1 occurs in L1 and L2 is derived from
L1 by substituting ONE occurence of E1 by E2.


Example:

  ?- subst_element(c,1,[a,c,b,c,d],L2).
  L2=[a,1,b,c,d];
  L2=[a,c,b,1,d]
 
Example query: subst_element(c,1,[a,c,b,c,d],L2)
*/

%%
% subst_element(?E1, ?E2, +L1, ?L2) - given a list determine if the secondary 
% list can be produced by replacing the first occurrence of E2 with E1
%
% ?E1 - the element to be searched for in L1
% ?E2 - the element replacing E1 to produce L2
% +L1 - the original list being searched through
% ?L2 - the final produced list
%%

% Matches if, for an instance of E1 anywhere in L1, that instance is replaced by E2 to form L2.
subst_element(E1, E2, L1, L2) :-
	append(A,[E1|B],L1),
	append(A,[E2|B],L2).
