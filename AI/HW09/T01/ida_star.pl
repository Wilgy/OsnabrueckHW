% ida_star.pl - File for HW09, T01
% implements an iterative deepening A* search algorithm
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

%------------------------------------------------------
% informed search strategies: A*
%
%------------------------------------------------------
% demonstrated using:
%
%        the eight puzzle
%------------------------------------------------------
% representing the problem
%------------------------------------------------------
% what's a state?
%
%            +--+--+--+
%            |CC|EE|HH|
%            +--+--+--+
%            |DD|  |BB|
%            +--+--+--+
%            |GG|AA|FF|
%            +--+--+--+
%
% size of state space:9 * 8! = 362880
%------------------------------------------------------
% how to represent a state:
%
%     [[c,e,h],[d,?,b],[g,a,f]]
%------------------------------------------------------
%
% some initial configurations
start(1,[[a,b,c],[d,e,f],[?,g,h]]). % very easy
start(2,[[?,a,b],[e,f,c],[d,g,h]]).
start(3,[[a,b,c],[d,?,e],[f,g,h]]).
start(4,[[?,b,c],[a,d,e],[f,g,h]]). % depth=17: space(bfs,17) = 2.7**17 = 21,536,939
%                                     at least 8 bytes/node: ~ 160MB to store the search tree
start(5,[[h, g, f], [e, d, c], [b, a, ?]]). % really hard to solve
%start(6,[[a, b, c], [d, h, f], [g, e, ?]]). % probably unsolvable
%start(7,[[c, e, h], [d, ?, b], [g, a, f]]). % probably unsolvable
%------------------------------------------------------
% state transitions
%-----------------------------------------------------------------------
% center
transitions([[A,B,C],[D,?,F],[G,H,I]],[
           [[A,B,C],[?,D,F],[G,H,I]],
           [[A,B,C],[D,F,?],[G,H,I]],
           [[A,?,C],[D,B,F],[G,H,I]],
           [[A,B,C],[D,H,F],[G,?,I]]]).

% center of a side
transitions([[A,?,C],[D,E,F],[G,H,I]],[
           [[?,A,C],[D,E,F],[G,H,I]],
           [[A,C,?],[D,E,F],[G,H,I]],
           [[A,E,C],[D,?,F],[G,H,I]]]).

transitions([[A,B,C],[D,E,F],[G,?,I]],[
           [[A,B,C],[D,E,F],[?,G,I]],
           [[A,B,C],[D,E,F],[G,I,?]],
           [[A,B,C],[D,?,F],[G,E,I]]]).

transitions([[A,B,C],[?,E,F],[G,H,I]],[
           [[A,B,C],[E,?,F],[G,H,I]],
           [[?,B,C],[A,E,F],[G,H,I]],
           [[A,B,C],[G,E,F],[?,H,I]]]).

transitions([[A,B,C],[D,E,?],[G,H,I]],[
           [[A,B,C],[D,?,E],[G,H,I]],
           [[A,B,?],[D,E,C],[G,H,I]],
           [[A,B,C],[D,E,I],[G,H,?]]]).

% corner
transitions([[?,B,C],[D,E,F],[G,H,I]],[
           [[B,?,C],[D,E,F],[G,H,I]],
           [[D,B,C],[?,E,F],[G,H,I]]]).

transitions([[A,B,?],[D,E,F],[G,H,I]],[
           [[A,?,B],[D,E,F],[G,H,I]],
           [[A,B,F],[D,E,?],[G,H,I]]]).

transitions([[A,B,C],[D,E,F],[G,H,?]],[
           [[A,B,C],[D,E,F],[G,?,H]],
           [[A,B,C],[D,E,?],[G,H,F]]]).

transitions([[A,B,C],[D,E,F],[?,H,I]],[
           [[A,B,C],[D,E,F],[H,?,I]],
           [[A,B,C],[?,E,F],[D,H,I]]]).

end([[a,b,c],[d,e,f],[g,h,?]]).

:- dynamic f_max/1.

set_next_max(L) :- retract(next_max(_)), assert(next_max(L)).

get_f_max(L) :- f_max(L).
get_f_max(L) :- next_max(L), set_f_max(L).

set_f_max(L) :- retract(f_max(_)), assert(f_max(L)).

search_ida_star(N,P) :-
   start(N,X),
   h(X, L),
   assert(f_max(L)),
   assert(next_max(L)), % initialize in the database
   get_f_max(L2),
   searchidah([X],P,0,0,L2).

searchidah([X|P],[X|P],_G,_F,_L) :-
   end(X).
searchidah([X|P],P1,G,_F,L) :-
   G1 is G+1,
   transitions(X,S),
   member(Y,S),
   not(member(Y,[X|P])),
   once(h(Y,H,0)),
   F1 is H + G1,
   f_in_limit(F1, L),
   % F1 = G1,
   searchidah([Y,X|P],P1,G1,F1,L).

% returns the same truth value as F =< L
% with the side effect that if F is higher than the current limit and lower than
% the next fmax, then the fmax is replaced with F in the database
% case 1: F value is below the limit, so return true
f_in_limit(F, L) :- F =< L.
% case 2: F value is above the limit and not the next fmax, so leave the database\
% unchanged and return false
f_in_limit(F, _) :-
   next_max(L),
   F >= L,
   !, fail.
% case 3: F value is above the limit and is the next fmax, so modify the database
% and return false (indicate that this current search should end)
f_in_limit(F, _) :-
   set_next_max(F),
   fail.


% compute h* value of a board
% h(+board,-H)
% keep track of the coordinates of tiles
h(X,H) :- h(X,H,0).

% h(+board, -H, +Y)
% Y = y-coordinate of the current row
h([],0,_).
h([A|R],H,Y) :-
   h1(A,H1,0,Y), % h* of a row
   Y1 is Y+1,
   h(R,H2,Y1),
   H is H1+H2.   % sum over all rows

% compute h* of a row
% h1(+tiles_of_row),-H,+X,+Y)
%  (X,Y) coordinates of the current tile
h1([],0,_,_).
h1([A|R],H,X,Y) :-
   p(A,X0,Y0),     % lookup target coordinates of tile
   d1(M,X0,Y0,X,Y),% compare to target coordinates
   X1 is X+1,
   h1(R,H1,X1,Y),
   H is H1+M.      % sum over all tiles in a row

% in a functional language:
%
%   h([],_)    = 0
%   h([A|R],Y) = h1(A,0,Y) + h(R,Y+1)
%
%   h1([],_,_)    = 0
%   h1([A|R],X,Y) = d1(p(A),(X,Y)) + h1(R,X+1,Y)
%
% for a functional extension of prolog see GRIPS:
%   http://www.j-paine.org/prolog/library.html

% compare coordinates: equality (count misplaced tiles)
d(0,X,Y,X,Y) :- ! .
d(1,_X0,_Y0,_X,_Y).

% compare coordinates: Manhaten distance
d1(M,X0,Y0,X,Y) :- M is abs(X0-X) + abs(Y0-Y) .

% compare coordinates: Manhaten distance (MHD) + (MHD-1)
% idea: if MHD>1 other tiles must be moved
d2(M,X0,Y0,X,Y) :-
   M0 is abs(X0-X) + abs(Y0-Y),
   % M is M0.
   (M0>1 -> M is  M0 + (M0 - 1) ; M is M0).
   %(M0>1 -> M is  M0 + (M0 - 1) + (M0 - 2) ; M is M0).

p(a,0,0).
p(b,1,0).
p(c,2,0).
p(d,0,1).
p(e,1,1).
p(f,2,1).
p(g,0,2).
p(h,1,2).
p(?,2,2).

