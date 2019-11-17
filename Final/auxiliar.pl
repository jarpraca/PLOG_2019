hasPiece(Board, Player, Piece) :-
    getPiecesPlayer(Board, Player, Pieces),
    delete_duplicates(Pieces, UniquePieces),
    member(Piece, UniquePieces).

parsePiece(Board, Piece) :-
    getCurrentPlayer(Board, Player),
    playerName(Player, PlayerName),
    format("~n~w, what piece do you want to place? (use lower case) ", [PlayerName]),
	read(PieceSelected),
	(hasPiece(Board, Player, PieceSelected) -> 
        (format("~nThe piece ~w has been selected.~n", [PieceSelected]), Piece = PieceSelected);
        (format("~nThe piece ~w is not available.~n", [PieceSelected]), parsePiece(Board, Piece))
	).

parseRow(Board, Row) :-
    getCurrentPlayer(Board, Player),
    playerName(Player, PlayerName),
    format("~n~w, in what row do you want to place it? ",  [PlayerName]),
	read(RowSelected),
    ((integer(RowSelected), RowSelected >= 1, RowSelected =< 4) ->
        Row = RowSelected;
        (write('\nRow must be 1, 2, 3 or 4!\n'), parseRow(Board, Row))
    ).

parseColumn(Board, Col) :-
    getCurrentPlayer(Board, Player),
	playerName(Player, PlayerName),
    format("~n~w, in what column do you want to place it? ",  [PlayerName]),
	read(ColSelected),
    (column(ColSelected, _ColNumber) ->
        Col = ColSelected;
        (write('\nColumn must be a, b, c or d!\n'), parseColumn(Board, Col))
    ).

verifyRow(Board, Row, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, Row, a, Opposite),
    \+getPiece(Board, Row, b, Opposite),
    \+getPiece(Board, Row, c, Opposite),
    \+getPiece(Board, Row, d, Opposite).

verifyColumn(Board, Col, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, 1, Col, Opposite),
    \+getPiece(Board, 2, Col, Opposite),
    \+getPiece(Board, 3, Col, Opposite),
    \+getPiece(Board, 4, Col, Opposite).

verifyQuad(Board, 1, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, 1, a, Opposite),
    \+getPiece(Board, 1, b, Opposite),
    \+getPiece(Board, 2, a, Opposite),
    \+getPiece(Board, 2, b, Opposite).

verifyQuad(Board, 2, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, 1, c, Opposite),
    \+getPiece(Board, 1, d, Opposite),
    \+getPiece(Board, 2, c, Opposite),
    \+getPiece(Board, 2, d, Opposite).

verifyQuad(Board, 3, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, 3, a, Opposite),
    \+getPiece(Board, 3, b, Opposite),
    \+getPiece(Board, 4, a, Opposite),
    \+getPiece(Board, 4, b, Opposite).

verifyQuad(Board, 4, Piece) :-
	oppositePiece(Piece, Opposite),
    \+getPiece(Board, 3, c, Opposite),
    \+getPiece(Board, 3, d, Opposite),
    \+getPiece(Board, 4, c, Opposite),
    \+getPiece(Board, 4, d, Opposite).

verifyEmptyCell(board(_CurrentPlayer, PiecesBoard, _PiecesPlayer1, _PiecesPlayer2), Row, Col) :-
    member(cell(Row, Col, e), PiecesBoard).

verifyMoveError(Board, Row, Col, Piece) :- 
    (verifyEmptyCell(Board, Row, Col) ->
        true;
        (write('\nThis cell already has a piece!\n'), fail)
    ),
    (verifyRow(Board, Row, Piece) ->
        true;
        (write('\nYou cannot place a piece in the same row as another piece of the same shape but different color!\n'), fail)
    ),
    (verifyColumn(Board, Col, Piece) ->
        true;
        (write('\nYou cannot place a piece in the same column as another piece of the same shape but different color!\n'), fail)
    ),
    ((getQuad(Row, Col, Quad), verifyQuad(Board, Quad, Piece)) ->
        true;
        (write('\nYou cannot place a piece in the same quadrant as another piece of the same shape but different color!\n'), fail)
    ).

