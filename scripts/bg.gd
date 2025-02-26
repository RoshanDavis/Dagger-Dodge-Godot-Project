extends Sprite2D


func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	

func _handle_screen_resize():
	var screen_size = get_viewport_rect().size
	region_rect.size = screen_size 
