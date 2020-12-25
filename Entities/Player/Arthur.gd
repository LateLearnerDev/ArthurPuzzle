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
const green = "#48b237"
const red = "#f02323"
const blue = "#1d6dca"
onready var hurt_box = $HurtBox
onready var player_label = $Label
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

signal arthur_froze
signal arthur_freed

func _ready():
	animationTree.active = true
	player_label.text = playerId[playerId.length() - 1]
	player_label.modulate = green
	
func _process(_delta):
	if !goal_reached:
		if Input.is_action_just_released(playerId):
			# warning-ignore:standalone_ternary
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
	# warning-ignore:return_value_discarded
	move_and_slide(force * delta)
	
func slow_down() -> void:
	speed /= 2
	
func arthur_froze() -> void:
	player_label.modulate = red
	set_idle()
	emit_signal("arthur_froze")
	
func arthur_freed() -> void:
	player_label.modulate = green
	set_active()
	emit_signal("arthur_freed")
	
func set_complete() -> void:
	player_label.modulate = blue
	
func set_idle() -> void:
	active = false
	animationState.travel("Idle")
	
func set_active() -> void:
	active = true

func _on_HurtBox_area_entered(area):
	get_tree().reload_current_scene()

func _on_FeetHurtBox_area_entered(area):
	get_tree().reload_current_scene()
