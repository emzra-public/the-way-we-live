extends Area2D

@export_enum("Dialog", "Transfer") var type: String
@export var dialog_key = ""
@export_file("*.tscn") var transfer_scene_file
var area_active = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		if type == "Dialog":
			G_Interact.DIALOG.emit(dialog_key)
		if type == "Transfer":
			get_tree().change_scene_to_file(transfer_scene_file)

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	area_active = false
