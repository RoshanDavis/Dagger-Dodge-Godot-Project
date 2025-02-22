extends Node

var slowmo_active = false

@export var normal_time_scale: float = 1.0
@export var slowmo_time_scale: float = 0.1


func start_slowmo():
	Engine.time_scale = slowmo_time_scale
	slowmo_active = true
	AudioManager.time_stop.play()
	
func stop_slowmo():
	Engine.time_scale = normal_time_scale
	slowmo_active = false

func request_slowmo_change():
	if slowmo_active:
		stop_slowmo()
	else:
		start_slowmo()
