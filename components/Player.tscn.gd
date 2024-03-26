extends CharacterBody2D

var MAX_SPEED = 700.0
var speed = 50.0
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
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	if (velocity.x > MAX_SPEED):
		velocity.x = MAX_SPEED
	elif (velocity.x < -MAX_SPEED):
		velocity.x = -MAX_SPEED
	if velocity.is_zero_approx():
		velocity.x = 0
	velocity.x *= 0.93

	move_and_slide()
