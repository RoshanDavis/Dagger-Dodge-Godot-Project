extends Control


func _ready():
	var score = get_parent().score
	set_score(score)

func set_score(score):
	$Score.text = str(score)


func _on_restart_button_button_up():
	get_parent().restart()


func _on_resume_button_button_up():
	get_parent().resume_game()
	queue_free()

func _on_exit_button_button_up():
	get_parent().exit_game()
