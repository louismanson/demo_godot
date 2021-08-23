extends KinematicBody2D
# Player

var UP = Vector2.UP
var velocity = Vector2.ZERO
var move_speed = 500
var gravity = 1200
var jump_force = -720
var is_grounded

#var player_health = 3
var max_health = 3

var hurted = false

var knockback_dir = 1
var knockback_int = 700

var facingRight = true

var is_pushing = false

onready var raycasts = $raycasts

signal change_life(player_health)

func _ready() -> void:
	Global.set("player", self) # Verifica la posiscion de player en la collision de enemigo plantle.
	if connect("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life") != OK:
		print("¡Algo salió mal!")
	emit_signal("change_life", max_health)
	position.x = Global.checkpoint_pos + 32 # Guarda la posicion de player
#	marcar como comentario para colocar al player en cualquier posision.

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0 # corrige error
	
	#	print(velocity.y)
	
	if !hurted: # corrige error
		_get_input() # corrige error
#	_get_input() # golpe
	
	if $pushRight.is_colliding(): # Esto hace que el Player pueda mover MoveBox. a la Der.
		var object = $pushRight.get_collider()
		object.move_and_slide(Vector2(30,0) * move_speed * delta)
		is_pushing = true
		
	elif $pushLeft.is_colliding(): # Esto hace que el Player pueda mover MoveBox. a la Izq.
		var object = $pushLeft.get_collider()
		object.move_and_slide(Vector2(-30,0) * move_speed * delta)
		is_pushing = true
	else:
		is_pushing = false
	
	velocity = move_and_slide(velocity, UP)
	
	is_grounded = _check_is_ground()
	
	if is_grounded:
		$Shadow.visible = true
	else:
		$Shadow.visible = false
	
	
	_set_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)


func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
#	Con este comando tambiamos de direccion la imagen del sprite (espejeado).
	if move_direction != 0:
		$texture.scale.x = move_direction
		$right.scale.x = move_direction # corrige error
		$left.scale.x = move_direction # corrige error
		$steps_fx.scale.x = move_direction # Particula humo
		knockback_dir = move_direction # golpe
		
	if velocity.x > 1: # Velocidad a la que mueve la caja a la Der.
		$pushRight.set_enabled(true)
	else:
		$pushRight.set_enabled(false)
		
	if velocity.x < -1: # Velocidad a la que mueve la caja a la Der.
		$pushLeft.set_enabled(true)
	else:
		$pushLeft.set_enabled(false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force /2
		$jumpFx.play()


func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false


func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0 or is_pushing: # Se agrega or... para que funcione con movebox
		anim = "run"
		$steps_fx.set_emitting(true) # Particula humo
	
	if velocity.y > 0 and ! is_grounded:
		anim = "fall"
	
	if hurted:
		anim = "hit"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)


func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int # corrige error
	if $left.is_colliding():
		velocity.x = knockback_dir * knockback_int # corrige error

#	velocity.x = -knockback_dir * knockback_int  # golpe
	velocity = move_and_slide(velocity) 


func _on_hurtbox_body_entered(_body: Node) -> void:
	print("Colision con el ememigo")
	playerDamage()


func hit_checkpoint():
	Global.checkpoint_pos = position.x


func _on_headCollider_body_entered(body: Node) -> void: # señal colission break box.
	print("Colision con el break box")
	if body.has_method("destroy"):
		body.destroy()


func _on_hurtbox_area_entered(_area: Area2D) -> void:
	print("Player colisiono con Seed")
	playerDamage()


func gameOver() -> void:
	if Global.player_health < 1:
		queue_free() # golpe
		Global.is_dead = true
		if get_tree().change_scene("res://Prefabs/GameOver.tscn") != OK:
			print("¡Algo salió mal!")


func playerDamage():
	Global.player_health -= 1
	hurted = true # golpe
	emit_signal("change_life", Global.player_health)
	knockback() # golpe
	get_node("hurtbox/collision").set_deferred("disabled", true) # golpe
	yield(get_tree().create_timer(0.3), "timeout") # golpe # Tiempo de reaccion despues de daño por enemigo
	get_node("hurtbox/collision").set_deferred("disabled", false) # golpe
	hurted = false # golpe
	gameOver()


func _on_Trigger_PlayerEntered() -> void:
	$Camera2D.current = false


func _on_Boss_BossDead() -> void:
	$Camera2D.current = true
