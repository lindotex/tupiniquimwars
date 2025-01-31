extends "res://scripts/state_machine/State.gd"


func player_shooting(delta: float)->void:
	var direction = input_movement()
