extends Control


func _on_texture_button_button_up():
	$"../Camera2D/AnimationPlayer".play("zoom out")
	%Player.canMove = true
	$"../Spawner".canSpawn = true
	$"../Spawner".spawn_gold_orb()
	visible = false
	process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _on_texture_button_mouse_entered():
	AudioManager.dagger_out.play()
	$AnimationPlayer.play("dagger out")


func _on_texture_button_mouse_exited():
	$AnimationPlayer.play("dagger in")
