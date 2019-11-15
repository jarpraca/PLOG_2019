valid_moves(Board, Player, ListOfMoves) :-
    findall(Move, valid_move(Board, Player, Move), ListOfMoves).

valid_move(Board, Player, Move) :-
    getQuad(Row, Col, _Quad),
    piecePlayer(Player, Piece),
    hasPiece(Board, Player, Piece),
    verifyMove(Board, Row, Col, Piece),
    Move = [Row, Col, Piece].

winning_moves(Board, Player, [Move | ListOfMoves], Aux, ListOfWinningMoves) :-
    move(Move, Board, NewBoard),
    (checkWin(NewBoard) ->
        (
            append([Move], Aux, NewAux),
            winning_moves(Board, Player, ListOfMoves, NewAux, ListOfWinningMoves)
        );
        winning_moves(Board, Player, ListOfMoves, Aux, ListOfWinningMoves)
    ).

winning_moves(_Board, _Player, [], ListOfWinningMoves, ListOfWinningMoves).
