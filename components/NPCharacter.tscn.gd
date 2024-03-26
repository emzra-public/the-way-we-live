extends Node2D

@onready var DialogBox = $DialogBox
@onready var InteractPoint = $InteractPoint
@onready var TooltipInteractableNow = $InteractPoint/TooltipInteractableNow

signal BEGIN_DIALOG
signal END_DIALOG

var file = FileAccess.open("res://assets/dialogue.json", FileAccess.READ)
var all_text = JSON.parse_string(file.get_as_text())
var current_block = []
var dialog_locked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogBox.visible = false
	TooltipInteractableNow.visible = false
	BEGIN_DIALOG.connect(on_display_dialog)

func _on_interact_point_area_entered(area):
	TooltipInteractableNow.visible = true

func _on_interact_point_area_exited(area):
	TooltipInteractableNow.visible = false

func on_display_dialog(text_key = null):
	if DialogBox.visible != true and text_key:
		set_current_block(all_text[text_key])
		get_tree().paused = true
		DialogBox.visible = true
		InteractPoint.visible = false
	if dialog_locked == true:
		return
	if current_block.size() == 0:
		DialogBox.reset()
		InteractPoint.visible = true
		get_tree().paused = false
		return

	var current_line = current_block.pop_front()

	if typeof(current_line) == TYPE_STRING:
		if (current_line.begins_with("@")):
			set_current_block(all_text[current_line.trim_prefix("@")])
			on_display_dialog()
		elif (current_line.begins_with("$")):
			var command = Callable(G_Player, current_line.trim_prefix("$"))
			command.call()
			on_display_dialog()
		else:
			DialogBox.show_text(current_line)

	elif typeof(current_line) == TYPE_DICTIONARY:
		dialog_locked = true
		var callback = func(response):
			dialog_locked = false
			DialogBox.reset()
			set_current_block(response)
			on_display_dialog()
		DialogBox.show_choices(callback, current_line.keys(), current_line.values())

func set_current_block(block):
	current_block = block
	if typeof(current_block) != TYPE_ARRAY:  # normalize to array
		current_block = [block]
	current_block = current_block.duplicate()
