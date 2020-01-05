
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