extends Area2D

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.enemies == 0:
		sprite.play("open")
		


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && Global.enemies == 0:
		if Global.level == 1:
			get_tree().change_scene_to_file("res://level_2.tscn")
		elif Global.level == 2:
			get_tree().change_scene_to_file("res://winscreen.tscn")
