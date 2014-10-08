:-module('$heroku', [heroku/0,
                     heroku_db_connect/1]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

heroku:-
	getenv('PORT', PortAtom),
	atom_number(PortAtom, Port),
        http_server(http_dispatch, [port(Port)]),
        prolog,
	thread_get_message(_).

heroku_db_connect(Connection):-
        ( getenv('DATABASE_URL', Url)->
            true
        ; otherwise->            
            format(user_error, 'No DATABASE_URL defined~n', []),
            halt
        ),
        ( parse_url(Url, Parts)->
            true
        ; otherwise->            
            format(user_error, 'Bad DATABASE_URL ~w~n', [Url]),
            halt
        ),            
        ( memberchk(protocol(postgres), Parts)->
            true
        ; otherwise->
            format(user_error, 'Bad protocol~n', [])
        ),
        memberchk(user(UserAndPass), Parts),
        memberchk(host(Hostname), Parts),
        memberchk(port(Port), Parts),
        memberchk(path(DbNameWithSlash), Parts),
        sub_atom(DbNameWithSlash, 1, _, 0, DbName),
        atomic_list_concat([User, Pass], ':', UserAndPass),
        format(atom(DriverString), 'Driver={PostgreSQL};UID=~w;PWD=~w;Server=~w;Port=~w;Database=~w', [User, Pass, Hostname, Port, DbName]),
        odbc_connect(-, Connection, [driver_string(DriverString)]).
                   
