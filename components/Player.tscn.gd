extends CharacterBody2D

@export var move_speed : float = 100

const MAX_SPEED = 300
const ACCEL = 1500
const FRICTION = 1200

func _physics_process(delta):
	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
		
	if input == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(input * ACCEL * delta)

	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(movement):
	velocity += movement
	velocity = velocity.limit_length(MAX_SPEED)
