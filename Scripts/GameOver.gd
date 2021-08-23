extends CanvasLayer


func _ready() -> void:
	pass


func _on_BtnRetry_pressed() -> void:
#	if get_tree().reload_current_scene() != OK:
#	if get_tree().change_scene("res://Levels/Level _02.tscn") != OK:
	if get_tree().change_scene("res://Levels/Level _01.tscn") != OK:
			print("¡Algo salió mal!")
	if Global.is_dead:
		Global.player_health = 3
		
