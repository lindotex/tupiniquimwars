extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Aplica a gravidade
	if not is_on_floor():
		velocity.y += 980 * delta  # Valor típico de gravidade

	# Movimento lateral
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
