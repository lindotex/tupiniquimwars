extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D  # Referência ao AnimatedSprite2D

var speed = 110.0  # Velocidade padrão (alterada dinamicamente)
const RUN_SPEED = 200.0  # Velocidade ao correr
const JUMP_VELOCITY = -400.0
const GRAVITY = 700

func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")  # Toca animação de pulo

	# Movimento
	var direction := Input.get_axis("ui_left", "ui_right")
	var is_running = Input.is_action_pressed("ui_run")  # Verifica se o Shift está pressionado

	# Atualiza a velocidade dependendo se está correndo ou não
	speed = RUN_SPEED if is_running else 80.0

	if direction:
		velocity.x = direction * speed

		# Espelha o sprite ao andar para a esquerda
		sprite.flip_h = direction < 0

		# Define a animação correta
		sprite.play("run" if is_running else "walk")  # Corre ou caminha dependendo do shift
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.play("idle")  # Fica parado quando não há movimento

	# Ajusta animação ao cair
	if velocity.y > 0 and not is_on_floor():
		sprite.play("fall_attack" if Input.is_action_pressed("attack") else "jump")

	move_and_slide()
