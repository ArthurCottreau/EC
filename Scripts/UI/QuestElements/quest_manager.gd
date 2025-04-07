extends Control

@export var quest_data: QuestList
@export var quest_prefab: PackedScene
@export var sfx_new_quest: AudioStreamWAV
@export var sfx_quest_done: AudioStreamWAV

@onready var target: BoxContainer = $QuestList/Columns
@onready var mission_label: Label = $MissionName/Panel/Label

var tween: Tween

func _ready() -> void:
	_initialize_signals()

func _initialize_signals() -> void:
	EventBus.add_signal("add_quest", add_quest)
	EventBus.add_signal("clean_quests", clean_quests)
	EventBus.add_signal("set_quest_state", set_quest_state)
	EventBus.add_signal("set_mission_name", set_mission_name)

func add_quest(key: String, quest_pos: int = target.get_child_count()) -> void:
	AudioManager.stop_sfx()
	AudioManager.play_sfx(sfx_new_quest, -5.0)
	
	var new_quest_data: Resource = load(quest_data.quests[key])
	var new_quest: BoxContainer = quest_prefab.instantiate()
	
	var new_quest_label: Label = new_quest.get_node("Panel/Label")
	var new_quest_margin: MarginContainer = new_quest.get_node("Margin")
	var quest_panel: PanelContainer = new_quest.get_node("Panel")
	
	match (new_quest_data.type): # Ajoute un style différent en fonction du type de quête
		0:
			new_quest_margin.add_theme_constant_override("margin_top", 35)
			new_quest_margin.add_theme_constant_override("margin_left", 60)
			new_quest_label.custom_minimum_size = Vector2(240,30)
		1:
			new_quest_margin.add_theme_constant_override("margin_left", 100)
			new_quest_label.custom_minimum_size = Vector2(200,30)
	
	new_quest_label.text = new_quest_data.name
	new_quest.name = key
	
	SaveManager.setElement("Quests", {key: false})
	
	target.add_child(new_quest)
	target.move_child(target.get_child(target.get_child_count()-1), quest_pos) # Pour deplacer la quête dans une autre position
	
	# Pour le fade in des quêtes
	tween = create_tween()
	tween.connect("finished", tween.kill)
	tween.tween_property(quest_panel, "self_modulate", Color.WHITE, 0.5)

func clean_quests() -> void:
	for i in target.get_children():
		i.queue_free()

func set_quest_state(quest_name: String) -> void:
	AudioManager.stop_sfx()
	AudioManager.play_sfx(sfx_quest_done, -5.0)
	
	target.get_node(quest_name + "/Panel/Label").modulate = Color.GREEN # Quand quête fini, passe le texte en vert
	SaveManager.setElement("Quests", {quest_name: true})

func set_mission_name(new_name: String) -> void:
	mission_label.text = new_name
