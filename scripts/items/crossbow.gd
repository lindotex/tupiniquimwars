extends Node2D
class_name Crossbow

signal reloaded()
signal reload_progress()

enum States { ready, firing, reloading}

@export var arrow_scene: PackedScene
@onready var reload_timer = $crossbow/reloadtimer

var can_fire: bool 
var state:States = States.ready

func _process(delta):
	if !reload_timer:
		reload_progress.emit(1- (reload_timer.time_left / reload_timer.wait_time))
		

func _ready():
	change_state(States.ready)

func change_state(new_state: States):
	state = new_state

func fire():
	if state == States.firing || States.reloading:
		return
		
	change_state(States.firing)
	var arrow = arrow_scene.instantiate()
	arrow.direction = Vector2.from_angle(global_rotation)
	arrow.global_position = global_position
	get_tree().root.add_child(arrow)
	change_state(States.reloading)
	reload_timer.start()

func _on_reloadtimer_timeout():
	change_state(States.ready)
	reloaded.emit()
