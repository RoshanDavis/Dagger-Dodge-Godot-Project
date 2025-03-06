extends Node2D

@onready var goldOrb = preload("res://scenes/gold_orb.tscn")

var origin :Vector2 = Vector2(-250,-450)
var end :Vector2 = Vector2(250,450)
var spawn_margin :Vector2 = Vector2(20,30)
var canSpawn = false

@export var progression_rate = 1
@export var min_wait_time = 1

func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)

func _handle_screen_resize():
	var expand_size = get_viewport_rect().size/2
	origin = to_global(-expand_size + spawn_margin)
	end = to_global(expand_size - spawn_margin)

func gen_random_pos():
	var x = randf_range(origin.x, end.x)
	var y = randf_range(origin.y, end.y)
	return Vector2(x, y)

func spawn_gold_orb():
	var goldOrbInstance = goldOrb.instantiate()
	goldOrbInstance.position = gen_random_pos()
	get_tree().current_scene.get_node("Orbs").add_child(goldOrbInstance)

func _on_gold_orb_spawn_timer_timeout():
	if canSpawn:
		spawn_gold_orb()

func _process(delta):
	difficulty_progression(delta)

func difficulty_progression(delta):
	if not canSpawn:
		return
		
	if $"Gold Orb Spawn Timer".wait_time > min_wait_time:
		$"Gold Orb Spawn Timer".wait_time -= delta * progression_rate
		
