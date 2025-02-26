extends Node2D

var slowmo_active = false

@export var normal_time_scale: float = 1.0
@export var slowmo_time_scale: float = 0.1

func  _ready():
	$"Slow Time Timer".wait_time *= slowmo_time_scale
	$LifetimeBar.step *= slowmo_time_scale
	$LifetimeBar.max_value = $"Slow Time Timer".wait_time
	
func _process(_delta):
	$LifetimeBar.value = $"Slow Time Timer".time_left
	
func start_slowmo():
	Engine.time_scale = slowmo_time_scale
	slowmo_active = true
	AudioManager.time_stop.play()
	$"Slow Time Timer".start()
	
func stop_slowmo():
	Engine.time_scale = normal_time_scale
	slowmo_active = false
	$"Slow Time Timer".stop()

func request_slowmo_change():
	if slowmo_active:
		stop_slowmo()
	else:
		start_slowmo()


func _on_slow_time_timer_timeout():
	print_debug("Slow time over")
	Input.action_release("Throw")
