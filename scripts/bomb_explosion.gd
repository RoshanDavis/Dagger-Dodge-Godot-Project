extends Area2D

@export var damage = 1

@onready var explosion_mark = preload("res://scenes/gold orb/bomb_explosion_mark.tscn")


func _ready():
	$"Explosion Particles".emitting = true

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.get_parent().take_damage(damage)
		

func _on_explosion_particles_finished():
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = position
	explosion_mark_instance.rotation_degrees = randi_range(0,360)
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance)
	queue_free()
