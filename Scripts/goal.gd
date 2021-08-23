extends Area2D
# goal

onready var changer = get_parent().get_node("Transition_in")

export var path : String

func _ready():
	pass


func _on_goal_body_entered(body: Node) -> void:
	if body.name == "Player":
		print ("Jugador entra en la meta")
		$confetti.emitting = true
		changer.change_scene(path)
		Global.checkpoint_pos = 0
		$victoryFx.play()


