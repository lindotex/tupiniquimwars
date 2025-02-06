extends Area2D
@onready var killzone = $"."
@onready var hero: CharacterBody2D = $"../hero"

func _on_body_exited(body):
	print(body +"You died");
