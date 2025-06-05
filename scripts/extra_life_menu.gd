extends Control


func _ready():
	set_process(false)
	$"Countdown Bar".max_value = $Timer.wait_time

func start_timer():
	set_process(true)
	$Timer.start()

func _on_timer_timeout():
	visible = false
	get_parent().show_game_over_menu()
	set_process(false)

func _on_watch_ad_button_up():
	AdManager.revive_reward_request = true
	AdManager.display_rewarded_ad()
	AdManager.player_revive_reward()
	visible = false
	$Timer.stop()

func _process(_delta):
	$"Countdown Bar".value = $Timer.time_left
