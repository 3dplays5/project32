extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_flip = true
@onready var sprite = $AnimatedSprite2D
@onready var aim = $Area2D
var particle = preload("res://enemydeath.tscn")

func _ready() -> void:
	Global.enemies += 1

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

	if SPEED > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	move_and_slide()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		var spawn = particle.instantiate()
		owner.add_child(spawn)
		spawn.transform = self.transform
		Global.enemies -= 1
		queue_free()
