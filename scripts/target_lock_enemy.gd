extends Node2D

var player
var tween :Tween
var power_index :int

@export var color :Array[Color]

@onready var explosion = preload("res://scenes/gold orb/bomb_explosion.tscn")
@onready var freeze = preload("res://scenes/freeze.tscn")

func _ready():
	AudioManager.beeping.play()
	if get_tree().current_scene.has_node("Player"):
		player = get_tree().current_scene.get_node("Player")
		position = player.global_position
		power_index = randi() % color.size()
		color_change()
		rotate_motion()
	else:
		queue_free()

func rotate_motion():
	tween = create_tween().set_loops()
	tween.tween_property(self,"rotation_degrees",10,1)
	tween.tween_property(self,"rotation_degrees",-10,1)

func color_change():
	tween = create_tween()
	tween.tween_property(self,"modulate",color[power_index],1)

func _physics_process(delta):
	if player != null:
		movement(delta)
		
func movement(_delta):
	var player_position = player.position
	
	if position.distance_to(player_position) > 5:
		tween = create_tween()
		tween.tween_property(self,"position",player_position,0.1)
		await tween.finished

func _on_charge_timer_timeout():
	AudioManager.beeping.stop()
	match power_index:
		0:
			var explosion_instance = explosion.instantiate()
			explosion_instance.position = position
			get_tree().current_scene.get_node("VFX").add_child(explosion_instance)
			queue_free()
		1:
			var freeze_instance = freeze.instantiate()
			player.add_child(freeze_instance)
			queue_free()
