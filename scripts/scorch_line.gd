extends Line2D

@export var max_length = 100

var player
var processing_time = 20

func _ready():
	if get_tree().current_scene.has_node("Player"):
		player = get_tree().current_scene.get_node("Player")
		$"Frequency Timer".start()
		await get_tree().create_timer(processing_time).timeout
		$"Frequency Timer".stop()
		$"Frequency Timer".queue_free()
	else:
		queue_free()

func _on_timer_timeout():
	add_point(player.global_position)
	if points.size() > max_length:
		remove_point(0)
	
