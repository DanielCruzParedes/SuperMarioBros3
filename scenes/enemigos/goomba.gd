extends CharacterBody2D

const SPEED = 30.0
var pegoDerecha=false
var pegoIzquierda=false
var puedoMoverme = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
	
func _physics_process(delta):
	detectar()

	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimationPlayer.play("run")
		move_and_slide()
	if pegoDerecha==false and pegoIzquierda==false:
		velocity.x = SPEED
		$AnimationPlayer.play("run")
		move_and_slide()
	elif pegoDerecha==true:
		velocity.x = -SPEED
		$AnimationPlayer.play("run")
		move_and_slide()
	elif pegoIzquierda==true:
		velocity.x = SPEED
		$AnimationPlayer.play("run")
		move_and_slide()
	
	
func detectar():
	#para que rebote cuando pegue a los costados
		if $derecha.is_colliding():
			pegoDerecha=true
			pegoIzquierda=false
		elif $izquierda.is_colliding():
			pegoIzquierda=true
			pegoDerecha=false
			

func desaparecer():
	$colisionGoomba.disabled = true
	$AnimationPlayer.play("dead")
	
	set_physics_process(false)
	
	await(get_tree().create_timer(0.4).timeout)
	queue_free()
	
