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
