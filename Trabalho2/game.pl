createPuzzle(Size):-
    initialBoard(Size,Board,ColumnRest, RowRest),
    drawBoard(Board,ColumnRest, RowRest),
    parseRests(ColumnRests, RowRests),nl,
    drawBoard(Board,ColumnRests,RowRests),
    parseSolution(Board, ColumnRests, RowRests).


parseRests(ColumnRests, RowRests):-
    write('How many column restrictions would you like to set? '),
    read(ColRestNum),
    parseColRests(ColRestNum, ColumnRests),
    write('How many row restrictions would you like to set? '),
    read(RowRestNum),
    parseRowRests(RowRestNum, RowRests).


parseSolution(Board, ColumnRests, RowRests):-
    write('Would you like me to solve it for you? (y-n)'),
    read(Answer),
    (
        Answer == 'y' ->
            (write('Very Well, heres the solution'),nl,getSolution(Solution, ColumnRests, RowRests),drawBoard(Solution,ColumnRests,RowRests));
            (
                Answer == 'n' ->
                    (write('Very Well,'),replay);
                (write('Unrecognized input, try again.'),nl,parseSolution(Board, ColumnRests, RowRests))
                           
            )   
    ).







parseColRests(0, ColRestList).

parseColRests(ColRestNum, ColRestList):-
    write('In what column would you like to set the restriction? '),
    read(Col),
    write('What value would you like to set the restriction to? '),
    read(Value),
    NewColRestNum is ColRestNum - 1,
    parseColRests(NewColRestNum,NewColRestList),
    add_tail(NewColRestList,[Col,Value],ColRestList).


parseRowRests(0, RowRestList).

parseRowRests(RowRestNum, RowRestList):-
    write('In what row would you like to set the restriction? '),
    read(Row),
    write('What value would you like to set the restriction to? '),
    read(Value),
    NewRowRestNum is RowRestNum - 1,
    parseRowRests(NewRowRestNum,NewRowRestList),
    add_tail(NewRowRestList,[Row,Value],RowRestList).



%    play_round(Board,ColumnRest, RowRest).


/**
 * Game loop:
 * Displays Board
 * Moves piece for current player
 * Checks if current player won
 * If so, displays winner
 * Else, switches player and plays next round
 */
play_round(Board,ColumnRest, RowRest) :-
	movePiece(Board, ColumnRest, RowRest, NewBoard),
	(isSolution(NewBoard,ColumnRest, RowRest) ->
		(drawBoard(Board,ColumnRest, RowRest),displayWinner);
		(drawBoard(Board,ColumnRest, RowRest), play_round(NewBoard,ColumnRest, RowRest))
    ).




movePiece(Board, NewBoard,ColumnRest, RowRest) :-
    length(Board, BoardSize),
	parseRow(Board, Row, BoardSize),
	parseColumn(Board, Col, BoardSize),
	(verifyMove(Board, Row, Col,ColumnRest, RowRest) ->
		(move([Row, Col, Piece], Board, NB), NewBoard = NB);
		movePiece(p, Board, NewBoard, Level)
	).



/**
 * Asks the user for a row
 * Reads the row
 * Checks if the row is correct
 * Returns the row
 */
parseRow(Board, Row, BoardSize) :-
    write('In what row do you want to place the next piece?'),
	read(RowSelected),
    ((integer(RowSelected), RowSelected >= 1, RowSelected =< BoardSize) ->
        Row = RowSelected;
        (write('\nRow must be one of the numbers on the left of the board!\n'), parseRow(Board, Row, BoardSize))
    ).

/**
 * Asks the user for a column
 * Reads the column
 * Checks if the column is correct
 * Returns the column
 */
parseColumn(Board, Col, BoardSize) :-
    write('In what column do you want to place the next piece?'),
	read(ColSelected),
    ((column(ColSelected, ColNumber), ColNumber >= 1, ColNumber =< BoardSize) ->
        Col = ColSelected;
        (write('\nColumn must be one of the letters on top of the board!\n'), parseColumn(Board, Col, BoardSize))
    ).


/**
 * Verifies if a move is valid, meaning the cell is empty and there isn't an opposite piece in the same row, column or quadrant
 * Prints error if any of the previous constrains fails
 */
verifyMove(Board, Row, Col,ColumnRest, RowRest) :- 
    (verifyEmptyCell(Board, Row, Col) ->
        true;
        (write('\nThis cell already has a piece!\n'), fail)
    ),
    (verifyRow(Board, Row, Col) ->
        true;
        (write('\nThis row already has two pieces!\n'), fail)
    ),
    (verifyColumn(Board, Row, Col) ->
        true;
        (write('\nThis column already has two pieces!\n'), fail)
    ),
    (verifySurroundings(Board, Row, Col) ->
        true;
        (write('\nTheres a piece in the cells surrouding the selected one!\n'), fail)
    ).

verifyEmptyCell(Board, Row, Col):-
    getCell(Board,Row,Col,Cell),
    (
        Cell == 1 ->
            fail;
        true
    ).

getSum([], 0).
getSum([H|T], Sum):-
    getSum(T, X),
    Sum is X + H.

verifyRow(Board, Row, Col):-
    nth1(Row, Board, Line),
    getSum(Line, Sum),
    (
        Sum == 2 ->
            fail;
        true
    ).

verifyColumn(Board, Row, Col):-
    transpose(Board, Columns),
    nth1(Col, Columns, Column),
    getSum(Column, Sum),
    (
        Sum == 2 ->
            fail;
        true
    ).

verifySurroundings(Board, Row, Col):-
    transpose(Board, Columns),
    %getAllDiags(Board, Diags),
    checkAllForConsecutives(Board),
    checkAllForConsecutives(Columns).
    %checkAllForConsecutives(Diags).

verifyRests(Board, Row, Col, [RowRestIndex,RowRestValue], [ColumnRestIndex,ColumnRestValue]):-
    transpose(Board, Columns),
    nth1(ColumnRestIndex, Columns, Restr1),
    countSpaces(Restr1, Count1),
    Count1 #= ColumnRestValue,
    nth1(RowRestIndex, Board, Restr2),
    countSpaces(Restr2, Count2),
    Count2 #= RowRestValue.
    
    