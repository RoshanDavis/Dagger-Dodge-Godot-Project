extends Area2D

var tween :Tween

@export var bush_colors :Array[Color]
@export var bush_textures :Array[Texture2D]

@onready var bush = $Bush

func _ready():
	$Bush.rotation_degrees = randi_range(0,360)
	$Bush.texture = bush_textures.pick_random()
	var color = bush_colors.pick_random()
	$Bush.modulate = color
	$"Bush Explosion".modulate = color

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
	AudioManager.bush_shake.play()
	tween = create_tween().parallel()
	tween.tween_property(self,"position:x",2,0.1).as_relative()
	tween.tween_property(self,"position:x",-3,0.1).as_relative()
	tween.tween_property(bush,"rotation_degrees",2,0.1).as_relative()
	tween.tween_property(bush,"rotation_degrees",-2,0.1).as_relative()

func explode():
	AudioManager.bush_break.play()
	$Bush.visible = false
	if has_node("Berries"):
		$Berries.visible = false
	$"Bush Explosion".emitting = true

func _on_bush_explosion_finished():
	queue_free()
