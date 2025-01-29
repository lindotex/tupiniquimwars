extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D  # Referência ao AnimatedSprite2D

const SPEED = 300.0
const RUN_SPEED = 500.0  # Velocidade ao correr
const JUMP_VELOCITY = -400.0
const GRAVITY = 700

func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")  # Toca animação de pulo

	# Verifica se o personagem está correndo
	var is_running = Input.is_action_pressed("ui_shift")
	var current_speed = RUN_SPEED if is_running else SPEED

	# Movimento
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * current_speed

		# Espelha o sprite ao andar para a esquerda
		if direction < 0:
			sprite.flip_h = true
		elif direction > 0:
			sprite.flip_h = false

		# Define a animação correta
		sprite.play("run" if is_running else "walk")
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		sprite.play("idle")  # Fica parado quando não há movimento

	# Ajusta animação ao cair
	if velocity.y > 0 and not is_on_floor():
		sprite.play("fall_attack" if Input.is_action_pressed("ui_attack") else "jump")

	move_and_slide()
