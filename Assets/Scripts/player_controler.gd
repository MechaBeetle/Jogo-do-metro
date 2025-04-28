extends CharacterBody2D
class_name PlayerController

@export var speed = 7.0
@export var jump_power = 10.0
@export var gravity_multiplier = 0.6

var jump_friction = speed * 2
var ground_friction = speed * 3
var speed_multiplier = 20.0
var jump_multiplier = -20.0
var direction = 0
var inertia_direction = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravity_multiplier * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
		inertia_direction = direction
	else:
		if abs(velocity.x) > ground_friction:
			if is_on_floor(): velocity.x += inertia_direction * ground_friction * -1.0
			else: velocity.x += inertia_direction * jump_friction * -1.0
		else:
			velocity.x = 0

	move_and_slide()
