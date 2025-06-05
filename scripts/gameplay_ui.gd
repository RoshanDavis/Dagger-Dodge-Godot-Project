extends CanvasLayer

var tween :Tween

@onready var game = get_tree().get_root().get_node("Game")

func set_max_health(health):
	$"Heart Health Indicator".set_max_health(health)

func set_current_health(health):
	$"Heart Health Indicator".set_current_health(health)
	
func set_score(score, value_added):
	$Score/Label.text = str(score)
	scale_score_label(value_added * 0.2)
	#rotate_score_label()
	scale_score_texture(value_added * 0.05)

func scale_score_label(scale_factor):
	tween = create_tween()
	tween.tween_property($Score/Label,"scale",Vector2(scale_factor, scale_factor),0.1).as_relative().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Score/Label,"scale",Vector2(1,1),1)
	
func scale_score_texture(scale_factor):
	tween = create_tween()
	tween.tween_property($Score/TextureRect,"scale",Vector2(scale_factor, scale_factor),0.1).as_relative().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Score/TextureRect,"scale",Vector2(1,1),1)

func rotate_score_label():
	tween = create_tween()
	tween.tween_property($Score/Label,"rotation_degrees",randi_range(-7,7),0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Score/Label,"rotation_degrees",0,1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT_IN)

func show_game_over_menu():
	Engine.time_scale = 0
	if GameSave.save_data["high_score"] < game.score:
		display_high_score()
	$"Game Over Menu".set_score()
	$"Game Over Menu".visible = true

func show_pause_menu():
	$"Pause Menu".set_score()
	$"Pause Menu".visible = true


func _on_pause_button_button_up():
	AudioManager.button_press.play()
	get_tree().get_root().get_node("Game").pause_game()
	
func display_high_score():
	$"Game Over Menu".high_score = true

func show_extra_life_menu():
	$"Extra Life Menu".visible = true
	$"Extra Life Menu".start_timer()
	
