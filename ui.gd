extends Node2D

@onready var health = $AspectRatioContainer/AnimatedSprite2D
@onready var bulletsui = $AspectRatioContainer/AnimatedSprite2D2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player_health == 4:
		health.play("default")
	elif Global.player_health == 3:
		health.play("3")
	elif Global.player_health == 2:
		health.play("2")
	elif Global.player_health == 1:
		health.play("1")

	if Global.bullets == 3:
		bulletsui.play("default")
	elif Global.bullets == 2:
		bulletsui.play("2")
	elif Global.bullets == 1:
		bulletsui.play("1")
	elif Global.bullets == 0:
		bulletsui.play("0")
