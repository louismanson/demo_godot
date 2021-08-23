extends Node
# Reset Level

var checkpoint_pos = 0

func _ready():
	Global.fruit = 0


func _on_Trigger_PlayerEntered_Camera() -> void:
	$BossCamera.current = true


func _on_Boss_BossDead() -> void:
	$BossCamera.current = false



#00:04:00
