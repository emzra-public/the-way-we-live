extends Control

var level = preload("res://Level1.tscn")

func _on_StartButton_pressed():
	get_tree().change_scene_to_packed(level)
