extends Control

@export var character_names :Array[String]
@export var characters :Array[Control]
@export var character_costs :Array[int]


@onready var recent_character = GameSave.save_data["recent_character"]
@onready var unlocked_characters = GameSave.save_data["unlocked_characters"]
@onready var current_index = 0
@onready var selected_index = 0

@onready var total_orbs = GameSave.save_data["total_orbs"]
@onready var high_score = GameSave.save_data["high_score"]

func _ready():
	current_index = character_names.find(recent_character)
	selected_index = current_index
	characters[current_index].visible = true
	
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$"High Score/High Score".text = str(high_score)
	$Selected.visible = true

func _on_right_button_button_up():
	AudioManager.button_press.play()
	characters[current_index].visible = false
	
	current_index += 1
	if current_index >= characters.size():
		current_index = 0
	
	if character_names[current_index] in unlocked_characters:
		$Locked.visible = false
		if current_index == selected_index:
			$"Select Button".visible = false
			$Selected.visible = true
		else:
			$"Select Button".visible = true
			$Selected.visible = false
	else:
		$"Select Button".visible = false
		$Selected.visible = false
		$Locked.visible = true
		$"Locked/Buy Button".text = str(character_costs[current_index])
		
	characters[current_index].visible = true
	

func _on_left_button_button_up():
	AudioManager.button_press.play()
	characters[current_index].visible = false
	
	current_index -= 1
	if current_index < 0:
		current_index = characters.size() - 1
	
	if character_names[current_index] in unlocked_characters:
		$Locked.visible = false
		if current_index == selected_index:
			$"Select Button".visible = false
			$Selected.visible = true
		else:
			$"Select Button".visible = true
			$Selected.visible = false
	else:
		$"Select Button".visible = false
		$Selected.visible = false
		$Locked.visible = true
		$"Locked/Buy Button".text = str(character_costs[current_index])
	
	characters[current_index].visible = true
	
func _on_select_button_button_up():
	AudioManager.button_press.play()
	selected_index = current_index
	GameSave.update_recent_character(character_names[selected_index])
	$"Select Button".visible = false
	$Selected.visible = true

func _on_buy_button_button_up():
	AudioManager.button_press.play()
	var new_total_orbs = total_orbs - character_costs[current_index]
	if new_total_orbs < 0:
		return
	GameSave.update_total_orbs(new_total_orbs)
	total_orbs = new_total_orbs
	GameSave.unlock_character(character_names[current_index])
	AudioManager.success.play()
	
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$Locked.visible = false
	$"Select Button".visible = true
	
func _on_return_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/managers/game.tscn")
