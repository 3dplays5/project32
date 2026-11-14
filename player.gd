extends CharacterBody2D

signal shoot
var SPEED = 600.0
var direction = ""
const JUMP_VELOCITY = -800
var gravity = 50
var bullets = 3
@onready var shotgun = $SHOTGUN
@onready var sprite = $AnimatedSprite2D
var directionback = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("left") && is_on_floor():
		if is_on_floor():
			velocity.x = -SPEED
			direction = "left"
			sprite.flip_h = true
	elif Input.is_action_pressed("right") && is_on_floor():
		if is_on_floor():
			velocity.x = SPEED
			direction = "right"
			sprite.flip_h = false
	else:
		if is_on_floor():
			velocity.x = 0
			
	if is_on_wall() && is_on_floor() == false:
		if direction == "right":
			velocity.x = -400
			direction = "left"
		elif direction == "left":
			velocity.x = 400
			direction = "right"
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("shoot"):
		var shoot_dir = get_local_mouse_position()
		var knockback = shoot_dir * -80
		knockback = knockback.limit_length(1000)
		velocity = knockback
		shoot.emit()
	
	move_and_slide()
