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
% 3.  [cat | []]    -- [X | Y]
%   X=cat, Y=[]
test_unify(3, [cat], [X|Y]) :-
    X = cat,
    Y = [].

% 4.  [A,B|C]       -- [mary,[does,not,like],fish]
% 4.  [A, B | C]    -- [mary, [does,not,like] | [fish]]
%   A=mary, B=[does,not,like], C=[fish]
test_unify(4, [A,B|C], [mary,[does,not,like],fish]) :-
    A = mary,
    B = [does,not,like],
    C = [fish].

% 5.  [['I'|A]|B]       -- [[I,go],[by,bike]]
% 5.  [['I' | A] | B]   -- [[I | [go]] | [[by,bike]]]
%   I='I', A=[go], B=[[by,bike]]
test_unify(5, [['I'|A]|B], [[I,go],[by,bike]]) :-
    I = 'I',
    A = [go],
    B = [[by,bike]].

% 6.  [nice|A]      -- [nice,weekend]
% 6.  [nice | A]    -- [nice | [weekend]]
%   A=[weekend]
test_unify(6, [nice|A], [nice,weekend]) :-
    A = [weekend].

% 7.  [lame,duck]   -- [duck,A]
%   fail: lame =/= duck
test_unify(7, [lame,duck], [duck,A]) :- fail.

% 8.  [lame|P]      -- [x|duck]
%   fail: lame =/= x
test_unify(8, [lame|P], [x|duck]) :- fail.

% 9. [Lame,Duck]    -- [lahme,ente]
%   Lame=lahme, Duck=ente
test_unify(9, [Lame,Duck], [lahme,ente]) :-
    Lame = lahme,
    Duck = ente.

% 10. [[[a,b],c],d]         -- [A,B|C]
% 10. [[[a,b],c], d | []]   -- [A, B | C]
%   A=[[a,b],c], B=d, C=[]
test_unify(10, [[[a,b],c],d], [A,B|C]) :-
    A = [[a,b],c],
    B = d,
    C = [].
