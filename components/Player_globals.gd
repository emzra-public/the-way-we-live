extends Node

signal GIVE_CHOICES(current_line)
signal CHOSE_CHOICE(index)

var cutscened = true

# karma
var player_karma = 0
var round = 0

func increase_player_karma():
	player_karma += 1
	print("Player karma is now: ", player_karma)

func decrease_player_karma():
	player_karma += 1
	print("Player karma is now: ", player_karma)

# dialogue variables

func naraka():
	return "first"

var quest_accepted = false
var quest_refused = false
var stole_and_attacked = false

func spirit():
	if quest_accepted:
		return "sixth"
	elif quest_refused:
		return "seventh"
	elif stole_and_attacked:
		return "eighth"

var rebirth_good = false
var rebirth_mostly_good = false
var rebirth_not_bad = false
var rebirth_jerk = false

func boss():
	if rebirth_good:
		return "rebirth_good"
	if rebirth_mostly_good:
		return "rebirth_mostly_good"
	if rebirth_not_bad:
		return "rebirth_not_bad"
	if rebirth_jerk:
		return "rebirth_jerk"

#rebirth

func reset_dialogue_variables():
	quest_accepted = false
	quest_refused = false
	stole_and_attacked= false
	rebirth_good = false
	rebirth_mostly_good = false
	rebirth_not_bad = false
	rebirth_jerk = false
	
	
func end_game():
	reset_dialogue_variables()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MenuStart.tscn")

func rebirth():
	reset_dialogue_variables()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Level1.tscn")
	cutscened = true
