extends Area2D

var powerup_index
var enemy_index
var enemy

@onready var game = get_tree().get_root().get_node("Game")
@onready var player = game.get_node("Player")
@onready var fireball = preload("res://scenes/special orb/fireball_power_up.tscn")

@export var powerup_sprites : Array[Sprite2D]
@export var score :int = 5

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
			game.add_score(score)
			powerup()
			queue_free()


func _on_lifetime_timeout():
	#death effect
	call_deferred("queue_free")


func powerup_selector():
	powerup_index = randi() % powerup_sprites.size()
	powerup_sprites[powerup_index].visible = true

func powerup():
	match powerup_index:
		0: # Fireball
			var fireball_instance = fireball.instantiate()
			player.call_deferred("add_child",fireball_instance)
			
	
