extends ProgressBar

@export var isHeartVisible = true

func _ready():
	$Heart.visible = isHeartVisible

func set_initial_health(health):
	max_value = health
	value = health

func set_max_health(health):
	max_value = health

func set_current_health(health):
	value = health
