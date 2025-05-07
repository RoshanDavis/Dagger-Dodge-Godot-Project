extends CanvasLayer


func _on_play_button_up():
	$"../../Camera2D/AnimationPlayer".play("zoom out")
	AudioManager.dagger_out.play()
	%Player.canMove = true
	%"Spawner".canSpawn = true
	%"Spawner".spawn_gold_orb()
	%"Gameplay UI".visible = true
	queue_free()

func _ready():
	update_high_score()
	update_total_orbs()

func update_high_score():
	$"High Score/High Score".text = str(GameSave.save_data["high_score"])

func update_total_orbs():
	$"Total Orbs/Total Orbs".text = str(GameSave.save_data["total_orbs"])


func _on_dagger_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/ui/dagger_selector.tscn")


func _on_store_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/ui/shop.tscn")


func _on_settings_button_button_up():
	AudioManager.button_press.play()
	$Settings.visible = true

func _on_characters_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/ui/character_selector.tscn")


func _on_tutorial_button_button_up():
	AudioManager.button_press.play()
	get_tree().change_scene_to_file("res://scenes/ui/tutorial.tscn")
	
	
	
	
	
	
	
