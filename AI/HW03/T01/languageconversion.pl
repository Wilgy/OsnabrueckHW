% languageconversion.pl - Prolog file for HW03, Task 1
% Series of questions for converting a natural language sentence into 
% predicate, clausal, and prolog sentences
%
% Author: T. Wilgenbusch, K. Hipkin, T, Fairman, B. Dell

/*
Transform the following natural language sentences

a) into predicate logic (as closely to the nl-formulation as possible),

b) into clausal form (conjuctive normal form without quantifiers).

c) if possible, try to formulate the statements as prolog programs

d) check if the programs will work properly or not.
   State assumptions which ensure correct solutions, if necessary.
   State possible problems or explain why it's not possible to
      represent a problem as a prolog program.

use the symbols:

and - for the logical and
or - for the logical or
not - for the logical not
all x :	- for universal quantification
ex x : - for existential quantification

Try to use the close world assumption and the
unique name assumption if suitable.
(If so, note it in a comment.)

closed world assumption:
   there are only those individuals in the model
   which are referenced by terms in the program.
   ground literals, which are not provable, are false.

unique name assumption:
   different names refer to different individuals.

clark completion:
   for equivalences, use one direction of the implication
   (the one you need);
   the other direction is added by the clark completion
   (but it will not be evaluated by prolog;
   so if both directions are needed, it will not work).

If possible, add clauses with test data for running the programs.
*/

% Example:
% 0. Über allen Wipfeln ist Ruh.
%    (it's calm over all treetops)

% all x: treetop(x) ->
%     (all y: place(y) and over(x,y) -> is_calm(y)).

% not treetop(x) or not place(y) or not over(x,y) or is_calm(y)

is_calm(Y) :- treetop(X), place(Y), over(X,Y).

% ok, will work as a prolog program!
% some data to test it

treetop(tt1).
treetop(tt2).
place(p1).
place(p2).
place(p3).
over(tt1,p1).
over(tt2,p2).
over(tt2,p3).

%-----------------------------------------------
% 1. If it is raining and freezing then it is slippery. (1 point)
%
% a) Predicate Logic Form
% all x: (raining(x) and freezing(x)) -> slippery(x) 
%
% b) Conjuctive Normal Form
% not(raining(x)) or not(freezing(x)) or slippery(x)
%
% c) Prolog Code

%%
% is_slippery(+X) - determines if a given location is slippery
% +X : the area being determined
%%
is_slippery(X) :- raining(X), freezing(X).

% d) Verification of Prolog Code
raining(osnabrueck).
raining(rochester).
raining(rainforest). % Should NOT be slippery in the rainforest
freezing(osnabrueck).
freezing(rochester).
freezing(antarctica). % Should NOT be slippery in antarctica

%-----------------------------------------------
% 2. w is true if and only if v is true. (2 points)
%
% a) Predicate Logic Form
% (w -> v) and (v -> w)
%
% b) Conjuctive Normal Form
% (not w or v) and (not v or w)
%
% c) Prolog Code
% Since we require BOTH w implies v AND v implies w, we cannot use the clark 
% completion for only one of those implications. So there is no valid way to  
% represent the above in Prolog.
%
% d) Verification of Prolog Code
% Cannot verify without Prolog code

%-----------------------------------------------
% 3. A man exists who is wiser than all other men. (2 points)
% 
% a) Predicate Logic Form
% ex x: all y: (man(x) and man(y) and x\=y) -> wiser(x,y)
%
% b) Conjuctive Normal Form
% not man(Sx) or not man(y) or Sx=y or wiser(Sx,y)
%
% c) Prolog Code

wiser(sx, Y) :- man(sx), man(Y), sx\=Y.

% d) Verification of Prolog Code
man(sx).
man(dummy).
man(idiot).
man(smartass).

%-----------------------------------------------
% 4. No man is wiser than he himself. (2 points)
%
% a) Predicate Logic Form
% all x: man(x) -> not(wiser(x, x))
%
% b) Conjuctive Normal Form
% not man(x) or not(wiser(x, x))
%
% c) Prolog Code

not_wiser(X, X) :- man(X).

% d) Verification of Prolog Code
% See the database of man() for Problem 3

%----------------------------------------------- 
% 5. It exists exactly one Kilimandscharo. (1 point)
%
% a) Predicate Logic Form
% ex x: kilimandscharo(x) and all y: not(x=y) and not(kilmandscharo(y))
%
% b) Conjuctive Normal Form
% kilmandscharo(thing) and not(thing=Y) and not(kilmandscharo(y))

% c) Prolog Code

kilmandscharo.

% d) Verification of Prolog Code


