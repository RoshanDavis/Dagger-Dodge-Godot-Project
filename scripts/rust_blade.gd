extends CharacterBody2D

var playerInvincible = true

@export var speed:float = 300
@export var damage = 1
@export var health = 1
@export var hit_effect :PackedScene

func _ready():
	velocity = global_transform.basis_xform(Vector2.RIGHT * speed)
	$HealthComponent.set_initial_health(health)
	
func _physics_process(delta):
	
	collision_handling(delta)
		
func collision_handling(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()
		if randf() < 0.5:
			take_damage(damage)

func take_damage(value):
	if not playerInvincible:
		$HealthComponent.take_damage(value)


func _on_area_2d_area_entered(area):
	if area.is_in_group("player") and not playerInvincible:
		area.get_parent().take_damage(damage)
		
		
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		AudioManager.dagger_hit_dagger.play()
		var hit_effect_instance = hit_effect.instantiate()
		hit_effect_instance.global_position = $"Hit Point".global_position
		get_tree().current_scene.get_node("VFX").add_child(hit_effect_instance)
		
		
	if area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)
		AudioManager.dagger_hit_body.play()

func _on_timer_timeout():
	playerInvincible = false
	$CollisionShape2D.disabled = false
	
func on_death():
	#get_parent().add_score(health + damage);
	call_deferred("queue_free")
