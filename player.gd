class_name Player extends CharacterBody2D

const SPEED = 900.0
const JUMP_VELOCITY = -900.0

var is_hurt: bool = false

# NOTE: If your sprite node is named AnimatedSprite2D, change "$Sprite2D" to "$AnimatedSprite2D"
@onready var sprite = $Sprite2D 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Only allow player controls if the player is NOT hurt
	if not is_hurt:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("Left", "Right")
		
		if direction != 0:
			velocity.x = direction * SPEED
			
			sprite.flip_h = (direction < 0)
			sprite.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			sprite.play("idle")
	else:
		velocity.x = move_toward(velocity.x, 0, 1500 * delta)

	move_and_slide()

func update_animations(direction: float) -> void:
	if not is_on_floor():
		pass
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func take_damage(bomb_position: Vector2) -> void:
	if is_hurt: 
		return
	
	is_hurt = true
	
	# 1. Calculate knockback direction away from the bomb
	var knockback_direction = (global_position - bomb_position).normalized()
	velocity.x = knockback_direction.x * 600
	velocity.y = -400 # Small upward pop
	
	# 2. Flash Red Animation using a Tween
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.2)
	
	# 3. Wait for the flash to finish before letting the player move again
	await tween.finished
	is_hurt = false
