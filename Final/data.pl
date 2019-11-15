cell(_Row, _Col, _Piece).

initialPiecesBoard([cell(1,a,e), cell(1,b,e), cell(1,c,e), cell(1,d,e),
                    cell(2,a,e), cell(2,b,e), cell(2,c,e), cell(2,d,e),
                    cell(3,a,e), cell(3,b,e), cell(3,c,e), cell(3,d,e),
                    cell(4,a,e), cell(4,b,e), cell(4,c,e), cell(4,d,e)]).

initialPiecesPlayer1([wo,wo,wy,wy,ws,ws,wc,wc]).

initialPiecesPlayer2([bo,bo,by,by,bs,bs,bc,bc]).

board(_CurrentPlayer, _PiecesBoard, _PiecesPlayer1, _PiecesPlayer2).

getCurrentPlayer(board(CurrentPlayer, _PiecesBoard, _PiecesPlayer1, _PiecesPlayer2), CurrentPlayer).

getPiecesPlayer(board(_CurrentPlayer, _PiecesBoard, PiecesPlayer1, _PiecesPlayer2), 1, PiecesPlayer1).

getPiecesPlayer(board(_CurrentPlayer, _PiecesBoard, _PiecesPlayer1, PiecesPlayer2), 2, PiecesPlayer2).

getPiecesBoard(board(_CurrentPlayer, PiecesBoard, _PiecesPlayer1, _PiecesPlayer2), PiecesBoard).

setPiece(board(1, PiecesBoard, PiecesPlayer1, PiecesPlayer2), Row, Col, Piece, board(1, NewPiecesBoard, NewPiecesPlayer1, PiecesPlayer2)) :-
    updateBoardPieces(PiecesBoard, Row, Col, Piece, NewPiecesBoard),
    updatePlayerPieces(PiecesPlayer1, 1, Piece, NewPiecesPlayer1).

setPiece(board(2, PiecesBoard, PiecesPlayer1, PiecesPlayer2), Row, Col, Piece, board(2, NewPiecesBoard, PiecesPlayer1, NewPiecesPlayer2)) :-
    updateBoardPieces(PiecesBoard, Row, Col, Piece, NewPiecesBoard),
    updatePlayerPieces(PiecesPlayer2, 2, Piece, NewPiecesPlayer2).

updateBoardPieces(PiecesBoard, Row, Col, Piece, NewPiecesBoard) :-
    delete_one(cell(Row, Col, e), PiecesBoard, NB),
    append(NB, [cell(Row, Col, Piece)], NewPiecesBoard).

updatePlayerPieces(PiecesPlayer1, 1, Piece, NewPiecesPlayer1) :-
    delete_one(Piece, PiecesPlayer1, NewPiecesPlayer1).

updatePlayerPieces(PiecesPlayer2, 2, Piece, NewPiecesPlayer2) :-
    delete_one(Piece, PiecesPlayer2, NewPiecesPlayer2).

getPiece(Board, Row, Col, Piece) :-
    getPiecesBoard(Board, PiecesBoard),
    member(cell(Row, Col, Piece), PiecesBoard).

getPieceString(e, '  ').
getPieceString(by, 'BY').
getPieceString(bo, 'BO').
getPieceString(bc, 'BC').
getPieceString(bs, 'BS').
getPieceString(wy, 'WY').
getPieceString(wo, 'WO').
getPieceString(wc, 'WC').
getPieceString(ws, 'WS').

getShape(e, e).
getShape(by, y).
getShape(bo, o).
getShape(bc, c).
getShape(bs, s).
getShape(wy, y).
getShape(wo, o).
getShape(wc, c).
getShape(ws, s).

getQuad(1,a,1).
getQuad(1,b,1).
getQuad(2,a,1).
getQuad(2,b,1).

getQuad(1,c,2).
getQuad(1,d,2).
getQuad(2,c,2).
getQuad(2,d,2).

getQuad(3,a,3).
getQuad(3,b,3).
getQuad(4,a,3).
getQuad(4,b,3).

getQuad(3,c,4).
getQuad(3,d,4).
getQuad(4,c,4).
getQuad(4,d,4).

oppositePiece(by, wy).
oppositePiece(bo, wo).
oppositePiece(bc, wc).
oppositePiece(bs, ws).
oppositePiece(wy, by).
oppositePiece(wo, bo).
oppositePiece(wc, bc).
oppositePiece(ws, bs).

piecePlayer(1, wo).
piecePlayer(1, wy).
piecePlayer(1, ws).
piecePlayer(1, wc).
piecePlayer(2, bo).
piecePlayer(2, by).
piecePlayer(2, bs).
piecePlayer(2, bc).

column(a,1).
column(b,2).
column(c,3).
column(d,4).