extends Sprite2D

@export var splats :Array[Texture2D]

func _ready():
	texture = splats.pick_random()
	rotation_degrees = randi_range(0, 360)
