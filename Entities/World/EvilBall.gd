extends KinematicBody2D

export var x_speed = 0
export var y_speed = 0
var is_active = false
var velocity = Vector2.ZERO

func _ready():
	is_active = true
	velocity.x = x_speed
	velocity.y = y_speed
	
func _physics_process(_delta):		
	if is_active:
		if is_on_wall():
			velocity.x *= -1.0
			velocity.y *= -1.0
		move_and_slide(velocity)
