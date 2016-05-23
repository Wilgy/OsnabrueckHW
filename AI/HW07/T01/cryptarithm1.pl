% cryptarithm1.pl - File for HW07, T01
% defines a predicate that solves a simple CLP logic puzzle
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*

(from http://www.contestcen.com/rithms.htm)

[code]
 M A N *  B I T = M O N K E Y
[/code]

a) Define a predicate

   man_bit_monkey([M, A, N], [ B, I, T], [M, O, N, K, E ,Y])

that computes a solution (assigning the digits to the letters)
such that the this multiplication task is correct.

assume that different letters represent different digits and leading digits are not zero.

Use generate and test as a first approach. Do not use a constraint logic programming library like clpfd here!

Check the efficency with the predicate 'time'.

b) Try to define an improved program 'man_bit_monkey_i'.

Try to minimize the number of inferences,
but try to use principles, which may be applied to similar problems! 
Do not use special properties of this problem.
Do not use a constraint logic programming library like clpfd here!

Hint:
select(?X,+L,-L1) 
selects an element X from the list L and binds L1 to L whithout X. 
may be used to select a digit from a set of available digits
to solve the 'all different' condition.
*/