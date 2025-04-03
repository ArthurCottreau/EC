extends PropTalk

var id: int

func initialize_garbage() -> void:
	if SaveManager.getElement("Missions", "Poubelle"):
		var poubelle_data: Array[bool] = SaveManager.getElement("Missions", "Poubelle")
		if poubelle_data[id] == true:
			queue_free()

func on_interact(player: Player) -> void:
	if SaveManager.getElement("Quests", "3-1_ramasser") == null:
		super(player)
	elif SaveManager.getElement("Quests", "3-1_ramasser") == false:
		
		#TEMPORAIRE
		AudioManager.stop_sfx()
		AudioManager.play_sfx(load("uid://ba8had06bq351"))
		
		var poubelle_data: Array[bool] = SaveManager.getElement("Missions", "Poubelle")
		poubelle_data[id] = true
		SaveManager.setElement("Missions", {"poubelle": poubelle_data})
		queue_free()
		
		if not poubelle_data.has(false):
			Dialogic.start("pnj_eboueur", "book2")
			
