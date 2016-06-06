% magic_sequences.pl - file for HW08, T01
% defines a predicate that determines if a given sequence is a "magic"
% sequence
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell


%-------------------------------------------------
% Define a predicate
%      magic_sequence(+N,-Sequence)
% which constructs a magic sequence of length N
%
% a magic sequence is a sequence of integers
%    S = [x0, x1, ..., xn-1]
% such that xi = |{j : xj = i}|
% (the value at position i is the number of occurrences
%  of i in the whole sequence)
%
% The following sequence is magic:
%    [2,1,2,0,0]
% since we have 
%     2 times a 0
%     1 time  a 1
%     2 times a 2
%     0 times a 3
%     0 times a 4 
%
% compute all magic sequences of length N
%
% Hints:
% - implement a generate and test approach
% - try to optimize it by using properties of
%   magic sequences as additional constraints
%   e.g. xi =< N-i (there much stronger constraints)
% - you can use length(-S,+N) to construct
%   a list of length N with N free variables
%   as elements
%-------------------------------------------------

doit :-
   between(0,8,N),
   magic_sequence(N,S),
   writeln(N:S),
   fail.

doit.

%-------------------------------------------------
% magic sequence of length N
% magic_sequence(+N,-Sequence)

magic_sequence(N,S) :-
   ...