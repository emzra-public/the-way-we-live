extends Node2D

@onready var DialogBox = $DialogBox
@onready var InteractPoint = $InteractPoint
@onready var TooltipInteractableNow = $InteractPoint/TooltipInteractableNow

signal BEGIN_DIALOG

var file = FileAccess.open("res://assets/dialogue.json", FileAccess.READ)
var all_text = JSON.parse_string(file.get_as_text())
var current_block = []
var responses = []
var dialog_locked = false
var finished_talking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogBox.visible = false
	TooltipInteractableNow.visible = false
	BEGIN_DIALOG.connect(on_display_dialog)
	DialogBox.DONE.connect(on_done_dialog)
	G_Player.CHOSE_CHOICE.connect(on_done_choice)

func on_done_dialog():
	dialog_locked = false
func on_done_choice(index):
	dialog_locked = false
	set_current_block(responses[index])
	on_display_dialog()

func _on_interact_point_area_entered(area):
	TooltipInteractableNow.visible = true

func _on_interact_point_area_exited(area):
	TooltipInteractableNow.visible = false

func on_display_dialog(text_key = null):
	if finished_talking:
		return
	if DialogBox.visible != true and text_key:
		set_current_block(all_text[text_key])
		get_tree().paused = true
		DialogBox.visible = true
		InteractPoint.visible = false
	if dialog_locked:
		return
	if current_block.size() == 0:
		DialogBox.reset()
		dialog_locked = false
		InteractPoint.visible = true
		if get_tree() != null:
			get_tree().paused = false
		finished_talking = true
		InteractPoint.visible = false
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
			dialog_locked = true
			DialogBox.show_text(current_line)

	elif typeof(current_line) == TYPE_DICTIONARY:
		dialog_locked = true
		responses = current_line.values()
		G_Player.GIVE_CHOICES.emit(current_line.keys())

func set_current_block(block):
	current_block = block
	if typeof(current_block) != TYPE_ARRAY:  # normalize to array
		current_block = [block]
	current_block = current_block.duplicate()
