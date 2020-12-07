tool
extends Area2D

export var reached = false
signal goal_reached()
signal goal_exited()

func _on_body_entered(_body: PhysicsBody2D) -> void:
	reached = true
	emit_signal("goal_reached")
	
func _on_body_exited(_body: PhysicsBody2D) -> void:
	reached = false
	emit_signal("goal_exited")
	

	
	






