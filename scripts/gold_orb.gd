extends Area2D

@onready var enemy = preload("res://scenes/jellyfish.tscn")

func _ready():
	$LifetimeBar.max_value = $Lifetime.wait_time

func _process(_delta):
	update_lifetime_bar()
	
func update_lifetime_bar():
	$LifetimeBar.value = $Lifetime.wait_time - $Lifetime.time_left

func _on_area_entered(area):
		if area.is_in_group("player"):
			get_parent().add_score(1)
			queue_free()


func _on_lifetime_timeout():
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	get_tree().get_root().get_node("Game").add_child(enemyInstance)
	call_deferred("queue_free")
