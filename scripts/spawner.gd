extends Node2D

@onready var goldOrb = preload("res://scenes/gold orb/gold_orb.tscn")
@onready var blueOrb = preload("res://scenes/blue orb/blue_orb.tscn")
@onready var redOrb = preload("res://scenes/red orb/red_orb.tscn")
@onready var specialOrb = preload("res://scenes/special orb/special_orb.tscn")

var origin :Vector2 = Vector2(-250,-450)
var end :Vector2 = Vector2(250,450)
var spawn_margin :Vector2 = Vector2(20,30)
var canSpawn = false

@export var progression_rate = 1
@export var min_wait_time :Array[float] = [1.5, 2.5, 3.7] 
@export var special_orb_spawn_time_range :Array[int] = [10, 20]

func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	special_orb()

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
	
	if $"Gold Orb Spawn Timer".wait_time > min_wait_time[0]:
		$"Gold Orb Spawn Timer".start()
		$"Gold Orb Spawn Timer".wait_time -= delta * progression_rate
	elif $"Blue Orb Spawn Timer".wait_time > min_wait_time[1]:
		$"Blue Orb Spawn Timer".start()
		$"Blue Orb Spawn Timer".wait_time -= delta * progression_rate
	elif $"Red Orb Spawn Timer".wait_time > min_wait_time[2]:
		$"Red Orb Spawn Timer".start()
		$"Red Orb Spawn Timer".wait_time -= delta * progression_rate
		
func spawn_blue_orb():
	var blueOrbInstance = blueOrb.instantiate()
	blueOrbInstance.position = gen_random_pos()
	get_tree().current_scene.get_node("Orbs").add_child(blueOrbInstance)

func _on_blue_orb_spawn_timer_timeout():
	if canSpawn:
		spawn_blue_orb()

func spawn_red_orb():
	var redOrbInstance = redOrb.instantiate()
	redOrbInstance.position = gen_random_pos()
	get_tree().current_scene.add_child(redOrbInstance)

func _on_red_orb_spawn_timer_timeout():
	if canSpawn:
		spawn_red_orb()

func special_orb():
	$"Special Orb Spawn Timer".wait_time = randi_range(special_orb_spawn_time_range[0],special_orb_spawn_time_range[1])
	$"Special Orb Spawn Timer".start()
	

func _on_special_orb_spawn_timer_timeout():
	if canSpawn:
		var specialOrbInstance = specialOrb.instantiate()
		specialOrbInstance.position = gen_random_pos()
		get_tree().current_scene.get_node("Orbs").add_child(specialOrbInstance)
		$"Special Orb Spawn Timer".wait_time = randi_range(special_orb_spawn_time_range[0],special_orb_spawn_time_range[1])
	else:
		$"Special Orb Spawn Timer".wait_time = randi_range(special_orb_spawn_time_range[0],special_orb_spawn_time_range[1])
