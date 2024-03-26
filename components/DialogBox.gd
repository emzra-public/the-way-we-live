extends MarginContainer

signal SELECTED(index)

const MAX_WIDTH = 1024
var text = ""
var letter = 0

@onready var timer = $LetterDisplayTimer
@onready var label = $LabelContainer/Label
@onready var choices = $ChoicesContainer
@onready var choices_list = $ChoicesContainer/Choices
@onready var choices_prefab = $ChoicesContainer/Choices/Button

func _ready():
	reset()

func reset():
	letter = 0
	label.text = ""
	visible = false
	choices.visible = false

func show_text(line):
	text = line
	label.text = line
	reset()
	visible = true
	show_text_display_letter()
	
func show_text_display_letter():
	label.text += text[letter]
	letter += 1
	if letter >= text.length():
		return
	timer.start(0.0309)
func _on_letter_display_timer_timeout():
	show_text_display_letter()

func show_choices(callback: Callable, options: Array, responses: Array):
	reset()
	while choices_list.get_child_count() > 1:  # first reset all options
		var button = choices_list.get_child(choices_list.get_child_count() - 1)
		choices_list.remove_child(button)
		button.queue_free()
	for connection in choices_list.get_child(0).pressed.get_connections():
		choices_list.get_child(0).pressed.disconnect(connection["callable"])

	for i in range(options.size()):
		if i != 0:
			choices_list.add_child(choices_prefab.duplicate())
		choices_list.get_child(i).text = options[i]
		choices_list.get_child(i).pressed.connect(callback.bind(responses[i]))
	choices.visible = true
