extends KinematicBody2D
class_name enemyBase
# Enemy Base

signal BossDead

export var speed = 32
export var health = 1
var motion =Vector2.ZERO
var move_direction = -1
var gravity = 1200
var hitted = false


func _physics_process(_delta: float) -> void:
	motion.x = speed * move_direction
	
	if move_direction == 1:
		$texture.flip_h = true
	else:
		$texture.flip_h = false
		
	motion = move_and_slide(motion)
	
#	_set_animation()

func apply_gravity(delta):
	motion.y += gravity * delta


func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "idle":
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")


func _set_animation():
	var anim = "run"
	
	if $ray_wall.is_colliding():
		anim = "idle"
	elif motion.x != 0:
		anim = "run"
		
	if hitted == true:
		anim = "hit"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)


func _on_hitbox_body_entered(body: Node) -> void:
	print("Enemigo Colisiona con el jugador")
	hitted = true
	health -= 1
	print(health)
	body.velocity.y = body.jump_force / 2 # 300
	$hitFx.play()
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		get_node("hitbox/collisio").set_deferred("disabled",true)
		set_physics_process(false)
		get_node("collision").set_deferred("disabled",true)
		yield(get_tree().create_timer(.7), "timeout")
		queue_free()

