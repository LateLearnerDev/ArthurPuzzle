extends Node

const player_ids = ["release_player_1", "release_player_2", "release_player_3"]
var arthurs

func initialise_arthurs():
	var key = 0	
	arthurs = get_tree().get_nodes_in_group("Arthurs")
	for arthur in arthurs:
		arthur.playerId = player_ids[key]
		key += 1

	


