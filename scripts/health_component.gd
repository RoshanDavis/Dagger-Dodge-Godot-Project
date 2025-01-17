extends Node

var maxHealth
var currentHealth

func _ready():
	maxHealth = 1
	currentHealth = 1

func take_damage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		get_parent().queue_free() # temp code
		
