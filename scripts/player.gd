extends CharacterBody2D

var game
var dagger
var has_shield = false
var canMove = false
var facingRight = true
var invincible = false
var powerup_invincibility = false
var can_throw_dagger = true

var mouse_points :Array[Vector2] = [Vector2(0,0), Vector2(0,0)]
var is_initial_rotation = true
var initial_rotation_deadzone = 25
var joystick_movement_deadzone = 200
var final_joystick_speed = 1000
var joystick_speed :float = 500

var health = 2
var recoilSpeed = 500
var speed = 200
var drag = 1

var powerup_speed_multiplier = 3 # can not be 0
var powerup_recoil_multiplier = 2 # can not be 0

@export var characters_textures :Array[Texture2D]

@onready var slowmoController = $"Slow-Mo Controller"
@onready var arrows = $Arrows

func _ready():
	velocity = Vector2(0,0)
	initialize_player()
	initialize_dagger()
	final_joystick_speed = joystick_speed/$"Slow-Mo Controller".slowmo_time_scale

func initialize_player():
	match GameSave.save_data["recent_character"]:
		"GroundZero":
			health = 3
			recoilSpeed = 400
			speed = 100
			drag = 1
			$Character.texture = characters_textures[0]
			$"Slow-Mo Controller".slomo_time = 0.5
		"OneShot":
			health = 1
			recoilSpeed = 500
			speed = 200
			drag = 1
			$Character.texture = characters_textures[1]
			$"Slow-Mo Controller".slomo_time = 0.5
		"SlipShade":
			health = 3
			recoilSpeed = 700
			speed = 400
			drag = 1
			$Character.texture = characters_textures[2]
			$"Slow-Mo Controller".slomo_time = 1
		"Tank":
			health = 5
			recoilSpeed = 500
			speed = 200
			drag = 1
			$Character.texture = characters_textures[3]
			$"Slow-Mo Controller".slomo_time = 1
			
	$HealthComponent.set_initial_health(health)
	%"Gameplay UI".set_max_health(health)
	%"Gameplay UI".set_current_health(health)

func initialize_dagger():
	match GameSave.save_data["recent_dagger"]:
		"KitchenKnife" :
			dagger = preload("res://scenes/daggers/KitchenKnife.tscn")
		"RustBlade" :
			dagger = preload("res://scenes/daggers/RustBlade.tscn")
		"Hydra" :
			dagger = preload("res://scenes/daggers/Hydra.tscn")

func _physics_process(delta):
	rotate_player()
	if canMove:
		movement(delta)

func rotate_player():
	if (mouse_points[0]-mouse_points[1]).length() < initial_rotation_deadzone and is_initial_rotation:
		#look_at(get_global_mouse_position())
		#rotation_degrees = fmod(rotation_degrees,360)
		pass
	else:
		rotation = mouse_points[0].angle_to_point(mouse_points[1])
		is_initial_rotation = false

	$Joystick.rotation_degrees = rotation_degrees
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
		slowmoController.start_slowmo()
		arrows.visible = true
		mouse_points[0] = get_global_mouse_position()
		is_initial_rotation = true
		$Joystick.global_position = mouse_points[0]
		$Joystick.visible = true
	
	if Input.is_action_pressed("Throw"):
		mouse_points[1] = get_global_mouse_position()
		if (mouse_points[1] - mouse_points[0]).length() > joystick_movement_deadzone:
			var dir = (mouse_points[1] - mouse_points[0]).normalized()
			mouse_points[0] = mouse_points[0].move_toward(mouse_points[1],delta * final_joystick_speed)
			mouse_points[1] += dir 
			$Joystick.global_position = mouse_points[0]
		
	if Input.is_action_just_released("Throw"):
		slowmoController.stop_slowmo()
		arrows.visible = false
		$Joystick.visible = false
		spawn_dagger()
		velocity =  global_transform.basis_xform(Vector2.LEFT * (recoilSpeed + velocity.length()))
	
	if velocity.length() > speed:
		velocity -= velocity * drag * delta

	var collision = move_and_collide(velocity * delta)
	if collision: 
		velocity = velocity.bounce(collision.get_normal())

func spawn_dagger():
	if not can_throw_dagger:
		return
	var daggerInstance = dagger.instantiate()
	daggerInstance.position = $FirePoint.global_position
	daggerInstance.rotation = rotation
	get_tree().current_scene.get_node("Daggers").add_child(daggerInstance)
	AudioManager.dagger_throw.play()

func take_damage(damage):
	if powerup_invincibility:
		return
	if invincible:
		return
	if has_shield:
		shield_broken()
		return 
	if GameSave.save_data["recent_character"] == "SlipShade" and randf() < 0.3:
		$"../UI/Pop Ups".popup("DODGE")
		print_debug("Damage Dodged")
		return
	if GameSave.save_data["recent_character"] == "Tank" and randf() < 0.3:
		$"../UI/Pop Ups".popup("BLOCK")
		print_debug("Damage Blocked")
		return
	AudioManager.player_hurt.play()
	$HealthComponent.take_damage(damage)
	%"Gameplay UI".set_current_health($HealthComponent.currentHealth)
	i_frames()
	
func i_frames():
	invincible = true
	$"I Frame Time".start()

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


func _on_i_frame_time_timeout():
	invincible = false

func _on_fireball_power_up_started():
	powerup_invincibility = true
	speed *= powerup_speed_multiplier
	recoilSpeed *= powerup_recoil_multiplier
	velocity *= powerup_speed_multiplier

func _on_fireball_power_up_done():
	powerup_invincibility = false
	speed /= powerup_speed_multiplier
	recoilSpeed /= powerup_recoil_multiplier
	
func freeze(this_node,freeze_time):
	if powerup_invincibility:
		this_node.death_effect()
		return
	canMove = false
	velocity = velocity.normalized() * speed
	slowmoController.stop_slowmo()
	await get_tree().create_timer(freeze_time).timeout
	canMove =  true
	
func freeze2(freeze_time):
	canMove = false
	velocity = velocity.normalized() * speed
	slowmoController.stop_slowmo()
	await get_tree().create_timer(freeze_time).timeout
	canMove =  true
	
func _on_paintball_power_up_started():
	powerup_invincibility = true
	$CollisionShape2D.scale = Vector2(5, 5)
	$Hitbox.scale = Vector2(5, 5)
	can_throw_dagger = false
	
	speed *= powerup_speed_multiplier
	recoilSpeed *= powerup_recoil_multiplier
	velocity *= powerup_speed_multiplier

func _on_paintball_power_up_done():
	powerup_invincibility = false
	$CollisionShape2D.scale = Vector2(1, 1)
	$Hitbox.scale = Vector2(1, 1)
	can_throw_dagger = true
	
	speed /= powerup_speed_multiplier
	recoilSpeed /= powerup_recoil_multiplier
