extends CharacterBody2D


const SPEED = 50.0
var puedoMoverme = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func muevete():
	pass

func _physics_process(_delta):
	if puedoMoverme == true:
		detectar()
		if $izquierda.is_colliding() and $izquierda.get_collider().is_in_group("mario"):
			colision_con_mario($izquierda.get_collider())
		if $derecha.is_colliding() and $derecha.get_collider().is_in_group("mario"):
			colision_con_mario($derecha.get_collider())
		if $arriba.is_colliding() and $arriba.get_collider().is_in_group("mario"):
			colision_con_mario($arriba.get_collider())
		if $abajo.is_colliding() and $abajo.get_collider().is_in_group("mario"):
			colision_con_mario($abajo.get_collider())
		
	else:
		position.y -= 0.5
		move_and_slide()
		await get_tree().create_timer(0.25).timeout
		puedoMoverme=true
		$colisionPistola.disabled=false
		


func detectar():
	pass
			
func desaparece():
	$colisionHongo.queue_free()
	queue_free()
	
	
func colision_con_mario(colision_mario):
	if not colision_mario.is_queued_for_deletion() and colision_mario.is_in_group("mario"):
		colision_mario.InstanceGangster()
		colision_mario.MarioGangsterInstanciado = true
		queue_free()
		
