tool
extends Area2D

onready var connected_items: Array = get_tree().get_nodes_in_group('Switchable')

func _ready():
	pass
	
func _get_configuration_warning() -> String:
	return "The switch has no connected items" if not connected_items else ""


func _on_Switch_body_entered(_body):
	for item in connected_items:
		item.queue_free()
