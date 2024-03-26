extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var sprite_stand = load("res://assets/chara-stand.png")
@onready var sprite_run = load("res://assets/chara-run.png")
@onready var sprite_fall = load("res://assets/chara-fall.png")

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
	if direction == 0:
		if velocity.y > 20:
			$Sprite2D.texture = sprite_fall
		else:
			$Sprite2D.texture = sprite_stand
	elif direction == -1:
		$Sprite2D.flip_h = true
		$Sprite2D.texture = sprite_run
	else:
		$Sprite2D.flip_h = false
		$Sprite2D.texture = sprite_run


	velocity.x += direction * speed
	if (velocity.x > MAX_SPEED):
		velocity.x = MAX_SPEED
	elif (velocity.x < -MAX_SPEED):
		velocity.x = -MAX_SPEED
	if velocity.is_zero_approx():
		velocity.x = 0
	velocity.x *= 0.93

	move_and_slide()
