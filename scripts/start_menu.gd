extends CanvasLayer


func _on_play_button_up():
	$"../../Camera2D/AnimationPlayer".play("zoom out")
	AudioManager.dagger_out.play()
	%Player.canMove = true
	%"Spawner".canSpawn = true
	%"Spawner".spawn_gold_orb()
	%"Gameplay UI".visible = true
	queue_free()


func _on_characters_button_button_up():
	print_debug("Pressed")
