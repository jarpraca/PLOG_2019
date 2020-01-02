:- use_module(library(clpfd)).
:- use_module(library(lists)).

/**
* Gets the Cell from Board located in Row and Col
*/
getCell(Board, Row, Col, Cell) :-
    nth1(Row, Board, Line),
    nth1(Col, Line, Cell).

checkAllCells(Board) :-
    checkAllLines(Board, Board, 1).

checkAllLines(_Board, [], _Row).

checkAllLines(Board, [Line | Lines], Row) :-
    checkLine(Board, Line, Row, 1),
    NextRow is Row+1,
    checkAllLines(Board, Lines, NextRow).

checkLine(_Board, [], _Row, _Col).

checkLine(Board, [E | Line], Row, Col) :-
    %format("~w ~w ~w", [Row, Col, E]),nl,
    checkSurroundingCells(Board, E, Row, Col),
    NextCol is Col+1,
    checkLine(Board, Line, Row, NextCol).

% checkAllCells(Board, Row, Col)

% checkAllCells(Board, Row, Col) :-
%     getCell(Board, Row, Col, Cell),
%     checkSurroundingCells(Board, Cell, Row, Col),
    

/**
* Checks if a cell located in Row and Col is black and if its surroundings cells are all white
*/


% checkSurroundingCells(_Board, Vars, 0) :-
%     getCell(Board, Row, Col, Cell),
%     format("~w ~w ~w", [Row, Col, Cell]),nl,
%     print(Vars),nl.


checkSurroundingCells(Board, Cell, Row, Col) :-
    % getCell(Board, Row, Col, Cell),
    %nth1(Row, Board, Line),
    %format("~w ~w ~w", [Row, Col, 1]),nl,
    %Cell #= 1, 
    ground(Cell),
    Cell == 1,
    print('check'),nl,
    checkSurroundingCellsAux(Board, Row, Col).

checkSurroundingCells(Board, Cell, Row, Col) :-
    % getCell(Board, Row, Col, Cell),
    %nth1(Row, Board, Line),
    %format("~w ~w ~w", [Row, Col, 1]),nl,
    %Cell #= 1, 
    ground(Cell),
    Cell == 0.

checkSurroundingCells(Board, Cell, Row, Col) :-
    (  
        Cell==1 ->
        checkSurroundingCellsAux(Board, Row, Col);
        true
    ).

%checkSurroundingCells(_Board, _Cell, _Row, _Col).

checkSurroundingCellsAux(Board, 1, 1) :-
    Cell4Row is 1+1,
    Cell4Col is 1,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0,
    Cell5Row is 1+1,
    Cell5Col is 1+1,
    getCell(Board, Cell5Row, Cell5Col, Cell5),
    Cell5 #= 0,
    Cell6Row is 1,
    Cell6Col is 1+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0.

checkSurroundingCellsAux(Board, 1, 9) :-
    Cell2Row is 1,
    Cell2Col is 9-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell3Row is 1+1,
    Cell3Col is 9-1,
    getCell(Board, Cell3Row, Cell3Col, Cell3),
    Cell3 #= 0,
    Cell4Row is 1+1,
    Cell4Col is 1,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0.

checkSurroundingCellsAux(Board, 9, 1) :-
    Cell6Row is 9,
    Cell6Col is 1+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0,
    Cell7Row is 9-1,
    Cell7Col is 1+1,
    getCell(Board, Cell7Row, Cell7Col, Cell7),
    Cell7 #= 0,
    Cell8Row is 9-1,
    Cell8Col is 1,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

checkSurroundingCellsAux(Board, 9, 9) :-
    Cell1Row is 9-1,
    Cell1Col is 9-1,
    getCell(Board, Cell1Row, Cell1Col, Cell1),
    Cell1 #= 0,
    Cell2Row is 1,
    Cell2Col is 9-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell8Row is 9-1,
    Cell8Col is 1,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

checkSurroundingCellsAux(Board, 1, Col) :-
    Cell2Row is 1,
    Cell2Col is Col-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell3Row is 1+1,
    Cell3Col is Col-1,
    getCell(Board, Cell3Row, Cell3Col, Cell3),
    Cell3 #= 0,
    Cell4Row is 1+1,
    Cell4Col is Col,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0,
    Cell5Row is 1+1,
    Cell5Col is Col+1,
    getCell(Board, Cell5Row, Cell5Col, Cell5),
    Cell5 #= 0,
    Cell6Row is 1,
    Cell6Col is Col+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0.

checkSurroundingCellsAux(Board, 9, Col) :-
    Cell1Row is 9-1,
    Cell1Col is Col-1,
    getCell(Board, Cell1Row, Cell1Col, Cell1),
    Cell1 #= 0,
    Cell2Row is 9,
    Cell2Col is Col-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell6Row is 9,
    Cell6Col is Col+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0,
    Cell7Row is 9-1,
    Cell7Col is Col+1,
    getCell(Board, Cell7Row, Cell7Col, Cell7),
    Cell7 #= 0,
    Cell8Row is 9-1,
    Cell8Col is Col,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

