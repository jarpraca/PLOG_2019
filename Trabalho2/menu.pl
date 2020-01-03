
:- consult('data.pl').
:- consult('display.pl').

/**
 * Draws game menu
 */
displayMenu :-
    write(' ________________________________________________________________'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|  XXXXXXXXX                  XXXXXXX                    x       |'),nl,
    write('|  XX                         XX   XX                    x       |'),nl,
    write('|  XX         xxxxxx  xxxxxx  XX   XX x    x xxxxx xxxxx x xxxxx |'),nl,
    write('|  XX    XXX    xx x  x    x  XXXXXXX x    x    x     x  x xxxxx |'),nl,
    write('|  XX     XX  xx  xx  xxxxxx  XX      x    x   x     x   x x     |'),nl,
    write('|  XXXXXXXXX  xxxxxx  x       XX      xxxxxx xxxxx xxxxx x xxxxx |'),nl,
    write('|                     x                                          |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                  ____________________________                  |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  1  |        Play          |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  0  |        Exit          |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|             Developed by: Joao Praca, Lucas Ribeiro            |'),nl,
    write('|________________________________________________________________|'),nl.

/**
 * Draws computer levels
 */
displayLevels :-
    write('   _____ ______________________ '),nl,
    write('  |     |                      |'),nl,
    write('  |  1  |         Easy         |'),nl,
    write('  |_____|______________________|'),nl,
    write('  |     |                      |'),nl,
    write('  |  2  |        Medium        |'),nl,
    write('  |_____|______________________|'),nl,
    write('  |     |                      |'),nl,
    write('  |  3  |         Hard         |'),nl,
    write('  |_____|______________________|'),nl.

/**
 * Parses menu option chosen and behaves accordingly:
 * 0 - Exit
 * 1 - Start Playing
 */
parseOption(0) :-
    fail.

parseOption(1) :-
    choose_level(Level),
    format("~nYou chose level: ~w", [Level]).
	


/**
 * Parses replay option chosen and behaves accordingly
 */
parseReplay(y) :-
	menu.

parseReplay(n).

parseReplay(_) :-
    replay.

/**
 * Asks user if he wants to play again
 */
replay :-
    write('\nDo you want to play again? (y/n) '),
	read(Replay),
	parseReplay(Replay).

/**
 * Displays levels
 * Asks user what level he wants for the respective computer player
 */
choose_level(Level) :-
    displayLevels,
    write("~nChoose the puzzles level of difficulty: "),
    read(Level),
    (level(Level) ->
        true;
        (write("\nLevel must be 1, 2 or 3!\n"), choose_level(Level))
    ).

/**
 * Displays menu
 * Asks user which game option he wants to play (P vs P, P vs C, C vs C, exit)
 */
menu :-
	displayMenu,
	write('\nPlease choose an option: '),
	read(Option),
	(parseOption(Option) ->
        replay;
        true
    ).
