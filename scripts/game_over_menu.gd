extends Control

@onready var game = get_tree().get_root().get_node("Game")

var high_score = false :
	set(value):
		high_score = value
		$ScoreTitle.text = "New High Score"

func set_score():
	$Score.text = str(game.score)


func _on_restart_button_button_up():
	AudioManager.button_press.play()
	game.restart()
