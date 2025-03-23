extends CharacterBody2D

var tween :Tween
var player

@onready var rot_saw = $"Gold Saw"
@onready var explosion = preload("res://scenes/gold orb/gold_saw_explosion.tscn") 

@export var speed: float = 500
@export var knockback_force: float = 500
@export var damage: int = 1

func _ready():

	if get_tree().current_scene.has_node("Player"):
		player = get_tree().current_scene.get_node("Player")
	look_at(player.global_position)
	velocity = global_transform.basis_xform(Vector2.RIGHT * speed)
	spin()

func _physics_process(delta):
	collision_handling(delta)
		
func collision_handling(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().is_in_group("wall"):
			explode()
		velocity = velocity.bounce(collision.get_normal())

func spin():
	tween = create_tween().set_loops()
	tween.tween_property(rot_saw,"rotation_degrees",360,1)
	tween.tween_property(rot_saw,"rotation_degrees",0,0)

func explode():
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = global_position
	get_tree().current_scene.get_node("VFX").add_child(explosion_instance)
	get_parent().queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
		explode()
	
	elif  area.is_in_group("player"):
		area.get_parent().take_damage(damage)
		area.get_parent().velocity += (area.global_position - global_position).normalized() * knockback_force
		explode()
	
	elif area.is_in_group("safe damage"):
		explode()
	
	
	
