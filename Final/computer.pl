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
    random_member(Move, ListOfMoves).

choose_move(Board, Level, Move) :-
    getCurrentPlayer(Board, Player),
    valid_moves(Board, Player, ListOfMoves),
    NewLevel is Level-1,
    best_move(Board, Player, NewLevel, ListOfMoves, -999999, _MaxValue, _Aux, Move).

best_move(_Board, _Player, _Level, [], Curr_MaxValue, Curr_MaxValue, Curr_BestMove, BestMove) :-
    random_member(BestMove, Curr_BestMove).

best_move(Board, Player, 1, [Move | ListOfMoves], Curr_MaxValue, MaxValue, Curr_BestMove, BestMove) :-
    move(Move, Board, NewBoard),
    value(NewBoard, Player, Value),
    (Value > Curr_MaxValue ->
        best_move(Board, Player, 1, ListOfMoves, Value, MaxValue, [Move], BestMove);
        (Value =:= Curr_MaxValue ->
            best_move(Board, Player, 1, ListOfMoves, Value, MaxValue, [Move | Curr_BestMove], BestMove);
            best_move(Board, Player, 1, ListOfMoves, Curr_MaxValue, MaxValue, Curr_BestMove, BestMove)
        )
    ).

best_move(Board, Player, Depth, [Move | ListOfMoves], Curr_MaxValue, MaxValue, Curr_BestMove, BestMove) :-
    Depth =\= 1,
    NewDepth is Depth - 1,
    move(Move, Board, NewBoard),
    write('.'),
    (checkWin(NewBoard) ->
        best_move(Board, Player, Depth, [], 999999, MaxValue, [Move], BestMove);
        (
            opponent_best_move(NewBoard, Player, NewDepth, OpponentBoard),
            (checkWin(OpponentBoard) ->
                best_move(Board, Player, Depth, ListOfMoves, Curr_MaxValue, MaxValue, Curr_BestMove, BestMove);
                (
                    valid_moves(OpponentBoard, Player, ListOfNextMoves),
                    best_move(OpponentBoard, Player, NewDepth, ListOfNextMoves, -999999, Value, _Aux, _NextMove),
                    (Value > Curr_MaxValue ->
                        best_move(Board, Player, Depth, ListOfMoves, Value, MaxValue, [Move], BestMove);
                        (Value =:= Curr_MaxValue ->
                            best_move(Board, Player, Depth, ListOfMoves, Value, MaxValue, [Move | Curr_BestMove], BestMove);
                            best_move(Board, Player, Depth, ListOfMoves, Curr_MaxValue, MaxValue, Curr_BestMove, BestMove)
                        )
                    )
                )
            )
        )
    ).

opponent_best_move(Board, Player, Depth, OpponentBoard) :-
    getOpponentPlayer(Player, OpponentPlayer),
    switchPlayer(Board, NextBoard),
    valid_moves(NextBoard, OpponentPlayer, ListOfMoves),
    best_move(NextBoard, OpponentPlayer, Depth, ListOfMoves, -999999, _MaxValue, _Aux, Move),
    move(Move, NextBoard, NextBoard2),
    switchPlayer(NextBoard2, OpponentBoard).
