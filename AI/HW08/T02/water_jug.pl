% water_jug.pl - file for HW08, T02
% defines a predicate to solve the water jug problem
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell


/************************************************************
A water-jug-problem:

Determine the amount of 8 liter of water by using a 3 liter
a 5 liter and a 9 liter jug.

You can
 - refill a jug with new water,
 - refill a jug from one of the other jugs
 - and empty a jug.

the problem is solved as soon as there are
8 liters of water in the third jug.

use the general search shell implemented below and write
problem specific end and expand predicates

write a predicate 

  test_it(+Strategy, -Solution) 

which calls the search shell and returns
a solution


Hints:

Use [J1,J2,J3] as state representation
 J1 : content of the 3 liter jug
 J2 : content of the 5 liter jug
 J3 : content of the 9 liter jug

****************************************************************/
% your problem specification goes here:
% (define end, expand and test_it)

test_it(Strategy,Sol) :-
   .

%---------------------------------------------------------------------------
% skeleton of the general uninformed search algorithm
%---------------------------------------------------------------------------
search(Start,Endp,Expand,Strategy,Path) :-
      search1(Endp,Expand,Strategy,[[Start]],Path).

search1(EndP,_Expand,_Strategy,[[End|Path]|_Agenda],[End|Path]) :-
     EndG =.. [EndP,End],
     EndG.

search1(EndP,Expand,Strategy,[[X|Path]|Agenda],RPath) :-
     Exp =.. [Expand,X,S],
     Exp,
     exp_path(S,[X|Path],Pathes),
     strategy(Strategy,Agenda,Pathes,Agenda1), !,
     search1(EndP,Expand,Strategy,Agenda1,RPath) .

search1(EndP,Expand,Strategy,[_|Agenda],Path) :-
     search1(EndP,Expand,Strategy,Agenda,Path) .

exp_path([],_P,[]).
exp_path([X|R],P,[[X|P]|Ps]) :-
     not(member(X,P)), !,
     exp_path(R,P,Ps).
exp_path([_X|R],P,Ps) :-
     exp_path(R,P,Ps).

% you have to add strategy specific code here
strategy(breadth_first,Agenda,Pathes,Agenda1) :-
      .

strategy(depth_first,Agenda,Pathes,Agenda1) :-
      .