%-----------------------------------------------
% 6. Every human being has exactly one mother. (2 points)
%
% a) Predicate Logic Form
% all h: human(h) and ex x: mother(x, h) and (all y: mother(y, x) -> (y = h))
%
% b) Conjuctive Normal Form
% (not(human(h)) or not(mother(m(h), h)) or mother(y, h)) and human(h) and mother(m(h)) 
% 
% c) Prolog Code
mother(Y, H) :-  human(H), Y = mother1(H), mother(mother1(H), H).

%
% d) Verification of Prolog Code

% mother1 is a skolemized function representing the mother
mother(mother1(child1), child1).
mother(mother1(child2), child2).

human(child1).
human(child2).

%-----------------------------------------------
% 7.  A thing is a railway station if it has tracks,
%     a load ticket window, a departure plan,
%     and a waiting room. (2 points)
%
% a) Predicate Logic Form
% all x: (has_tracks(x) and
%         has_ticket_window(x) and
%         has_departure_plan(x) and
%         has_waiting_room(x)) ->
%            railway_station(x)
%
% b) Conjuctive Normal Form
% not has_tracks(x) or not has_ticket_window(x) or not has_departure_plan(x)
%     or not has_waiting_room(x) or railway_station(x)
%
% c) Prolog Code

railway_station(X) :-   has_tracks(X),
                        has_ticket_window(X),
                        has_departure_plan(X),
                        has_waiting_room(X).

% d) Verification of Prolog Code
%        bahnhof has tracks, a ticket window, a departure plan, a waiting room --> railway_station(bahnhof)
%        kino has a ticket window --> not railway_station(kino)
%        flughofen has a ticket window, a departure plan, a waiting room --> not railway_station(flughofen)
%        krankenhaus has a waiting room --> not railway_station(krankenhaus)
has_tracks(bahnhof).

has_ticket_window(bahnhof).
has_ticket_window(kino).
has_ticket_window(flughofen).

has_departure_plan(bahnhof).
has_departure_plan(flughofen).

has_waiting_room(bahnhof).
has_waiting_room(krankenhaus).
has_waiting_room(flughofen).

%-----------------------------------------------
% 8.  The Introduction to AI and logical programming
%     course has five examination parts: homeworks for block 1,
%     homeworks for block 2, exam 1, exam 2, and an additional
%     exam. Students who pass all the homeworks and exam 1 and 
%     exam 2 pass the entire course. Students who fail at exactly
%     one of the first two exams can substitute that exam with
%     the additional exam. (3 points)
%
% a) Predicate Logic Form
% all x:( student(x) and
%           (
%              ( pass(x, homework1) and
%                pass(x, homework2) and
%                 (
%                    ( pass(x, exam1) and pass(x, exam2)) or
%                    ( pass(x, exam1) and pass(x, alternate_exam)) or
%                    ( pass(x, exam2) and pass(x, alternate_exam))
%                 )
%              ) -> pass(x, intro_to_ai)
%           )
%        )
% 
%
% b) Conjuctive Normal Form
% (
%     not(pass(x, homework1)) or
%     not(pass(x, homework2)) or
%     not(pass(x, exam1)) or
%     not(pass(x, exam2)) or
%     not(student(x)) or
%     pass(x, intro_to_ai)
% )
% and
% (
%     not(pass(x, homework1)) or
%     not(pass(x, homework2)) or
%     not(pass(x, exam1)) or
%     not(pass(x, alternate_exam)) or
%     not(student(x)) or
%     pass(x, intro_to_ai)
% )
% and
% (
%     not(pass(x, homework1)) or
%     not(pass(x, homework2)) or
%     not(pass(x, exam2)) or
%     not(pass(x, alternate_exam)) or
%     not(student(x)) or
%     pass(x, intro_to_ai)
% )
%
% c) Prolog Code

pass(X, intro_to_ai) :-
   student(X), pass(X, homework1), pass(X, homework2), pass(X, exam1), pass(X, exam2).
   
pass(X, intro_to_ai) :-
   student(X), pass(X, homework1), pass(X, homework2), pass(X, exam1), pass(X, alternate_exam).
   
pass(X, intro_to_ai) :-
   student(X), pass(X, homework1), pass(X, homework2), pass(X, exam2), pass(X, alternate_exam).

%
% d) Verification of Prolog Code

pass(good_student, homework1).
pass(good_student, homework2).
pass(good_student, exam1).
pass(good_student, exam2).

pass(passing_student, homework1).
pass(passing_student, homework2).
pass(passing_student, exam1).
pass(passing_student, alternate_exam).

pass(no_hw_student, exam1).
pass(no_hw_student, exam2).

student(good_student). % passes intro_to_ai
student(passing_student). % passes intro_to_ai
student(no_hw_student). % missing required hw1 and hw2 passing grades, fails intro_to_ai
student(failing_student). % missing all required passing grades, fails intro_to_ai
