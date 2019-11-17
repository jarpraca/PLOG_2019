switchPlayer(board(CurrentPlayer, PiecesBoard, PiecesPlayer1, PiecesPlayer2), board(NextPlayer, PiecesBoard, PiecesPlayer1, PiecesPlayer2)) :-
	getOpponentPlayer(CurrentPlayer, NextPlayer).

move([Row, Col, Piece], Board, NewBoard) :-
    setPiece(Board, Row, Col, Piece, NewBoard).

movePiece(p, Board, NewBoard, Level) :-
	parsePiece(Board, Piece),
	parseRow(Board, Row),
	parseColumn(Board, Col),
	(verifyMoveError(Board, Row, Col, Piece) ->
		(move([Row, Col, Piece], Board, NB), NewBoard = NB);
		movePiece(p, Board, NewBoard, Level)
	).

movePiece(c, Board, NewBoard, 2) :-
	write('Thinking...'),
	choose_move(Board, 2, Move),
	move(Move, Board, NewBoard),
	nl.

movePiece(c, Board, NewBoard, Level) :-
	write('Thinking...'),
	choose_move(Board, Level, Move),
	move(Move, Board, NewBoard),
	sleep(1),
	nl.

game_over(Board, Winner) :- 
    checkWin(Board),
    getCurrentPlayer(Board, Player),
	Winner = Player.

play_round(Board, LevelPlayer1, LevelPlayer2) :-
    getCurrentPlayer(Board, Player),
	playerType(Player, PlayerType),
	currentPlayerLevel(Player, LevelPlayer1, LevelPlayer2, CurrentLevel),
	display_game(Board, Player),
	movePiece(PlayerType, Board, NewBoard, CurrentLevel),
	(game_over(NewBoard, Winner) ->
		(drawBoard(NewBoard), displayWinner(Winner));
		(switchPlayer(NewBoard, NextBoard), play_round(NextBoard, LevelPlayer1, LevelPlayer2))
	).

startGame(FirstPlayer, LevelPlayer1, LevelPlayer2) :-
	initialPiecesBoard(InitialPiecesBoard),
    initialPiecesPlayer1(InitialPiecesPlayer1),
    initialPiecesPlayer2(InitialPiecesPlayer2),
	play_round(board(FirstPlayer, InitialPiecesBoard, InitialPiecesPlayer1, InitialPiecesPlayer2), LevelPlayer1, LevelPlayer2).
