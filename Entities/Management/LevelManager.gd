tool
extends Node2D

export var next_scene: PackedScene
onready var goals: Array = get_tree().get_nodes_in_group("Goals")
onready var level_end: CanvasLayer = $LevelEnd

func _ready():
	pass

func _check_all_goals():
	for goal in goals:
		if !goal.reached:
			return
		
	to_next_level()
		
func to_next_level() -> void:	
	level_end.end_level_transition()
	#Need to call below, only after above function has finished (the animation)
	#get_tree().change_scene_to(next_scene)

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
