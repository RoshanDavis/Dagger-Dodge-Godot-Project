extends Node


func remove_all_children():
	var children = get_children()
	for child in children:
		remove_child(child)
		child.queue_free()
