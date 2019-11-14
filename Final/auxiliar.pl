parsePiece(Player, Piece) :-
    format("~nPlayer ~d, what piece do you wanna place? (use lower case) ", [Player]),
	read(PieceSelected),
	((pieces(Player, Pieces), member(PieceSelected, Pieces)) -> 
        (format("~nThe piece ~w has been selected.~n", [PieceSelected]), Piece = PieceSelected);
        (format("~nThe piece ~w is not available.~n", [PieceSelected]), parsePiece(Player, Piece))
	).

parseRow(Player, Row) :-
    format("~nPlayer ~d, in what row do you wanna place it? ",  [Player]),
	read(RowSelected),
    ((integer(RowSelected), RowSelected >= 1, RowSelected =< 4) ->
        Row = RowSelected;
        (write('\nRow must be 1, 2, 3 or 4!\n'), parseRow(Player, Row))
    ).

parseColumn(Player, Col) :-
    format("~nPlayer ~d, in what column do you wanna place it? ",  [Player]),
	read(ColSelected),
    (column(ColSelected, _) ->
        Col = ColSelected;
        (write('\nColumn must be a, b, c or d!\n'), parseColumn(Player, Col))
    ).

/*
verifyRow(Row, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(Row, 1, Opposite),
	\+board(Row, 2, Opposite),
	\+board(Row, 3, Opposite),
	\+board(Row, 4, Opposite).

verifyColumn(Col, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(1, Col, Opposite),
	\+board(2, Col, Opposite),
	\+board(3, Col, Opposite),
	\+board(4, Col, Opposite).

verifyQuad(1, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(1, a, Opposite),
	\+board(1, b, Opposite),
	\+board(2, a, Opposite),
	\+board(2, b, Opposite).

verifyQuad(2, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(1, c, Opposite),
	\+board(1, d, Opposite),
	\+board(2, c, Opposite),
	\+board(2, d, Opposite).

verifyQuad(3, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(3, a, Opposite),
	\+board(3, b, Opposite),
	\+board(4, a, Opposite),
	\+board(4, b, Opposite).

verifyQuad(4, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(3, c, Opposite),
	\+board(3, d, Opposite),
	\+board(4, c, Opposite),
	\+board(4, d, Opposite).

verifyCoords(Row, Col, Piece, Res) :- 
	((integer(Row), Row >= 1, Row =< 4, column(Col, _)) -> 
		(\+board(Row, Col, e) ->
			(write('\nThis cell already has a piece!\n'), Res=0);
			(verifyRow(Row, Piece), verifyColumn(Col, Piece), getQuad(Row, Col, Quad), verifyQuad(Quad, Piece) ->
				Res=1;
				(write('\nYou cannot place a piece in the same row, column or quadrant as another piece of the same shape but different color!\n'), Res=0)
			)
		);
		write('\nRow or Column are incorrect!\n')
	).
*/

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

verifyEmptyCell(Board, Row, Col) :-
    member(cell(Row, Col, e), Board).

verifyMove(Board, Row, Col, Piece) :- 
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

delete_one(X,L,L1):-
    append(La,[X|Lb],L),
    append(La,Lb,L1). 

removePiece(Piece, Player) :-
    pieces(Player, Pieces),
    delete_one(Piece, Pieces, NewPieces),
    updatePieces(Player, NewPieces).

convertToShapes([], _).

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
