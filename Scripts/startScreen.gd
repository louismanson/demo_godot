extends Control
# Start Screen

func _ready() -> void:
	$controls/startBtn.grab_focus()
# 00:10:45


func _on_startBtn_pressed() -> void:
	get_tree().change_scene("res://Levels/Level _01.tscn")


func _on_controlsBtn_pressed() -> void:
	var controlScreen = load("res://Scenes/controlsScreen.tscn").instance()
	get_tree().current_scene.add_child(controlScreen)

func _on_quitBtn_pressed() -> void:
	get_tree().quit()












