% global_counter.pl - File for HW07, T03
% Adds several predicates (w/ tests) to improve a global counter implementation
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

/*

Add to the "global counter" code:
a) A predicate inc_counter(Counter) that increases a counter by 1 (5 points)
b) A suitable unit test for inc_counter (5 points)
c) A predicate dec_counter(Counter) that decreases a counter by 1 (2 points)
d) A suitable unit test for dec_counter (2 points)
e) An option to have a maximum value for the counter. If this maximum is reached
    (value to be set >= maximum), an exception is generated.
    Provide suitable unit tests for the maximum value feature. (6 points)

*/

% counter(?Name, ?Value) provides read access to the counters
% If the counter does not exist, prolog raises an exception.
% This exception is caught by catch/3.
%
% error(existence_error(procedure, global__counter__/2),_)
% describes the exception raised if a predicate does not exist.
counter(Name, Value) :-
    catch( global__counter__(Name, Value),
           error(existence_error(procedure,global__counter__/2),_),
           fail).

%-------------------------------------------------------------------------------
% PART E
% max_counter(?Name, ?Value) provides read access to the counters with max values
% If the counter does not exist with the given max value, prolog raises an exception.
% This exception is caught by catch/3.
%
% error(existence_error(procedure, global__max__value__/2),_)
% describes the exception raised if a predicate does not exist.
max_counter(Name, Value) :-
    catch( global__max__value__(Name, Value),
           error(existence_error(procedure,global__max__value__/2),_),
           fail).

% isset_counter(?Name) succeeds if counter Name is set
isset_counter(Name) :-
    counter(Name,_).

% set_counter(+Name, +Value) sets the counter Name to integer value Value
set_counter(Name, Value) :-
    retract(global__counter__(Name, _)),
    integer(Value) -> assert(global__counter__(Name,Value))
                    ; throw(error(counter_error(non_integer),Value)).

% create_counter(+Name) creates a new counter with value 0
create_counter(Name) :-
    create_counter(Name, 0).

% create counter(+Name, +Value) creates a new counter with value Value
% throws an error(counter_error(non_integer)) exception if value is not
% an integer
create_counter(Name, Value) :-
    \+ counter(Name,_), % make sure counter does not exist already
    (integer(Value) -> assert(global__counter__(Name,Value))
                    ; throw(error(counter_error(non_integer),Value))).

% destroy_counter(+Name, -Value) destroys a counter
destroy_counter(Name,Value) :-
    retract(global__counter__(Name, Value)).

% list_counters(-List) constructs a list of all currently used counters
list_counters(List) :-
    findall(counter(Name=Value), counter(Name, Value), List).

%-------------------------------------------------------------------------------
% PART A + PART E
% inc_counter(+Counter) increments an existing counter by 1
% throws an error(counter_error(out_of_bounds)) exception if new value is over max
inc_counter(Counter) :-
    counter(Counter, Value),
    % If the counter has a max value, we must be careful not to go over it.
    % We add the cut operator to have Prolog remove all remaining choice points
    % for inc_counter that potentially do not handle the max value correctly.
    max_counter(Counter, MaxValue), !,
    (Value < MaxValue ->
        % If the value can still be incremented, increment it.
        % Otherwise, raise an exception.
        (NewValue is Value + 1,
        set_counter(Counter, NewValue))
        ; throw(error(counter_error(out_of_bounds),Counter))).

inc_counter(Counter) :-
    % If there is no max value, then increment the counter like normal.
    counter(Counter, Value),
    NewValue is Value + 1,
    set_counter(Counter, NewValue).

%-------------------------------------------------------------------------------
% PART C
% dec_counter(+Counter) decrements an existing counter by 1
dec_counter(Counter) :-
    counter(Counter, Value),
    NewValue is Value - 1,
    set_counter(Counter, NewValue).

%-------------------------------------------------------------------------------
% PART E
% set_max_value(+Counter, +MaxValue) gives an existing counter a max value,
% meaning that the counter's value cannot be incremented past that MaxValue
% throws an error(counter_error(non_integer)) exception if MaxValue is not an integer
set_max_value(Counter, MaxValue) :-
    counter(Counter, _),
    (integer(MaxValue) -> assert(global__max__value__(Counter, MaxValue))
                        ; throw(error(counter_error(non_integer), MaxValue))).

% unit tests
%
% start unit tests, prove
% ?- run_tests.
%
:- begin_tests(counters).

% helper: erase all currently set counters
% We need to prefix the predicate name with 'user:'
% because the tests run in a separate namespace.
eraseall :- abolish(user:global__counter__/2).

% test if list_counters is true for empty list if there are no counters
test(emptylist, [setup(eraseall)]) :-
    list_counters([]).

% test if access to non-existant counter fails (instead of exception raised)
test(nonexistingcounter, [cleanup(eraseall), fail]) :-
    counter(foo,_).

% test if creating a counter with a nonint value raises a counter_error(non_integer) exception
test(nonintvalue, [error(counter_error(non_integer)), cleanup(eraseall)]) :-
    create_counter(foo, bar).

% test if creating a new counter (implicitly initialized with 0) works
test(createcounter, [cleanup(eraseall)]) :-
    create_counter(foo),
    counter(foo,0).

%-------------------------------------------------------------------------------
% PART B
% test if incrementing an existing counter by 1 works
test(inccounter, [cleanup(eraseall)]) :-
    create_counter(foo,3),
    inc_counter(foo),
    counter(foo,4).

%-------------------------------------------------------------------------------
% PART D
% test if decrementing an existing counter by 1 works
test(deccounter, [cleanup(eraseall)]) :-
    create_counter(foo,3),
    dec_counter(foo),
    counter(foo,2).

%-------------------------------------------------------------------------------
% PART E
% test if setting a max value for a non-existing counter fails (instead of exception raised)
test(setmax_nonexistingcounter, [setup(eraseall), cleanup(eraseall), fail]) :-
    set_max_value(foo, _).

% test if setting a non-int max value raises a counter_error(non_integer) exception
test(setmax_nonint, [setup(eraseall), error(counter_error(non_integer)), cleanup(eraseall)]) :-
    create_counter(foo),
    set_max_value(foo, bar).

% test if setting a max value works
test(setmax, [setup(eraseall), cleanup(eraseall)]) :-
    create_counter(foo),
    set_max_value(foo, 100),
    max_counter(foo, 100).

% test if incrementing a counter with max value to a value below the limit works
test(setmax_outofbounds, [setup(eraseall), cleanup(eraseall)]) :-
    create_counter(foo, 99),
    set_max_value(foo, 100),
    inc_counter(foo).

% test if incrementing past max value for a counter raises a counter_error(out_of_bounds) exception
test(setmax_outofbounds,
        [setup(eraseall), error(counter_error(out_of_bounds)), cleanup(eraseall)]) :-
    create_counter(foo, 100),
    set_max_value(foo, 100),
    inc_counter(foo).

:- end_tests(counters).
