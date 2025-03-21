extends Line2D

var previous_position :Vector2 = Vector2.ZERO

@export var object :Node2D
@export var offset :float = 0
@export var max_length :int = 30

func _ready():
	previous_position = object.position

func _process(_delta):
	var current_position = object.position
	var direction = (current_position - previous_position).normalized()
	
	add_point(current_position - offset * direction)
	if points.size() > max_length:
		remove_point(0)
	
	previous_position = current_position
