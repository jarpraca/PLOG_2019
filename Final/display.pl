draw_column_letters :- write('        a      b      c      d\n').

write_row_number(N):-
	write('  '),
	print(N),
	write('  ').

draw_separator:- write('      ______ ______ ______ ______\n').

drawColumn(Board, Row, Col) :-
	Col < 5,
	write('  '),
	column(ColLetter, Col),
	getPiece(Board, Row, ColLetter, Piece),
	getPieceString(Piece, String),
	print(String),
	write('  |'),
	NextCol is Col+1,
	drawColumn(Board, Row, NextCol).

drawColumn(_, _, 5).

drawRow(Board, Row) :-
	Row < 5,
	write('     |      |      |      |      |\n'),
	write_row_number(Row),
	write('|'),
	drawColumn(Board, Row, 1),
	write('\n     |______|______|______|______|\n'),
	NextRow is Row+1,
	drawRow(Board, NextRow).

drawRow( _, 5).

draw_number(N):-
	write('Player '),
	print(N),
	write('\n').

draw_pieces([]) :-
	write('\n\n').

draw_pieces([H|T]):-
	getPieceString(H, X),	
	print(X),
	write(' '),
    draw_pieces(T).

draw_player(Player):-
	pieces(Player, Pieces),
	draw_number(Player),
	write('Pieces : '),
	draw_pieces(Pieces).

drawBoard(Board) :-
	nl,
	draw_column_letters,
	draw_separator,
	drawRow(Board, 1),
	nl.

display_game(Board, Player) :-
	drawBoard(Board),
	draw_player(Player).

displayWinner(Player) :-
	drawBoard,
	write('  ============================='),nl,
	write('||                             ||'),nl,
	format("||        PLAYER ~d WON!        ||", [Player]),nl,
	write('||                             ||'),nl,
	write('  ============================='),nl.
