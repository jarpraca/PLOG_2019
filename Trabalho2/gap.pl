:- use_module(library(clpfd)).
:- use_module(library(lists)).

/**
* Gets the Cell from Board located in Row and Col
*/
getCell(Board, Row, Col, Cell) :-
    nth1(Row, Board, Line),
    nth1(Col, Line, Cell).

/**
* Checks if a cell located in Row and Col is black and if its surroundings cells are all white
*/
checkSurroundingCells(Board, Cell) :-
    getCell(Board, Row, Col, Cell),
    %nth1(Row, Board, Line),
    %format("~w ~w", [Row, Line]),nl,
    %Cell #= 1, 
    checkSurroundingCellsAux(Board, Row, Col).

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

play(Vars) :-
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
    maplist(checkSurroundingCells(Lines), Vars),nl,
    %write('HELLO'),nl,
    nth1(2, Columns, Restr1),
    %print(Restr1),nl,
    countSpaces(Restr1, Count1),
    %print(Count1),nl,
    Count1 #= 5,
    nth1(8, Lines, Restr2),
    countSpaces(Restr2, Count2),
    Count2 #= 4,
    labeling([], Vars).
