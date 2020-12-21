extends KinematicBody2D

enum {
	IDLE, MOVE, ATTACK
}

export var speed = 1800
var state
var velocity = Vector2.ZERO
var force = Vector2.ZERO
var playerId
var active = true
var goal_reached = false
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

signal arthur_froze
signal arthur_freed

func _ready():
	animationTree.active = true
	
func _process(_delta):
	if !goal_reached:
		if Input.is_action_just_released(playerId):
			arthur_froze() if active else arthur_freed()
	
func _physics_process(delta):
	if active:
		handle_move_state(delta)
	else:
		handle_idle_state(delta)

func handle_move_state(delta) -> void:
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
				
	velocity = move_and_slide((velocity + force) * delta)

func handle_idle_state(delta) -> void:
	move_and_slide(force * delta)
	
func slow_down() -> void:
	speed /= 2
	
func arthur_froze() -> void:
	set_idle()
	emit_signal("arthur_froze")
	
func arthur_freed() -> void:
	set_active()
	emit_signal("arthur_freed")
	
func set_idle() -> void:
	active = false
	animationState.travel("Idle")
	
func set_active() -> void:
	active = true
		
