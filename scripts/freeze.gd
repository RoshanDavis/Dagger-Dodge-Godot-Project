extends Node2D

var is_frozen = true
var tween :Tween

@export var freeze_time :float = 1

@onready var freeze_timer = $"Freeze Timer"
@onready var progress_bar = $TextureProgressBar
@onready var explosion = preload("res://scenes/sfx/ice_explosion.tscn")

func _ready():
	if get_parent().has_method("freeze"):
		visible = true
		shake()
		freeze_timer.wait_time = freeze_time
		progress_bar.max_value = freeze_time
		freeze_timer.start()
		get_parent().freeze(self,freeze_time)
	else:
		death_effect()

func shake():
	$Struggle.play()
	tween = create_tween().set_loops()
	tween.tween_property(self,"position:x",5,0.1)
	tween.tween_property(self,"position:x",-5,0.1)
	tween.tween_property(self,"rotation_degrees",10,0.1)
	tween.tween_property(self,"rotation_degrees",-10,0.1)

func _process(_delta):
	progress_bar.value = freeze_timer.time_left

func _on_freeze_timer_timeout():
	death_effect()

func death_effect():
	$Struggle.stop()
	if not is_frozen:
		return
	AudioManager.ice_break.play()
	is_frozen = false
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	get_tree().current_scene.get_node("VFX").add_child(explosion_instance)
	queue_free()
