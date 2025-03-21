extends Label


func _ready():
	update_text("Hello")
	
	await get_tree().create_timer(1).timeout
	update_font_size(70)
	await get_tree().create_timer(1).timeout
	update_text("Hello There")
	
func update_text(s :String):
	text = s
	recalibrate_dimensions()

func update_font_size(x :int):
	add_theme_font_size_override("font_size",x)


func recalibrate_dimensions():
	#size.x = get_total_character_count()
	#size.y = get_line_count()
	print_debug(size)
	pivot_offset = size/2 
	position -= size
