extends Area2D

var damage = 5

func _ready():
	$"Explosion Particles".emitting = true

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("enemy"):
		area.get_parent().take_damage(damage)


func _on_explosion_particles_finished():
	queue_free()
