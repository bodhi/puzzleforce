% active(alberta).
% active(bob).
% active(christie).
% active(farid).

% mentions(alberta, bob).
% mentions(bob, alberta).

% mentions(alberta, christie).
% mentions(christie, alberta).

% mentions(bob, duncan).
% mentions(duncan, bob).

% mentions(bob, christie).
% mentions(christie, bob).

% mentions(duncan, emily).
% mentions(emily, duncan).

% mentions(emily, christie).
% mentions(christie, emily).

% mentions(duncan, farid).
% mentions(farid, duncan).

connected(X, Y) :-
        mentions(X, Y),
        mentions(Y, X).

connected_at(1, X, Y) :- connected(X, Y).

connected_at(Depth, X, Z) :-
        Depth > 1,
        Next is Depth - 1,
        connected(X, Y),
        connected_at(Next, Y, Z),
        X \= Z,
        X \= Y,
        not(connected(X, Z)),
        not(connected_at(Next, X, Z)).

write_connections(X) :-
        write_out([X]),
        connections(X, 1).

connections(X, Depth) :-
        setof(Person, connected_at(Depth, X, Person), People),
        write_out(People),
        Next is Depth + 1,
        connections(X, Next);
        true.

connection_list([X|[]]) :- write_connections(X).

connection_list([X|T]) :-
        write_connections(X),
        write('\n'),
        connection_list(T),
        true.

write_out([X|[]]) :-
        write(X),
        write('\n').

write_out([X|T]) :-
        write(X),
        write(', '),
        write_out(T).

output :-
        setof(Person, active(Person), People),
        connection_list(People).
