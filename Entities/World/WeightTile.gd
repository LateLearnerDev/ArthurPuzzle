tool
extends Area2D

export var max_bodies = 1;
var body_count = 0

func _on_WeightTile_body_entered(_body):
	body_count += 1
	if body_count > 1:
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


func _on_WeightTile_body_exited(_body):
	body_count -= 1
