extends CharacterBody2D

var speed = 1000
var moving = true
func _ready() -> void:
	$AnimatedSprite2D.play("default")
func _physics_process(delta):
	if moving:
		position += transform.x * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("splat")
	moving = false
	await get_tree().create_timer(0.2).timeout
	queue_free()
