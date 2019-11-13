verifyPiece(Piece, Player, Res) :-
	((pieces(Player, Pieces), member(Piece, Pieces)) -> 
        (format("~nThe piece ~w has been selected.~n", [Piece]), Res=1);
        (format("~nThe piece ~w is not available.~n", [Piece]), Res=0)
	).

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
	\+board(4, b, Opposite),
	\+board(3, a, Opposite),
	\+board(4, b, Opposite).

verifyQuad(4, Piece) :-
	oppositePiece(Piece, Opposite),
	\+board(3, c, Opposite),
	\+board(4, d, Opposite),
	\+board(3, c, Opposite),
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

rowToList(Row, List) :-
    board(Row, a, X1),
    getShape(X1, Y1),
    board(Row, b, X2),
    getShape(X2, Y2),
    board(Row, c, X3),
    getShape(X3, Y3),
    board(Row, d, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

columnToList(Col, List) :-
    board(1, Col, X1),
    getShape(X1, Y1),
    board(2, Col, X2),
    getShape(X2, Y2),
    board(3, Col, X3),
    getShape(X3, Y3),
    board(4, Col, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(1, List) :-
    board(1, a, X1),
    getShape(X1, Y1),
	board(1, b, X2),
    getShape(X2, Y2),
	board(2, a, X3),
    getShape(X3, Y3),
	board(2, b, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(2, List) :-
    board(1, c, X1),
    getShape(X1, Y1),
	board(1, d, X2),
    getShape(X2, Y2),
	board(2, c, X3),
    getShape(X3, Y3),
	board(2, d, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(3, List) :-
    board(3, a, X1),
    getShape(X1, Y1),
	board(3, b, X2),
    getShape(X2, Y2),
	board(4, a, X3),
    getShape(X3, Y3),
	board(4, b, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

quadToList(4, List) :-
    board(3, c, X1),
    getShape(X1, Y1),
	board(3, d, X2),
    getShape(X2, Y2),
	board(4, c, X3),
    getShape(X3, Y3),
	board(4, d, X4),
    getShape(X4, Y4),
    List = [Y1, Y2, Y3, Y4].

checkListUnique([H|[]], 1) :-
    \+H == e.

checkListUnique([H|T], N) :-
    \+H == e,
    \+member(H, T),
    X is N-1,
    checkListUnique(T, X).

checkRowWin(Row) :- 
    rowToList(Row, Pieces),
    checkListUnique(Pieces, 4).

checkColumnWin(Col) :- 
    columnToList(Col, Pieces),
    checkListUnique(Pieces, 4).

checkQuadWin(Quad) :- 
    quadToList(Quad, Pieces),
    checkListUnique(Pieces, 4).

checkWin :- 
    checkRowWin(1);
    checkRowWin(2);
    checkRowWin(3);
    checkRowWin(4);
    checkColumnWin(a);
    checkColumnWin(b);
    checkColumnWin(c);
    checkColumnWin(d);
    checkQuadWin(1);
    checkQuadWin(2);
    checkQuadWin(3);
    checkQuadWin(4).
