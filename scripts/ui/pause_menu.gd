extends Node

@onready var main_volume_selector = %"Main Volume Selector"
@onready var main_volume_label = %"Main Volume Label"
@onready var quit = %Quit as Button
@onready var tab_container = %tab_container

var main_volume_value : int
# Called when the node enters the scene tree for the first time.
func _ready():
	focus_button()
	main_volume_controller()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func focus_button() -> void:
	if tab_container:
		var button:BoxContainer = tab_container.get_child(0)
		if button is BoxContainer:
			button.grab_focus()

func main_volume_controller():
	pass
