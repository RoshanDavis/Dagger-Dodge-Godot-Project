extends CharacterBody2D

var game
var dagger
var has_shield = false
var canMove = false
var facingRight = true

@export var health = 5
@export var recoilSpeed = 500
@export var speed = 200
@export var drag = 1
@export var movement_type:int = 2

@onready var slowmoController = $"Slow-Mo Controller"
@onready var arrows = $Arrows

func _ready():
	velocity = Vector2(0,0)
	dagger = preload("res://scenes/dagger.tscn")
	$HealthComponent.set_initial_health(health)
	%"Gameplay UI".set_max_health(health)
	%"Gameplay UI".set_current_health(health)
	
func _physics_process(delta):
	match  movement_type:
		1:
			rotate_player()
			if canMove:
				movement(delta)
		2:
			rotate_player()
			if canMove:
				movement2(delta)
		
func rotate_player():
	look_at(get_global_mouse_position())
	rotation_degrees = fmod(rotation_degrees,360)
	var rot = abs(rotation_degrees)
	if (rot>90 and rot<270):
		if facingRight:
			apply_scale(Vector2(1,-1))
			facingRight = false
	else:
		if not facingRight: 
			apply_scale(Vector2(1,-1))
			facingRight = true


func movement(delta):
	if Input.is_action_just_pressed("Throw"):
		spawn_dagger()
		velocity = velocity + global_transform.basis_xform(Vector2.LEFT * recoilSpeed) 

	if velocity.length() > speed:
		velocity -= velocity * drag * delta

	var collision = move_and_collide(velocity * delta)
	if collision: 
		velocity = velocity.bounce(collision.get_normal())

func movement2(delta):
	if Input.is_action_just_pressed("Throw"):
		slowmoController.start_slowmo()
		arrows.visible = true
		
	if Input.is_action_just_released("Throw"):
		slowmoController.stop_slowmo()
		arrows.visible = false
		spawn_dagger()
		velocity =  global_transform.basis_xform(Vector2.LEFT * (recoilSpeed + velocity.length()))
		
	if velocity.length() > speed:
		velocity -= velocity * drag * delta

	var collision = move_and_collide(velocity * delta)
	if collision: 
		velocity = velocity.bounce(collision.get_normal())

func spawn_dagger():
	var daggerInstance = dagger.instantiate()
	daggerInstance.position = $FirePoint.global_position
	daggerInstance.rotation = rotation
	get_parent().add_child(daggerInstance)
	AudioManager.dagger_throw.play()

func take_damage(damage):
	if has_shield:
		shield_broken()
		return 
	AudioManager.player_hurt.play()
	$HealthComponent.take_damage(damage)
	%"Gameplay UI".set_current_health($HealthComponent.currentHealth)

func _on_hitbox_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(1)

func on_death():
	get_parent().game_over()
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
	%"Gameplay UI".set_current_health($HealthComponent.currentHealth)
