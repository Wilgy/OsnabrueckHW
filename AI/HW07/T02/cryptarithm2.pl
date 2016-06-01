% cryptarithm2.pl - File for HW07, T02
% Uses the clpfd library to solve a simple CLP logic puzzle
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
Solve this riddle:

[code]
 M A N *  B I T = M O N K E Y
[/code]

using the clpfd library.
*/

:- use_module(library(clpfd)).

%%
% man_bit_monkey(+L1, +L2, +L3) - solves the above defined CLP logic puzzle
% using the clpfd library
%
% +L1 - MAN
% +L2 - BIT
% +L3 - MONKEY
%%
man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E, Y]) :- 
    % Define the ranges for all variables.
    [M, B] ins 1..9,
    [A, N, I, T, O, K, E, Y] ins 0..9,
    % Ensure that they are all distinct.
    all_distinct([M, A, N, B, I, T, O, K, E, Y]),
    % Constraint that MAN * BIT = MONKEY.
    ((M*100) + (A*10) + N) * ((B*100) + (I*10) + T) #=
    ((M*100000) + (O*10000) + (N*1000) + (K*100) + (E*10) + Y),
    % Print out the values.
    label([M, A, N, B, I, T, O, K, E, Y]).

% ?- time(man_bit_monkey([M, A, N], [B, I, T], [M, O, N, K, E, Y])).
% 359,906 inferences, 0.062 CPU in 0.070 seconds (89% CPU, 5767687 Lips)
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
% 15,580,775 inferences, 2.122 CPU in 2.113 seconds (100% CPU, 7343833 Lips)
% false.
