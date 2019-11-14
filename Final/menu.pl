displayMenu :-
    write(' ________________________________________________________________'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|              o-o  o   o   O  o   o o-O-o o-O-o o  o            |'),nl,
    write('|             o   o |   |  / \\ |\\  |   |     |   | /             |'),nl,
    write('|             |   | |   | o---o| \\ |   |     |   OO              |'),nl,
    write('|             o   O |   | |   ||  \\|   |     |   | \\             |'),nl,
    write('|              o-O\\  o-o  o   oo   o   o   o-O-o o  o            |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                  _____ ______________________                  |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  1  |   Player vs Player   |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  2  |  Player vs Computer  |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  3  | Computer vs Computer |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                 |     |                      |                 |'),nl,
    write('|                 |  0  |         Exit         |                 |'),nl,
    write('|                 |_____|______________________|                 |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|                                                                |'),nl,
    write('|             Developed by: Joao Praca, Lucas Ribeiro            |'),nl,
    write('|________________________________________________________________|'),nl.

parseOption(0) :-
    fail.

parseOption(1) :-
	startGame.

parseReplay(y) :-
	menu.

parseReplay(n).

replay :-
    write('\nDo you want to play again? (y/n) '),
	read(Replay),
	parseReplay(Replay).

menu :-
	displayMenu,
	write('\nPlease choose an option: '),
	read(Option),
	(parseOption(Option) ->
        replay;
        true
    ).
