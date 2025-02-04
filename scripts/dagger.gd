extends CharacterBody2D

var invincibile = true

@export var speed:float = 300
@export var damage = 1
@export var health = 1

func _ready():
	velocity = global_transform.basis_xform(Vector2.RIGHT * speed)
	$HealthComponent.set_initial_health(health)
	
func _physics_process(delta):
	movement(delta)
		
func movement(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()

func take_damage(health):
	if not invincibile:
		$HealthComponent.take_damage(health)


func _on_area_2d_area_entered(area):
	if area.is_in_group("player") and not invincibile:
		area.get_parent().take_damage(damage)
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)

func _on_timer_timeout():
	invincibile = false

func on_death():
	get_parent().add_score(health + damage);
	call_deferred("queue_free")
