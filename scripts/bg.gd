extends Sprite2D

@export var bg_colors :Array[Color]

func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	modulate = bg_colors[randi() % bg_colors.size()]
	

func _handle_screen_resize():
	var screen_size = get_viewport_rect().size
	region_rect.size = screen_size 
