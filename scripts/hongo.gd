extends CharacterBody2D


const SPEED = 50.0
var pegoDerecha=false
var pegoIzquierda=false
var puedoMoverme = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func muevete():
	pass

func _physics_process(delta):
	if puedoMoverme == true:
		detectar()
		##Cuando me tiro encima del hongo no desaparece de todas las otas formas si el mario 
		#for i in get_slide_collision_count():
		#	var obj_colisionado=get_slide_collision(i).get_collider()
		#	if(obj_colisionado.is_in_group("mario")):
		#		print("salto mario en mi")
		#		desaparece()
			
		if not is_on_floor():
			velocity.y += gravity * delta
			move_and_slide()
		if pegoDerecha==false and pegoIzquierda==false:
			velocity.x = SPEED
			move_and_slide()
		elif pegoDerecha==true:
			velocity.x = -SPEED
			move_and_slide()
		elif pegoIzquierda==true:
			velocity.x = SPEED
			move_and_slide()
		if $izquierda.is_colliding() and $izquierda.get_collider().is_in_group("mario"):
			colision_con_mario($izquierda.get_collider())
		if $derecha.is_colliding() and $derecha.get_collider().is_in_group("mario"):
			colision_con_mario($derecha.get_collider())
		if $arriba.is_colliding() and $arriba.get_collider().is_in_group("mario"):
			colision_con_mario($arriba.get_collider())
		if $abajo.is_colliding() and $abajo.get_collider().is_in_group("mario"):
			colision_con_mario($abajo.get_collider())
		
	else:
		position.y -= 1
		move_and_slide()
		await get_tree().create_timer(0.25).timeout
		puedoMoverme=true
		$colisionHongo.disabled=false
		


func detectar():
	
	#para que rebote cuando pegue a los costados
		if $derecha.is_colliding():
			pegoDerecha=true
			pegoIzquierda=false
		elif $izquierda.is_colliding():
			pegoIzquierda=true
			pegoDerecha=false
			
func desaparece():
	$colisionHongo.queue_free()
	queue_free()
	
	
func colision_con_mario(colision_mario):
	if not colision_mario.is_queued_for_deletion() and colision_mario.is_in_group("mario"):
		colision_mario.InstanceGrande()
		colision_mario.MarioGrandeInstanciado = true
		queue_free()
		
