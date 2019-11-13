:- dynamic board/3.

resetBoard :-
    retractall(board(1,a,_)),
    retractall(board(1,b,_)),
    retractall(board(1,c,_)),
    retractall(board(1,d,_)),
    retractall(board(2,a,_)),
    retractall(board(2,b,_)),
    retractall(board(2,c,_)),
    retractall(board(2,d,_)),
    retractall(board(3,a,_)),
    retractall(board(3,b,_)),
    retractall(board(3,c,_)),
    retractall(board(3,d,_)),
    retractall(board(4,a,_)),
    retractall(board(4,b,_)),
    retractall(board(4,c,_)),
    retractall(board(4,d,_)).

addBoard :-
    assert(board(1,a,e)),
    assert(board(1,b,e)),
    assert(board(1,c,e)),
    assert(board(1,d,e)),
    assert(board(2,a,e)),
    assert(board(2,b,e)),
    assert(board(2,c,e)),
    assert(board(2,d,e)),
    assert(board(3,a,e)),
    assert(board(3,b,e)),
    assert(board(3,c,e)),
    assert(board(3,d,e)),
    assert(board(4,a,e)),
    assert(board(4,b,e)),
    assert(board(4,c,e)),
    assert(board(4,d,e)).

resetPieces :-
    retract(pieces(1, _)),
    retract(pieces(2, _)).

initialPieces :-
    assert(pieces(1, [wo,wo,wy,wy,ws,ws,wc,wc])),
    assert(pieces(2, [bo,bo,by,by,bs,bs,bc,bc])).

setPiece(Row, Col, Piece) :-
    retract(board(Row, Col, e)),
    assert(board(Row, Col, Piece)).

updatePieces(Player, NewPieces) :-
    retract(pieces(Player, _)),
    assert(pieces(Player, NewPieces)).

getPiece(e, '  ').
getPiece(by, 'BY').
getPiece(bo, 'BO').
getPiece(bc, 'BC').
getPiece(bs, 'BS').
getPiece(wy, 'WY').
getPiece(wo, 'WO').
getPiece(wc, 'WC').
getPiece(ws, 'WS').

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
getQuad(5,b,3).

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

column(a,1).
column(b,2).
column(c,3).
column(d,4).