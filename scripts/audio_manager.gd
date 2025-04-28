extends Node2D

# Game Music 
@onready var game_music = $"Game Music"

# UI
@onready var game_over = $"Game Over"
@onready var dagger_out = $"Dagger Out"
@onready var button_press = $"Button Press"
@onready var success = $Success

# Player
@onready var dagger_throw = $"Dagger Throw"
@onready var player_hurt = $"Player Hurt"
@onready var shield_broke = $"Shield Broke"
@onready var time_stop = $"Time Stop"


#Dagger
@onready var dagger_hit_body = $"Dagger Hit Body"
@onready var dagger_hit_dagger = $"Dagger Hit Dagger"

# Orbs
@onready var gold_orb_pickup = $"Gold Orb Pickup"
@onready var orb_pop = $"Orb Pop"

# Enemies
@onready var jelly_death = $"Jelly Death"
@onready var metal_hit = $"Metal Hit"
@onready var bomb_explosion = $"Bomb Explosion"
@onready var saw_start = $"Saw Start"
@onready var spikes_out = $"Spikes Out"
@onready var beeping = $Beeping
@onready var ice_break = $"Ice Break"

# Power Ups
@onready var orb_explosion = $"Orb Explosion"
@onready var whoosh = $Whoosh
@onready var small_explosion = $"Small Explosion"
@onready var slash = $Slash

# Environment
@onready var bush_shake = $"Bush Shake"
@onready var bush_break = $"Bush Break"
@onready var rock_break = $"Rock Break"
@onready var flower_break = $"Flower Break"

func _ready():
	game_music.play()
