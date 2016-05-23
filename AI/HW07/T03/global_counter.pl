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
e) An option to have a maximum value for the counter. If this maximum is 
reached (value to be set >= maximum), an exception is generated. Provide 
suitable unit tests for the maximum value feature. (6 points)

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
     
%-------------------------------------------------------------------------------
% PART E
% max_counter(?Name, ?Value) provides read access to the counters max values
% if not max value exists, prolog would raise an exception
% this exception is caught by catch/3.
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

% set the counter Name to integer value Value
set_counter(Name, Value) :-
    retract(global__counter__(Name, _)),
    integer(Value) -> assert(global__counter__(Name,Value))
                    ; throw(error(counter_error(non_integer),Value)).

% create_counter(+Name) creates a new counter with value 0
create_counter(Name) :-
    create_counter(Name, 0).

% create_counter(+Name, +Value) creates a new counter with value Value
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

%-------------------------------------------------------------------------------
% PART A
% inc_counter(+Counter) increments and existing counter by 1
% throws and error(counter_error(out_of_bounds)) if the counter is being 
% above a max value
inc_counter(Counter) :- 
    counter(Counter, Value),
    % If there is a max value, we need to ensure we do not go over it
    max_counter(Counter, MaxValue),
    (Value < MaxValue -> 
        % If the value can still be incremented, remove the old (counter, value)
        % pair and assert the new pair; We add the cut operator to prevent 
        % Prolog from thinking that there are more choice points after the 
        % increment
        (NewValue is Value + 1,
        destroy_counter(Counter, Value), 
        create_counter(Counter, NewValue), !);
        throw(error(counter_error(out_of_bounds),Counter))). 

inc_counter(Counter) :- 
    % If there is no max value, then increment the counter like normal
    counter(Counter, Value),
    NewValue is Value + 1,
    destroy_counter(Counter, Value),
    create_counter(Counter, NewValue).

%-------------------------------------------------------------------------------
% PART C
% dec_counter(+Counter) decreases and existing counter by 1
dec_counter(Counter) :-
    counter(Counter, Value),
    NewValue is Value - 1,
    destroy_counter(Counter, Value),
    create_counter(Counter, NewValue).

%-------------------------------------------------------------------------------
% PART E
% set_max_value(+Counter, +MaxValue) gives an existing counter a max value, 
% meaning that a counter cannot be incremented passed that MaxValue
% throws a non_integer exception if MaxValue is not an integer
set_max_value(Counter, MaxValue) :-
    counter(Counter, _),
    integer(MaxValue) -> assert(global__max__value__(Counter, MaxValue));
        throw(error(counter_error(non_integer),MaxValue)).

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

%-------------------------------------------------------------------------------
% PART B
% test if incrementing a counter works
test(inccounter, [cleanup(eraseall)]) :- 
    create_counter(foo),
    inc_counter(foo), % Final vaue should be 1
    counter(foo, 1).

%-------------------------------------------------------------------------------
% PART D
% test if decrementing a counter works
test(deccounter, [cleanup(eraseall)]) :- 
    create_counter(foo),
    dec_counter(foo), % Final value should be -1
    counter(foo, -1).

%-------------------------------------------------------------------------------
% PART E
% test that if a max value is set for a counter, that an error is thrown when
% that max value is attempted to be incremented past
test(maxvalue, [error(counter_error(out_of_bounds)), cleanup(eraseall)]) :-
    create_counter(foo),
    set_max_value(foo, 1),
    inc_counter(foo),
    inc_counter(foo). % Throws out_of_bounds exception

% test if creating a counter with
test(nonintmaxvalue, [error(counter_error(non_integer)), cleanup(eraseall)]) :-
    create_counter(foo),
    set_max_value(foo, bar).

:- end_tests(counters).