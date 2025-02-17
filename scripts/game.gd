extends Node

@onready var score:int = 0
@onready var gameOverMenu = preload("res://scenes/game_over_menu.tscn")

func _ready():
	AudioManager.game_music.play()

func set_max_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_max_health(health)
	else:
		printerr("Health Bar Component Missing")

func set_current_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_current_health(health)
	else:
		printerr("Health Bar Component Missing")

func add_score(value):
	score += value

func game_over():
	AudioManager.game_over.play()
	var gameOverMenuInstance = gameOverMenu.instantiate()
	gameOverMenuInstance.position = Vector2(0,0)
	get_tree().get_root().get_node("Game").add_child(gameOverMenuInstance)
	
func restart():
	get_tree().reload_current_scene()
