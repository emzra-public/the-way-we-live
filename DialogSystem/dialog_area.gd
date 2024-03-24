extends Area2D

@export var dialog_key = ""
var area_active = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		DialogBus.emit_signal("display_dialog", dialog_key)

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	area_active = false

