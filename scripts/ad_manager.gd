extends Node2D

@onready var admob = $Admob

var is_initialized :bool = false

var revive_reward_request: bool = false

func _ready():
	admob.initialize()

func _on_banner_button_button_up():
	display_banner_ad()

func _on_interstitial_button_button_up():
	display_interstitial_ad()

func _on_reward_button_button_up():
	display_rewarded_ad()

func display_banner_ad():
	if is_initialized:
		admob.load_banner_ad()
		await admob.banner_ad_loaded
		admob.show_banner_ad()

func display_interstitial_ad():
	if is_initialized:
		admob.load_interstitial_ad()
		await  admob.interstitial_ad_loaded
		admob.show_interstitial_ad()

func display_rewarded_ad():
	if is_initialized:
		admob.load_rewarded_ad()
		await admob.rewarded_ad_loaded
		admob.show_rewarded_ad()

func _on_admob_initialization_completed(_status_data):
	is_initialized = true


func _on_admob_rewarded_ad_user_earned_reward(_ad_id, _reward_data):
	if revive_reward_request:
		player_revive_reward()
		revive_reward_request = false
		return
		
	var current_orbs = GameSave.save_data["total_orbs"]
	GameSave.update_total_orbs(current_orbs + 500)
	if get_tree().current_scene.has_method("update_total_orbs"):
		get_tree().current_scene.update_total_orbs()

func player_revive_reward():
	get_tree().current_scene.get_node("Player").revive_player()
	get_tree().current_scene.get_node("Daggers").remove_all_children()
	get_tree().current_scene.get_node("Enemies").remove_all_children()
	get_tree().current_scene.get_node("Orbs").remove_all_children()
