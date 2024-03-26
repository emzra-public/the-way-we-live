extends MarginContainer

@onready var choices_list = $Choices
@onready var button_prefab = $Choices/Button

func _ready():
	visible = false
	choices_list.get_child(0).pressed.connect(on_done.bind(0))
	G_Player.GIVE_CHOICES.connect(show_choices)
	return

func on_done(index):
	visible = false
	G_Player.CHOSE_CHOICE.emit(index)

func show_choices(choices):
	while choices_list.get_child_count() > 1:
		var button = choices_list.get_child(choices_list.get_child_count() - 1)
		choices_list.remove_child(button)
		button.queue_free()
	
	for index in range(choices.size()):
		if (index == 0):
			choices_list.get_child(0).text = choices[index]
		else:
			choices_list.add_child(button_prefab.duplicate())
			choices_list.get_child(index).text = choices[index]
			choices_list.get_child(index).pressed.connect(on_done.bind(index))
	visible = true
