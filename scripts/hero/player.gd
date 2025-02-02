extends CharacterBody2D
@onready var animated_sprite_2d = $Sprite2D

@export var GRAVITY = 1000
@export var walking_speed: float = 300
@export var JUMP_FORCE: int = 500
@export var JUMP_HORIZONTAL: int = 100
@export var highscore: int = 0
var RUNNING_SPEED = walking_speed * 1.5

enum State { Idle, Run, Walk, Falling, Jump}
var current_state

#var arrow = preload(arrow.tscn)
var player_death_effect = preload("res://Scenes/characters/player_death_effect.tscn")

func _ready():
	current_state = State.Idle
	pass

func _physics_process(delta: float)->void:
	player_falling(delta)
	player_idle(delta)
	player_walk(delta)
	player_jump(delta)
	
	print("Current State:", State.keys()[current_state])
	
	move_and_slide()

func player_falling(delta: float):
	if !is_on_floor() and !player_jump(delta):
		velocity.y += GRAVITY * delta
		current_state = State.Falling

func player_jump(delta: float):
	var jumping = Input.is_action_pressed("jump")
	if is_on_floor() and jumping:
		velocity.y += -JUMP_FORCE
		current_state = State.Jump
	if !is_on_floor() and current_state == State.Jump:
		var direction = input_movement()
		velocity.x += direction * JUMP_HORIZONTAL * delta

func player_idle(delta: float):
	if is_on_floor():
		current_state = State.Idle

func player_walk(delta: float):
	var direction = input_movement()
	if direction:
		velocity.x = direction * walking_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walking_speed)
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_animations():
	if current_state == State.Walk:
		animated_sprite_2d.play("walk")
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")

func input_movement():
	var direction: float = Input.get_axis("left", "right")
	return direction

func player_death()->void:
	var player_death_effect_instance = player_death_effect.initiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	queue_free()

func _on_hurtbox_body_entered(body: Node2D)->void:
	if body.is_in_group("Enemy"):
		print("Enemy entered", body.damage_amount)
		var tween = get_tree().create_tween()
		tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", true,0)
		tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", false,0.2)
		
		#hit_animation_player.play("hurt")
		#HealthManager.decrease_health(body.damage_amount)
	#if HealthManager.current_health == 0:
		#player_death()
		
