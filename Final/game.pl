switchPlayer(Board, 1, NextBoard) :-
	setPlayer(Board, 2),
	board(NB),
	NextBoard is NB.

switchPlayer(Board, 2, NextBoard) :-
	setPlayer(Board, 1),
	board(NB),
	NextBoard is NB.

move([Row, Col, Piece], [Player | Board], NewBoard) :-
    setPiece([Player | Board], Row, Col, Piece), % Nao precisa de guardar na database
    removePiece(Piece, Player),
    board(NB),
    NewBoard is NB.

readAndMove(Player, Board, NewBoard) :-
	parsePiece(Player, Piece),
	parseRow(Player, Row),
	parseColumn(Player, Col),
	(verifyMove(Board, Row, Col, Piece) ->
		(move([Row, Col, Piece], [Player | Board], NB), NewBoard is NB);
		readAndMove(Player, Board, NewBoard)
	).

game_over([Player | Board], Winner) :- 
    checkWin(Board),
	Winner is Player.

play_round([Player | Board]) :-
	display_game(Board, Player),
	readAndMove(Player, Board, NewBoard),
	(game_over(NewBoard, Winner) ->
		displayWinner(Winner);
		(switchPlayer(NewBoard, Player, NextBoard), play_round(NextBoard))
	).

/*
play_round(Player):-
	board(Board),
	display_game(Board, Player),
	format("~nPlayer ~d, what piece do you wanna place? (use lower case) ", [Player]),
	read(PieceSelected),
	verifyPiece(PieceSelected, Player, Res1),
	(Res1==1 -> 
		(format("~nPlayer ~d, in what row do you wanna place ~w? ",  [Player, PieceSelected]),
		read(Row),
		format("~nPlayer ~d, in what column do you wanna place ~w? ",  [Player, PieceSelected]),
		read(Col),
		move([Row, Col, PieceSelected], Board, NewBoard)
		verifyCoords(Row, Col, PieceSelected, Res2),
		(Res2==1 -> 
			(setPiece(Row, Col, PieceSelected),
			removePiece(PieceSelected, Player),
			(checkWin ->
				(board(NewBoard),
				displayBoard(NewBoard), 
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
*/
reset :- 
	(resetBoard, resetPieces);
	(\+resetBoard, \+resetPieces).

startGame :-
	reset,
	addBoard,
	initialPieces,
	board(Board),
	play_round(Board).

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
