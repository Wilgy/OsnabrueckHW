% simpleworld.pl - Prolog File for HW02, Task 1
% Creates a representation of the Towers of Hanoi problem as well as rules
% to solve the problem
%
% Author: T. Wilgenbusch, K. Hipkin, T, Fairman, B. Dell

%-------------------------------------------------------------------
% 1. describe the following situation of the towers of Hanoi game
%    in logic
%
%          I                     I                    I
%          I                     I                    I
%        +---+                   I                +-------+
%        | d |                   I                |   c   |
%  +----------------+            I              +-----------+
%  |       a        |            I              |     b     |
% ==================================================================
%         rod1                  rod2                 rod3
%
% use relative positions like
%       a is on rod1
%       d is on a
%       top of d is clear
% etc.
% since the size of the disks matters it must be represented, too.
%
% hints: 
% - use the identifiers from the diagram (a, b, c, d, rod1, rod2, rod3)
% - use as size of disks: a:4, b:3, c:2, d:1
% - use predicate names: 
%     is_on(A,B)       meaning A is on B
%     clear_top(A)     meaning top of A is clear
%     and size_of(A,S) meaning size of A is S
% - avoid blanks between predicate name and open parenthesis
% - terminate statements by a dot  
% - assume implicit universal quantification for variables
% - use upper case symbols for variables (Prolog style variables)
% - use < or > to compare numbers (like in X < 6 or X > Y)
%

% 2. specify a predicate is_above(A,B) which is true
%    if A is on B or if A is on C and C is above B, etc.
%

% 3. specify a predicate move(A,B,C) which is true
%    if the top of A is clear
%       the top of C is clear
%       A is on B
%       and the size of C is bigger than size of A
%    A is a disk,
%    B maybe a disk or a rod
%    C maybe a disk or a rod
%
%-------------------------------------------------------------------

% your solution goes here:




% use this 'predicate' to print all legal moves
% do not change this!

print_all_moves :-
  forall(move(A,B,C), writeln(move(A,B,C))),
  forall(is_above(A,B), writeln(is_above(A,B))).