extends Control

signal start_game()

@onready var buttons_v_box = %ButtonsVbox
@onready var new_game = %Start as Button
@onready var settings = %Settings as Button
@onready var quit = %Quit as Button

func _ready() -> void:
	focus_button()
	new_game.button_down.connect(_on_new_game_pressed)
	settings.button_down.connect(_on_settings_pressed)
	quit.button_down.connect(_on_quit_pressed)
	pass

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stages/fase_1.tscn")
	start_game.emit()
	hide()

func _on_settings_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

func on_visibility_changed()-> void:
	if visible:
		focus_button()

func focus_button() -> void:
	if buttons_v_box:
		var button:Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()
