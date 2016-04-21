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

% -----------------------------------------------------------------------------
% Lecture Database
% Each entry in the database is a 'lecture', whose contents are ordered as 
% follows:
%   1.  Name of the Lecture; either a string or symbol
%   2.  Teacher(s) of the Lecture; Can be a string/symbol OR a nested 'and' 
%       structure containing more than one teacher
%   3.  A time_room structure containing a string time and a string room OR a
%       nested 'and' structure similar to teacher names of this structures
% -----------------------------------------------------------------------------
lecture_db(lecture(
    'Multi-Agent Systems', 
    'Kühnberger', 
    time_room('Thu 16-18','31/147'))).

lecture_db(lecture(
    'Functional Programming', 
    'Gust', 
    time_room('Thu 12-14','69/E23'))).

lecture_db(lecture(
    'Aspects of knowledge representation in artificial general intelligence', 
    'Kühnberger', 
    time_room('Thu 16-18','31/147'))).

lecture_db(lecture(
    'Entscheidungs- und Spieltheorie für Studierende der Kognitionswissenschaft', 
    'Gaertner', 
    time_room('Thu 14-16','69/E23'))).

lecture_db(lecture(
    'Modal Logic',
    'Martinez Baldares',
    time_room('Tue 14-16', '31/449'))).

lecture_db(lecture(
    'Introduction to Algebraic Logic',
    and('Martinez Baldares',  'Kühnberger'),
    time_room('Mon 14-16', '31/423'))).

lecture_db(lecture(
    'Artificial Intelligence',
    and('Gust', 'Kühnberger'),
    and(time_room('Mon 14-16, 31/449'), time_room('Tue 14-16', '31/449')))).

lecture_db(lecture(
    'Tutorials Artificial Intelligence',
    and('Gust', 'Kühnberger'), 
    and(time_room('Tue 16-18', '69/118'), 
    and(time_room('Wed 12-14', '69/E15'), 
    and(time_room('Thu 10-12', '32/372'), 
    time_room('Fri 12:00-14:00', '32/107') ) ) ) ) ).

%% lecture_db(lecture(
%%     'testname',
%%     and('testt1', and('testt2', and('testt3', 'testt4'))), 
%%     and(time_room('Tue 16-18', '69/118'), 
%%     and(time_room('Wed 12-14', '69/E15'), 
%%     and(time_room('Thu 10-12', '32/372'), 
%%     time_room('Fri 12:00-14:00', '32/107') ) ) ) ) ).


% -----------------------------------------------------------------------------
% Predicates for accessing/searching the database
% -----------------------------------------------------------------------------


%%%
% in_and - determines if an element given is in a nested 'and' structure
% Used as a helper function in the following predicates
%
% E - the element being checked; Can be a symbol, string, or a 
% time_room structure (Or anything really);
% and(E, _RA), and(_HA, and(RAH, RA)), and(_HA, E) - The and structure being 
% searched through
%
% NOTE: This will ONLY return true if E is a singleton value of the 'and' 
% structure; i.e. what happens when E is an 'and' structure itself is untested
%%%
in_and(E, and(E, _RA)).

in_and(E, and(_HA, and(RAH, RA))) :-
  in_and(E, and(RAH, RA)).

% This rule prevents E from being an 'and' structure
in_and(E, and(_HA, E)):-
  E\=and(_X, _Y).

%%
% lecture_name - produces a lecture name of a given lecture found in the 
% database
%
% lecture(...) - The lecture being 'searched' for
% N - the name of the lecture to be produced
%%
lecture_name(lecture(N, T, TR), N)  :-
  lecture_db(lecture(N, T, TR)).

%%
% teacher - produces the name(s) of any teachers for a given lecture
%
% lecture(...) - The lecture being looked for
% T, X - the teacher or teachers produced
%%
teacher(lecture(N, T, TR), T) :-
  lecture_db(lecture(N, T, TR)),
  atom(T).

teacher(lecture(N, and(T, OT), TR), X) :- 
  lecture_db(lecture(N, and(T, OT), TR)),
  in_and(X, and(T, OT)).

%%
% time_room - produces the time_room structs for a given lecture
%
% lecture(...) 0 The lecture being searched for
% time_room(Time, Room), X - The time_room(s) produced
%%
time_room(lecture(N, T, time_room(Time, Room)), time_room(Time, Room)) :-
  lecture_db(lecture(N, T, time_room(Time, Room))).

time_room(lecture(N, T, and(TR, OTR)), X) :- 
  lecture_db(lecture(N, T, and(TR, OTR))),
  in_and(X, and(TR, OTR)).

%%
% conflict - determines if two lectures conflict with one another by 
% having the same room
%
% TimeRoom - The time_room structure that s being checked
% Lecture1 - The first lecture that may have a conflict
% Lecture2 - The second lecture that may have a conflict
%%
conflict(TimeRoom, Lecture1, Lecture2) :-
    % Determine if Lecture1 and Lecture2 are in the database
    lecture_db(Lecture1),
    lecture_db(Lecture2),
    % Ensure that Lecture1 and Lecture2 are not the same, since a lecture 
    % cannot be in conflict with itself
    Lecture1\=Lecture2,
    % This predicate will return true if Lecture1 or Lecture2 both have the 
    % The same time and room information
    time_room(Lecture1, TimeRoom),
    time_room(Lecture2, TimeRoom).

%%
% time - Given a lecture, returns all times that this lecture occurs
%
% lecture(...) - the lecture that is being examined
% X - the times being returned
%%
time(lecture(N, T, time_room(X, Y)), X) :-
    lecture_db(lecture(N, T, time_room(X, Y))).

time(lecture(N, T, and(TR, OTR)), X) :-
    lecture_db(lecture(N, T, and(TR, OTR))),
    in_and(time_room(X, _Y), and(TR, OTR)).

%%
% room - Given a lecture, returns all rooms where this lecture occurs
%
% lecture(...) - the lecture that is being examined
% X - the roooms being returned
%%
room(lecture(N, T, time_room(X, Y)), Y) :-
    lecture_db(lecture(N, T, time_room(X, Y))).

room(lecture(N, T, and(TR, OTR)), Y) :-
    lecture_db(lecture(N, T, and(TR, OTR))),
    in_and(time_room(_X, Y), and(TR, OTR)).


%%
% free_room - attempts to find a free room for a given time
%
% Time - the time slot that we are searching for
% Room - the room that is found that is free
%%
free_room(Time, Room) :- 
    lecture_db(lecture(N, T, TR)),
    time(lecture(N, T, TR), CT),
    room(lecture(N, T, TR), CR).