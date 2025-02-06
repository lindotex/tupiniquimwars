extends Area2D

class_name Gem

@onready var hero: CharacterBody2D = $hero

func _on_body_entered(body):
		print("+1 Coin")
		body.collect(self)
		queue_free()
