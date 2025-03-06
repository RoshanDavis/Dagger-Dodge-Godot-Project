extends Node2D

@onready var explosion = preload("res://scenes/bomb_explosion.tscn")

func _on_animation_player_animation_finished(_anim_name):
	var explosionInstance = explosion.instantiate()
	explosionInstance.position = global_position
	get_tree().current_scene.get_node("VFX").add_child(explosionInstance)
	queue_free()
