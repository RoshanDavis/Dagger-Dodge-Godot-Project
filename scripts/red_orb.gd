extends Area2D

var powerup_index
var enemy_index
var enemy

@onready var game = get_tree().get_root().get_node("Game")
@onready var player = game.get_node("Player")
@onready var explosion = preload("res://scenes/red orb/red_explosion.tscn")
@onready var fireball = preload("res://scenes/red orb/mini_fireball.tscn")

@export var powerup_sprites : Array[Sprite2D]
@export var enemies :Array[PackedScene]
@export var score :int = 3

func _ready():
	$LifetimeBar.max_value = $Lifetime.wait_time
	powerup_selector()
	enemy_selector()
	
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
	spawn_enemy()
	call_deferred("queue_free")

func enemy_selector():
	enemy_index = randi() % enemies.size()
	enemy = enemies[enemy_index]
	
func spawn_enemy():
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	get_tree().current_scene.get_node("Enemies").add_child(enemyInstance)

func powerup_selector():
	powerup_index = randi() % powerup_sprites.size()
	powerup_sprites[powerup_index].visible = true

func powerup():
	match powerup_index:
		0: # Orb Explosion
			var explosionInstance = explosion.instantiate()
			explosionInstance.position = global_position
			get_tree().current_scene.get_node("VFX").call_deferred("add_child",explosionInstance)
		
		1: # Mini Fireball Spread
			for i in range(0, 360, 45):
				var fireball_instance = fireball.instantiate()
				fireball_instance.position = position
				fireball_instance.rotation_degrees = i
				get_tree().current_scene.get_node("Enemies").call_deferred("add_child",fireball_instance)
			
		