verifyMove(Board, Row, Col, Piece) :- 
    verifyEmptyCell(Board, Row, Col),
    verifyRow(Board, Row, Piece),
    verifyColumn(Board, Col, Piece),
    getQuad(Row, Col, Quad),
    verifyQuad(Board, Quad, Piece).

delete_one(X,L,L1):-
    append(La,[X|Lb],L),
    append(La,Lb,L1). 

delete_duplicates(X, Y) :-
    sort(X, Y).

difference_lists(L1, [H | T], L) :-
    delete_one(H, L1, L),
    difference_lists(L1, T, L).

convertToShapes([], _Shapes).

convertToShapes([H|T], Shapes) :-
    getShape(H, S),
    append([S], Shapes, Shapes),
    convertToShapes(T, Shapes).

rowToList(Board, Row, List) :-
    getPiece(Board, Row, a, X1),
    getPiece(Board, Row, b, X2),
    getPiece(Board, Row, c, X3),
    getPiece(Board, Row, d, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

columnToList(Board, Col, List) :-
    getPiece(Board, 1, Col, X1),
    getPiece(Board, 2, Col, X2),
    getPiece(Board, 3, Col, X3),
    getPiece(Board, 4, Col, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(Board, 1, List) :-
    getPiece(Board, 1, a, X1),
    getPiece(Board, 1, b, X2),
    getPiece(Board, 2, a, X3),
    getPiece(Board, 2, b, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(Board, 2, List) :-
    getPiece(Board, 1, c, X1),
    getPiece(Board, 1, d, X2),
    getPiece(Board, 2, c, X3),
    getPiece(Board, 2, d, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(Board, 3, List) :-
    getPiece(Board, 3, a, X1),
    getPiece(Board, 3, b, X2),
    getPiece(Board, 4, a, X3),
    getPiece(Board, 4, b, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(Board, 4, List) :-
    getPiece(Board, 3, c, X1),
    getPiece(Board, 3, d, X2),
    getPiece(Board, 4, c, X3),
    getPiece(Board, 4, d, X4),
    getShape(X1, Y1),
    getShape(X2, Y2),
    getShape(X3, Y3),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

checkListUnique([H|[]], 1) :-
    \+H == e.

checkListUnique([H|T], N) :-
    \+H == e,
    \+member(H, T),
    X is N-1,
    checkListUnique(T, X).

checkRowWin(Board, Row) :- 
    rowToList(Board, Row, Pieces),
    checkListUnique(Pieces, 4).

checkColumnWin(Board, Col) :- 
    columnToList(Board, Col, Pieces),
    checkListUnique(Pieces, 4).

checkQuadWin(Board, Quad) :- 
    quadToList(Board, Quad, Pieces),
    checkListUnique(Pieces, 4).

checkWin(Board) :- 
    checkRowWin(Board, 1);
    checkRowWin(Board, 2);
    checkRowWin(Board, 3);
    checkRowWin(Board, 4);
    checkColumnWin(Board, a);
    checkColumnWin(Board, b);
    checkColumnWin(Board, c);
    checkColumnWin(Board, d);
    checkQuadWin(Board, 1);
    checkQuadWin(Board, 2);
    checkQuadWin(Board, 3);
    checkQuadWin(Board, 4).

opponent_loses([_Row, _Col, Piece], Board, Player) :-
    oppositePiece(Piece, Opposite),
    getOpponentPlayer(Player, Opponent), 
    \+hasPiece(Board, Opponent, Opposite).

opponent_can_win([_Row, _Col, Piece], Board, Player) :-
    oppositePiece(Piece, Opposite),
    getOpponentPlayer(Player, Opponent), 
    hasPiece(Board, Opponent, Opposite).

currentPlayerLevel(Player, LevelPlayer1, LevelPlayer2, CurrentLevel) :-
    playerNumber(Player, PlayerNumber),
    (PlayerNumber =:= 1 ->
        CurrentLevel is LevelPlayer1;
        CurrentLevel is LevelPlayer2
    ).