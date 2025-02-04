extends CharacterBody2D
@export var patrol_points: Node
@onready var animated_sprite2D = $AnimatedSprite2D
@onready var timer = $Timer

@export var gravity: int = 700
@export var speed: int = 600

enum State { Idle, Walk }

var current_state = State
var direction : Vector2 = Vector2.LEFT
var number_of_points: int
var point_positions: Array[Vector2]
var current_point: Vector2
var current_point_position: int


func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol Points associated")
	current_state = State.Idle

func _physics_process(delta) -> void:
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	move_and_slide()
	animation()

func enemy_gravity(delta:float):
	velocity.y = gravity * delta

func enemy_idle(delta:float):
	velocity.x = move_toward(velocity.x, 0, speed * delta)
	current_state = State.Idle

func enemy_walk(delta):
	# Patrol function
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position += 1
	
	# Condition to not go Out of Bounds of numbers (2) after turning:
	if current_point_position >= number_of_points:
		current_point_position = 0
	
	current_point = point_positions[current_point_position]
	
	# Changes the direction whenever it is closer to an point in patrol points.
	if current_point.x > position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	animated_sprite2D.flip_h = direction.x<0

func animation():
	if current_state == State.Idle:
		animated_sprite2D.play("idle")
	if current_state == State.Walk:
		animated_sprite2D.play("run")
