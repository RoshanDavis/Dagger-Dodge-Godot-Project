extends CharacterBody2D


var dagger
@export var health = 5
@export var recoilSpeed = 500
@export var speed = 200
@export var drag = 1

func _ready():
	velocity = Vector2(0,0)
	dagger = preload("res://scenes/dagger.tscn")
	$HealthComponent.set_initial_health(health)
	get_parent().set_max_health(health)
	get_parent().set_current_health(health)
	
func _physics_process(delta):
	movement(delta)

func movement(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Throw"):
		var daggerInstance = dagger.instantiate()
		daggerInstance.position = $FirePoint.global_position
		daggerInstance.rotation = rotation
		get_tree().get_root().get_node("Game").add_child(daggerInstance)
		
		velocity = velocity + global_transform.basis_xform(Vector2.LEFT * recoilSpeed) 

	if velocity.length() > speed:
		velocity -= velocity * drag * delta

	var collision = move_and_collide(velocity * delta)
	if collision: 
		velocity = velocity.bounce(collision.get_normal())

func take_damage(damage):
	$HealthComponent.take_damage(damage)
	get_parent().set_current_health($HealthComponent.currentHealth)

func _on_hitbox_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(1)

func on_death():
	get_parent().game_over()
	call_deferred("queue_free")
