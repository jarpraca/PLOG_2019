valid_moves(Board, Player, ListOfMoves) :-
    findall(Move, valid_move(Board, Player, Move), ListOfMoves).

valid_move(Board, Player, Move) :-
    getQuad(Row, Col, _Quad),
    piecePlayer(Player, Piece),
    hasPiece(Board, Player, Piece),
    verifyMove(Board, Row, Col, Piece),
    Move = [Row, Col, Piece].

losing_moves(_Board, _Player, [], ListOfLosingMoves, ListOfLosingMoves).

losing_moves(Board, Player, [Move | ListOfMoves], Aux, ListOfLosingMoves) :-
    move(Move, Board, NewBoard),
    ((checkWin(NewBoard), opponent_can_win(Move, NewBoard, Player)) ->
        (
            append([Move], Aux, NewAux),
            losing_moves(Board, Player, ListOfMoves, NewAux, ListOfLosingMoves)
        );
        losing_moves(Board, Player, ListOfMoves, Aux, ListOfLosingMoves)
    ).

winning_moves(_Board, _Player, [], ListOfWinningMoves, ListOfWinningMoves).

winning_moves(Board, Player, [Move | ListOfMoves], Aux, ListOfWinningMoves) :-
    move(Move, Board, NewBoard),
    ((checkWin(NewBoard), opponent_loses(Move, NewBoard, Player)) ->
        (
            append([Move], Aux, NewAux),
            winning_moves(Board, Player, ListOfMoves, NewAux, ListOfWinningMoves)
        );
        winning_moves(Board, Player, ListOfMoves, Aux, ListOfWinningMoves)
    ).

value(Board, Player, Value) :-
    (checkWin(Board) ->
        Value is 999999;
        (
            value_valid_moves(Board, Player, Moves, Valid),
            value_winning_moves(Board, Player, Moves, Winning),
            value_losing_moves(Board, Player, Moves, Losing),
            UpdatedValid is (Valid - Winning - Losing),
            Value is (UpdatedValid + Winning*100 - Losing*100)
        )
    ).

value_valid_moves(Board, Player, ListOfMoves, Value) :-
    valid_moves(Board, Player, ListOfMoves),
    length(ListOfMoves, Value).

value_winning_moves(Board, Player, ListOfMoves, Value) :-
    winning_moves(Board, Player, ListOfMoves, [], ListOfWinningMoves),
    length(ListOfWinningMoves, Value).

value_losing_moves(Board, Player, ListOfMoves, Value) :-
    losing_moves(Board, Player, ListOfMoves, [], ListOfLosingMoves),
    length(ListOfLosingMoves, Value).

choose_move(Board, 1, Move) :-
    getCurrentPlayer(Board, Player),
    valid_moves(Board, Player, ListOfMoves),
    best_move(Board, Player, 1, ListOfMoves, -999999, _Aux, Move).

best_move(_Board, _Player, _Level, [], _MaxValue, Curr_Best_Move, Curr_Best_Move).

best_move(Board, Player, 1, [Move | ListOfMoves], MaxValue, Curr_Best_Move, BestMove) :-
    move(Move, Board, NewBoard),
    value(NewBoard, Player, Value),
    format("(~w, ~d),",[Move, Value]),
    (Value > MaxValue ->
        best_move(Board, Player, 1, ListOfMoves, Value, Move, BestMove);
        best_move(Board, Player, 1, ListOfMoves, MaxValue, Curr_Best_Move, BestMove)
    ).