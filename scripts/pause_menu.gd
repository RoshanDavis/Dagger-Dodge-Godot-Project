extends Control

@onready var game = get_tree().get_root().get_node("Game")

func set_score():
	$Score.text = str(game.score)

func _on_restart_button_button_up():
	game.restart()

func _on_resume_button_button_up():
	game.resume_game()
	visible = false

func _on_exit_button_button_up():
	game.exit_game()
