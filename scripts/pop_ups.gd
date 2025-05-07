extends Control

var tween :Tween

@export var text_theme:Theme

@onready var player = get_tree().current_scene.get_node("Player")

func _ready():
	pass

func popup(msg :String):
	var label = Label.new()
	label.position = player.position - Vector2(30, 20)
	label.text = msg
	label.theme = text_theme
	add_child(label)
	tween = create_tween()
	tween.tween_property(label, "modulate:a", 0, 0.3)
	await tween.finished
	label.queue_free()
	
	
