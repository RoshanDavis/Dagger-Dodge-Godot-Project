extends Control

@export var dagger_names :Array[String]
@export var daggers :Array[Control]
@export var dagger_costs :Array[int]


@onready var recent_dagger = GameSave.save_data["recent_dagger"]
@onready var unlocked_daggers = GameSave.save_data["unlocked_daggers"]
@onready var current_index = 0
@onready var selected_index = 0

@onready var total_orbs = GameSave.save_data["total_orbs"]
@onready var high_score = GameSave.save_data["high_score"]

func _ready():
	current_index = dagger_names.find(recent_dagger)
	selected_index = current_index
	daggers[current_index].visible = true
	
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$"High Score/High Score".text = str(high_score)
	$Selected.visible = true

func _on_right_button_button_up():
	daggers[current_index].visible = false
	
	current_index += 1
	if current_index >= daggers.size():
		current_index = 0
	
	if dagger_names[current_index] in unlocked_daggers:
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
		$"Locked/Buy Button".text = str(dagger_costs[current_index])
		
	daggers[current_index].visible = true
	

func _on_left_button_button_up():
	daggers[current_index].visible = false
	
	current_index -= 1
	if current_index < 0:
		current_index = daggers.size() - 1
	
	if dagger_names[current_index] in unlocked_daggers:
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
		$"Locked/Buy Button".text = str(dagger_costs[current_index])
	
	daggers[current_index].visible = true
	
func _on_select_button_button_up():
	selected_index = current_index
	GameSave.update_recent_dagger(dagger_names[selected_index])
	$"Select Button".visible = false
	$Selected.visible = true

func _on_buy_button_button_up():
	var new_total_orbs = total_orbs - dagger_costs[current_index]
	if new_total_orbs < 0:
		return
	GameSave.update_total_orbs(new_total_orbs)
	total_orbs = new_total_orbs
	GameSave.unlock_dagger(dagger_names[current_index])
	
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$Locked.visible = false
	$"Select Button".visible = true
	
func _on_return_button_button_up():
	get_tree().change_scene_to_file("res://scenes/managers/game.tscn")
