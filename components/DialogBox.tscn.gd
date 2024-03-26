extends MarginContainer

signal DONE

var text = ""
var letter = 0

@onready var timer = $LetterDisplayTimer
@onready var label = $LabelContainer/Label

func _ready():
	reset()

func reset():
	letter = 0
	label.text = ""
	visible = false

func show_text(line):
	text = line
	label.text = line
	reset()
	visible = true
	show_text_display_letter()

func show_text_display_letter():
	if letter >= text.length():
		DONE.emit()
		return
	label.text += text[letter]
	letter += 1
	timer.start(0.005)
func _on_letter_display_timer_timeout():
	show_text_display_letter()
