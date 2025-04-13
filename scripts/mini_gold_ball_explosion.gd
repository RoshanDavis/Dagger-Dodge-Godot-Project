extends Area2D

@export var damage :int = 2

@onready var explosion_mark = preload("res://scenes/gold orb/mini_gold_ball_explosion_mark.tscn")

func _ready():
	$"Explosion".emitting = true
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = position
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance)

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)


func _on_fire_explosion_finished():
	queue_free()
