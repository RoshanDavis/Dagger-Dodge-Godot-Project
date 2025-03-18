extends Area2D

var tween :Tween

@export var flower_colors :Array[Color]

func _ready():
	rotation_degrees = randi_range(0,360)
	var rand_scale = randf_range(0.1, 0.16)
	scale = Vector2(rand_scale, rand_scale)
	modulate = flower_colors.pick_random()


func _on_area_entered(area):
	if area.is_in_group("player"):
		shake()
		if area.get_parent().velocity.length() >= 1000:
			explode()
	elif area.is_in_group("slow enemy"):
		shake()
	elif area.is_in_group("unsafe damage"):
		explode()
	elif area.is_in_group("safe damage"):
		explode()
	elif area.is_in_group("dagger"):
		explode()

func shake():
	tween = create_tween().parallel()
	tween.tween_property(self,"position:x",1,0.1).as_relative()
	tween.tween_property(self,"position:x",-1,0.1).as_relative()
	tween.tween_property(self,"rotation_degrees",3,0.1).as_relative()
	tween.tween_property(self,"rotation_degrees",-3,0.1).as_relative()

func explode():
	$Flower.visible = false
	$"Flower Explosion".emitting = true

func _on_flower_explosion_finished():
	queue_free()
