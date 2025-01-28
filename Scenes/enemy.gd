extends CharacterBody2D


var speed = 100
var direction = 1


func _physics_process(delta: float) -> void:
	# Movimento básico de patrulha
	velocity.x = speed * direction
	velocity = move_and_slide(velocity.x)

	# Inverta a direção se atingir uma borda
	if is_on_wall():
		direction *= -1
