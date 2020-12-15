extends Area2D

func _on_Hole_Entered(_body):
	get_tree().reload_current_scene()
