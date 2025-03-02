extends CharacterBody2D
class_name Player

# Player properties
var speed: float = 200.0
var jump_force: float = -400.0
var gravity: float = 20.0
var velocity: Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity
	# Move the player
	move_and_slide(velocity, Vector2.UP)

# Handle player input
func _input(event: InputEvent) -> void:
	handle_input()

func handle_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

