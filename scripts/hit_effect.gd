extends Node2D

func _ready():
	$"Hit Effect".emitting = true
	

func _on_hit_effect_finished():
	queue_free()
