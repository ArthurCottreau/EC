extends Node2D

@export var chair_obj: Node2D

func _physics_process(_delta: float) -> void:
	if chair_obj.is_siting == true:
		check_mission_done()

func check_mission_done() -> void:
	if SaveManager.getElement("Quests", "0-2_chaise") == false:
		# activer lors que mission accomplie
		Dialogic.start("Introduction", "book5")
	else:
		# supprime la mission si elle déjà accomplie
		queue_free()
