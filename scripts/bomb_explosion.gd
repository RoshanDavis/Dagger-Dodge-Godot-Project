extends Area2D

@export var damage = 1



func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("player"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("enemy"):
		area.get_parent().take_damage(damage)
