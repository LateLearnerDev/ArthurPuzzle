extends KinematicBody2D

enum {
	IDLE, MOVE, ATTACK
}

export var speed = 1800
var state
var velocity = Vector2.ZERO
var playerId
var active = true

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	
func _process(_delta):
	if Input.is_action_just_released(playerId):
		active = !active
		animationState.travel("Idle")
		print(velocity)
	
func _physics_process(delta):
	if active:
		handle_move_state(delta)

func handle_move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * speed
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity * delta)
		
