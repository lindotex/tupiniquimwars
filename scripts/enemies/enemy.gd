extends CharacterBody2D

var GRAVITY = 700
var speed = 100
var direction = 1

func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Movimento básico de patrulha
	velocity.x = speed * direction * delta

	# Mova o personagem
	move_and_slide()

	# Inverta a direção se atingir uma borda
	if is_on_wall():
		direction *= -1
