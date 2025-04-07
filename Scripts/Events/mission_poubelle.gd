extends Node2D

func _ready() -> void:
	if SaveManager.getElement("Missions", "Poubelle") == null: # Si il n'y a aucune sauvegarde
		var poubelle_data: Array[bool]
		
		for i in get_children().size():
			get_child(i).id = i
			poubelle_data.append(false)
			
		SaveManager.setElement("Missions", {"Poubelle": poubelle_data})
	else:
		for i in get_children().size():
			var poubelle: Node2D = get_child(i)
			poubelle.id = i
			poubelle.initialize_garbage()
