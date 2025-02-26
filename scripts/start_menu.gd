extends CanvasLayer


func _process(_delta):
	if Input.is_action_just_pressed("Throw"):
		$"../../Camera2D/AnimationPlayer".play("zoom out")
		AudioManager.dagger_out.play()
		%Player.canMove = true
		%"Spawner".canSpawn = true
		%"Spawner".spawn_gold_orb()
		%"Gameplay UI".visible = true
		queue_free()
