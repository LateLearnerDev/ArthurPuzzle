extends Area2D

func _on_Hole_Entered(_body):
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
