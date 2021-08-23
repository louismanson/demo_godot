extends Area2D
# Fall-zone


func _on_fallzone_body_entered(body: Node) -> void:
	print(body.name)
	if get_tree().change_scene("res://Prefabs/GameOver.tscn") != OK:
		print("¡Algo salió mal!")
	


