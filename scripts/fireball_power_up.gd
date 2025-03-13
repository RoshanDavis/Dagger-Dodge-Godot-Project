extends Area2D

signal started
signal done

var tween: Tween

@export var damage = 15
@export var fade_out_time = 1

@onready var scorch_line = preload("res://scenes/special orb/scorch_line.tscn")

func _ready():
	if get_parent().name == "Player":
		started.connect(get_parent()._on_fireball_power_up_started)
		done.connect(get_parent()._on_fireball_power_up_done)
	started.emit()
	spawn_scorch_line()

func spawn_scorch_line():
	var scorch_line_instance = scorch_line.instantiate()
	scorch_line_instance.processing_time = $"Power Up Time".wait_time
	get_tree().current_scene.get_node("Marks").add_child(scorch_line_instance)

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)


func _on_power_up_time_timeout():
	tween = create_tween()
	tween.tween_property(self,"modulate:a",0,fade_out_time)
	await get_tree().create_timer(fade_out_time).timeout
	done.emit()
	queue_free()
