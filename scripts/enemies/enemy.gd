extends CharacterBody2D

@export var GRAVITY: int = 700
@export var speed: int = 100
var direction: Vector2 = Vector2.LEFT

enum State {Idle, Walk}
var current_state = State

func _ready():
	current_state = State.Idle

func _physics_process(delta: float) -> void:
	enemy_gravity(delta)
	enemy_idle(delta)

	move_and_slide()


func enemy_gravity(delta:float):
	velocity.y = GRAVITY * delta

# Idle
func enemy_idle(delta:float):
	velocity.x = move_toward(velocity.x, 0, speed * delta)
	current_state = State.Idle

func enemy_walk(delta:float):
	velocity.x = direction * GRAVITY * delta
	current_state = State.walk
