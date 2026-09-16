extends RigidBody2D

@export var value: int = 5
@onready var despawn_timer = $DespawnTimer
@onready var sprite = $AnimatedSprite2D

func _ready():
	despawn_timer.timeout.connect(_on_despawn_timer_timeout)
	
func _on_area_2d_body_entered(body: Node2D):
	if body is Player:
		GameController.bomb_touched(value)
		body.take_damage(global_position)
		explode_and_free()
	elif "TileMap" in body.name or "Floor" in body.name:
		explode_and_free()

func explode_and_free():
	if Engine.has_meta("main_camera"):
		var camera = Engine.get_meta("main_camera")
		camera.apply_shake(12.0)
	queue_free()

func _on_despawn_timer_timeout():
	var fade_tween = create_tween()
	fade_tween.tween_property(sprite, "modulate:a", 0.0, 1.0)
	fade_tween.finished.connect(queue_free)
