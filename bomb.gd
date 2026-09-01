extends Node2D

@export var value: int = 1
@onready var despawn_timer = $DespawnTimer
@onready var sprite = $AnimatedSprite2D
func _ready():
	despawn_timer.timeout.connect(_on_despawn_timer_timeout)
	
func _on_area_2d_body_entered(body):
	if body is Player:
		GameController.coin_collected(value)
		self.queue_free()

func _on_despawn_timer_timeout():
	var fade_tween = create_tween()
	fade_tween.tween_property(sprite, "modulate:a", 0.0, 1.0)
	fade_tween.finished.connect(queue_free)
