extends Area2D


func _ready() -> void:
	pass


func _on_trampoline_body_entered(body: Node) -> void:
	print("Trampa Colisiona con Player")
	body.velocity.y = body.jump_force
	$anim.play("jump")
