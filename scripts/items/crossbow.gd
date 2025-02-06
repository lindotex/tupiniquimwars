extends Node2D
class_name Crossbow

@export var bullet_scene: PackedScene

@onready var reload_timer = $crossbow/reloadtimer

var can_fire: bool 

var states:States = States.ready

func _ready():
	change.estate
