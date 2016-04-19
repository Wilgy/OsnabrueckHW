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

If there are multible values for a field (e.g. for times and rooms, or teachers)
use a construction and(first_value, second_value)

--------------------------------------------------------------

Define access predicates for all fields: lecture_name, teacher, time_room
example: 

lecture_name(lecture(X,_,_), X).

for fields with multible values the access predicates must
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

--------------------------------------------------------------

Define a predicate 
conflict(TimeRoom, Lecture1, Lecture2) :- ....

which checks for a conflict (two different lectures are
at the same time in the same room) and gives the time
and room with the name of the two lectures. (Just compare
the represenations of time slots like 'Thu 12-14')

--------------------------------------------------------------

Define a predicate
free_room(Time, Room) :- ....

which finds a free room for a given time.

hint: define predicates time and room which specify all possible time slots
(only those occurring in one of the lectures)

and all possible rooms (again only those occurring in one the lectures).

--------------------------------------------------------------*/

% your code goes here: