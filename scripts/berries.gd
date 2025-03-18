extends Node2D

@export var berry_patterns :Array[Node2D]
@export var berry_colors :Array[Color]

func _ready():
	berry_patterns.pick_random().visible = true
	modulate = berry_colors.pick_random()
