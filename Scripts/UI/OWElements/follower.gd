extends Control

var follower: int = 0

@onready var follower_label = $PanelLabel/Label
@onready var grade_element = get_parent().get_node("Grade")
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_initialize_follower()

func _initialize_follower() -> void:
	follower_label.text = str(follower)
	EventBus.add_signal("add_follower", add_follower)

func add_follower(arg: int = 1) -> void:
	
		#TEMPORAIRE
	AudioManager.stop_sfx()
	AudioManager.play_sfx(load("uid://411hqn6fotde"))
	
	EventBus.emit_signal("change_time", 180)
	
	anim_player.play("feedback_good")
	follower += arg
	follower_label.text = str(follower)
	grade_element.update_grading()
