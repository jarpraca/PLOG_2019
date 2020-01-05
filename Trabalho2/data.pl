
/**
 * Initial empty Board
 */

getLine(0,_Line).

getLine(N, Line):-
    NewN is N-1,
    getLine(NewN,NewLine),
    add_tail(NewLine,0,Line).


initialBoardAux(0,_Line,_Board).

initialBoardAux(N,Line,Board):-
    NewN is N-1,
    initialBoardAux(NewN,Line,NewBoard),
    add_tail(NewBoard,Line,Board).


initialBoard(N,Board,[[0,0]], [[0,0]]):-
    getLine(N,Line),
    initialBoardAux(N,Line,Board).

/**
* Generates a random board for the puzzle
*/

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
    getRandomRests(RowRests,NumberOfRowRests,Size).
    



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
 * Associates a piece with its respective string to display
 */
getPieceString(0, ' ').
getPieceString(1, 'X').