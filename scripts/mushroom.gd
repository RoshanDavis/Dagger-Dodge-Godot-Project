extends Area2D

var tween :Tween

@export var mushroom_textures :Array[Texture2D]

func _ready():
	$Mushroom.texture = mushroom_textures.pick_random()
	var rand_scale = randf_range(0.2, 0.25)
	scale = Vector2(rand_scale, rand_scale)
	rotation_degrees = randf_range(-10,10)
	

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
	AudioManager.flower_break.play()
	$Mushroom.visible = false
	$"Mushroom Explosion".emitting = true

func _on_mushroom_explosion_finished():
	queue_free()
