extends Label
# Score


func _process(_delta: float) -> void:
	text = "00" + String(Global.fruit)
	if Global.fruit >= 10:
		text = "0" + String(Global.fruit)

