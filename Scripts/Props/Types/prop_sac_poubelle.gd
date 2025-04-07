extends PropTalk

@export var sfx_pick_up: AudioStreamWAV

var id: int

func initialize_garbage() -> void:
	if SaveManager.getElement("Missions", "Poubelle"):
		var poubelle_data: Array[bool] = SaveManager.getElement("Missions", "Poubelle")
		if poubelle_data[id] == true:
			queue_free()

func on_interact(player: Player) -> void:
	if SaveManager.getElement("Quests", "3-1_ramasser") == null: # Quête NON commencée
		super(player)
	elif SaveManager.getElement("Quests", "3-1_ramasser") == false: #Quête commencée
		
		AudioManager.play_sfx(sfx_pick_up, -5.0)
		
		var poubelle_data: Array[bool] = SaveManager.getElement("Missions", "Poubelle")
		poubelle_data[id] = true
		SaveManager.setElement("Missions", {"poubelle": poubelle_data})
		queue_free()
		
		if not poubelle_data.has(false):
			Dialogic.start("pnj_eboueur", "book2")
			
