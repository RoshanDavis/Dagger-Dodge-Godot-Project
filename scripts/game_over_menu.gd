extends Control

func _ready():
	var score = get_parent().score
	set_score(score)

func set_score(score):
	$Score.text = str(score)
