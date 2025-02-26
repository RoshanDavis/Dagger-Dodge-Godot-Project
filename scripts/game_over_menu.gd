extends Control

@onready var game = get_tree().get_root().get_node("Game")


func set_score():
	$Score.text = str(game.score)


func _on_restart_button_button_up():
	game.restart()
