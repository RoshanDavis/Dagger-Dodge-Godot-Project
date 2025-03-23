extends Area2D

@export var damage :int = 15
@export var paint_colors :Array[Color]

var selected_color :Color

signal started
signal done

func _ready():
	if get_parent().name == "Player":
		started.connect(get_parent()._on_paintball_power_up_started)
		done.connect(get_parent()._on_paintball_power_up_done)
	started.emit()
	selected_color = paint_colors.pick_random()
	modulate = selected_color

func _on_power_up_time_timeout():
	done.emit()
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("wall"):
		explode()

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		explode()
		area.get_parent().take_damage(damage)
		
	elif area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)

func explode():
	# spawn splash with selected color
	#change color
	selected_color = paint_colors.pick_random()
	modulate = selected_color
