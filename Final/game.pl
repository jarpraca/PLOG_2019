switchPlayer(board(CurrentPlayer, PiecesBoard, PiecesPlayer1, PiecesPlayer2), board(NextPlayer, PiecesBoard, PiecesPlayer1, PiecesPlayer2)) :-
	getOpponentPlayer(CurrentPlayer, NextPlayer).

move([Row, Col, Piece], Board, NewBoard) :-
    setPiece(Board, Row, Col, Piece, NewBoard).

movePiece(p, Board, NewBoard) :-
	parsePiece(Board, Piece),
	parseRow(Board, Row),
	parseColumn(Board, Col),
	(verifyMoveError(Board, Row, Col, Piece) ->
		(move([Row, Col, Piece], Board, NB), NewBoard = NB);
		readAndMove(Board, NewBoard)
	).

movePiece(c, Board, NewBoard) :-
	choose_move(Board, 1, Move),
	move(Move, Board, NewBoard).

game_over(Board, Winner) :- 
    checkWin(Board),
    getCurrentPlayer(Board, Player),
	Winner = Player.

play_round(Board) :-
    getCurrentPlayer(Board, Player),
	playerType(Player, PlayerType),
	display_game(Board, Player),
	movePiece(PlayerType, Board, NewBoard),
	(game_over(NewBoard, Winner) ->
		(drawBoard(NewBoard), displayWinner(Winner));
		(switchPlayer(NewBoard, NextBoard), play_round(NextBoard))
	).

startGame(FirstPlayer) :-
	initialPiecesBoard(InitialPiecesBoard),
    initialPiecesPlayer1(InitialPiecesPlayer1),
    initialPiecesPlayer2(InitialPiecesPlayer2),
	play_round(board(FirstPlayer, InitialPiecesBoard, InitialPiecesPlayer1, InitialPiecesPlayer2)).
