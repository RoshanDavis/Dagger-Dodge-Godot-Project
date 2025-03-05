extends Area2D

@export var damage = 1


func _ready():
	$"Explosion Particles".emitting = true

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.get_parent().take_damage(damage)
		

func _on_explosion_particles_finished():
	queue_free()
