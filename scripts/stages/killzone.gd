extends Area2D
@onready var killzone = $"."

func _on_body_exited(body):
	print(body +"You died")
