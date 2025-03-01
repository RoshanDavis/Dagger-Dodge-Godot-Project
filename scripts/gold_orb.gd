extends Area2D

var powerup_index

@onready var game = get_tree().get_root().get_node("Game")
@onready var enemy = preload("res://scenes/jellyfish.tscn")

@export var powerup_sprites : Array[Sprite2D]

func _ready():
	$LifetimeBar.max_value = $Lifetime.wait_time
	powerup_selector()
	
func _process(_delta):
	update_lifetime_bar()
	
func update_lifetime_bar():
	$LifetimeBar.value = $Lifetime.wait_time - $Lifetime.time_left

func _on_area_entered(area):
		if area.is_in_group("player"):
			AudioManager.gold_orb_pickup.play()
			game.add_score(1)
			game.gold_powerup(powerup_index)
			queue_free()


func _on_lifetime_timeout():
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	get_tree().get_root().get_node("Game").add_child(enemyInstance)
	call_deferred("queue_free")

func powerup_selector():
	powerup_index = randi() % powerup_sprites.size()
	powerup_sprites[powerup_index].visible = true


	
	
