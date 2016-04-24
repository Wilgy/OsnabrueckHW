% classschedule.pl - Prolog file for HW02, Task 2
% Used to define a database containg information for a class 
% schedule an several procedures for that schedule
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*------------------------------------------------------------
Implement the following class schedule:
--------------------------------------------------------------

Multi-Agent Systems,
  Kühnberger,
  Thu 16-18 in 31/147

Functional Programming,
  Gust,
  Thu 12-14 in 69/E23

Aspects of knowledge representation in artificial general intelligence,
  Kühnberger,
  Tue 12-14 in 31/147

Entscheidungs- und Spieltheorie für Studierende der Kognitionswissenschaft,
  Gaertner,
  Thu 14-16 in 31/423

Modal Logic,
  Martinez Baldares,
  Tue 14-16 in 31/449

Introduction to Algebraic Logic,
  Martinez Baldares and Kühnberger,
  Mon 14-16 in 31/423

Artificial Intelligence,
  Gust and Kühnberger,
  Mon 14-16 in 31/449 and Tue 14-16 in 31/449

Tutorials Artificial Intelligence,
  Gust and Kühnberger, 
  Tue 16-18 in 69/118 and Wed 12-14 in 69/E15 and Thu 10-12 in 32/372 and Fri 12:00-14:00 32/107

----------------------------------------------------------------

Implement a database for the lectures:
Example: 

lecture_db(lecture('Multi-Agent Systems', 'Kühnberger', time_room('Thu 16-18','31/147'))).
.....

If there are multiple values for a field (e.g. for times and rooms, or teachers)
use a construction and(first_value, second_value)

--------------------------------------------------------------*/

lecture_db(lecture(
  'Multi-Agent Systems',
  'Kühnberger',
  time_room('Thu 16-18', '31/147'))).
lecture_db(lecture(
  'Functional Programming',
  'Gust',
  time_room('Thu 12-14', '69/E23'))).
lecture_db(lecture(
  'Aspects of knowledge representation in artificial general intelligence',
  'Kühnberger',
  time_room('Tue 12-14', '31/147'))).
lecture_db(lecture(
  'Entscheidungs- und Spieltheorie für Studierende der Kognitionswissenschaft',
  'Gaertner',
  time_room('Thu 14-16', '31/423'))).
lecture_db(lecture(
  'Modal Logic',
  'Martinez Baldares',
  time_room('Tue 14-16', '31/449'))).
lecture_db(lecture(
  'Introduction to Algebraic Logic',
  and('Martinez Baldares', 'Kühnberger'),
  time_room('Mon 14-16', '31/423'))).
lecture_db(lecture(
  'Artificial Intelligence',
  and('Gust', 'Kühnberger'),
  and(time_room('Mon 14-16', '31/449'), time_room('Tue 14-16', '31/449')))).
lecture_db(lecture(
  'Tutorials Artificial Intelligence',
  and('Gust', 'Kühnberger'),
  and(time_room('Tue 16-18', '69/118'),
    and(time_room('Wed 12-14', '69/E15'),
      and(time_room('Thu 10-12', '32/372'),
        time_room('Fri 12-14', '32/107')))))).


/*--------------------------------------------------------------

Define access predicates for all fields: lecture_name, teacher, time_room
example: 

lecture_name(lecture(X,_,_), X).

for fields with multiple values, the access predicates must
decompose these values such that all the values can be
enumerated, eg.

?- time_room(lecture(lec1, tech1, 
              and(time_room(t1,r1),
                  and(time_room(t2,r2), time_room(t3,r3)))),
             TR).

should produce (when asking for alternative solution with ;):
TR = time_room(t1,r1) ;
TR = time_room(t2,r2) ;
TR = time_room(t3,r3) .

--------------------------------------------------------------*/

lecture_name(lecture(N,_,_), N).

teacher(lecture(_,P,_), P) :- atomic(P).
teacher(lecture(_,and(P,_),_), P).
teacher(lecture(N,and(_,X),TR), P) :- teacher(lecture(N,X,TR), P).

time_room(lecture(_,_,time_room(T,R)), time_room(T, R)).
time_room(lecture(_,_,and(time_room(T,R),_)), time_room(T,R)).
time_room(lecture(N,P,and(_,X)), TR) :- time_room(lecture(N,P,X), TR).

/*--------------------------------------------------------------

Define a predicate 
conflict(TimeRoom, Lecture1, Lecture2) :- ....

which checks for a conflict (two different lectures are
at the same time in the same room) and gives the time
and room with the name of the two lectures. (Just compare
the representations of time slots like 'Thu 12-14')

--------------------------------------------------------------*/

conflict(TR, L1, L2) :-
  lecture_db(L1),
  lecture_db(L2),
  L1 \= L2, % necessary because a lecture cannot conflict with itself
  time_room(L1, TR),
  time_room(L2, TR). 

/*--------------------------------------------------------------

Define a predicate
free_room(Time, Room) :- ....

which finds a free room for a given time.

hint: define predicates time and room which specify all possible time slots
(only those occurring in one of the lectures)

and all possible rooms (again only those occurring in one the lectures).

--------------------------------------------------------------*/

time(T) :-
  lecture_db(L),
  time_room(L, time_room(T,_)).

room(R) :-
  lecture_db(L),
  time_room(L, time_room(_, R)).

occupied_room(T, R) :-
  time(T),
  room(R),
  lecture_db(L),
  time_room(L, time_room(T, R)).

free_room(T, R) :-
  time(T),
  room(R),
  not(occupied_room(T, R)).
