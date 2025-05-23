extends Node

@onready var score:int = 0
@onready var player = %Player

func _ready():
	
	pass

func add_score(value):
	if GameSave.save_data["recent_character"] == "OneShot":
		value *= 2
	if GameSave.save_data["recent_dagger"] == "Hydra":
		value *= 2
	score += value 
	%"Gameplay UI".set_score(score, value)
	
func game_over():
	Engine.time_scale = 0
	AudioManager.game_over.play()
	if GameSave.save_data["high_score"] < score:
		%"Gameplay UI".display_high_score()
	%"Gameplay UI".show_game_over_menu()
	GameSave.save_score_data(score)
	
func restart():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func resume_game():
	Engine.time_scale = 1
	player.canMove = true
	
func exit_game():
	get_tree().quit()

func pause_game():
	Engine.time_scale = 0
	if player != null:
		player.canMove = false
	%"Gameplay UI".show_pause_menu()
