extends Node2D

var tween :Tween

@onready var laser_source = $LaserSource
@onready var death_effect = preload("res://scenes/sfx/hit_effect_2.tscn")
@onready var laser_charge = $"Laser Charge"

@export var charge_time :float =  2
@export var health:int = 5

func _ready():
	$HealthComponent.set_initial_health(health)
	$HealthBar.set_initial_health(health)
	charge_laser()
	#await get_tree().create_timer(charge_time).timeout # charge time
	laser_charge.play()
	$Laser.start_laser()

func charge_laser():
	tween = create_tween().set_parallel(true)
	tween.tween_property(laser_source, "modulate:a", 1, charge_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(laser_source, "scale", Vector2(1,1), charge_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func _on_laser_firing_finished():
	# Cool down
	laser_charge.stop()
	tween = create_tween().set_parallel(true)
	tween.tween_property(laser_source, "modulate:a", 0, charge_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(laser_source, "scale", Vector2(0.5,0.5), charge_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	laser_charge.play()
	charge_laser()
	$Laser.start_laser()
	
func take_damage(value):
	$HealthComponent.take_damage(value)
	$HealthBar.set_current_health($HealthComponent.currentHealth)
	
func on_death():
	AudioManager.metal_hit.play()
	var death_effect_instance = death_effect.instantiate()
	death_effect_instance.global_position = position
	get_tree().current_scene.get_node("VFX").add_child(death_effect_instance)
	call_deferred("queue_free")
