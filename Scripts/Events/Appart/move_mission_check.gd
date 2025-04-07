extends Node2D

@export var distance: float = 20.0

var player: Player
var start_pos: Vector2

func initialize_quest(player_obj: Player) -> void:
	player = player_obj
	start_pos = player.position

func _physics_process(_delta: float) -> void:
	if not player:
		return
		
	if player.position.distance_to(start_pos) > distance:
		check_mission_done()

func check_mission_done() -> void:
	if SaveManager.getElement("Quests", "0-1_deplacer") == false:
		# activer lors que mission accomplie
		Dialogic.start("Introduction", "book4")
	else:
		# supprime la mission si elle déjà accomplie
		queue_free()
