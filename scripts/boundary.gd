extends Node2D


func _ready():
	_handle_screen_resize()
	get_tree().get_root().size_changed.connect(_handle_screen_resize)
	

func _handle_screen_resize():
	var expand_size = get_viewport_rect().size/2
	$"Wall T".position = -expand_size
	$"Wall R".position = Vector2(expand_size.x,-expand_size.y)
	$"Wall L".position = Vector2(-expand_size.x,expand_size.y)
	$"Wall B".position = expand_size
