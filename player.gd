extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
var gravity = 50
var bullets = 3
@onready var shotgun = $SHOTGUN


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
	else:
		if is_on_floor():
			velocity.x = 0
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("shoot"):
		shoot()

	move_and_slide()

func shoot()
	shotgun.global_transform.basis.z
