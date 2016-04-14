/*
 family tree
 http://en.wikipedia.org/wiki/Family_tree_of_the_Greek_gods

 Author: T. Wilgenbusch, T. Fairman, K. Hipkin, B. Dell
*/


/*
 Consider the following family tree and formulate the
 information contained in that tree as prolog facts.
*/

%  Kronos oo Rhea
%          |
%          +--Hades
%          |
%          +--Zeus oo Hera
%          |       |
%          |       +--Hebe 
%          |  
%          +--Poseidon oo Amphitrite
%                     |
%                     +--Triton
%                     |
%                     +--Rode
%
%  (read the tree from upper left to lower right)

/*
 Think about how information concerning gender can
 be represented with minimal redundancy.
 Hint: to state both father(kronos,poseidon) and male(kronos)
 as facts in the program is redundant, because
 male(kronos) is derivable from father(kronos,poseidon)

 Use predicate names from the set: {father, mother, parent, male, female}
*/
male(kronos).
male(hades).
male(zeus).
male(poseidon).
male(triton).

female(rhea).
female(hera).
female(hebe).
female(amphitrite).
female(rode).

parent(kronos, hades).
parent(kronos, zeus).
parent(kronos, poseidon).
parent(rhea, hades).
parent(rhea, zeus).
parent(rhea, poseidon).

parent(zeus, hebe).
parent(hera, hebe).

parent(poseidon, triton).
parent(poseidon, rode).
parent(amphitrite, triton).
parent(amphitrite, rode).

/*
Pose at least these queries:
 - Who is the mother of whom?
 - Which are the children of Zeus?
 - Do Hades and Zeus have both the same father?
 - Which Individuals have common children?
 - Which men have more than one child?
 - Who has no ancestor (in this family tree)?

Add the queries and answers as arguments of the following predicate.
*/

mother(M, C) :- female(M), parent(M, C).


father(F, C) :- male(F), parent(F, C).


% example
query(                           
   'Who is the mother of whom?',
   (mother(M,C)),
   (M=rhea, C=hades;
    M=rhea, C=zeus;
    M=rhea, C=poseidon;
    M=amphitrite, C=triton;
    M=amphitrite, C=rhode) ).   % more variables connected by ','
                                 % alternatives connected by ';'
                                 % if there is no answer enter 'false' here
query(
   'Which are the children of Zeus?',
   (father(zeus, C)) ,
   (C=hebe) ).  

query(
   'Do Hades and Zeus have both the same father?',
   (father(X, hades)) ,
   (father(X, zeus)) ,
   (X=kronos) ).

query(
   'Which Individuals have common children?',
   (parent(X, C)) ,
   (parent(Y, C)) , 
   (X\=Y) ,
   (X=kronos, Y=rhea;
    X=zeus, Y=hera;
    X=poseidon, Y=amphitrite) ).

query(
   'Which men have more than one child?',
   (father(X, C1)) ,
   (father(X, C2)) ,
   (C1\=C2) ,
   (X=kronos;
    X=poseidon) ).  

query(
   'Who has no ancestor?',
   (parent(P, X)),
   (not(P)),
   (X=kronos;
    X=rhea) ).