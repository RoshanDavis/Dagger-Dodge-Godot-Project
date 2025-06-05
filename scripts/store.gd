extends Control

@export var pages :Array[Control]

@onready var total_orbs = GameSave.save_data["total_orbs"]
@onready var high_score = GameSave.save_data["high_score"]

func _ready():
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$"High Score/High Score".text = str(high_score)

func _on_return_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/managers/game.tscn")

func update_total_orbs():
	$"Total Orbs".text = str(GameSave.save_data["total_orbs"])


func _on_watch_ad_button_button_up():
	AdManager.display_rewarded_ad()
