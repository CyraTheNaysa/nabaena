extends Node2D

@export var falling_items: Array[PackedScene] = []
@export var min_x: float = 50.0
@export var max_x: float = 1100.0

@export var spawn_y: float = -50.0

@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():

	if falling_items.size() > 0:
		var random_index = randi() % falling_items.size()
		var chosen_scene = falling_items[random_index]
		if chosen_scene:
			var new_item = chosen_scene.instantiate()
			var random_x = randf_range(min_x, max_x)	
			new_item.position = Vector2(random_x, spawn_y)
			get_parent().add_child(new_item)
