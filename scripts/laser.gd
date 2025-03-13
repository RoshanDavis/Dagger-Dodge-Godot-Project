extends RayCast2D

var tween: Tween
var can_damage = false
var player
signal firing_finished
var cast_point := target_position

@onready var beam_particles = $"Beam Particles"
@onready var target_particles = $"Target Particles"
@onready var damage_zone = $"Damage Zone"
@onready var laser_mark = preload("res://scenes/blue orb/blue_laser_mark.tscn")

@export var charge_time: float = 2 # aiming time
@export var firing_time: float = 2
@export var damage: int = 1

var is_casting := false:
	set(cast):
		is_casting = cast
		set_physics_process(is_casting)
		beam_particles.emitting = is_casting
		if is_casting:
			appear()
		else:
			disappear()
			target_particles.emitting = false
		

func _ready():
	target_position.x = max(Global.viewport_size.x,Global.viewport_size.y)
	if get_tree().current_scene.has_node("Player"):
		player = get_tree().current_scene.get_node("Player")
	set_physics_process(false)
	$Line2D.points[0] = Vector2.ZERO
	
func _physics_process(_delta):
	cast_point = target_position
	force_raycast_update()
	
	target_particles.emitting = is_colliding() and can_damage
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		target_particles.global_rotation = get_collision_normal().angle()
		target_particles.position = cast_point + Vector2(30, 0)
	
	$Line2D.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	damage_zone.position = cast_point * 0.5
	damage_zone.get_child(0).shape.extents.x = cast_point.length() * 0.5

func appear() -> void:
	tween = create_tween()
	tween.tween_property($Line2D, "width", 30, 0.5)
	fire_laser()

func disappear() -> void:
	tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.2)
	$Line2D.modulate.a8 = 70
	can_damage = false

func rotate_to_player():
	if player != null:
		look_at(player.position)
	else:
		var rot = randf_range(0,360)
		tween = create_tween()
		tween.tween_property(self,"rotation_degrees",rot,charge_time)
		
func start_laser():
	self.is_casting = true
	rotate_to_player()
	

func fire_laser():
	await get_tree().create_timer(charge_time).timeout # charge up time
	tween = create_tween().parallel()
	tween.tween_property($Line2D, "width", 50, 0.1)
	tween.tween_property($Line2D, "modulate:a", 1, 0.1)
	can_damage = true
	damage_zone.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(firing_time).timeout # firing time
	self.is_casting = false
	can_damage=false
	damage_zone.process_mode = Node.PROCESS_MODE_DISABLED
	spawn_laser_mark()
	firing_finished.emit()
	
func re_fire_laser():
	rotate_to_player()
	await get_tree().create_timer(2).timeout # reload time
	self.is_casting = true

func _on_damage_zone_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
			
	if area.is_in_group("player"):
		area.get_parent().take_damage(damage)

func spawn_laser_mark():
	var laser_mark_instance = laser_mark.instantiate()
	laser_mark_instance.position = global_position
	laser_mark_instance.rotation = rotation
	laser_mark_instance.points[0] = Vector2.ZERO
	laser_mark_instance.points[1] = cast_point
	get_tree().current_scene.get_node("Marks").add_child(laser_mark_instance)
