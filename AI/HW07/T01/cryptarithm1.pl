% cryptarithm1.pl - File for HW07, T01
% defines a predicate that solves a simple CLP logic puzzle
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*

(from http://www.contestcen.com/rithms.htm)

[code]
 M A N *  B I T = M O N K E Y
[/code]

                          ( M*100 + A*10 + N )
*                         ( B*100 + I*10 + T )
==============================================
M*100000 + O*10000 + N*1000 + K*100 + E*10 + Y

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

%%
% generate(+L) - bind each var in the list to a unique digit 0..9
%
% +L - the list of variables
%%
generate(L) :-
    select_unique(L, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

%%
% select_unique(+VarList, +DigitList) - bind each var in VarList to
% a distinct value from DigitList
%
% +VarList - the list of variables
% +DigitList - the list of unique numbers 0..9
%%

% Base case: Both lists are empty.
select_unique([], []).

% Recursive case: use the select() predicate to pick a digit from the list,
% Then call select_unique again for the rest of the variables and digits.
select_unique([L|LRest], Digits) :-
    select(L, Digits, DRest),
    select_unique(LRest, DRest).

%%
% test(+L) - test that the variable assignments in L adhere to the problem's constraints
%
% +L - the list of variables
%%
test([M, A, N, B, I, T, O, K, E, Y]) :-
    M \= 0,
    B \= 0,
    Man is (M*100) + (A*10) + N,
    Bit is (B*100) + (I*10) + T,
    Monkey is (M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y,
    Monkey is Man * Bit.

%%
% man_bit_monkey(+L1, +L2, +L3) - solves the above defined CLP logic puzzle
%
% +L1 - MAN
% +L2 - BIT
% +L3 - MONKEY
%%
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

%-------------------------------------------------------------------------------
% PART B

%%
% generate_i(+L) - bind each var in the list to a unique digit 0..9
% using fewer references than the generate(+L) predicate
%
% +L - the list of variables
%%
generate_i([M, A, N, B, I, T, O, K, E, Y]) :-
    % First picking M and B, and then including 0 for the rest of the selection
    % greatly reduces the number of inferences need (much less backtracking)
    select_unique_i([M, B], [1, 2, 3, 4, 5, 6, 7, 8, 9], L),
    append([0], L, L1),
    select_unique_i([A, N, I, T, O, K, E, Y], L1, []).

%%
% select_unique_i(+VarList, +DigitList, ?RemList) - bind distinct digits to
% all of the variables in VarList, leaving unused digits in RemList
%
% +VarList - the list of variables
% +DigitList - the list of unique numbers 0..9
% ?RemList - the list of digits not already used
%%

% Base case: When we run out of variables, pass the remainder of the list
% into the third variable.
select_unique_i([], L, L).

% Recursive case: use the select() predicate to pick a digit from the list,
% Then call select_unique_i again for the rest of the variables and digits.
select_unique_i([L|LRest], Digits, Rem) :-
    select(L, Digits, DRest),
    select_unique_i(LRest, DRest, Rem).

%%
% test_i(+L) - test that the variable assignments in L adhere to the problem's constraints
% using fewer references than the test(+L) predicate
%
% +L - the list of variables
%%
test_i([M, A, N, B, I, T, O, K, E, Y]) :-
    % Putting all of the computation on one line (slightly) reduces the number of inferences
    0 is ((M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y) -
        (((M*100) + (A*10) + N) * ((B*100) + (I*10) + T)).

% man_bit_monkey_i(+L1, +L2, +L3) - solves the above defined CLP logic puzzle using
% fewer inferences than the man_bit_monkey() predicate
%
% +L1 - MAN
% +L2 - BIT
% +L3 - MONKEY
%%
man_bit_monkey_i([M, A, N], [B, I, T], [M, O, N, K, E ,Y]) :-
    generate_i([M, A, N, B, I, T, O, K, E, Y]),
    test_i([M, A, N, B, I, T, O, K, E, Y]).

% ?- time(man_bit_monkey_i([M, A, N], [B, I, T], [M, O, N, K, E ,Y])).
% 1,983,856 inferences, 0.499 CPU in 0.495 seconds (101% CPU, 3974045 Lips)
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
% 24,593,249 inferences, 5.944 CPU in 5.959 seconds (100% CPU, 4137743 Lips)
% false.
