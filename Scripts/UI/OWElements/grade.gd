extends Control

@onready var grade_label = $PanelLabel/Label
@onready var indicateur_temps = get_parent().get_node("Timer/BarreTemps/TimerBarIndicateur")
@onready var carbone_element = get_parent().get_node("Carbone")
@onready var timer_element = get_parent().get_node("Timer")
@onready var follower_element = get_parent().get_node("Follower")

func _ready() -> void:
	indicateur_temps.text = ">>>"

func update_grading() -> void:
	var grading_score: float = carbone_element.empreinte - floor(follower_element.follower/4)
	match grading_score:
		var x when x >= 18:
			grade_label.text = "F"
			timer_element.time_multi = 1.5
			indicateur_temps.text = ">>>>>"
		var x when x < 18 and x >= 15:
			grade_label.text = "E"
			timer_element.time_multi = 1.5
			indicateur_temps.text = ">>>>>"
		var x when x < 15 and x >= 12:
			grade_label.text = "D"
			timer_element.time_multi = 1.2
			indicateur_temps.text = ">>>>"
		var x when x < 12 and x >= 9:
			grade_label.text = "C"
			timer_element.time_multi = 1
			indicateur_temps.text = ">>>"
		var x when x < 9 and x >= 6:
			grade_label.text = "B"
			timer_element.time_multi = 0.8571
			indicateur_temps.text = ">>"
		var x when x < 6 and x > 2 :
			grade_label.text = "A"
			timer_element.time_multi = 0.75
			indicateur_temps.text = ">"
		var x when x <= 2:
			grade_label.text = "S"
			timer_element.time_multi =  0.75
			indicateur_temps.text = ">"
