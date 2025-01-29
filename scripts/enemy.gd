extends CharacterBody2D

var speed = 100
var direction = 1

func _physics_process(delta: float) -> void:
	# Movimento básico de patrulha
	velocity.x = speed * direction

	# Mova o personagem
	move_and_slide()

	# Inverta a direção se atingir uma borda
	if is_on_wall():
		direction *= -1
