extends Control

@onready var game = get_tree().get_root().get_node("Game")

func set_score():
	$Score.text = str(game.score)

func _on_restart_button_button_up():
	AudioManager.button_press.play()
	game.restart()

func _on_resume_button_button_up():
	AudioManager.button_press.play()
	game.resume_game()
	visible = false


func _on_settings_button_button_up():
	AudioManager.button_press.play()
	$Settings.visible = true
