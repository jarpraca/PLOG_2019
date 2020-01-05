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
    %print('check'),nl,
    checkSurroundingCellsAux(Board, Row, Col).

checkSurroundingCells(_Board, Cell,_Row,_Col) :-
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

spaces([]).
spaces([L | List]) :-
    countSpaces(L, Count),
    Count #>0,
    spaces(List).

spacesDiags([L | List]) :-
    noConsecutiveBlack(L),
    spacesDiags(List).

noConsecutiveBlack(List) :-
    length(List, 1).

noConsecutiveBlack([1 | List]) :-
    nth1(1, List, Next),
    Next #= 0,
    noConsecutiveBlack(List).

noConsecutiveBlack([0 | List]) :-
    noConsecutiveBlack(List).

getAllDiags(Coord, Diags) :-
    getDiags(Coord, Diags1),
    invert(Coord, Inverted),
    getDiags(Inverted, Diags2),
    append(Diags1, Diags2, Diags).

getDiags(Coord, Diags) :-
    getDiags1(Coord, 2, [], Diags1),
    getDiags2(Coord, 1, [], Diags2),
    append(Diags1, Diags2, Diags).

getDiags1(Coord, Row, Aux, Diags) :-
    length(Coord, Row),
    Diags=Aux.

getDiags1(Coord, Row, Aux, Diags) :-
    getDiag1(Coord, Row, 1, [], Diag),
    append(Aux, [Diag], NewAux),
    NextRow is Row+1,
    getDiags1(Coord, NextRow, NewAux, Diags).

getDiag1(_Coord, 0, _Col, Aux, Aux).
getDiag1(Coord, Row, Col, Aux, Diag) :-
    getCell(Coord, Row, Col, Cell),
    append(Aux, [Cell], NewAux),
    NextRow is Row-1,
    NextCol is Col+1,
    getDiag1(Coord, NextRow, NextCol, NewAux, Diag).

%---

getDiags2(Coord, Col, Aux, Diags) :-
    length(Coord, Col),
    Diags=Aux.

getDiags2(Coord, Col, Aux, Diags) :-
    length(Coord, Row),
    getDiag2(Coord, Col, Row, [], Diag),
    append(Aux, [Diag], NewAux),
    NextCol is Col+1,
    getDiags2(Coord, NextCol, NewAux, Diags).

getDiag2(Coord, Col, _Row, Aux, Aux) :-
    length(Coord, N),
    Col=:=N+1.

getDiag2(Coord, Col, Row, Aux, Diag) :-
    getCell(Coord, Row, Col, Cell),
    append(Aux, [Cell], NewAux),
    NextRow is Row-1,
    NextCol is Col+1,
    getDiag2(Coord, NextCol, NextRow, NewAux, Diag).

invert(Coord, Inverted) :-
    invert(Coord, _Aux, Inverted).

invert([], Aux, Aux).
invert([L | Coord], Aux, Inverted) :-
    reverse(L, LR),
    append(Aux, [LR], NewAux),
    invert(Coord, NewAux, Inverted).

/*Lucas came into action
*/


add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).

getDiagonal([], _, _, []).
getDiagonal([Row|Rest], Col, DCol, Result) :-
    (  nth0(Col, Row, El)
    -> (Result = [El | R2],
        Col2 is Col + DCol,
        getDiagonal(Rest, Col2, DCol, R2))
    ;  Result = []).

getAllDiagonals(Board, Diags):-
    getAllDiagonalsAux(Board,0, Diags1),
    transpose(Board, Board2),
    getAllDiagonalsAux(Board2,0, Diags2),
    %reverse(Board, Board3),
    %getAllDiagonalsAux(Board3,0, Diags3),
    %print(Diags1),nl,
    %print(Diags2),nl,
    %print(Diags3),nl,
    %append(Diags1,Diags2,DiagsTmp),
    %append(DiagsTmp,Diags3,Diags),
    append(Diags1, Diags2, Diags).
    %print(Diags),nl.


getAllDiagonalsAux(_Board,9, _Diags).

getAllDiagonalsAux(Board,Index, Diags):-
    getDiagonal(Board, Index,1,DiagRight),
    getDiagonal(Board, Index,-1,DiagLeft),
    NewIndex is Index + 1,
    getAllDiagonalsAux(Board, NewIndex, NewDiags),
    add_tail(NewDiags,DiagRight,IntDiags),
    add_tail(IntDiags,DiagLeft,Diags).

printMatrix([]).
printMatrix([H|T]) :- write(H), nl, printMatrix(T).


checkConsecutive([0]).
checkConsecutive([1]).

checkConsecutive([]).

checkConsecutive([Head|[HeadList|List]]):-
    (Head == 1 ->
        HeadList #= 0;
        true
    ),
    checkConsecutive([HeadList|List]).

checkAllForConsecutives([]).

checkAllForConsecutives([Head|List]):-
    %nl,nl,
    %print(Head),nl,nl,
    checkConsecutive(Head),
    checkAllForConsecutives(List).


forceRests(Lines,ColumnRests, RowRests):-
    forceColRests(Lines,ColumnRests),
    forceRowRests(Lines,RowRests).

forceColRests(_Lines,[]).

forceColRests(Lines,[ColumnRestsHead|ColumnRestsTail]):-
    forceColRest(Lines,ColumnRestsHead),
    forceColRests(Lines,ColumnRestsTail).

forceRowRests(_Lines,[]).


forceRowRests(Lines,[RowRestsHead|RowRestsTail]):-
    forceRowRest(Lines,RowRestsHead),
    forceRowRests(Lines,RowRestsTail).



forceColRest(Lines,[ColumnRestIndex,ColumnRestValue]):-
    transpose(Lines, Columns),
    nth1(ColumnRestIndex, Columns, Restr1),
    countSpaces(Restr1, Count1),
    Count1 #= ColumnRestValue.


forceRowRest(Lines,[RowRestIndex,RowRestValue]):-
    nth1(RowRestIndex, Lines, Restr2),
    countSpaces(Restr2, Count2),
    Count2 #= RowRestValue.


forceRowLength([],_N).

forceRowLength([LinesHead|LinesTail],N):-
    length(LinesHead, N),
    forceRowLength(LinesTail,N).
    


getSolution(Lines,Size,ColumnRests, RowRests) :-
    length(Lines,Size),
    forceRowLength(Lines,Size),
    transpose(Lines, Columns),
    getAllDiagonals(Lines, Diags),
    append(Lines, Vars),
    domain(Vars, 0, 1),
    % constraints
    same_sum(Lines, Sum),
    same_sum(Columns, Sum),
    Sum #= 2,
    forceRests(Lines,ColumnRests, RowRests),
    checkAllCells(Lines),
    spaces(Lines),
    spaces(Columns),
    checkAllForConsecutives(Diags),
    %print(Diags),nl,
    labeling([], Vars).

isSolution(Lines,[ColumnRestIndex,ColumnRestValue],[RowRestIndex,RowRestValue]):-
    transpose(Lines, Columns),
    %getAllDiags(Lines, Diags),
    append(Lines, Vars),
    domain(Vars, 0, 1),
    % constraints
    same_sum(Lines, Sum),
    same_sum(Columns, Sum),
    Sum #= 2,
    nth1(ColumnRestIndex, Columns, Restr1),
    countSpaces(Restr1, Count1),
    Count1 #= ColumnRestValue,
    nth1(RowRestIndex, Lines, Restr2),
    countSpaces(Restr2, Count2),
    Count2 #= RowRestValue,
    checkAllCells(Lines),
    spaces(Lines),
    spaces(Columns).
    %checkAllForConsecutives(Diags).
