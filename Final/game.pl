switchPlayer(Player,NextPlayer):-
	(Player == 1 -> 
		NextPlayer is 2;
		NextPlayer is 1
	).

play_round(Player):-
	display_game(Player),
	format("~nPlayer ~d, what piece do you wanna place? ", [Player]),
	read(PieceSelected),
	verifyPiece(PieceSelected, Player, Res1),
	(Res1==1 -> 
		(format("~nPlayer ~d, in what row do you wanna place ~w? ",  [Player, PieceSelected]),
		read(Row),
		format("~nPlayer ~d, in what column do you wanna place ~w? ",  [Player, PieceSelected]),
		read(Col),
		verifyCoords(Row, Col, PieceSelected, Res2),
		(Res2==1 -> 
			(setPiece(Row, Col, PieceSelected),
			removePiece(PieceSelected, Player),
			(checkWin ->
				(display_game(Player), 
				displayWinner(Player)
				);
				(switchPlayer(Player, NextPlayer),
				play_round(NextPlayer))
				)
			);
			play_round(Player)
		)
		);
		play_round(Player)
	).

reset :- 
	(resetBoard, resetPieces);
	(\+resetBoard, \+resetPieces).

startGame :-
	reset,
	addBoard,
	initialPieces,
	play_round(1).

parseOption(0).

parseOption(1) :-
	startGame.

parseReplay(y) :-
	menu.

parseReplay(n).

menu :-
	displayMenu,
	write('\nPlease choose an option: '),
	read(Option),
	parseOption(Option),
	write('\nDo you want to play again? (y/n) '),
	read(Replay),
	parseReplay(Replay).
