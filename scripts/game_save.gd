extends Node

const save_path = "user://savegame.data"

var save_data :Dictionary = {
	"high_score" : 0,
	"total_orbs" : 0,
	"current_character" : 0,
	"current_dagger" : 0,
	"characters_unlocked" : [],
	"daggers_unlocked" : [],
	"achievements_unlocked" : []
}

func _ready():
	if FileAccess.file_exists(save_path):
		load_game_data()
	else:
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(save_data)
		file.close()
		load_game_data()


func save_score_data(score: int):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	if save_data["high_score"] < score:
		save_data["high_score"] = score
		
	save_data["total_orbs"] += score 
	
	file.store_var(save_data)
	file.close()

func load_game_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	save_data = file.get_var()
	print_debug(save_data)
	
	file.close()
	
	
	
	
	
