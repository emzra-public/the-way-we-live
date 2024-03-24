extends CanvasLayer

@export_file("*.json") var all_text_file

var all_text = {}
var current_block = []
var in_progress = false

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
	DialogBus.display_dialog.connect(on_display_dialog)

func on_display_dialog(text_key):
	set_current_block(all_text[text_key])
	show_text()

func set_current_block(block):
	current_block = block.duplicate()
	if typeof(current_block) != TYPE_ARRAY:  # normalize to array
		current_block = [current_block]

func show_text():
	if visible != true:
		get_tree().paused = true
		visible = true
	if current_block.size() == 0:
		visible = false
		text_label.text = ""
		get_tree().paused = false
		return

	var current_line = current_block.pop_front()

	if typeof(current_line) == TYPE_STRING:
		show_textline(current_line)

	elif typeof(current_line) == TYPE_DICTIONARY:
		show_choices(current_line.keys(), current_line.values())

func show_textline(current_line):
	text_label.text = current_line

func show_choices(choices: Array[String], responses: Array):
	while choices_list.get_child_count() > 1:
		var button = choices_list.get_child(choices_list.get_child_count() - 1)
		choices_list.remove_child(button)
		button.queue_free()
	
	for i in range(choices.size()):
		if (i == 0):
			choices_list.get_child(0).text = choices[i]
		else:
			choices_list.add_child(choices_prefab.duplicate())
			choices_list.get_child(i).text = choices[i]
			choices_list.get_child(i).pressed.connect(show_choices_callback.bind(responses[i]))
	choices_dialog.visible = true
func show_choices_callback(response):
	choices_dialog.visible = false
	set_current_block(response)
	show_text()
