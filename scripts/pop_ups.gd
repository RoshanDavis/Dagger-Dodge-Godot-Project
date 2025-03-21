extends Control

var tween :Tween

@export var base_font_size = 70
@export var initial_scale = 0.1

@onready var player = get_tree().current_scene.get_node("Player")
@onready var default_theme = preload("res://themes/default.tres")


func popup_tween(item):
	tween = create_tween()
	tween.tween_property(item,"scale",Vector2(1,1),0.1)
