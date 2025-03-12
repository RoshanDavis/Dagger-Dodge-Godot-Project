extends Node2D

var viewport_size

func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	

func _handle_screen_resize():
	viewport_size = get_viewport_rect().size
