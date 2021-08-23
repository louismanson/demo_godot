extends Area2D
# Checkpoint
func _ready():
	pass


func _on_checkpoint_body_entered(body):
	if body.name == "Player":
		body.hit_checkpoint()
		$anim.play("checked")
		$collision.queue_free()
