extends Control

@onready var hearts_list : Array[TextureRect]

#func _ready():
	#var heart = $"Heart Container/Heart"
	##hearts_list.append(heart)

func set_max_health(health):
	var heart = $"Heart Container/Heart"
	var heart_container = $"Heart Container"
	hearts_list.append(heart)
	
	for i in hearts_list:
		health -= 1
	
	for i in range(health):
		print_debug(heart)
		var new_heart = heart.duplicate()
		heart_container.add_child(new_heart)
		hearts_list.append(new_heart)

func set_current_health(health):
	if health == 1:
		hearts_list[0].get_child(0).get_node("AnimationPlayer").play("beating")
	else:
		hearts_list[0].get_child(0).get_node("AnimationPlayer").play("idle")
	for i in hearts_list:
		if health > 0:
			i.modulate = Color(1,1,1)
			health -= 1
		else:
			i.modulate = Color(0,0,0)
	
