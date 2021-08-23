extends Control


func _ready() -> void:
	$returnBtn.grab_focus()


func _on_returnBtn_pressed() -> void:
	queue_free()
