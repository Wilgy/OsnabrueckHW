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
% (raining(x) and freezing(x)) or not slippery(x)
%
% c) Prolog Code
is_slippery(X) :- raining(X), freezing(X).

% d) Verification of Prolog Code
raining(osnabrueck).
raining(rochester).
freezing(osnabrueck).
freezing(rochester).


%-----------------------------------------------
% 2. w is true if and only if v is true. (2 points)
%
% a) Predicate Logic Form
% w -> v and v -> w
%
% b) Conjuctive Normal Form
% not w and v and not v and w
%
% c) Prolog Code
%
% d) Verification of Prolog Code


%-----------------------------------------------
% 3. A man exists who is wiser than all other men. (2 points)
% 
% a) Predicate Logic Form
% ex x: man(x) ->
%  (all y: man(y) and x\=y -> wiser(x, y))
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
% d) Verification of Prolog Code


%-----------------------------------------------
% 4. No man is wiser than he himself. (2 points)
%
% a) Predicate Logic Form
% all x: man(x) ->
%  not(wiser(x, x))
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
% d) Verification of Prolog Code


%----------------------------------------------- 
% 5. It exists exactly one Kilimandscharo. (1 point)
%
% a) Predicate Logic Form
% ex x -> kilimandscharo(x) and all y: not(x=y) -> not(kilmandscharo(y))
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
kilmandscharo.
% d) Verification of Prolog Code


%-----------------------------------------------
% 6. Every human being has exactly one mother. (2 points)
%
% a) Predicate Logic Form
% all h: human(h) -> ex x: mother(x, h) and (all y: mother(y, x) -> (y = h))
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
% d) Verification of Prolog Code


%-----------------------------------------------
% 7.  A thing is a railway station if it has tracks,
%     a load ticket window, a departure plan,
%     and a waiting room. (2 points)
%
% a) Predicate Logic Form
% all x: has_tracks(x) and 
%        has_ticket_window(x) and
%        has_departure_plan(x) and 
%        has_waiting_room(x) -> 
%           railway_station(x)
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
% d) Verification of Prolog Code

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
% all x:( ( student(x) and 
%           pass(x, exam1) and 
%           pass(x, exam2) and 
%           pass(x, homework1) and 
%           pass(x, homework2) -> pass(x, intro_to_ai)) 
%          )
%          or
%          ( ( not(pass(x, exam1)) and pass(x, exam2) ) -> replace(exam1, additional_exam) or 
%            ( pass(x, exam1) and not(pass(x, exam2)) ) -> replace(exam2, additional_exam) 
%          )
% 
%
% b) Conjuctive Normal Form
%
% c) Prolog Code
%
% d) Verification of Prolog Code
