extends Area2D

var damage = 100

func _on_animation_player_animation_finished(_anim_name):
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("enemy"):
		area.get_parent().take_damage(damage)
