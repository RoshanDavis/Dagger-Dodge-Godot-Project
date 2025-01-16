extends CharacterBody2D

var speed
var recoilDir
var dagger

func _ready():
	speed = 250
	recoilDir = Vector2.ZERO
	dagger = preload("res://scenes/dagger.tscn")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Throw"):
		look_at(get_global_mouse_position())
		var daggerInstance = dagger.instantiate()
		daggerInstance.position = $FirePoint.global_position
		daggerInstance.rotation = rotation
		get_tree().get_root().get_node("Game").add_child(daggerInstance)
