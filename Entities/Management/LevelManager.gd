tool
extends Node2D

export var next_scene: PackedScene
onready var goals: Array = get_tree().get_nodes_in_group("Goals")
onready var level_end: CanvasLayer = $LevelEnd
onready var arthurs = CharacterManagement.initialise_arthurs()

func _check_all_goals():
	CharacterManagement.slow_arthurs(arthurs)
	
	for arthur in arthurs:
		if arthur.goal_reached:
			CharacterManagement.freeze_arthur(arthur)
	
	for goal in goals:
		if !goal.reached:
			return
		
	to_next_level()
		
func to_next_level() -> void:	
	level_end.end_level_transition()
	yield(level_end, "tree_exited")
	# I think this is cheating. I yield the animation to finish inside LevelEnd
	# and then free it from memory so that I can listen here and only switch to 
	# next scene once LevelEnd has exited the tree.
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
