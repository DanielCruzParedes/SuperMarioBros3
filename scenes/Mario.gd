extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650
var salto_valido=false;
var tiempo_salto=0.0
var colision



func _physics_process(delta):
	detectar()
	
	velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("izquierda", "derecha")
	#if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"): 
	velocity.x = direction * SPEED
	
	if Input.is_action_pressed("derecha"):
		
		$SpriteMario.flip_h = false
		if is_on_floor():
			$Animacion.play("run")
			
	elif Input.is_action_pressed("izquierda"):
		
		$SpriteMario.flip_h = true
		if is_on_floor():
			$Animacion.play("run")
	else:
		if salto_valido:
			$Animacion.play("idle")
	
	if Input.is_action_pressed("speed") and Input.is_action_pressed("derecha") and salto_valido:
		velocity.x = SPEED+75
		$Animacion.speed_scale = 2
	elif Input.is_action_pressed("speed") and Input.is_action_pressed("izquierda") and salto_valido:
		velocity.x = (SPEED*-1)-75
		$Animacion.speed_scale = 2
	else:
		$Animacion.speed_scale = 1
	move_and_slide()
	
	if Input.is_key_pressed(KEY_Z) and not is_on_floor():
		$Animacion.play("jump")
		
		
	if Input.is_action_just_pressed("saltar") and salto_valido:
		$Animacion.play("jump")
		velocity.y=+JUMP_VELOCITY
		salto_valido=false
		
		
			
	elif Input.is_action_just_released("saltar") and salto_valido:
		$Animacion.play("jump")
		velocity.y +=175
		salto_valido=false
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#for i in get_slide_collision_count():
	#	var obj_colisionado=get_slide_collision(i).get_collider()
		#if(obj_colisionado.is_in_group("power_Up")):
		#	obj_colisionado.queue_free()
	#	if obj_colisionado.is_in_group("enemigos"):
	#		print("go0ombaaaa")
	#		Muerte()
	
	
func detectar():
		
		if $abajo.is_colliding():
			colision=$abajo.get_collider()
			
			if colision!=null:	
				if colision.is_in_group("suelos"):
					salto_valido=true
				else:
					salto_valido=false
				
			
				
		if $arriba.is_colliding():
			var colision2=$arriba.get_collider()
			if colision2!=null:
				if colision2.is_in_group("bloques"):
					colision2.muevete()
				else:
					pass
		
		if $derecha.is_colliding():
			var colision2=$derecha.get_collider()
			if colision2!=null:
				if colision2.is_in_group("enemigos"):
					Muerte()
				else:
					pass
		if $izquierda.is_colliding():
			var colision2=$izquierda.get_collider()
			if colision2!=null:
				if colision2.is_in_group("enemigos"):
					Muerte()
				else:
					pass
			
			
func Muerte():
	get_tree().get_nodes_in_group("camara")[0].puedo_seguir=false
	queue_free()
	
	#saltar_valido=ha tocado el piso
	
