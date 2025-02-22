extends Node

@onready var score:int = 0
@onready var gameOverMenu = preload("res://scenes/game_over_menu.tscn")
@onready var player = %Player
@onready var pauseMenu = preload("res://scenes/pause_menu.tscn")

func _ready():
	AudioManager.game_music.play()

func set_max_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_max_health(health)
	elif  has_node("Heart Health Indicator"):
		$"Heart Health Indicator".set_max_health(health)

func set_current_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_current_health(health)
	elif  has_node("Heart Health Indicator"):
		$"Heart Health Indicator".set_current_health(health)

func add_score(value):
	score += value
	$Score/HFlowContainer/Label.text = str(score)
	
func game_over():
	Engine.time_scale = 0
	AudioManager.game_over.play()
	var gameOverMenuInstance = gameOverMenu.instantiate()
	gameOverMenuInstance.position = Vector2(0,0)
	get_tree().get_root().get_node("Game").add_child(gameOverMenuInstance)
	$"Pause/Pause Button".disabled = true
	
func restart():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func powerup(x):
	match x:
		0:
			player.heal(1)
		1:
			player.shield_gained()

func resume_game():
	Engine.time_scale = 1
	
	player.canMove = true
	$"Pause/Pause Button".disabled = false
	
func exit_game():
	get_tree().quit()

func _on_pause_button_button_up():
	var pauseMenuInstance = pauseMenu.instantiate()
	pauseMenuInstance.position = Vector2(0,0)
	get_tree().get_root().get_node("Game").add_child(pauseMenuInstance)
	Engine.time_scale = 0
	player.canMove = false
	$"Pause/Pause Button".disabled = true
