extends CharacterBody2D

func _ready():
	pass

func _physics_process(delta):
	$AnimationPlayer.play("fuego")
	position.x -= 1
	move_and_slide()
	timerParaDesaparecer()


func timerParaDesaparecer():
	await(get_tree().create_timer(2).timeout)
	queue_free()
func detectar():
	pass
#	if $derecha.is_colliding():
#		var colisionDerecha = $derecha.get_collider()
#		if colisionDerecha.is_in_group("mariogangster"):
#			print("pego derecha")
#			colisionDerecha.InstanceMarioPeque()
#		elif colisionDerecha.is_in_group("marioGrande"):
#			print("pego derecha")
#			colisionDerecha.InstanceMarioPeque()
#			queue_free()
#
#	if $arriba.is_colliding():
#		var colisionArriba = $arriba.get_collider()
#		if colisionArriba.is_in_group("enemigos"):
#			print("pego derecha")
#			colisionArriba.queue_free()
#			queue_free()
#		else:
#			queue_free()
#
#	if $izquierda.is_colliding():
#		var colisionIzquierda = $izquierda.get_collider()
#		if colisionIzquierda.is_in_group("enemigos"):
#			colisionIzquierda.queue_free()
#			print("pego izquierda")
#			queue_free()
#		else:
#			queue_free()
#
#	if $abajo.is_colliding():
#		var colisionIzquierda = $abajo.get_collider()
#		if colisionIzquierda.is_in_group("enemigos"):
#			colisionIzquierda.queue_free()
#			print("pego abajo")
#			queue_free()