checkSurroundingCellsAux(Board, Row, 1) :-
    Cell4Row is Row+1,
    Cell4Col is 1,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0,
    Cell5Row is Row+1,
    Cell5Col is 1+1,
    getCell(Board, Cell5Row, Cell5Col, Cell5),
    Cell5 #= 0,
    Cell6Row is Row,
    Cell6Col is 1+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0,
    Cell7Row is Row-1,
    Cell7Col is 1+1,
    getCell(Board, Cell7Row, Cell7Col, Cell7),
    Cell7 #= 0,
    Cell8Row is Row-1,
    Cell8Col is 1,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

checkSurroundingCellsAux(Board, Row, 9) :-
    Cell1Row is Row-1,
    Cell1Col is 9-1,
    getCell(Board, Cell1Row, Cell1Col, Cell1),
    Cell1 #= 0,
    Cell2Row is Row,
    Cell2Col is 9-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell3Row is Row+1,
    Cell3Col is 9-1,
    getCell(Board, Cell3Row, Cell3Col, Cell3),
    Cell3 #= 0,
    Cell4Row is Row+1,
    Cell4Col is 9,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0,
    Cell8Row is Row-1,
    Cell8Col is 9,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

checkSurroundingCellsAux(Board, Row, Col) :-
    Cell1Row is Row-1,
    Cell1Col is Col-1,
    getCell(Board, Cell1Row, Cell1Col, Cell1),
    Cell1 #= 0,
    Cell2Row is Row,
    Cell2Col is Col-1,
    getCell(Board, Cell2Row, Cell2Col, Cell2),
    Cell2 #= 0,
    Cell3Row is Row+1,
    Cell3Col is Col-1,
    getCell(Board, Cell3Row, Cell3Col, Cell3),
    Cell3 #= 0,
    Cell4Row is Row+1,
    Cell4Col is Col,
    getCell(Board, Cell4Row, Cell4Col, Cell4),
    Cell4 #= 0,
    Cell5Row is Row+1,
    Cell5Col is Col+1,
    getCell(Board, Cell5Row, Cell5Col, Cell5),
    Cell5 #= 0,
    Cell6Row is Row,
    Cell6Col is Col+1,
    getCell(Board, Cell6Row, Cell6Col, Cell6),
    Cell6 #= 0,
    Cell7Row is Row-1,
    Cell7Col is Col+1,
    getCell(Board, Cell7Row, Cell7Col, Cell7),
    Cell7 #= 0,
    Cell8Row is Row-1,
    Cell8Col is Col,
    getCell(Board, Cell8Row, Cell8Col, Cell8),
    Cell8 #= 0.

/**
* Counts the number of black cells in a list
*/
countBlackCells(List, Count) :-
    countBlackCells(List, 0, Count).

countBlackCells([], N, N).

countBlackCells([1 | List], N, Count) :-
    NextN is N+1,
    countBlackCells(List, NextN, Count).

countBlackCells([0 | List], N, Count) :-
    countBlackCells(List, N, Count).

