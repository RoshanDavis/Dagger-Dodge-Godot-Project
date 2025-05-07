extends Node2D

@onready var admob = $Admob

var is_initialized :bool = false

func _ready():
	admob.initialize()

func _on_banner_button_button_up():
	if is_initialized:
		admob.load_banner_ad()
		await admob.banner_ad_loaded
		admob.show_banner_ad()

func _on_interstitial_button_button_up():
	if is_initialized:
		admob.load_interstitial_ad()
		await  admob.interstitial_ad_loaded
		admob.show_interstitial_ad()

func _on_reward_button_button_up():
	if is_initialized:
		admob.load_rewarded_ad()
		await admob.rewarded_ad_loaded
		admob.show_rewarded_ad()

func _on_admob_initialization_completed(status_data):
	is_initialized = true


func _on_admob_rewarded_ad_user_earned_reward(ad_id, reward_data):
	var current_orbs = GameSave.save_data["total_orbs"]
	GameSave.update_total_orbs(current_orbs + 500)
	# Add code to update UI
