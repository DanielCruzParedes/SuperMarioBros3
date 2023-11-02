extends CharacterBody2D

const SPEED = 30.0
var pegoDerecha=false
var pegoIzquierda=false
var puedoMoverme = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if puedoMoverme == true:
		detectar()
		##Cuando el goomba me toca no desaparezco pero si mario lo toca si 
		for i in get_slide_collision_count():
			var obj_colisionado=get_slide_collision(i).get_collider()
			if(obj_colisionado.is_in_group("mario")):
				obj_colisionado.Muerte()
			

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
	else:
		position.y -= 1
		move_and_slide()
		await get_tree().create_timer(0.25).timeout
		puedoMoverme=true
		$colisionGoomba.disabled=false
	
	
	
func detectar():
		if $derecha.is_colliding():
			pegoDerecha=true
			pegoIzquierda=false
		elif $izquierda.is_colliding():
			pegoIzquierda=true
			pegoDerecha=false
