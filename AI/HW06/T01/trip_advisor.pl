% trip_advisor.pl - File for HW06, T01
% Adds cuts to existing program such that there's only
% one solution for each city that's worth a visit.
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

% trip advisor

% Points of interest
% poi(?city, ?sight)
%
poi(osnabrueck, castle).
poi(osnabrueck, townhall).
poi(osnabrueck, museum).
poi(muenster, castle).
poi(muenster, townhall).
poi(hannover, castle).
poi(fuerstenau, castle).
poi(bramsche, museum).
poi(meppen, townhall).

% visit(?city, ?reason)
%
% A city is worth a visit if it has a castle
%
visit(City, has_castle) :- poi(City, castle).

% Bramsche is worth a visit for its own rights (Task 1)
visit(bramsche, is_bramsche).

% A city is worth a visit
% if it has two points of interest
%
visit(City, has_2_poi(X,Y)) :-
    poi(City, X),
    poi(City, Y),
    !,
    X \= Y.

% Tests:
% ?- visit(C, R).
% C = osnabrueck,
% R = has_castle ;
% C = muenster,
% R = has_castle ;
% C = hannover,
% R = has_castle ;
% C = fuerstenau,
% R = has_castle ;
% C = bramsche,
% R = is_bramsche ;
% false.
%
% ?- visit(osnabrueck, _).
% true.
%
% ?- visit(muenster, _).
% true.
%
% ?- visit(hannover, _).
% true.
%
% ?- visit(fuerstenau, _).
% true.
%
% ?- visit(bramsche, _).
% true.
%
% ?- visit(meppen, _).
% false.

