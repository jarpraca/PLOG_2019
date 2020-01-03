/**
 * Cell of a Board
 */
cell(_Row, _Col, _Piece).

/**
 * Initial empty Board
 */
initialPiecesBoard([cell(1,a,e), cell(1,b,e), cell(1,c,e), cell(1,c,e), cell(1,d,e), cell(1,e,e),cell(1,f,e), cell(1,g,e), cell(1,h,e),
                    cell(2,a,e), cell(2,b,e), cell(2,c,e), cell(2,c,e), cell(2,d,e), cell(2,e,e),cell(2,f,e), cell(2,g,e), cell(2,h,e),
                    cell(3,a,e), cell(3,b,e), cell(3,c,e), cell(3,c,e), cell(3,d,e), cell(3,e,e),cell(3,f,e), cell(3,g,e), cell(3,h,e),
                    cell(4,a,e), cell(4,b,e), cell(4,c,e), cell(4,c,e), cell(4,d,e), cell(4,e,e),cell(4,f,e), cell(4,g,e), cell(4,h,e),
                    cell(5,a,e), cell(5,b,e), cell(5,c,e), cell(5,c,e), cell(5,d,e), cell(5,e,e),cell(5,f,e), cell(5,g,e), cell(5,h,e),
                    cell(6,a,e), cell(6,b,e), cell(6,c,e), cell(6,c,e), cell(6,d,e), cell(6,e,e),cell(6,f,e), cell(6,g,e), cell(6,h,e),
                    cell(7,a,e), cell(7,b,e), cell(7,c,e), cell(7,c,e), cell(7,d,e), cell(7,e,e),cell(7,f,e), cell(7,g,e), cell(7,h,e),
                    cell(8,a,e), cell(8,b,e), cell(8,c,e), cell(8,c,e), cell(8,d,e), cell(8,e,e),cell(8,f,e), cell(8,g,e), cell(8,h,e),
                    cell(9,a,e), cell(9,b,e), cell(9,c,e), cell(9,c,e), cell(9,d,e), cell(9,e,e),cell(9,f,e), cell(9,g,e), cell(9,h,e)]).


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

/**
 * Existing levels
 */
level(1).
level(2).
level(3).