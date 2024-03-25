extends Node2D

@onready var tooltip = $InteractPoint/TooltipInteractableNow

# Called when the node enters the scene tree for the first time.
func _ready():
	tooltip.visible = false

func _on_interact_point_area_entered(area):
	tooltip.visible = true

func _on_interact_point_area_exited(area):
	tooltip.visible = false
