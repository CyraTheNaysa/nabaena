extends Camera2D

var shake_intensity: float = 0.0
var shake_fade: float = 5.0

func _ready() -> void:
	# This registers the camera globally so any script can call it
	Engine.set_meta("main_camera", self)

func _process(delta: float) -> void:
	if shake_intensity > 0.0:
		shake_intensity = move_toward(shake_intensity, 0.0, shake_fade * delta)
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		offset = Vector2.ZERO

func apply_shake(intensity: float, fade: float = 15.0) -> void:
	shake_intensity = intensity
	shake_fade = fade
	
