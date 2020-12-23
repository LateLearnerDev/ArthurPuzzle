extends Area2D

enum TYPE { INTERMITTENT, CONSTANT }
export(TYPE) var type = TYPE.INTERMITTENT
var animPlayer

func _ready():
	# This can easily be done with one animation player - just put all the sprites
	# in the same file
	if type == TYPE.INTERMITTENT:
		$ApConstantSpikes.queue_free()
		$ApConstantSpikes.queue_free()
		animPlayer = $AnimationPlayer
		animPlayer.play("Active")
	elif type == TYPE.CONSTANT:
		$AnimationPlayer.queue_free()
		$Sprite.queue_free()
		$CollisionShape2D.disabled = false
		animPlayer = $ApConstantSpikes
		animPlayer.play("ActiveConstant")
		
		

func _on_Spikes_entered(_body):
	print('spikes touched')
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
