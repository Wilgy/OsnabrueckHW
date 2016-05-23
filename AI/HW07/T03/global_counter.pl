% global_counter.pl - File for HW07, T03
% Adds several predicates to increase the functionality of a global counter
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*

Add to the "global counter" code:
a) A predicate inc_counter(Counter) that increases a counter by 1 (5 points)
b) A suitable unit test for inc_counter (5 points)
c) A predicate dec_counter(Counter) that decreases a counter by 1 (2 points)
d) A suitable unit test for dec_counter (2 points)
e) An option to have a maximum value for the counter. If this maximum is reached (value to be set >= maximum), an exception is generated. Provide suitable unit tests for the maximum value feature. (6 points)

*/
 
% counter(?Name, ?Value) provides read access to the counters
% if not counter exists, prolog would raise an exception
% this exception is caught by catch/3.
%
% error(existence_error(procedure, global__counter__/2),_)
% describes the exception raised if a predicate does not exist.
%
counter(Name, Value) :-
    catch( global__counter__(Name, Value),
           error(existence_error(procedure,global__counter__/2),_),
           fail).
           
% isset_counter(?Name) succeeds if counter Name is set
isset_counter(Name) :-
    counter(Name,_).

% set the counter Name to integer value Value
set_counter(Name, Value) :-
    retract(global__counter__(Name, _)),
    integer(Value) -> assert(global__counter__(Name,Value))
                    ; throw(error(counter_error(non_integer),Value)).

% create_counter(+Name) creates a new counter with value 0
create_counter(Name) :-
    create_counter(Name, 0).

% create counter(+Name, +Value) creates a new counter with value Value
% throws an error(error_counter(non_integer)) exception if value is not
% an integer
create_counter(Name, Value) :-
    \+ counter(Name,_), % make sure counter does not exist already
    (integer(Value) -> assert(global__counter__(Name,Value))
                    ; throw(error(counter_error(non_integer),Value))).
    
% destroy_counter(+Name, -Value) destroys a counter
destroy_counter(Name,Value) :-
    retract(global__counter__(Name, Value)).
    
% list_counters(-List) constructs a list of all currently used counters
%
list_counters(List) :-
    findall(counter(Name=Value), counter(Name, Value), List).
    
    
% unit tests
%
% start unit tests, prove
% ?- run_tests.
%
:- begin_tests(counters).

% helper: erase all currently set counters
% we need to prefix the predicate name with user:
% because the tests run in a separate namespace
eraseall :- abolish(user:global__counter__/2).

% test if list_counters is true for empty list if there are no counters
test(emptylist, [setup(eraseall)]) :-
    list_counters([]).

% test if access to non-existant counter fails (instead of exception raised)
test(nonexistingcounter, [cleanup(eraseall), fail]) :-
    counter(foo,_).

% test if creating a counter with
test(nonintvalue, [error(counter_error(non_integer)), cleanup(eraseall)]) :-
    create_counter(foo, bar).
    
% test if creating a new counter (implicitly initialized with 0) works
test(createcounter, [cleanup(eraseall)]) :-
    create_counter(foo),
    counter(foo,0).

:- end_tests(counters).