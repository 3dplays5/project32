extends Area2D
var motion = Vector2()
var bullet = preload("res://p_bullet.tscn")
var particle = preload("res://gunshoot.tscn")
@onready var sprite = $AnimatedSprite2D
signal shoot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if global_rotation_degrees < 90 && global_rotation_degrees > -90:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
		

func _on_player_shoot() -> void:
	var spawn = bullet.instantiate()
	owner.owner.add_child(spawn)
	spawn.transform = $Marker2D.global_transform
	var spawn2 = particle.instantiate()
	$Marker2D.add_child(spawn2)
	shoot.emit()
