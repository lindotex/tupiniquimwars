extends CharacterBody2D
@onready var animated_sprite_2d = $Sprite2D
@onready var coin: Node2D = $"../Coin"

@export var GRAVITY = 1000
@export var walking_speed: float = 250
@export var Jump_y_force: int = 500
@export var Jump_x_force: int = 600
@export var highscore: int = 0
var running_speed = 600
var _is_crouching = false

enum State { Idle, Run, Walk, Falling, Jump, Menu, Attack, Aim, Duck, Hurt}
var current_state

#var arrow = preload(arrow.tscn)
var player_death_effect = preload("res://Scenes/characters/player_death_effect.tscn")
var menu_scene = "res://scenes/menus/menu.tscn" # Alterar para Pause

func _ready():
	current_state = State.Idle
	pass

func _physics_process(delta: float)->void:
	player_animations()
	player_falling(delta)
	player_idle(delta)
	player_walk(delta)
	player_run(delta)
	player_attack()
	player_duck()
	player_hurt()
	player_aim()
	menu_call()
	player_jump(delta)
	#print("Current State:", State.keys()[current_state])
	move_and_slide()
	
func input_movement():
	var direction: float = Input.get_axis("left", "right")
	return direction
	
func player_falling(delta: float):
	if !is_on_floor() and State.Walk:
		var direction = input_movement()
		velocity.y += GRAVITY * delta
		velocity.x = direction * Jump_x_force * delta
		current_state = State.Falling

func player_jump(delta: float):
	var jumping = Input.is_action_pressed("jump")
	
	if is_on_floor() and jumping:
		velocity.y += -Jump_y_force
		current_state = State.Jump
	if !is_on_floor() and current_state == State.Jump:
		var direction = input_movement()
		velocity.x = direction * Jump_x_force * delta
		current_state = State.Jump

func player_idle(delta: float)->void:
	var direction = input_movement()
	var movement = direction * delta
	if is_on_floor() and !movement:
		current_state = State.Idle

func player_walk(delta: float)->void:
	var direction = input_movement()
	
	if direction:
		velocity.x = direction * walking_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walking_speed)
	
	if direction != 0:
		current_state = State.Walk
		animated_sprite_2d.flip_h = false if direction > 0 else true

#func player_death()->void:
	#var player_death_effect_instance = player_death_effect.initiate() as Node2D
	#player_death_effect_instance.global_position = global_position
	#get_parent().add_child(player_death_effect_instance)
	#queue_free()
#
#func _on_hurtbox_body_entered(body: Node2D)->void:
	#if body.is_in_group("Enemy"):
		#print("Enemy entered", body.damage_amount)
		#var tween = get_tree().create_tween()
		#tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", true,0)
		#tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", false,0.2)
		#
		##hit_animation_player.play("hurt")
		##HealthManager.decrease_health(body.damage_amount)
	##if HealthManager.current_health == 0:
		##player_death()

func player_run(delta: float)->void:
	# Get Run Input
	var running = Input.is_action_pressed("run")
	# Get Direction of the movement
	var direction = input_movement()
	# Verify if player is running on floor
	if is_on_floor() and running:
		# Don't Play Run Animation while not moving
		if !direction:
			current_state = State.Idle
		else:
			velocity.x = direction * running_speed
			current_state = State.Run
	if !is_on_floor() and current_state == State.Run:
		velocity.x += direction * running_speed * delta

func menu_call():
	var menu = Input.is_action_pressed("menu")
	if menu:
		get_tree().change_scene_to_file(menu_scene)
		current_state = State.Menu

func player_attack():
	var attack = Input.is_action_pressed("attack")
	if attack:
		current_state = State.Attack
		print("Player Atacou")

func player_aim():
	var direction = input_movement()
	var aiming = Input.is_action_pressed("aim")
	
	if direction and aiming:
		velocity.x = direction * 0
		current_state = State.Attack
	else:
		velocity.x = move_toward(velocity.x, 0, 0)

# VOLTAR PARA TERMINAR ESSA JOÇA::::::::::::::::::::::::::::::
func player_duck():
	var duck = Input.is_action_pressed("down")
	var direction = input_movement()
	if is_on_floor() and duck:
		velocity.x = 0
		print("Player Duck")
		current_state = State.Duck
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

func player_hurt():
	pass

func player_animations():
	if current_state == State.Walk:
		animated_sprite_2d.play("walk")
	elif current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif current_state == State.Falling:
		animated_sprite_2d.play("falling")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Attack:
		animated_sprite_2d.play("attack")
	elif current_state == State.Aim:
		animated_sprite_2d.play("walk")
	elif current_state == State.Duck:
		animated_sprite_2d.play("duck")
	elif current_state == State.Hurt:
		animated_sprite_2d.play("hurt")
