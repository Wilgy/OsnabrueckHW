% listuni.pl - Prolog file for HW02, Task 5
% A set of problems dealing with prolog list unification
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

% Example:
% 1.  [A,B,C]        -- [jerry,likes,fish]
%   A=jerry, B=likes, C=fish

test_unify(1,[A,B,C],[jerry,likes,fish]) :-
  A = jerry,
  B = likes,
  C = fish.

% Example:
% 2.  [a|b]         -- [a,b]
%   fail: b =/= [b]
test_unify(2, [a|b] ,[a,b]) :- fail.

% 3.  [cat]         -- [X|Y]

% 4.  [A,B|C]       -- [mary,[does,not,like],fish]

% 5.  [['I'|A]|B]   -- [[I,go],[by,bike]]

% 6.  [nice|A]      -- [nice,weekend]

% 7.  [lame,duck]   -- [duck,A]

% 8.  [lame|P]      -- [x|duck]

% 9. [Lame,Duck]    -- [lahme,ente]

% 10. [[[a,b],c],d] -- [A,B|C]

/*
Hint:
use the Prolog system to verify your tries
*/