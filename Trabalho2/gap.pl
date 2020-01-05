:- consult('menu.pl').
:- consult('data.pl').
:- consult('game.pl').
:- consult('display.pl').
:- consult('solver.pl').

:- use_module(library(random)).
:- use_module(library(system)).
:- use_module(library(timeout)).
:- use_module(library(clpfd)).
:- use_module(library(lists)).

play :- menu.