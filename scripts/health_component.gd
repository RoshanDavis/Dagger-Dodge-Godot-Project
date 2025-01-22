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
		#get_parent().queue_free() # temp code
		get_parent().call_deferred("queue_free")
		#print_debug(get_parent())
		
