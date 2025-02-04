extends Node

var maxHealth
var currentHealth

func _ready():
	maxHealth = 1
	currentHealth = 1

func set_initial_health(health):
	maxHealth = health
	currentHealth = health

func take_damage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		if get_parent().has_method("on_death"):
			get_parent().on_death()
		else:
			get_parent().call_deferred("queue_free")
