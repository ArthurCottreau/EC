extends Control

var empreinte: float = 10

@onready var empreinte_label: Label = $PanelLabel/Label
@onready var grade_element: Control = get_parent().get_node("Grade")
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_initialize_empreinte()

func _initialize_empreinte() -> void:
	empreinte_label.text = str(empreinte)
	EventBus.add_signal("set_empreinte", on_update_empreinte)

func on_update_empreinte(arg: float) -> void:
	play_feedback(arg)
	empreinte += arg
	empreinte_label.text = str(empreinte)
	grade_element.update_grading()

func play_feedback(score: float) -> void:
	if score > 0:
		anim_player.play("feedback_bad")
		
		#TEMPORAIRE
		AudioManager.stop_sfx()
		AudioManager.play_sfx(load("uid://b7tvwd2f2hquj"))
		
	else:
		anim_player.play("feedback_good")
		
		#TEMPORAIRE
		AudioManager.stop_sfx()
		AudioManager.play_sfx(load("uid://411hqn6fotde"))
