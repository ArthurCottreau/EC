extends Control

var count: int = 0

@onready var sprites_tv: Node2D = $Meuble

func _on_tv_eteint() -> void:
	$Meuble/SpriteTV.play("stop")
	#changer animation TV dans la map
	await get_tree().create_timer(2.5).timeout
	get_parent().quit_minigame()

func _on_pousser_meuble_pressed() -> void:
	if count <= 16:
		sprites_tv.position.x += -5
		count += 1
	else:
		$Meuble/Pousser_meuble.disabled = true
		$Prise.disabled = false

func _on_update_score(score: float):
	EventBus.emit_signal("set_empreinte", score)
