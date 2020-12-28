tool
extends Node2D

export var next_scene: PackedScene
export var countdown_seconds: float = 3.0
onready var goals: Array = get_tree().get_nodes_in_group("Goals")
onready var level_end: CanvasLayer = $LevelEnd
onready var arthurs = CharacterManagement.initialise_arthurs()
var timer_label = Label.new()
var countdown_active = false

func _ready():
	for arthur in arthurs:
		arthur.connect("arthur_froze", self, "timer_start")
		arthur.connect("arthur_freed", self, "timer_pause")
		
	timer_label = $HUD/label_timer
	timer_label.text = str(countdown_seconds)
	
	
func _process(_delta):
	if countdown_active and countdown_seconds > 0:
		countdown_seconds -= _delta
		timer_end_check()
		timer_label.text = str(countdown_seconds)
		
		

func timer_end_check():
	if countdown_seconds <= 0:
		countdown_seconds = 0	
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func timer_start():
	countdown_active = true

func timer_pause():
	for arthur in arthurs:
		if !arthur.active:
			return
	countdown_active = false
		

func _check_all_goals():
	CharacterManagement.slow_arthurs(arthurs)
	
	for arthur in arthurs:
		if arthur.goal_reached:
			CharacterManagement.arthur_complete(arthur)
	
	for goal in goals:
		if !goal.reached:
			timer_start()
			return
	
	countdown_active = false
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
