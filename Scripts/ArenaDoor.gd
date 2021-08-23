extends StaticBody2D
# Arena Door

signal DoorClosed


func _ready() -> void:
	pass


func _on_Trigger_PlayerEntered() -> void:
	print("player colisiono con Arena Door")
	$anim.play("active")
	emit_signal("DoorClosed")


func _on_Boss_BossDead() -> void:
	$anim.play("inactive")
