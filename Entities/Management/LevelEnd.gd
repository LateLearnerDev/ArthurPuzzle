extends CanvasLayer

onready var anim_player: AnimationPlayer = $AnimationPlayer

func end_level_transition() -> void:
	anim_player.play("fade")
	yield(anim_player, "animation_finished")
	
