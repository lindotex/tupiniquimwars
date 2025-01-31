extends Control

@onready var new_game = $"Panel/New Game" as Button
@onready var quit = $Panel/Quit as Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game.button_down.connect(_on_new_game_pressed)
	quit.button_down.connect(_on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/stages/fase_1.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
