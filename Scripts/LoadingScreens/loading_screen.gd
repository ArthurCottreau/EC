extends Node2D

@export var loading_screens: Resource
var next_scene: Node2D
var loading_screen_key: String

func _ready() -> void:
	initialize_loading_screen()
	initialize_load_type()

func initialize_loading_screen() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)

func initialize_load_type() -> void:
	if loading_screen_key.is_empty():
		_on_event_trigger()
	else:
		if AudioManager.get_current_music() != next_scene.stream :
			AudioManager.fade_music(-80, 3.0)
		FadeManager.visible = false
		var load_trans: Node2D = load(loading_screens.types[loading_screen_key]).instantiate()
		add_child(load_trans)

func _on_event_trigger() -> void:
	FadeManager.visible = true
	ThreadLoad.trigger_next_scene(next_scene)
