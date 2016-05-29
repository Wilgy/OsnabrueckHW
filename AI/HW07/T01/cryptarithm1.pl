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

   man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E ,Y])

that computes a solution (assigning the digits to the letters)
such that this multiplication task is correct.

Assume that different letters represent different digits and leading digits are not zero.

Use generate and test as a first approach. Do not use a constraint logic programming library like clpfd here!

Check the efficiency with the predicate 'time'.

b) Try to define an improved program 'man_bit_monkey_i'.

Try to minimize the number of inferences,
but try to use principles which may be applied to similar problems!
Do not use special properties of this problem.
Do not use a constraint logic programming library like clpfd here!

Hint:
select(?X,+L,-L1)
selects an element X from the list L and binds L1 to L without X.
may be used to select a digit from a set of available digits
to solve the 'all different' condition.
*/

%-------------------------------------------------------------------------------
% PART A

generate(L) :-
    select_unique(L, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

select_unique([], []).
select_unique([L|LRest], Digits) :-
    select(D, Digits, DRest),
    L = D,
    select_unique(LRest, DRest).

%                           ( M*100 + A*10 + N )
% *                         ( B*100 + I*10 + T )
% ==============================================
% M*100000 + O*10000 + N*1000 + K*100 + E*10 + Y
test([M, A, N, B, I, T, O, K, E, Y]) :-
    M \= 0,
    B \= 0,
    Man is (M*100) + (A*10) + N,
    Bit is (B*100) + (I*10) + T,
    Monkey is (M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y,
    Monkey is Man * Bit.

man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E ,Y]) :-
    generate([M, A, N, B, I, T, O, K, E, Y]),
    test([M, A, N, B, I, T, O, K, E, Y]).

% ?- time(man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E ,Y])).
% % 4,983,458 inferences, 0.702 CPU in 0.704 seconds (100% CPU, 7098898 Lips)
% M = 1,
% A = 3,
% N = 9,
% B = 7,
% I = 8,
% T = 6,
% O = 0,
% K = 2,
% E = 5,
% Y = 4 ;
%
% % 43,115,730 inferences, 7.784 CPU in 7.800 seconds (100% CPU, 5538700 Lips)
% false.
