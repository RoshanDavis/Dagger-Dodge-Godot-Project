extends CharacterBody2D

var dagger
@export var recoilSpeed = 200

func _ready():
	velocity = Vector2(0,0)
	dagger = preload("res://scenes/dagger.tscn")
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Throw"):
		var daggerInstance = dagger.instantiate()
		daggerInstance.position = $FirePoint.global_position
		daggerInstance.rotation = rotation
		get_tree().get_root().get_node("Game").add_child(daggerInstance)
		velocity = global_transform.basis_xform(Vector2.LEFT * recoilSpeed) 
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
