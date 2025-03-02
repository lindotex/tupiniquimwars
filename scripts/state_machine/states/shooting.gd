#@extends "res://scripts/state_machine/State.gd"

func input_movement():
	var direction: float = Input.get_axis("left", "right")
	return direction

func player_shooting(delta: float)->void:
	var direction = input_movement()
