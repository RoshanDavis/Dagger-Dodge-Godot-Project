extends Node

var tween :Tween

@export var limit :int = 1000 

func _on_child_entered_tree(node):
	# Remove first child if over the limit
	if limit <= 0: # handling edge case
		tween = create_tween()
		tween.tween_property(node,"modulate:a",0,2)
		await tween.finished
		node.queue_free()
	elif get_child_count() > limit:
		var child = get_child(0)
		child.reparent(get_tree().current_scene.get_node("Graveyard"))
		tween = create_tween()
		tween.tween_property(child,"modulate:a",0,2)
		await tween.finished
		child.queue_free()
