extends CanvasLayer


func set_max_health(health):
	$"Heart Health Indicator".set_max_health(health)

func set_current_health(health):
	$"Heart Health Indicator".set_current_health(health)
	
func set_score(score):
	$Score/Label.text = str(score)

func show_game_over_menu():
	$"Game Over Menu".set_score()
	$"Game Over Menu".visible = true

func show_pause_menu():
	$"Pause Menu".set_score()
	$"Pause Menu".visible = true


func _on_pause_button_button_up():
	get_tree().get_root().get_node("Game").pause_game()
