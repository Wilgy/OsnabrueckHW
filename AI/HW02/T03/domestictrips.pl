% domestictrips.pl - Prolog File for HW02, Task 3
% Gives a database representation of city country pairs and defines a 
% predicate that determines if a list of those cities, if visited, is a 
% 'domestic' trip
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell


/*
Define a predicate:

    domestic_trip(Tour, Country)

which takes a list of city names and a country name
and is true if all the cities of the nonempty tour
are located in the same country.

A city database is given.

Example:

?- domestic_trip([berlin, osnabrueck], germany).
true.
?- domestic_trip([paris, nantes, paris], X).
X = france
?- domestic_trip([madrid, barcelona, marseille], X).
false.

*/

% city(City, Country)
%
city(osnabrueck, germany).
city(bramsche, germany).
city(berlin, germany).
city(paris, france).
city(nantes, france).
city(marseille, france).
city(madrid, spain).
city(barcelona, spain).

% domestic_trip(Tour, Country)
%  Tour is a list of cities
%  the predicate is provable if all cities
%  are located in the same country.
%
% ...your definition goes here...

% Base case occurs when there are no more countries to check (will return true)
domestic_trip([], _Country).

% Recursively moves through the list, ensuring that all cities are from the 
% same country (otherwise return false)
domestic_trip([H | T], Country) :-
    city(H, Country),
    domestic_trip(T, Country).