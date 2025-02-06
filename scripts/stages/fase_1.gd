extends Node2D

@export var hero: Hero
@export var ui: UI 

func _ready():
	if !hero.collected.connect(ui._on_collected):
		hero.collected.connect(ui._on_collected)
