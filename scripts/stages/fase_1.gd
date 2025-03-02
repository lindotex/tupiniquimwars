extends Node2D

@export var hero: Hero
@export var ui: UI 

func _ready():
	if !hero.collected.connect(ui._on_collected):
		hero.collected.connect(ui._on_collected)
	if !hero.reload_progress.is_connected(ui._on_reload_progress):
		hero.reload_progress.connect(ui._on_reload_progress)
	#if !hero.reloaded.is_connected(ui._on_reloaded):
		#hero.reloaded.connect(ui._on_reloaded)
