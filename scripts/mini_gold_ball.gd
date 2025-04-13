extends Area2D

@export var speed :float = 500

@onready var explosion = preload("res://scenes/gold orb/mini_gold_ball_explosion.tscn")

func _ready():
	pass

func _physics_process(delta):
	position += global_transform.basis_xform(Vector2.RIGHT) * speed * delta

func _on_body_entered(body):
	if body.is_in_group("wall"):
		explode()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		explode()

func explode():
	$"Gold Particles".visible = false
	$"Gold Particles".emitting = false
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	get_tree().current_scene.get_node("VFX").call_deferred("add_child",explosion_instance)
	queue_free()
