extends Area2D
@onready var hero: CharacterBody2D = $hero
@export var highscore:int

func _on_body_entered(body):
	print("+1 Coin")
	print(highscore)
	queue_free()
