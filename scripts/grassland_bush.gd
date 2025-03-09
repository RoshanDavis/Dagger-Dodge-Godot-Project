extends Area2D

@export var bush_colors :Array[Color]
@export var bush_textures :Array[Texture2D]


func _ready():
	$Bush.rotation_degrees = randi_range(0,360)
	$Bush.texture = bush_textures.pick_random()
	var color = bush_colors.pick_random()
	$Bush.modulate = color
	$"Bush Explosion".modulate = color

func _on_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("shake")
		if area.get_parent().velocity.length() >= 1000:
			explode()
	elif area.is_in_group("slow enemy"):
		$AnimationPlayer.play("shake")
	elif area.is_in_group("unsafe damage"):
		explode()
	elif area.is_in_group("safe damage"):
		explode()
	elif area.is_in_group("dagger"):
		explode()
	

func explode():
	$Bush.visible = false
	$"Bush Explosion".emitting = true

func _on_bush_explosion_finished():
	queue_free()
