extends CanvasLayer

@export_file("*.json") var all_text_file

var all_text = {}
var current_block = []
var in_progress = false
var dialog_locked = false

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var choices_dialog = $ChoicesDialog
@onready var choices_list = $ChoicesDialog/MarginContainer/Choices
@onready var choices_prefab = $ChoicesDialog/MarginContainer/Choices/Button

signal SELECTED(index)

func _ready():
	visible = false
	choices_dialog.visible = false
	if FileAccess.file_exists(all_text_file):
		var file = FileAccess.open(all_text_file, FileAccess.READ)
		all_text = JSON.parse_string(file.get_as_text())
	G_Interact.DIALOG.connect(on_display_dialog)

func on_display_dialog(text_key = null):
	if visible != true and text_key:
		set_current_block(all_text[text_key])
		get_tree().paused = true
		visible = true
	if dialog_locked == true:
		return
	if current_block.size() == 0:
		visible = false
		text_label.text = ""
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
			show_textline(current_line)

	elif typeof(current_line) == TYPE_DICTIONARY:
		dialog_locked = true
		show_choices(current_line.keys(), current_line.values())

func set_current_block(block):
	current_block = block
	if typeof(current_block) != TYPE_ARRAY:  # normalize to array
		current_block = [block]
	current_block = current_block.duplicate()

func show_textline(current_line):
	text_label.text = current_line

func show_choices(choices: Array, responses: Array):
	while choices_list.get_child_count() > 1:  # first reset all options
		var button = choices_list.get_child(choices_list.get_child_count() - 1)
		choices_list.remove_child(button)
		button.queue_free()
	for connection in choices_list.get_child(0).pressed.get_connections():
		choices_list.get_child(0).pressed.disconnect(connection["callable"])

	for i in range(choices.size()):
		if i != 0:
			choices_list.add_child(choices_prefab.duplicate())
		choices_list.get_child(i).text = choices[i]
		choices_list.get_child(i).pressed.connect(show_choices_on_choice.bind(responses[i]))
	choices_dialog.visible = true
func show_choices_on_choice(response):
	choices_dialog.visible = false
	dialog_locked = false
	set_current_block(response)
	on_display_dialog()
