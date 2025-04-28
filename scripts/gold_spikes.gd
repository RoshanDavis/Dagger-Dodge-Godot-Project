extends Area2D

@export var damage = 1
@export var knockback_force = 300

@onready var explosion = preload("res://scenes/gold orb/gold_spike_explosion.tscn")
@onready var explosion_mark = preload("res://scenes/gold orb/gold_spike_explosion_mark.tscn")

func _ready():
	AudioManager.spikes_out.play()

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		explode()
	
	elif  area.is_in_group("player"):
		area.get_parent().take_damage(damage)
		area.get_parent().velocity += (area.global_position - global_position).normalized() * knockback_force
		explode()
	
	elif area.is_in_group("safe damage"):
		explode()

func explode():
	AudioManager.metal_hit.play()
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	get_tree().current_scene.get_node("VFX").add_child(explosion_instance)
	
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = global_position
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance)
	
	queue_free()
	
	
	
	
	
	
	
	
	
	
	
	
	
