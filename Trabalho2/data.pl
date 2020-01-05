
/**
 * Initial empty Board
 */

getLine(0,Line).

getLine(N, Line):-
    NewN is N-1,
    getLine(NewN,NewLine),
    add_tail(NewLine,0,Line).


initialBoardAux(0,Line,Board).

initialBoardAux(N,Line,Board):-
    NewN is N-1,
    initialBoardAux(NewN,Line,NewBoard),
    add_tail(NewBoard,Line,Board).
/*
getRest([ColumnRestHead,ColumnRestTail], [RowRestHead,RowRestTail],N):-
    MaxValue is N-2,
    random(2,MaxValue,ColumnRestValue),
    random(2,MaxValue,RowRestValue),
    random(1,N,ColumnRestIndex),
    random(1,N,RowRestIndex),
    ColumnRestHead is ColumnRestIndex,
    ColumnRestTail is ColumnRestValue,
    RowRestHead is RowRestIndex,
    RowRestTail is RowRestValue.*/

initialBoard(N,Board,[[0,0]], [[0,0]]):-
    %getRest(ColumnRest, RowRest,N),
    %print('ColumnRest: '),
    %print(ColumnRest),nl,
    %print('RowRest: '),
    %print(RowRest),nl,
    getLine(N,Line),
    initialBoardAux(N,Line,Board).

getRandomRest([RestsIndex,RestsValue],Size):-
    random(1,Size,RestsIndex),
    MaxValue is Size - 1, 
    random(2, MaxValue, RestsValue).


getRandomRests([Rests],1,Size):-
    getRandomRest(Rests,Size).

getRandomRests([RestsHead|RestsTail],Number,Size):-
    getRandomRest(RestsHead,Size),
    NewNumber is Number - 1,
    getRandomRests(RestsTail,NewNumber,Size).





randomBoard(Size,Board,ColumnRests, RowRests):-
    random(9,11,Size),
    length(Board,Size),
    forceRowLength(Board,Size),
    random(1,3,NumberOfColumnRests),
    random(1,3,NumberOfRowRests),
    getRandomRests(ColumnRests,NumberOfColumnRests,Size),
    getRandomRests(RowRests,NumberOfRowRests,Size),
    print(Board),nl.
    



/**
 * Associates a column letter with a respective number
 */
column(a,1).
column(b,2).
column(c,3).
column(d,4).
column(e,5).
column(f,6).
column(g,7).
column(h,8).
column(i,9).
column(j,10).

/**
 * Existing levels
 */
level(1).
level(2).
level(3).

/**
 * Associates a piece with its respective string to display
 */
getPieceString(0, ' ').
getPieceString(1, 'X').