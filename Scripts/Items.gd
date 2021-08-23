extends Area2D
# Items

export var fruits = 1


func _on_items_body_entered(_body: Node) -> void:
	$collectedFx.play()
	print("Objeto frutas colisiona con el Jugador")
#	print(body.name)
	$anim.play("collected")
	Global.fruit += fruits
	print(Global.fruit)
#	Global.fruits += fruits


func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()














