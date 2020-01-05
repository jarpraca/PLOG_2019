

/**
 * Gets a piece from the Board in a certain Row and Col
 * Return the Piece
 */

getPiece(Board, Row, Col, Piece) :-
    nth1(Row, Board, RowLine),
    column(Col, ColN),
    nth1(ColN, RowLine, Piece).

/**
 * Writes column names
 */



checkRestsByIndex([],Index):- fail.

checkRestsByIndex([[RestsHeadIndex|RestsHeadValue]|RestsTail],Index):-
    (RestsHeadIndex == Index ->
        true;
        checkRestsByIndex(RestsTail,Index) 
    ).


getValueOfIndex([],Index,Rest):- fail.

getValueOfIndex([[RestsHeadIndex,RestsHeadValue]|RestsTail],Index,Value):-
    (RestsHeadIndex == Index ->
        Value is RestsHeadValue;
        getValueOfIndex(RestsTail,Index,Value) 
    ).


draw_column_header(0,Size,ColumnRests).

draw_column_header(N,Size,ColumnRests):-
    Index is (Size - N + 1),
    NewN is N - 1,
    (checkRestsByIndex(ColumnRests,Index) ->
        (write('  '),column(Col,Index),getValueOfIndex(ColumnRests,Index,ColumnRestValue),write(Col),write('-'),write(ColumnRestValue),write(' '));
        (write('   '),column(Col,Index),write(Col),write('  '))
    ),
    
    draw_column_header(NewN,Size,ColumnRests).

/**
 * Writes row number
 */
draw_row_number(N, RowRests):-
    (N < 10 ->
        (checkRestsByIndex(RowRests,N)  ->
            (write(' '),getValueOfIndex(RowRests,N,RowRestValue), write(N),write('-'),write(RowRestValue),write(' '));
            (write('  '),write(N),write('  '))
        );
        (checkRestsByIndex(RowRests,N)  ->
            (getValueOfIndex(RowRests,N,RowRestValue), write(N),write('-'),write(RowRestValue),write(' '));
            (write(' '),write(N),write('  '))
        )
    ).

/**
 * Draws board line separator
 */
draw_separator(BoardSize):-
    write('      '),
    draw_separatorAux(BoardSize).

draw_separatorAux(0):-
    nl.

draw_separatorAux(BoardSize):-
    write('_____ '),
    NewBoardSize is BoardSize-1,
    draw_separatorAux(NewBoardSize).

/**
 * Draws all pieces of a Row using Col to find each piece in Board
 */
drawColumn(_Board, _Row, 0, BoardSize).

drawColumn(Board, Row, Col, BoardSize) :-
	write('  '),
    column(ColLetter, Col),
    print(Board),
	getPiece(Board, Row, ColLetter, Piece),
    getPieceString(Piece, String),
    write(Piece),
	write(String),
	write('  |'),
	NextCol is Col-1,
	drawColumn(Board, Row, NextCol, BoardSize).


drawMidDash(0):-
    nl.

drawMidDash(BoardSize):-
    write('     |'),
    NewBoardSize is BoardSize-1,
    drawMidDash(NewBoardSize).


drawBottomDash(0):-
    nl.

drawBottomDash(BoardSize):-
    write('_____|'),
    NewBoardSize is BoardSize-1,
    drawBottomDash(NewBoardSize).

/**
 * Draws all rows of Board and its internal separators
 */
drawRow( _Board, BoardSize, RowRests, BoardSize):-
    write('     |'),
    drawMidDash(BoardSize),
	draw_row_number(BoardSize, RowRests),
	write('|'),
    drawColumn(Board, BoardSize, BoardSize, BoardSize),
    write('\n     |'),    
	%write('     |_____|_____|_____|_____|\n'),
    drawBottomDash(BoardSize).

drawRow(Board, Row, RowRests, BoardSize) :-
    write('     |'),
    drawMidDash(BoardSize),
	draw_row_number(Row, RowRests),
	write('|'),
    drawColumn(Board, Row, BoardSize, BoardSize),
    write('\n     |'),    
	%write('     |_____|_____|_____|_____|\n'),
    drawBottomDash(BoardSize),
	NextRow is Row+1,
	drawRow(Board, NextRow, RowRests, BoardSize).

/**
 * Draws pieces of the list received
 */
draw_pieces([]) :-
	write('\n\n').

draw_pieces([H|T]):-
	getPieceString(H, X),	
	print(X),
	write(' '),
    draw_pieces(T).

/**
 * Draws Board (all rows, column and respective pieces)
 */
drawBoard(Board,ColumnRests, RowRests) :-
    nl,
    length(Board, BoardSize),
    write('     '),
	draw_column_header(BoardSize,BoardSize, ColumnRests),nl,
	draw_separator(BoardSize),
	drawRow(Board, 1, RowRests, BoardSize),
	nl.
