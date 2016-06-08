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
start([3, 5, 9]).

goal([_, _, 8]).

test_it(Strategy,Sol) :-
  start(X),
  search(X, goal, create_paths, Strategy, Sol).

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

move_water(JFrom, JTo, MaxValue, NewJFromValue, NewJToValue) :-
  JFrom =< MaxValue - JTo,
  NewJFromValue is 0,
  NewJToValue is JTo + JFrom.

move_water(JFrom, JTo, MaxValue, NewJFromValue, NewJToValue) :-
  JFrom > MaxValue - JTo,
  NewJFromValue is JFrom - (MaxValue - JTo),
  NewJToValue is JTo + (MaxValue - JTo).


create_paths([J1, J2, J3], NewPathes) :-
  
  %Generate all the moved water values
  % Move J1 contents to J2 and J3
  move_water(J1, J2, 5, NJ1A, NJ2A),
  move_water(J1, J3, 9, NJ1B, NJ3B),

  % Move J2 contents to J1 and J3
  move_water(J2, J3, 9, NJ2C, NJ3C),
  move_water(J2, J1, 3, NJ2D, NJ1D),

  % Move J3 contents to J1 and J2
  move_water(J3, J1, 3, NJ3E, NJ1E),
  move_water(J3, J2, 5, NJ3F, NJ2F),

  append([[3, J2, J3], [J1, 5, J3], [J1, J2, 9], % Fill in each jug
    [0, J2, J3], [J1, 0, J3], [J1, J2, 0], % Empty each jug 
    [NJ1A, NJ2A, J3], [NJ1B, J2, NJ3B], % Fill in the moved contents
    [J1, NJ2C, NJ3C], [NJ1D, NJ2D, J3], 
    [NJ1E, J2, NJ3E], [J1, NJ2F, NJ3F]], [], NewPathes), !. 




% you have to add strategy specific code here
strategy(breadth_first,Agenda,Paths,Agenda1) :-
  append(Agenda, Paths, Agenda1).

strategy(depth_first,Agenda,Paths,Agenda1) :-
  append(Paths, Agenda, Agenda1).