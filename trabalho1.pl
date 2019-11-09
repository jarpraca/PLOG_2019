draw_column_letters :- write('        a     b     c     d   \n').
get_piece(blank, X) :- X='..' .
get_piece(by, X) :- X='BY'.
get_piece(bo, X) :- X='BO'.
get_piece(bc, X) :- X='BC'.
get_piece(bs, X) :- X='BS'.
get_piece(wy, X) :- X='WY'.
get_piece(wo, X) :- X='WO'.
get_piece(wc, X) :- X='WC'.
get_piece(ws, X) :- X='WS'.
write_row_number(N):-
	write('  '),
	print(N),
	write('  ').
draw_separator:- write('     -------------------------\n').
draw_line([H|T]) :-
	write('  '),
	get_piece(H, X),
	print(X),
	write(' |'),
	draw_line(T).
draw_line([]).
draw_board([H|T], Z) :-
	write_row_number(Z),
	write('|'),
	draw_line(H),
	write('\n'),
	draw_separator,
	X is Z+1,
	draw_board(T, X).
draw_board([],_).

draw_number(N):-
	write('Player '),
	print(N),
	write('\n').
draw_pieces([]) :-
	write('\n\n').
draw_pieces([H|T]):-
	get_piece(H, X),	
	print(X),
	write(' '),
    draw_pieces(T).
draw_player([H|T]):-
	draw_number(H),
	write('Pieces : '),
	draw_pieces(T).
display_game(Board,Player) :- 
	write('\n'),
	draw_column_letters,
	draw_separator,
	draw_board(Board, 1),
	draw_player(Player).