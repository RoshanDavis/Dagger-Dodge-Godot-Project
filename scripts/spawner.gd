extends Node2D

#@onready var spawnArea = $CollisionShape2D.shape.extents
#@onready var origin = $CollisionShape2D.global_position -  spawnArea
#@onready var end = $CollisionShape2D.global_position +  spawnArea


@onready var goldOrb = preload("res://scenes/gold_orb.tscn")

var origin :Vector2 = Vector2(-250,-450)
var end :Vector2 = Vector2(250,450)
var spawn_margin :Vector2 = Vector2(20,30)
var canSpawn = false

@export var difficulty = 1
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
	get_tree().get_root().get_node("Game").add_child.call_deferred(goldOrbInstance)

func _on_gold_orb_spawn_timer_timeout():
	if canSpawn:
		spawn_gold_orb()

func _process(delta):
	# difficulty progression
	if $"Gold Orb Spawn Timer".wait_time > min_wait_time and canSpawn:
		$"Gold Orb Spawn Timer".wait_time -= delta * difficulty/10
