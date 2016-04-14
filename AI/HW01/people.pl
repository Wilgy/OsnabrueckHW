% people.pl - file to solve HW01 Problem 2 questions
%
% Author: T. Wilgenbusch, T. Fairman, K. Hipkin

% -------------------------------------------------------------
%
% male(X).  % X is male.
%

male(wilhelm).
male(klaus).
male(bernd).
male(heinz_bernd).
male(herrmann_joseph).
male(oliver).
male(manuel).
male(tobias).
male(ole).
male(lukas).
male(heiner).
male(malte).
male(peter).
male(dieter).
male(gerd).
male(eike).
male(mark).
male(torsten).
male(heinz).
male(nikolaus).
male(rolf).
male(joerg).
male(john).

% ---------------------------------------------------------
%
% female(X).  % X is female.
%

female(elisabeth).
female(christa).
female(margret).
female(gerda).
female(lisa).
female(rahel).
female(anne).
female(helene).
female(ulla).
female(hildegard).
female(miriam).
female(annette).
female(inga).
female(lea).
female(sara).
female(laura).
female(helen).
female(alexandra).
female(erika).
female(anni).

%Le
% ------------------------------------------------------
%
% parent(X,Y). % X is a parent of Y
%

parent(wilhelm,christa).
parent(wilhelm,margret).
parent(wilhelm,gerda).
parent(wilhelm,lisa).
parent(wilhelm,anne).
parent(wilhelm,klaus).
parent(elisabeth,christa).
parent(elisabeth,margret).
parent(elisabeth,gerda).
parent(elisabeth,lisa).
parent(elisabeth,anne).
parent(elisabeth,klaus).

parent(bernd, heinz_bernd).
parent(bernd, ulla).
parent(bernd, hildegard).
parent(helene, heinz_bernd).
parent(helene, ulla).
parent(helene, hildegard).

parent(christa, oliver).
parent(christa, manuel).
parent(christa, miriam).
parent(herrmann_joseph, oliver).
parent(herrmann_joseph, manuel).
parent(herrmann_joseph, miriam).
parent(margret, tobias).
parent(margret, simone).
parent(heinz_bernd, tobias).
parent(heinz_bernd, simone).

parent(gerda,ole).
parent(gerda,inga).
parent(heiner,ole).
parent(heiner,inga).

parent(lisa,eike).
parent(lisa,laura).
parent(malte,eike).
parent(malte,laura).

parent(klaus,lea).
parent(klaus,sara).
parent(klaus,lukas).
parent(annette,lea).
parent(annette,sara).
parent(annette,lukas).

parent(hildegard,alexandra).
parent(hildegard,helen).
parent(hildegard,mark).
parent(hildegard,katharina).
parent(dieter,alexandra).
parent(dieter,helen).
parent(dieter,mark).
parent(dieter,katharina).

parent(alexandra,rahel).
parent(torsten,rahel).

parent(nikolaus,bernd).
parent(nikolaus,heinz).

parent(heinz,traudel).
parent(heinz,rolf).
parent(anni,traudel).
parent(anni,rolf).

parent(rolf,joerg).
parent(erika,joerg).

% --------------------
% Rules

father(V,K) :-
        parent(V,K),
        male(V).

mother(M,K) :-
        parent(M,K),
        female(M).

son(Son,Parent) :-
        parent(Parent,Son),
        male(Son).

daughter(Daughter,Parent) :-
        parent(Parent,Daughter),
        female(Daughter).

brother(B,G) :-
        father(F,B),
        mother(M,B),
        father(F,G),
        mother(M,G),
        male(B),
        B\=G.

sister(S,G) :-
        father(F,S),
        mother(M,S),
        father(F,G),
        mother(M,G),
        female(S),
        S\=G.

brother_or_sister(A,B) :-
        brother(A,B).

brother_or_sister(A,B) :-
        sister(A,B).

grandparent(G,E) :-
        parent(G,X),
        parent(X,E).

grandfather(G,E) :-
        grandparent(G,E),
        male(G).

grandmother(G,E) :-
        grandparent(G,E),
        female(G).

great_grandparent(U,UE) :-
        parent(U,G),
        parent(G,E),
        parent(E,UE).

cousin(C,X) :-
        parent(VM,X),
        parent(OT,C),
        brother_or_sister(VM,OT),
        X\=C.

