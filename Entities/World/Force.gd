tool
extends Area2D

export var x_force = 0
export var y_force = 0

func _on_Force_body_entered(body):
	body.force = Vector2(x_force, y_force)

func _on_Force_body_exited(body):
	body.force = Vector2.ZERO
