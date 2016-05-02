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
subst_element(..)...