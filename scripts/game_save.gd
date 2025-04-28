extends Node

const save_path = "user://savegame.data"

var save_data :Dictionary = {
	"high_score" : 0,
	"total_orbs" : 10000,
	"recent_character" : "GroundZero",
	"unlocked_characters" : ["GroundZero"],
	"recent_dagger" : "KitchenKnife",
	"unlocked_daggers" : ["KitchenKnife"],
	"unlocked_achievements" :[]
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
	
func update_total_orbs(amount :int):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_data["total_orbs"] = amount
	
	file.store_var(save_data)
	file.close()

func unlock_character(character :String):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_data["unlocked_characters"].append(character)
	
	file.store_var(save_data)
	file.close()

func update_recent_character(character :String):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_data["recent_character"] = character
	
	file.store_var(save_data)
	file.close()

func unlock_dagger(character :String):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_data["unlocked_daggers"].append(character)
	
	file.store_var(save_data)
	file.close()

func update_recent_dagger(character :String):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_data["recent_dagger"] = character
	
	file.store_var(save_data)
	file.close()
	
	
