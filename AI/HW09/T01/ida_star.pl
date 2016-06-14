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