% trip_advisor.pl - File for HW06, T01
% Adds cuts to existing program to give only unique solutions
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
    X \= Y.