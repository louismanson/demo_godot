extends Area2D
# Fire Trap

func _ready() -> void:
	pass


func _on_Fire_body_entered(body: Node) -> void:
	print("EL player entro a la Trampa de Fuego")
	if body.has_method("playerDamage"):
		body.playerDamage()


func _on_startTimer_timeout() -> void:
	$anim.play("on")
	$FireCol.set_deferred("disabled", false)

func _on_stopTimer2_timeout() -> void:
	$anim.play("off")
	$FireCol.set_deferred("disabled", true)









