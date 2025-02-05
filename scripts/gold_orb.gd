extends Area2D


func _on_area_entered(area):
		if area.is_in_group("player"):
			print_debug("testing")
			get_parent().add_score(1)
			queue_free()
