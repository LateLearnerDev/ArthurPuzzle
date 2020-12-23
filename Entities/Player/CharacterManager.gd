extends Node

const player_ids = ["release_player_1", "release_player_2", "release_player_3"]

func initialise_arthurs():
	var key = 0	
	var arthurs = get_tree().get_nodes_in_group("Arthurs")
	for arthur in arthurs:
		arthur.playerId = player_ids[key]
		key += 1
		
	return arthurs

func slow_arthurs(arthurs):
	for arthur in arthurs:
		arthur.slow_down()	

func freeze_arthur(arthur):
	arthur.set_idle()
	
func arthur_complete(arthur):
	arthur.set_idle()
	arthur.set_complete()
	

	