same_sum([], _).
same_sum([X | R], Sum) :-
    sum(X, #=, Sum),
    same_sum(R, Sum).

/**
* Counts the number of spaces between two black cells in a List
*/
countSpaces([1 | List], Count) :-
    countSpacesAux(List, 0, Count).

countSpaces([0 | List], Count) :-
    countSpaces(List, Count).

countSpacesAux([], N, N).

countSpacesAux([1 | _List], N, N).

countSpacesAux([0 | List], N, Count) :-
    NextN is N+1,
    countSpacesAux(List, NextN, Count).

printLines([]).

printLines([Line | Board]) :-
    print(Line),
    nl,
    printLines(Board).

ant(Lines) :-
    Lines=[ [C11,C12,C13,C14,C15,C16,C17,C18,C19],
            [C21,C22,C23,C24,C25,C26,C27,C28,C29],
            [C31,C32,C33,C34,C35,C36,C37,C38,C39],
            [C41,C42,C43,C44,C45,C46,C47,C48,C49],
            [C51,C52,C53,C54,C55,C56,C57,C58,C59],
            [C61,C62,C63,C64,C65,C66,C67,C68,C69],
            [C71,C72,C73,C74,C75,C76,C77,C78,C79],
            [C81,C82,C83,C84,C85,C86,C87,C88,C89],
            [C91,C92,C93,C94,C95,C96,C97,C98,C99]],
    transpose(Lines, Columns),
    append(Lines, Vars),
    domain(Vars, 0, 1),
    % constraints
    same_sum(Lines, Sum),
    same_sum(Columns, Sum),
    Sum #= 2,
    nth1(2, Columns, Restr1),
    countSpaces(Restr1, Count1),
    Count1 #= 5,
    nth1(8, Lines, Restr2),
    countSpaces(Restr2, Count2),
    Count2 #= 4,
    print('BEFORE'),nl,
    printLines(Lines),nl,
    %maplist(checkSurroundingCells(Lines), Vars),
    %printLines(Lines),nl,
    checkAllCells(Lines),
    print('AFTER'),nl,
    printLines(Lines),nl,
    labeling([], Vars),
    printLines(Lines).

%-----------------------------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------------------------

flat_list(Cols, Vars) :-
    flat_list(Cols, [], Vars).

flat_list([], Aux, Aux).

flat_list([C | Cols], Aux, Vars) :-
    append(C, NewC),
    append(Aux, NewC, NewAux),
    flat_list(Cols, NewAux, Vars).

getRow([Row, _Col], Row).

getCol([_Row, Col], Col).

getAllRows(Coord, Rows) :-
    getAllRows(Coord, [], Rows).

getAllRows([], Aux, Aux).

getAllRows([E | Coord], Aux, Rows) :-
    getRow(E, Row),
    append(Aux, [Row], NextAux),
    getAllRows(Coord, NextAux, Rows).

countRows(Coord) :-
    countRows(Coord, 9).

countRows(Coord, 0).

countRows(Coord, N) :-
    getAllRows(Coord, Rows),
    global_cardinality(Rows, [1-2,2-2,3-2,4-2,5-2,6-2,7-2,8-2,9-2]),
    Next is N-1,
    countRows(Coord, Next).


getAllCols(Coord, Cols) :-
    getAllCols(Coord, [], Cols).

getAllCols([], Aux, Aux).

getAllCols([E | Coord], Aux, Cols) :-
    getCol(E, Col),
    append(Aux, [Col], NextAux),
    getAllCols(Coord, NextAux, Cols).

countCols(Coord) :-
    countCols(Coord, 9).

countCols(Coord, 0).

countCols(Coord, N) :-
    getAllCols(Coord, Cols),
    global_cardinality(Cols, [1-2,2-2,3-2,4-2,5-2,6-2,7-2,8-2,9-2]),
    Next is N-1,
    countCols(Coord, Next).

getPieceByRow(Coord, Row, Piece) :-
    nth1(I, Coord, [Row, _Col]),
    nth1(I, Coord, Piece).

diff(T2, 0, T2).

diff(T2, T1, Diff) :-
    NextT2 is T2-1,
    NextT1 is T1-1,
    diff(NextT2, NextT1, Diff).

checkSpacesInRow(Coord, Row, Spaces) :-
    findall(Piece, getPieceByRow(Coord, Row, Piece), Pieces),
    nth1(1, Pieces, Piece1),
    nth1(2, Pieces, Piece2),
    nth1(2, Piece1, Piece1Col),
    nth1(2, Piece2, Piece2Col),
    % List = [Piece1Col, Piece2Col],
    % sort(List, ListOrdered),
    nth1(1, ListOrdered, Min),
    nth1(2, ListOrdered, Max),
    %diff(Max, Min, Diff),
    ((Max-Min-1) #= Spaces;
    (Min-Max+1) #= -Spaces).

getPieceByCol(Coord, Col, Piece) :-
    nth1(I, Coord, [_Row, Col]),
    nth1(I, Coord, Piece).

checkSpacesInCol(Coord, Col, Spaces) :-
    findall(Piece, getPieceByCol(Coord, Col, Piece), Pieces),
    nth1(1, Pieces, Piece1),
    nth1(2, Pieces, Piece2),
    nth1(1, Piece1, Piece1Row),
    nth1(1, Piece2, Piece2Row),
    %diff(Max, Min, Diff),
    (abs(Piece2Row-Piece1Row)-1) #= Spaces.

surround([]).
surround([E | Coord]) :-
    alone(E, Coord),
    surround(Coord).

alone(_E1, []).
alone(E1, [E2 | Coord]) :-
    notNear(E1, E2),
    alone(E1, Coord).

notNear([R1, C1], [R2, C2]) :-
    abs(R2-R1) #> 1;
    abs(C2-C1) #> 1.

notRepeated([]).

notRepeated([E | Coord]) :-
    checkNotRepeated(E, Coord),
    notRepeated(Coord).

checkNotRepeated(_E1, []).

checkNotRepeated(E1, [E2 | Coord]) :-
    checkPair(E1, E2),
    checkNotRepeated(E1, Coord).

checkPair([R1, C1], [R2, C2]) :-
    R1 #\= R2;
    C1 #\= C2.

play(Coord) :-
    Coord=[ [R1,C1],
            [R2,C2],
            [R3,C3],
            [R4,C4],
            [R5,C5],
            [R6,C6],
            [R7,C7],
            [R8,C8],
            [R9,C9],
            [R10,C10],
            [R11,C11],
            [R12,C12],
            [R13,C13],
            [R14,C14],
            [R15,C15],
            [R16,C16],
            [R17,C17],
            [R18,C18]],
    append(Coord, Vars),
    domain(Vars, 1, 9),
    % constraints
    notRepeated(Coord),
    countRows(Coord),
    print('countRows'),nl,
    countCols(Coord),
    print('countCols'),nl,
    print(Coord),nl,
    surround(Coord),
    print('surround'),nl,
    print(Coord),nl,
    checkSpacesInRow(Coord, 8, 4),
    checkSpacesInCol(Coord, 2, 5),
    %print('checkSpaces'),nl,
    labeling([], Vars).
