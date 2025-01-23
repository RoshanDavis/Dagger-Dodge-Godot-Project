extends CharacterBody2D

@export var speed:float = 300

func _ready():
	velocity = global_transform.basis_xform(Vector2.RIGHT * speed)
	
func _physics_process(delta):
	movement(delta)
		
func movement(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()

func take_damage(health):
	$HealthComponent.take_damage(health)


func _on_area_2d_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("dagger"):
		area.get_parent().take_damage(1)
