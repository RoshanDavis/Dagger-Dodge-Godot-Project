extends AnimatedSprite2D



@onready var player = %Player

@export var fast_color :Color = Color(1,1,1)

var speed
var min_speed = 500
var max_speed = 1200

func _process(_delta):
	if player != null:
		speed = clamp(player.velocity.length(),min_speed,max_speed)
		fast_color.a = (speed - min_speed)/ (max_speed - min_speed)
		modulate = fast_color 
		position = player.global_position
		rotation = player.velocity.angle()
		visible = true
	else:
		visible = false

	
	
	
