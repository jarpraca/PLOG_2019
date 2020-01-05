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
    write('|                  ____________________________                  |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  1  |    Create Puzzle     |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  2  |   Randomize Puzzle   |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  0  |        Exit          |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|             Developed by: Joao Praca, Lucas Ribeiro            |'),nl,
    write('|________________________________________________________________|'),nl.



/**
 * Parses menu option chosen and behaves accordingly:
 * 0 - Exit
 * 1 - Create Puzzle
 * 1 - Auto generate puzzle
 */
parseOption(0) :-
    fail.

parseOption(1) :-
    chooseSize(Size),
    (verifySize(Size) ->
        (format("~nYou chose size: ~wx~w", [Size,Size]),createPuzzle(Size));
        (write('Size should be either 9 or 10\n'),parseOption(1))
    ).

parseOption(2) :-
    randomizePuzzle. 


/**
 * Verifies if input size is acceptable
 */	
verifySize(Size):-
    Size > 8,
    Size < 11.

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
chooseSize(Size) :-
    write('Choose the puzzles size: '),
    read(Size).

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
