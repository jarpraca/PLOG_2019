:- consult('display.pl').
:- consult('auxiliar.pl').
:- consult('data.pl').
:- consult('game.pl').

play :- startGame.

reset :- resetBoard, resetPieces.