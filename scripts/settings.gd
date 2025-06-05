extends Control

@export var music_on_icon :Texture2D
@export var music_off_icon :Texture2D
@export var sfx_on_icon :Texture2D
@export var sfx_off_icon :Texture2D

@onready var music_on = GameSave.save_data["music_on"]
@onready var sfx_on = GameSave.save_data["sfx_on"]
@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var total_orbs = GameSave.save_data["total_orbs"]
@onready var high_score = GameSave.save_data["high_score"]

func _ready():
	update_music_state()
	update_sfx_state()
	$"Total Orbs/Total Orbs".text = str(total_orbs)
	$"High Score/High Score".text = str(high_score)

func update_music_state():
	if music_on:
		AudioServer.set_bus_mute(music_bus, false)
		$"Music Button".icon = music_on_icon
	else:
		AudioServer.set_bus_mute(music_bus, true)
		$"Music Button".icon = music_off_icon

func update_sfx_state():
	if sfx_on:
		$"SFX Button".icon = sfx_on_icon
		AudioServer.set_bus_mute(sfx_bus, false)
	else:
		$"SFX Button".icon = sfx_off_icon
		AudioServer.set_bus_mute(sfx_bus, true)

func _on_music_button_button_up():
	AudioManager.button_press.play()
	music_on = not music_on
	update_music_state()

func _on_sfx_button_button_up():
	AudioManager.button_press.play()
	sfx_on = not sfx_on
	update_sfx_state()
	

func _on_return_button_button_up():
	AudioManager.button_press.play()
	visible = false
	GameSave.update_audio_state(music_on, sfx_on)

func update_total_orbs():
	$"Total Orbs".text = str(GameSave.save_data["total_orbs"])
