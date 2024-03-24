extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://Levels/scene_1.tscn")

func _on_TransitionLocation_touch():
	get_tree().change_scene_to_file("res://Levels/scene_2.tscn")
