extends Control

const ITEM_SPAWN_MARGIN: int = 50

@export var items: Array[PackedScene]
@export var max_trash_items: int

var score: float
var trash_count: int
var z_index_tracker: int

func _ready() -> void:
	randomize()

func update_trash_count() -> void:
	
	#TEMPORAIRE
	AudioManager.stop_sfx()
	AudioManager.play_sfx(load("uid://ba8had06bq351"))
	
	trash_count += 1
	if trash_count == max_trash_items:
		EventBus.emit_signal("set_empreinte", score)
		await get_tree().create_timer(2.5).timeout 
		get_parent().quit_minigame()

func update_score(value: float) -> void:
	score += value
	update_trash_count()

func _on_timer_timeout() -> void:
	if trash_count < max_trash_items:
		var trash_load = items[randi_range(0,items.size()-1)]
		var trash_instance: Node2D = trash_load.instantiate()
		
		trash_instance.position.x = randf_range(ITEM_SPAWN_MARGIN, size.x - ITEM_SPAWN_MARGIN)
		
		add_child(trash_instance)
