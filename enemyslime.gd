extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_flip = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = SPEED
	
	if is_on_wall() && can_flip:
		if can_flip:
			SPEED *= -1
			can_flip = false
		await get_tree().create_timer(0.1).timeout
		can_flip = true

	move_and_slide()
