extends CharacterBody2D

var MAX_SPEED = 600.0
var speed = 300.0
var jump_speed = -600.0

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = 1200


func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x += direction * speed
	if velocity.x >= 

	move_and_slide()
