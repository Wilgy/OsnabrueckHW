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

%%
% count_index(+Index, +TotalList, +CurrentCount, -FinalCount) - counts the 
% number of times Index appears in TotalList
%
% +Index - the number(index) we are searching for
% +TotalList - the list being searched through
% +CurrentCount - the current count of Index (starts at 0)
% -FinalCount - the final number of times that Index appears in TotalList
%%

% Base case: Finish processing when the list is empty and copy final value
count_index(_Index, [], FinalCount, FinalCount).

% Recursive case 1: The Index matches the current element; increment the 
% counter and continue processing;
count_index(Index, [Index|Rest], CurrentCount, FinalCount) :- 
    NewCount is CurrentCount + 1,
    count_index(Index, Rest, NewCount, FinalCount).

% Recursive case 2: Case 1 failed and the element does not match the Index;
% Don't increment the counter and continue processing;
count_index(Index, [OtherElement|Rest], CurrentCount, FinalCount) :-
    OtherElement\=Index,
    count_index(Index, Rest, CurrentCount, FinalCount).

%%
% test_sequence(+Index, +List, +TotalList) - determines if TotalList is a 
% magic sequence of numbers
%
% +Index - the current index in the List that we are testing
% +List - the list that we are processing through
% +TotalList - the complete, unchanged list permutation
%%

% Base Case: we have processed through the entire List
test_sequence(_Index ,[], _TotalList).

% Recursive Case: Count the number of times that the current Index integer 
% appears in the TotalList; if that number matches X, then move onto the 
% next element in List;
test_sequence(Index, [X|Rest], TotalList) :-
    count_index(Index, TotalList, 0, X),
    NewIndex is Index + 1,
    test_sequence(NewIndex, Rest, TotalList).

%%
% permutation(+CurrentIndex, +List, -FinalList, +Size) - generates all possible 
% permutations of a list of size CurrentIndex, with values that range from 
% 0 to Size
%
% +CurrentIndex - the index of the list that we are currently filling (begins 
%   with N)
% +List - the list being created (starts as the empty list)
% -FinalList - the final list permutation generated
% +Size - the maximum range of the values that will be put into FinalList
%%

% Base Case: Finish creating the List and copy the value into FinalList
permutation(0, List, List, _S) :- !.

% Recursive Case: Create a value between 0 and Size, then append that value to 
% List;  Continue recursively until we have generated a list of the correct size
permutation(CurrentIndex, List, FinalList, Size) :-
    NextIndex is CurrentIndex - 1,
    between(0,Size,X),
    append([X], List, NewList),
    permutation(NextIndex, NewList, FinalList, Size).

%%
% magic_sequence(+N, -S) - main function that produces all "magic sequences" of 
% length N
%
% +N - The length of the lists being generated (0 or greater)
% -S - The magic sequences returned
%%
magic_sequence(N,Sequence) :-
    permutation(N, [], Sequence, N),
    test_sequence(0, Sequence, Sequence).