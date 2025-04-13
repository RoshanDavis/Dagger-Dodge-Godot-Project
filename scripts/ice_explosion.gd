extends GPUParticles2D

@onready var explosion_mark = preload("res://scenes/sfx/explosion_spread_mark.tscn")

func _ready():
	emitting = true
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = global_position
	explosion_mark_instance.modulate = modulate
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance) 

func _on_finished():
	queue_free()
