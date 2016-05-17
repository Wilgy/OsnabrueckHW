% operators.pl - File for HW06, T03
% Defines operators and predicates # and ?? such that several pseudo-nl-sentences
% can be read and processed
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*
Define operators and the predicate # and ?? such that

- the following input can be read by prolog without an error message:
	-- # mary traveled from berlin to hamburg where she visited her brother.

- at the prolog command line, prolog will perform the following action:
	-- print the terms (one per line):
			traveled(mary, to(from(berlin), hamburg))
			visited(she, her(brother))
	-- add the above two facts into the prolog knowledge base
	   as clauses for a predicate 'facts'

?- # mary traveled from berlin to hamburg where she visited her brother.

define an operator ?? such that 

?- Who traveled from Pos1 to Pos2 ?? .
gives the answer:
Who = mary
Pos1 = berlin
Pos2 = hamburg

and
?- Who visited her brother ?? .
gives the answer:
Who = she
*/

% your code goes here:




% this line will be processed as if it were entered as a query:
:- # mary traveled from berlin to hamburg where she visited her brother.

% now the above queries should be processed correctly
