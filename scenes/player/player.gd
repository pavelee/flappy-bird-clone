extends CharacterBody2D
class_name Player

signal on_game_started

@export var gravity: float = 1000
@export var jump_force: float = -400
@export var max_speed: float = 400
@export var rotation_speed: float = 2
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio

var is_started: bool = false
var should_process_input: bool = true

func _physics_process(delta: float) -> void:
		# if we jump, then make it happen!
	if Input.is_action_just_pressed("Jump") and should_process_input:
		velocity.y = jump_force
		jump_audio.play()
		# tilt up
		rotation = deg_to_rad(-30)
		if not is_started:
			is_started = true
			on_game_started.emit()
	
	# freeze player until game has started
	if not is_started:
		return
	
	# apply gravity
	velocity.y += gravity * delta
	# limit velocity to maximum speed
	velocity.y = min(velocity.y, max_speed)
		
	# process phisics - moving player
	move_and_slide()
	
	# rotate player when falling
	rotate_player(delta)

func stop_movement() -> void:
	should_process_input = false

func stop_gravity() -> void:
	gravity = 0
	velocity = Vector2.ZERO

func rotate_player(delta: float) -> void:
	# if player move down and still not at 90 rotation
	if velocity.y > 0 and rotation < deg_to_rad(90):
		# increase rotation in declared speed
		rotation += rotation_speed * delta
		
