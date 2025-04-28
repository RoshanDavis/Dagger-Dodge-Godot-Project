extends Area2D

var powerup_index
var enemy_index
var enemy

@onready var game = get_tree().get_root().get_node("Game")
@onready var player = game.get_node("Player")
@onready var explosion = preload("res://scenes/gold orb/gold_explosion.tscn")
@onready var splat = preload("res://scenes/sfx/splat.tscn")
@onready var slash = preload("res://scenes/sfx/slash.tscn")
@onready var gold_ball = preload("res://scenes/gold orb/mini_gold_ball.tscn")

@export var powerup_sprites : Array[Sprite2D]
@export var enemies :Array[PackedScene]
@export var score :int = 1
@export var splat_color :Color
@export var slash_color :Color

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
	spawn_splat()
	spawn_enemy()
	call_deferred("queue_free")

func enemy_selector():
	enemy_index = randi() % enemies.size()
	enemy = enemies[enemy_index]
	
func spawn_enemy():
	AudioManager.orb_pop.play()
	var enemyInstance = enemy.instantiate()
	enemyInstance.position = position
	get_tree().current_scene.get_node("Enemies").add_child(enemyInstance)

func powerup_selector():
	powerup_index = randi() % powerup_sprites.size()
	powerup_sprites[powerup_index].visible = true

func powerup():
	match powerup_index:
		0: # Heart
			spawn_splat()
			player.heal(1)
		1: # Shield
			spawn_splat()
			player.shield_gained()
		2: # Orb Explosion
			AudioManager.orb_explosion.play()
			var explosionInstance = explosion.instantiate()
			explosionInstance.position = global_position
			get_tree().current_scene.get_node("VFX").call_deferred("add_child",explosionInstance)
		3: # Slash
			spawn_splat()
			var slash_instance = slash.instantiate()
			slash_instance.position = global_position
			slash_instance.rotation = player.rotation
			slash_instance.scale = Vector2(0.2, 0.2)
			slash_instance.modulate = slash_color
			get_tree().current_scene.get_node("VFX").call_deferred("add_child", slash_instance)
		4: # Mini Gold Balls Horizontal
			spawn_splat()
			for i in range(0, 360, 180):
				var gold_ball_instance = gold_ball.instantiate()
				gold_ball_instance.position = position
				gold_ball_instance.rotation_degrees = i
				get_tree().current_scene.get_node("VFX").call_deferred("add_child",gold_ball_instance)
		5: # Mini Gold Balls Vertical
			spawn_splat()
			for i in range(0, 360, 180):
				var gold_ball_instance = gold_ball.instantiate()
				gold_ball_instance.position = position
				gold_ball_instance.rotation_degrees = i + 90
				get_tree().current_scene.get_node("VFX").call_deferred("add_child",gold_ball_instance)

func spawn_splat():
	var splat_instance = splat.instantiate()
	splat_instance.position = global_position
	splat_instance.scale = Vector2(0.3, 0.3)
	splat_instance.modulate = splat_color
	get_tree().current_scene.get_node("Marks").add_child(splat_instance)
