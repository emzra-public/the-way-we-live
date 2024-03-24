extends Node2D

func _ready():
	$VBoxContainer/RestartButton.grab_focus()
	
func _on_restart_button_pressed():
	PlayerKarma.restart_game()
