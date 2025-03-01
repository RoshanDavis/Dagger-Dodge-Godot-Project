extends Node

@onready var score:int = 0
@onready var player = %Player

func _ready():
	AudioManager.game_music.play()

func add_score(value):
	score += value 
	%"Gameplay UI".set_score(score)
	
func game_over():
	Engine.time_scale = 0
	AudioManager.game_over.play()
	%"Gameplay UI".show_game_over_menu()
	
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

func gold_powerup(x):
	match x:
		0:
			player.heal(1)
		1:
			player.shield_gained()
