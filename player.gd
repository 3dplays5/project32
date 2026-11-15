extends CharacterBody2D

signal shoot
var SPEED = 600.0
var direction = ""
const JUMP_VELOCITY = -800
var gravity = 50
@onready var shotgun = $SHOTGUN
@onready var sprite = $AnimatedSprite2D
var can_dmg = true
var particle = preload("res://enemydeath.tscn")

func _ready() -> void:
	Global.player_health = 4
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("left") && is_on_floor():
		sprite.play("run")
		if is_on_floor():
			velocity.x = -SPEED
			direction = "left"
			sprite.flip_h = true
	elif Input.is_action_pressed("right") && is_on_floor():
		sprite.play("run")
		if is_on_floor():
			velocity.x = SPEED
			direction = "right"
			sprite.flip_h = false
	else:
		sprite.play("default")
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
		
	if is_on_floor():
		if Global.bullets != 3:
			Global.bullets = 3
	if Input.is_action_pressed("reload scene"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("shoot"):
		if Global.bullets > 0:
			var shoot_dir = get_local_mouse_position()
			var knockback = shoot_dir * -100
			knockback = knockback.limit_length(1000)
			velocity = knockback
			Global.bullets -= 1
			shoot.emit()
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if can_dmg:
			Global.player_health -= 1
			var shoot_dir = body.global_position
			var knockback = shoot_dir * -100
			knockback = knockback.limit_length(1000)
			velocity = knockback
			can_dmg = false 
	if body.is_in_group("lava"):
		velocity.y = -2000
		Global.player_health -= 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		await get_tree().create_timer(0.1).timeout
		can_dmg = true
		if Global.player_health <= 0:
			sprite.hide()
			var spawn = particle.instantiate()
			owner.add_child(spawn)
			spawn.transform = self.transform
			await get_tree().create_timer(0.3).timeout
			get_tree().change_scene_to_file("res://gameover.tscn")
	if body.is_in_group("lava"):
		await get_tree().create_timer(0.1).timeout
		can_dmg = true
		if Global.player_health <= 0:
			sprite.hide()
			var spawn = particle.instantiate()
			owner.add_child(spawn)
			spawn.transform = self.transform
			await get_tree().create_timer(0.3).timeout
			get_tree().change_scene_to_file("res://gameover.tscn")
		
		
