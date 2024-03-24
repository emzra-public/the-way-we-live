extends PanelContainer

signal SELECTED(index)

@onready var choices_list = $"MarginContainer/Choices"
@onready var choices_prefab = $"MarginContainer/Choices/Button"

var choices:Array[String]:
	set(value):
		choices = value
		initButtons()

# Called when the node enters the scene tree for the first time.
func _ready():
	choices_list.get_child(0).pressed.connect(onChoice.bind(0))

func initButtons():
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
			choices_list.get_child(i).pressed.connect(onChoice.bind(i))

func onChoice(choice_index):
	visible = false
	SELECTED.emit(choice_index)
	if choice_index == 2:  # Assuming option 2 increases karma
		PlayerKarma.increase_karma()
	elif choice_index == 3:  # Assuming option 3 increases stole
		PlayerKarma.increase_stole()
	
