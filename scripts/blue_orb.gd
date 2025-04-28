extends Area2D

var powerup_index
var enemy_index
var enemy

@onready var game = get_tree().get_root().get_node("Game")
@onready var player = game.get_node("Player")
@onready var explosion = preload("res://scenes/blue orb/blue_explosion.tscn")
@onready var splat = preload("res://scenes/sfx/splat.tscn")
@onready var slash = preload("res://scenes/sfx/slash.tscn")
@onready var waterball = preload("res://scenes/blue orb/mini_waterball.tscn")

@export var powerup_sprites : Array[Sprite2D]
@export var enemies :Array[PackedScene]
@export var score :int = 2
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
		0: # Orb Explosion
			var explosionInstance = explosion.instantiate()
			explosionInstance.position = global_position
			get_tree().current_scene.get_node("VFX").call_deferred("add_child",explosionInstance)
		1: # Slash
			spawn_splat()
			for i in range(0, 360, 180):
				var slash_instance = slash.instantiate()
				slash_instance.position = global_position
				slash_instance.rotation_degrees = player.rotation_degrees + i
				slash_instance.scale = Vector2(0.25, 0.25)
				slash_instance.modulate = slash_color
				slash_instance.damage = 5
				get_tree().current_scene.get_node("VFX").call_deferred("add_child", slash_instance)
		2: # Mini Waterballs
			spawn_splat()
			for i in range(0, 360, 90):
				var waterball_instance = waterball.instantiate()
				waterball_instance.position = position
				waterball_instance.rotation_degrees = i + 45
				get_tree().current_scene.get_node("VFX").call_deferred("add_child",waterball_instance)
	
func spawn_splat():
	var splat_instance = splat.instantiate()
	splat_instance.position = global_position
	splat_instance.scale = Vector2(0.5, 0.5)
	splat_instance.modulate = splat_color
	get_tree().current_scene.get_node("Marks").add_child(splat_instance)
