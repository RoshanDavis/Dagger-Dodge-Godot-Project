extends CharacterBody2D

var playerInvincible = true

@export var speed:float = 300
@export var damage = 1
@export var health = 1
@export var hit_effect :PackedScene
@export var spawn_chance :float = 0.5
@export var spawn_limit :int = 100

@onready var dagger = preload("res://scenes/daggers/Hydra.tscn")

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

func take_damage(value):
	if not playerInvincible:
		$HealthComponent.take_damage(value)


func _on_area_2d_area_entered(area):
	if area.is_in_group("player") and not playerInvincible:
		area.get_parent().take_damage(damage)
		
		
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		AudioManager.dagger_hit_dagger.play()
		hit_effect_vfx()
		
		
	if area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)
		AudioManager.dagger_hit_body.play()

func _on_timer_timeout():
	playerInvincible = false
	$CollisionShape2D.disabled = false
	
func on_death():
	if randf() < spawn_chance and get_tree().current_scene.get_node("Daggers").get_child_count() < spawn_limit:
		spawn_double()
	
	call_deferred("queue_free")

func hit_effect_vfx():
	var hit_effect_instance = hit_effect.instantiate()
	hit_effect_instance.global_position = $"Hit Point".global_position
	
	get_tree().current_scene.get_node("VFX").add_child(hit_effect_instance)
	
func spawn_double():
	var dagger_instance1 = dagger.instantiate()
	dagger_instance1.global_position = $SpawnPoint1.global_position
	dagger_instance1.rotation = $SpawnPoint1.rotation
	get_tree().current_scene.get_node("Daggers").call_deferred("add_child", dagger_instance1)
	
	var dagger_instance2 = dagger.instantiate()
	dagger_instance2.global_position = $SpawnPoint2.global_position
	dagger_instance2.rotation = $SpawnPoint2.rotation
	get_tree().current_scene.get_node("Daggers").call_deferred("add_child", dagger_instance2)
