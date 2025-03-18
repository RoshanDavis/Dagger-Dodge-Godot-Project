extends Sprite2D

@export var biomes :Array[String]
@export var grassland_colors :Array[Color]
@export var mudland_colors :Array[Color]

# grassland
@onready var grassland_bush = preload("res://scenes/environment/grassland_bush.tscn")
@onready var grassland_rock = preload("res://scenes/environment/grassland_rock.tscn")
@onready var flower = preload("res://scenes/environment/flower.tscn")
@onready var grassland_berry_bush = preload("res://scenes/environment/grassland_berry_bush.tscn")

# mudland
@onready var mudland_bush = preload("res://scenes/environment/mudland_bush.tscn")
@onready var mudland_rock = preload("res://scenes/environment/mudland_rock.tscn")
@onready var mushroom = preload("res://scenes/environment/mushroom.tscn")

var origin :Vector2 = Vector2(-250,-450)
var end :Vector2 = Vector2(250,450)
var spawn_margin :Vector2 = Vector2(20,30)

func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	
	biome_generation()
	
func _handle_screen_resize():
	var expand_size = get_viewport_rect().size/2
	origin = to_global(-expand_size + spawn_margin)
	end = to_global(expand_size - spawn_margin)
	
	var screen_size = get_viewport_rect().size
	region_rect.size = screen_size 

	
func gen_random_pos():
	var x = randf_range(origin.x, end.x)
	var y = randf_range(origin.y, end.y)
	return Vector2(x, y)


func spawn_items(item, quantity):
	for i in range(quantity):
		var item_instance = item.instantiate()
		item_instance.position = gen_random_pos()
		get_tree().current_scene.get_node("Environment").add_child(item_instance)
		
func delete_all_children():
	var children = $"../Environment".get_children()
	for child in children:
		child.free()

func biome_generation():
	var population = population_calc()
	match biomes.pick_random():
		"grassland":
			modulate = grassland_colors.pick_random()
			spawn_items(grassland_rock, population * 0.5)
			spawn_items(flower, population * 2)
			spawn_items(grassland_bush, population)
			spawn_items(grassland_berry_bush, population * randi_range(1,5) * 0.1)

		"mudland":
			modulate = mudland_colors.pick_random()
			spawn_items(mudland_rock, population * 2)
			spawn_items(mushroom, population)
			spawn_items(mudland_bush, population)
	

func population_calc()->int:
	return int(get_viewport_rect().size.length()/100)
	
	
	
