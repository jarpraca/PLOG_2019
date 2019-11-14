switchPlayer(board(1, PiecesBoard, PiecesPlayer1, PiecesPlayer2), board(2, PiecesBoard, PiecesPlayer1, PiecesPlayer2)).

switchPlayer(board(2, PiecesBoard, PiecesPlayer1, PiecesPlayer2), board(1, PiecesBoard, PiecesPlayer1, PiecesPlayer2)).

move([Row, Col, Piece], Board, NewBoard) :-
    setPiece(Board, Row, Col, Piece, NewBoard).

readAndMove(Board, NewBoard) :-
	parsePiece(Board, Piece),
	parseRow(Board, Row),
	parseColumn(Board, Col),
	(verifyMove(Board, Row, Col, Piece) ->
		(move([Row, Col, Piece], Board, NB), NewBoard = NB);
		readAndMove(Board, NewBoard)
	).

game_over(Board, Winner) :- 
    checkWin(Board),
    getCurrentPlayer(Board, Player),
	Winner = Player.

play_round(Board) :-
    getCurrentPlayer(Board, Player),
	display_game(Board, Player),
	readAndMove(Board, NewBoard),
	(game_over(NewBoard, Winner) ->
		(drawBoard(NewBoard), displayWinner(Winner));
		(switchPlayer(NewBoard, NextBoard), play_round(NextBoard))
	).

startGame :-
	initialPiecesBoard(InitialPiecesBoard),
    initialPiecesPlayer1(InitialPiecesPlayer1),
    initialPiecesPlayer2(InitialPiecesPlayer2),
	play_round(board(1, InitialPiecesBoard, InitialPiecesPlayer1, InitialPiecesPlayer2)).
