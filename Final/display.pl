draw_column_letters :- write('        a      b      c      d\n').

write_row_number(N):-
	write('  '),
	print(N),
	write('  ').

draw_separator:- write('      ______ ______ ______ ______\n').

drawColumn(_Board, _Row, 5).

drawColumn(Board, Row, Col) :-
	Col < 5,
	write('  '),
	column(ColLetter, Col),
	getPiece(Board, Row, ColLetter, Piece),
	getPieceString(Piece, String),
	write(String),
	write('  |'),
	NextCol is Col+1,
	drawColumn(Board, Row, NextCol).

drawRow( _Board, 5).

drawRow(Board, Row) :-
	Row < 5,
	write('     |      |      |      |      |\n'),
	write_row_number(Row),
	write('|'),
	drawColumn(Board, Row, 1),
	write('\n     |______|______|______|______|\n'),
	NextRow is Row+1,
	drawRow(Board, NextRow).

draw_name(Player):-
	playerName(Player, PlayerName),
	print(PlayerName),
	write('\n').

draw_pieces([]) :-
	write('\n\n').

draw_pieces([H|T]):-
	getPieceString(H, X),	
	print(X),
	write(' '),
    draw_pieces(T).

draw_player(Board, Player):-
	getPiecesPlayer(Board, Player, Pieces),
	draw_name(Player),
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
	draw_player(Board, Player).

displayWinner(Player) :-
	write('  ============================='),nl,
	write('||                             ||'),nl,
	displayWinnerName(Player),
	write('||                             ||'),nl,
	write('  ============================='),nl.

displayWinnerName(p) :-
	playerNameCaps(p, PlayerName),
	format("||         ~w WON!         ||", [PlayerName]),nl.

displayWinnerName(c1) :-
	playerNameCaps(c1, PlayerName),
	format("||       ~w WON!       ||", [PlayerName]),nl.

displayWinnerName(c2) :-
	playerNameCaps(c2, PlayerName),
	format("||       ~w WON!       ||", [PlayerName]),nl.

displayWinnerName(Player) :-
	playerNameCaps(Player, PlayerName),
	format("||        ~w WON!        ||", [PlayerName]),nl.

