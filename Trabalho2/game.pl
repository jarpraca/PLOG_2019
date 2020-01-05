createPuzzle(Size):-
    initialBoard(Size,Board,InitialColumnRests, InitialRowRests),
    drawBoard(Board,InitialColumnRests, InitialRowRests),
    parseRests(ColumnRests, RowRests),nl,
    drawBoard(Board,ColumnRests,RowRests),
    parseSolution(Board, ColumnRests, RowRests).


randomizePuzzle:-
    randomBoard(_Size,Board,ColumnRests, RowRests),
    drawBoard(Board,ColumnRests,RowRests),
    parseSolution(Board, ColumnRests, RowRests).


parseRests(ColumnRests, RowRests):-
    write('How many column restrictions would you like to set? '),
    read(ColRestNum),
    nl,
    parseColRests(ColRestNum, ColumnRests),
    nl,
    write('How many row restrictions would you like to set? '),
    read(RowRestNum),
    parseRowRests(RowRestNum, RowRests).


parseSolution(Board, ColumnRests, RowRests):-
    write('Would you like me to solve it for you? (y/n)'),
    read(Answer),
    (
        Answer == 'y' ->
            (write('Very Well, heres the solution'),nl,length(Board,Size),time_out(getSolution(Solution, Size, ColumnRests, RowRests),2000,_X),(\+ground(Solution)->write('Solution couldnt be found!\n');drawBoard(Solution,ColumnRests,RowRests)));
            (
                Answer == 'n' ->
                    (write('Very Well,'),replay);
                (write('Unrecognized input, try again.'),nl,parseSolution(Board, ColumnRests, RowRests))
                           
            )   
    ).


parseColRests(0, _ColRestList).

parseColRests(ColRestNum, ColRestList):-
    write('In what column would you like to set the restriction? '),
    read(Col),
    column(Col, Column),
    nl,
    write('What value would you like to set the restriction to? '),
    read(Value),
    NewColRestNum is ColRestNum - 1,
    parseColRests(NewColRestNum,NewColRestList),
    add_tail(NewColRestList,[Column,Value],ColRestList).


parseRowRests(0, _RowRestList).

parseRowRests(RowRestNum, RowRestList):-
    nl,
    write('In what row would you like to set the restriction? '),
    read(Row),
    nl,
    write('What value would you like to set the restriction to? '),
    read(Value),
    NewRowRestNum is RowRestNum - 1,
    parseRowRests(NewRowRestNum,NewRowRestList),
    add_tail(NewRowRestList,[Row,Value],RowRestList).




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

