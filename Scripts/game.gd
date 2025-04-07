extends Node2D
class_name Game

@export var first_map: String
@export var controls: Resource
@export var viewport: SubViewport

static var inputs: InputManager

func _ready() -> void:
	_initialize_signals()
	_initialize_viewport()
	_initialize_inputs()
	#_initialize_dialogic()

func _initialize_signals() -> void:
	EventBus.add_signal("set_ui_visibility", $UI.set_visible)

func _initialize_viewport() -> void:
	ThreadLoad.initialize_viewport(viewport)
	ThreadLoad.load_scene(first_map)
	get_tree().root.size_changed.connect(_setup_resolution_change) # Signal si la résolution change
	_setup_resolution_change()

func _initialize_inputs() -> void:
	match OS.get_name(): 
		"Web":
			if _is_mobile():
				inputs = load(controls.types["Mobile"]).instantiate()
			else:
				inputs = load(controls.types["Default"]).instantiate()
		_: # Si pas sur plateforme web
			inputs = load(controls.types["Default"]).instantiate()
	
	$UI.add_child(inputs)

func _initialize_dialogic() -> void:
	Dialogic.start("init")

func _is_mobile() -> bool:
	return OS.has_feature("web_android") || OS.has_feature("web_ios")

func _setup_resolution_change() -> void:
	$Viewports.set_size(get_viewport_rect().size)
	$UI.set_size(get_viewport_rect().size)
	FadeManager.set_size(get_viewport_rect().size)
	$UI/Pointer.on_resolution_change()
