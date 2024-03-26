extends Node

signal GIVE_CHOICES(current_line)
signal CHOSE_CHOICE(index)

# karma
var player_karma = 0
var boss_karma = 0

func increase_player_karma():
	player_karma += 1
	print("Player karma is now: ", player_karma)

func decrease_player_karma():
	player_karma += 1
	print("Player karma is now: ", player_karma)

# dialogue variables
var quest_accepted = false
var quest_refused = false
var stole_and_attacked = false
var spirits_encouraged = false
var spirits_discouraged = false
var spirits_told_truth = false
var spirits_lied_to = false
var spirits_lied_to_2 = false
var spirits_refused_to_share_with = false

func accepted_quest():
	quest_accepted = true
	
func refused_quest():
	quest_refused = true

func attack_and_steal():
	stole_and_attacked = true

func discourage_spirits():
	spirits_discouraged = true

func encourage_spirits():
	spirits_encouraged = true

func tell_truth_to_spirits():
	spirits_told_truth = true
	
func lie_to_spirits():
	spirits_lied_to = true

func lie_to_spirits_2():
	spirits_lied_to_2 = true

func refuse_to_share_with_spirits():
	spirits_refused_to_share_with = true

func naraka():
	return "@first"

func spirit():
	if quest_accepted:
		return "@sixth"

	elif quest_refused:
		return "@seventh"

	elif stole_and_attacked:
		return "@eighth" 

func boss():
	if spirits_encouraged:
		return "@ninth"
	if spirits_discouraged:
		return "@tenth"
	if spirits_told_truth:
		return "@eleventh"
	if spirits_lied_to:
		return "@twelfth"
	if spirits_lied_to_2:
		return "@thirteenth"
	if spirits_refused_to_share_with:
		return "@fourteenth"

func reset_globals():

	player_karma = 0
	boss_karma = 0

func reset_dialogue_variables():
	quest_accepted = false
	quest_refused = false
	stole_and_attacked= false
	spirits_encouraged = false
	spirits_discouraged = false
	spirits_told_truth = false
	spirits_lied_to = false
	spirits_lied_to_2 = false
	spirits_refused_to_share_with = false
	
func restart_game():
	reset_globals()
	get_tree().change_scene_to_file("res://Levels/start.tscn")

func rebirth():
	reset_dialogue_variables()
	get_tree().change_scene_to_file("res://Level1.tscn")
