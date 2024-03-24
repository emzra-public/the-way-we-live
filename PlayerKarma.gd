extends Node

var round = 0
var stole = 0
var helped = 0
var deaths = 0
var victories = 0

func increase_round():
	round += 1
	print("Round is now: ", round)

func increase_stole():
	stole += 1
	print("Stole is now: ", stole)

func increase_helped():
	helped += 1
	print("Help is now:", helped)

func increase_deaths():
	deaths += 1
	print("Deaths is now:", deaths)
	
func increase_victories():
	victories += 1
	print("Victories is now:", victories)

func reset_globals():
	round = 0
	stole = 0
	helped = 0
	deaths = 0
	victories = 0
	
func restart_game():
	reset_globals()
	get_tree().change_scene_to_file("res://Levels/start.tscn")
