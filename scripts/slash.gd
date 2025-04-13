extends Area2D

@export var damage = 2
@export var speed = 4500

@onready var explosion = preload("res://scenes/sfx/explosion_spread.tscn")
@onready var explosion_mark = preload("res://scenes/sfx/explosion_spread_mark.tscn")


func _physics_process(delta):
	position += global_transform.basis_xform(Vector2.RIGHT) * speed * delta

func _on_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		
	if area.is_in_group("damageable enemy"):
		area.get_parent().take_damage(damage)


func _on_body_entered(body):
	if body.is_in_group("wall"):
		explode()

func explode():
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	explosion_instance.modulate = modulate
	get_tree().current_scene.get_node("VFX").add_child(explosion_instance)
	
	var explosion_mark_instance = explosion_mark.instantiate()
	explosion_mark_instance.position = global_position
	explosion_mark_instance.modulate = modulate
	explosion_mark_instance.rotation_degrees = randi_range(0, 360)
	get_tree().current_scene.get_node("Marks").add_child(explosion_mark_instance)
	
	queue_free()
