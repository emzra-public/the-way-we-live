extends Node

signal GIVE_CHOICES(current_line)
signal CHOSE_CHOICE(index)

var player_strength = 0
var boss_strength = 0

func increase_player_strength():
	player_strength += 1
	print("Player strength is now: ", player_strength)

func increase_boss_strength():
	boss_strength += 1
	print("Boss strength is now: ", boss_strength)

func reset_globals():
	player_strength = 0
	boss_strength = 0
	
func restart_game():
	reset_globals()
	get_tree().change_scene_to_file("res://Levels/start.tscn")

func rebirth():
	get_tree().change_scene_to_file("res://Level1.tscn")