foo(A,B) :-
        parent(C,B),
        parent(D,C),
        parent(E,D),
        son(F,E),
        parent(F,G),
        parent(G,A),
        male(A).

% a) (1 point) Add a rule grandchild(Grandchild, Grandparent)
%------------------------------------------------------------------------------
% Grandchild is the 'grandchild' of Grandparent if Grandchild's parent is the
% child of Grandparent
grandchild(Grandchild, Grandparent) :- 
        parent(Grandparent, X), 
        parent(X, Grandchild).


% b) (4 points) List all the (male) cousins of Manuel.
%   Explain why all names are listed more than once.
%   Change the rules such that Manuel is not cousin
%   of himself and the names will only occur once.
%------------------------------------------------------------------------------
% Two problems:
% 1.    The brother and sister rules were not checking if B, G and 
%       S, G (respectively) were UNIQUE; i.e. a person could be the brother
%       or sister of themselves.  Fixing this resolved manuel being the cousin
%       of himself
% 2.    The parents being found in brother and sister were not UNIQUE; i.e. the
%       E value n brother and sister could be matched more than once, first 
%       with E being the mother, and then with E being the father.  Ensuring 
%       that B, G and S,G had the same mother and father removed this problem
% NOTE: The requirement in the cousin rule that C be male was removed to make 
% the rule more flexible
male_cousin_of_manuel(C) :-  
        male(C),
        cousin(manuel, C).


% c) (2 points) The program should be extended to answer questions
%    like: what is the relationship of Tobias and Ulla?
%    Why is the represenation of the facts and rules
%    unsuitable for such questions?
%    Try to find a better representation and demonstrate
%    it for the relations parent, father, mother, grandfather, grandmother.
%    You don't need to reformulate any facts, just add 'wrapper'
%    rules.
%
%    You shall be able to ask:
%    ?- relation(bernd, tobias, X)
%    X = grandfather
%------------------------------------------------------------------------------
% To solve this problem, the relation rule has a different rule for each 
% type of relationship.  When two people are found to have a particular 
% relationship, a symbol representing that relationship is returned
%
% The reason that our current database is unsuited for this task is that there 
% is no concrete definition of the relationships between people in our 
% database; so we need to create symbols to represent these relationships 
relation(P1, P2, father) :- father(P1, P2).
relation(P1, P2, mother) :- mother(P1, P2).
relation(P1, P2, son) :- son(P1, P2).
relation(P1, P2, daughter) :- daughter(P1, P2).
relation(P1, P2, brother) :- brother(P1, P2).
relation(P1, P2, sister) :- sister(P1, P2).
relation(P1, P2, grandfather) :- grandfather(P1, P2).
relation(P1, P2, grandmother) :- grandmother(P1, P2).
relation(P1, P2, cousin) :- cousin(P1, P2).
relation(P1, P2, grandchild) :- grandchild(P1, P2).


% d) (3 Points) It would be nice to have a relation yca (youngest common
%    ancestor). yca(X,Y,Z) should be true if Z is the youngest common ancestor
%    of X and Y.
%
%   To solve this in general is beyond your current skills.
%   One possibility is to implement a rule common_ancestor(X,Y,Z) that
%   is true for every Z that is a common ancestor of X and Y. Formulate the
%   rule in such a way that the youngest ancestor is considered first.
%
%   The following queries should work:
%   ?- common_ancestor(tobias, simone, Z).
%   Z = heinz_bernd ;
%   Z = margret
%   (there may be more solutions that are older common ancestors)
%
%   ?- common_ancestor(tobias, joerg, Z).
%   Z = nikolaus
%------------------------------------------------------------------------------
% To determine common ancestors of two people, we set up a recursive rule
% that climbs up the family tree of each person and then checks if the parents 
% each are the same; if so they are considered an ancestor

% Base case: When X and Y have the same parent (Z), we have found a common 
% ancestor of both
common_ancestor(X, Y, Z) :- 
        parent(Z, X),
        parent(Z, Y).

% Recursive call: Find the parent of X and call common_ancestor on that parent
common_ancestor(X, Y, Z) :-
        parent(P1, X),
        common_ancestor(P1, Y, Z).

% Recursive call: Find the parent of Y and call common_ancestor on that parent
common_ancestor(X, Y, Z) :-
        parent(P2, Y),
        common_ancestor(X, P2, Z).
