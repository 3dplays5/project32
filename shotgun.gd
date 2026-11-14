extends Area2D
var motion = Vector2()
@onready var sprite = $AnimatedSprite2D
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
	var direction = get_global_mouse_position().direction_to(self.global_position)
