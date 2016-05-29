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

Use generate and test as a first approach. Do not use a constraint logic 
programming library like clpfd here!

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
% select_unique(+VarList, +NumList) - helper function of man_bit_monkey to 
% select the distinct integers for all of the variables passed in
%
% +VarList - the list of variables that are being selected
% +NumList - the list of numbers 0..9
%%

% Base case: Both lists are empty
select_unique([], []).

% Recursive case: use the select() predicate to pick a number from the list,
% Then call select_unique again for the rest of the variables and numbers
select_unique([VH|VR], NumList) :-
    select(VH, NumList, NumListRem),
    select_unique(VR, NumListRem).

%%
% man_bit_monkey(+L1, +L2, +L3) - solves the above defined CLP logic puzzle
%
% +L1 - MAN
% +L2 - BIT
% +L3 - MONKEY
%%
man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E, Y]) :-
    select_unique([M, A, N, B, I, T, O, K, E, Y], 
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),
    M\=0, B\=0,
    Man is (M*100) + (A*10) + N,
    Bit is (B*100) + (I*10) + T,
    Monkey is (M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y,
    Monkey is Man * Bit.

% ?- time(man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E, Y])).
% 4,500,422 inferences, 0.934 CPU in 0.936 seconds (100% CPU, 4817845 Lips)
% M = 1,
% A = 3,
% N = 9,
% B = 7,
% I = 8,
% T = 6,
% O = 0,
% K = 2,
% E = 5,
% Y = 4 

%-------------------------------------------------------------------------------
% PART B

%%
% select_unique_i(+VarList, +NumList, +RemList) - helper function of
% man_bit_monkey_i to select the distinct integers for all of the variables
%
% +VarList - the list of variables that are being selected
% +NumList - the list of numbers 0..9
%%

% Base case: When we have run out of variables, pass the remainder of the list
% into the third variables
select_unique_i([], L, L).

% Recursive case: use the select() predicate to pick a number from the list,
% Then call select_unique_i again for the rest of the variables and numbers
select_unique_i([VH|VR], NumList, L) :-
    select(VH, NumList, NumListRem),
    select_unique_i(VR, NumListRem, L).

% man_bit_monkey_i(+L1, +L2, +L3) - solves the above defined CLP logic puzzle in 
% fewer inferences than the man_bit_monkey() predicate
%
% +L1 - MAN
% +L2 - BIT
% +L3 - MONKEY
%%
man_bit_monkey_i([M, A, N], [B, I, T], [M, O, N, K, E, Y]) :-
    % First picking M and B, and then including 0 for the rest of the selection
    % greatly reduces the number of inferences need (much less backtracking)
    select_unique_i([M, B], [1, 2, 3, 4, 5, 6, 7, 8, 9], L),
    append([0], L, L1),
    select_unique([A, N,I, T, O, K, E, Y], L1),
    % Putting all of the computation into one line reduces 
    % the number of inferences (slightly)
    0 is ( (M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y ) - 
        ((M*100) + (A*10) + N) * ((B*100) + (I*10) + T).

% ?- time(man_bit_monkey_i([M, A, N], [B, I, T], [M, O, N, K, E, Y])).
% 1,767,219 inferences, 0.720 CPU in 0.721 seconds (100% CPU, 2453580 Lips)
% M = 1,
% A = 3,
% N = 9,
% B = 7,
% I = 8,
% T = 6,
% O = 0,
% K = 2,
% E = 5,
% Y = 4
