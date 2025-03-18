extends Area2D

@export var rock_colors :Array[Color]
@export var rock_textures :Array[Texture2D]

@onready var rock = $Rock
@onready var rock_explosion = $"Rock Explosion"

func _ready():
	rock.texture = rock_textures.pick_random()
	modulate = rock_colors.pick_random()
	rock.rotation_degrees = randi_range(0,360)
	var random_scale = randf_range(0.1,0.2)
	rock.scale = Vector2(random_scale,random_scale)


func _on_area_entered(area):
	if area.is_in_group("player") and area.get_parent().velocity.length() >= 1000:
		explode()
	elif area.is_in_group("unsafe damage"):
		explode()
	elif area.is_in_group("safe damage"):
		explode()
	elif area.is_in_group("dagger"):
		explode()

func explode():
	rock.visible = false
	$"Rock Explosion".emitting = true

func _on_rock_explosion_finished():
	queue_free()
	pass
