extends CharacterBody2D

var game
var dagger
var has_shield = false
var canMove = false

@export var health = 5
@export var recoilSpeed = 500
@export var speed = 200
@export var drag = 1

func _ready():
	game = get_tree().get_root().get_node("Game")
	velocity = Vector2(0,0)
	dagger = preload("res://scenes/dagger.tscn")
	$HealthComponent.set_initial_health(health)
	game.set_max_health(health)
	game.set_current_health(health)
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	if canMove:
		movement(delta)

func movement(delta):
	if Input.is_action_just_pressed("Throw"):
		var daggerInstance = dagger.instantiate()
		daggerInstance.position = $FirePoint.global_position
		daggerInstance.rotation = rotation
		game.add_child(daggerInstance)
		
		AudioManager.dagger_throw.play()
		
		velocity = velocity + global_transform.basis_xform(Vector2.LEFT * recoilSpeed) 

	if velocity.length() > speed:
		velocity -= velocity * drag * delta

	var collision = move_and_collide(velocity * delta)
	if collision: 
		velocity = velocity.bounce(collision.get_normal())

func take_damage(damage):
	if has_shield:
		shield_broken()
		return 
	AudioManager.player_hurt.play()
	$HealthComponent.take_damage(damage)
	game.set_current_health($HealthComponent.currentHealth)

func _on_hitbox_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(1)

func on_death():
	game.game_over()
	call_deferred("queue_free")

func shield_gained():
	has_shield = true
	$Shield.visible = true

func shield_broken():
	AudioManager.shield_broke.play()
	has_shield = false
	$Shield.visible = false

func heal(value):
	$HealthComponent.heal(value)
	game.set_current_health($HealthComponent.currentHealth)
