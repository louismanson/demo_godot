extends Area2D
# Trigger

signal PlayerEntered


func _physics_process(_delta: float) -> void:
#	print ("Player Colisiono con Trigger")
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			emit_signal("PlayerEntered")
			queue_free()

						#00:18:57
