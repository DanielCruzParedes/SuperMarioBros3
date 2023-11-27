extends CharacterBody2D

var pegoDerecha=false
var pegoIzquierda=false
var puedoMoverme = false

# Get the gravity from the project settings to be synced with RigidBody nodes.

var monedaAgarrada=false
func muevete():
	pass

func _physics_process(delta):
	if monedaAgarrada:
		if $izquierda.is_colliding() and $izquierda.get_collider().is_in_group("mario"):
			colision_con_mario($izquierda.get_collider())
			monedaAgarrada=true
		elif $derecha.is_colliding() and $derecha.get_collider().is_in_group("mario"):
			colision_con_mario($derecha.get_collider())
			monedaAgarrada=true
		elif $arriba.is_colliding() and $arriba.get_collider().is_in_group("mario"):
			colision_con_mario($arriba.get_collider())
			monedaAgarrada=true
		elif $abajo.is_colliding() and $abajo.get_collider().is_in_group("mario"):
			colision_con_mario($abajo.get_collider())
			monedaAgarrada=true
		##Cuando me tiro encima del hongo no desaparece de todas las otas formas si el mario 
		#for i in get_slide_collision_count():
		#	var obj_colisionado=get_slide_collision(i).get_collider()
		#	if(obj_colisionado.is_in_group("mario")):
		#		print("salto mario en mi")
		#		desaparece()
		
		



	
func colision_con_mario(colision_mario):
	if not colision_mario.is_queued_for_deletion() and colision_mario.is_in_group("mario"):
		queue_free()
		Singleton.monedas+=1

