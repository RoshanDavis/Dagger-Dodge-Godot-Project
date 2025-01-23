extends Node

func set_max_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_max_health(health)
	else:
		printerr("Health Bar Component Missing")

func set_current_health(health):
	if has_node("HealthBar"):
		$HealthBar.set_current_health(health)
	else:
		printerr("Health Bar Component Missing")
