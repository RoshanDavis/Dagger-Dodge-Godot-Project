extends CharacterBody2D

@export var speed:float = 200

func _ready():
	velocity = global_transform.basis_xform(Vector2.RIGHT * speed)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()
