extends CharacterBody2D

@onready var player = get_tree().get_root().get_node("Game").get_node("Player")

@export var speed:float = 70
@export var health:int = 3
@export var damage = 1

var facingRight = true

func _ready():
	$HealthComponent.set_initial_health(health)
	$HealthBar.set_initial_health(health)
	
func _physics_process(delta):
	movement(delta)
		
func movement(delta):
	var player_position = player.position
	var target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = target_position * speed
		move_and_slide()
	
	if (facingRight and velocity.x < 0) or (!facingRight and velocity.x > 0):
		$Polygons.scale.x *= -1
		facingRight = not facingRight


func take_damage(value):
	$HealthComponent.take_damage(value)
	$HealthBar.set_current_health($HealthComponent.currentHealth)
	
func on_death():
	call_deferred("queue_free")

func _on_hitbox_area_entered(area):

	if area.is_in_group("dagger"):
		area.get_parent().take_damage(damage)
