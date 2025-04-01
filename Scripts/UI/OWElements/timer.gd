extends Control

@export var heure : int
@export var minute : int
@export var seconde : int
@export var time_multi : float = 1.0

var time : float
var format_string = "%02d : %02d : %02d"
var tween: Tween

@onready var time_label = $PanelLabel/Label
@onready var timer_bar = $BarreTemps/PanelProgressBar/TimeBar
@onready var changing_timer_bar = $BarreTemps/PanelProgressBar/TimeBar/ChangeTimeBar

func _ready() -> void:
	time_label.text = format_string % [heure, minute, seconde]
	time = (heure * 3600) + (minute * 60) + seconde
	changing_timer_bar.visible = false

func _process(delta: float) -> void:
	if time > 0:
		time -= delta * time_multi
		timer_bar.value = -time
		heure = int(time / 3600)
		minute = int(time / 60) % 60
		seconde = int(time) % 60
		time_label.text = format_string % [heure, minute, seconde]
	else:
		pass
		
func add_time(added_time: float) -> void:
	changing_timer_bar.value = -time
	changing_timer_bar.visible = true
	time += added_time
	
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(changing_timer_bar, "value", -time, 1.0)
	
	await get_tree().create_timer(1.0).timeout
	changing_timer_bar.visible = false
	
func remove_time(removed_time: float) -> void:
	changing_timer_bar.value = -time
	changing_timer_bar.value += -removed_time
	changing_timer_bar.visible = true
	
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(timer_bar, "value", changing_timer_bar.value, 1.0)
	
	await get_tree().create_timer(1.0).timeout
	changing_timer_bar.visible = false
	time += removed_time

func _on_button_pressed() -> void:
	remove_time(-1000.0)
