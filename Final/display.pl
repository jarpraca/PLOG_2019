draw_column_letters :- write('        a     b     c     d   \n').

write_row_number(N):-
	write('  '),
	print(N),
	write('  ').
draw_separator:- write('     -------------------------\n').
draw_line(R, C) :-
	C < 5,
	write('  '),
	column(D, C),
	board(R, D, P),
	getPiece(P, X),
	print(X),
	write(' |'),
	T is C+1,
	draw_line(R, T).
draw_line(_, 5).
draw_board(R) :-
	R < 5,
	write_row_number(R),
	write('|'),
	draw_line(R, 1),
	write('\n'),
	draw_separator,
	X is R+1,
	draw_board(X).
draw_board(5).

draw_number(N):-
	write('Player '),
	print(N),
	write('\n').
draw_pieces([]) :-
	write('\n\n').
draw_pieces([H|T]):-
	getPiece(H, X),	
	print(X),
	write(' '),
    draw_pieces(T).
draw_player(Player):-
	pieces(Player, Pieces),
	draw_number(Player),
	write('Pieces : '),
	draw_pieces(Pieces).
display_game(Player) :-
	write('\n'),
	draw_column_letters,
	draw_separator,
	draw_board(1),
	draw_player(Player).