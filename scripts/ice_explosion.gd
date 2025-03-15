extends GPUParticles2D

@onready var explosion_mark = preload("res://scenes/sfx/ice_explosion_mark.tscn")

func _ready():
	emitting = true
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = global_position
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance) 

func _on_finished():
	queue_free()
