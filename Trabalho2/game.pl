
/**
 * Creates a puzzle of a given size and initiates the first mode of the app
 */	
createPuzzle(Size):-
    initialBoard(Size,Board,InitialColumnRests, InitialRowRests),
    drawBoard(Board,InitialColumnRests, InitialRowRests),
    parseRests(ColumnRests, RowRests),nl,
    drawBoard(Board,ColumnRests,RowRests),
    parseSolution(Board, ColumnRests, RowRests).

/**
 * Randomizes a puzzle and initiates the second mode of the app
 */	
randomizePuzzle:-
    randomBoard(_Size,Board,ColumnRests, RowRests),
    drawBoard(Board,ColumnRests,RowRests),
    parseSolution(Board, ColumnRests, RowRests).

/**
 * Asks user for the info about the restrictions to place on the board
 */	
parseRests(ColumnRests, RowRests):-
    write('How many column restrictions would you like to set? '),
    read(ColRestNum),
    nl,
    parseColRests(ColRestNum, ColumnRests),
    nl,
    write('How many row restrictions would you like to set? '),
    read(RowRestNum),
    parseRowRests(RowRestNum, RowRests).

/**
 * Asks user if he wants the solution
 */	
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


/**
 * Asks user for the info on the desired restrictions
 */	

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



