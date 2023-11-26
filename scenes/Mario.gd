extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650
var salto_valido=false;
var colision
var Morir=false
var puedeSonarBrincar = true
var estaSobreTuboEntrable = false
var estaAladoDeTuboEntrable = false

var MarioGrandeInstanciado=false

func _ready():
	Singleton.puedesonartheme=true
	if Singleton.primeraVezApareciendo == false:
		print("deberia de sonar el dano")
		$deGrandeAPeque.play()
		get_tree().get_nodes_in_group("camara")[0].puedo_seguir=true


func _physics_process(delta):
	detectar()
	velocity.y += gravity * delta
	if Morir==false:
		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("izquierda", "derecha")
		#if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"): 
		velocity.x = direction * SPEED
		
		if Input.is_action_just_pressed("abajo") and estaSobreTuboEntrable==true:
			print("intento entrar")
			teletransportarABonus()
			estaSobreTuboEntrable=false
			
		if Input.is_action_just_pressed("derecha") and estaAladoDeTuboEntrable == true:
			print("intenta salir")
			salirDelBonus()
			estaAladoDeTuboEntrable=false
			
	
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
			$brincar.play()
			
			
				
		elif Input.is_action_just_released("saltar") and salto_valido:
			$Animacion.play("jump")
			velocity.y +=175
			salto_valido=false
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		global_position.y-=5
		move_and_slide()
		
	
func detectar():
		if $abajo.is_colliding() or $abajo2.is_colliding():
			if $abajo.is_colliding():
				colision=$abajo.get_collider()
			elif $abajo2.is_colliding():
				colision=$abajo2.get_collider()
			
			if colision!=null:	
				if colision.is_in_group("suelos"):
					salto_valido=true
				else:
					salto_valido=false
				
				if colision.is_in_group("enemigos"):
					position.y -= 20

					colision.desaparecer()
				elif colision.is_in_group("power_Up"):
					if not MarioGrandeInstanciado:
						InstanceGrande()
						MarioGrandeInstanciado = true
						colision.queue_free()
				elif colision.is_in_group("vida"):
					Singleton.vidas+=1
					colision.queue_free()
				elif colision.is_in_group("bloqueM"):
					Muerte()
				
				if colision.is_in_group("tubosentrables"):
					estaSobreTuboEntrable=true
					salto_valido=true
				else:
					estaSobreTuboEntrable=false
					
					
				
		if $arriba.is_colliding() or $arriba2.is_colliding():
			var colision2
			if $arriba.is_colliding():
				colision2=$arriba.get_collider()
			if $arriba2.is_colliding():
				colision2=$arriba2.get_collider()
				
			if colision2!=null:
				if colision2.is_in_group("bloques"):
					colision2.muevete()
				if colision2.is_in_group("aqum_coins"):
					colision2.muevete()
				elif colision2.is_in_group("power_Up"):
					if not MarioGrandeInstanciado:
						InstanceGrande()
						MarioGrandeInstanciado = true
						colision2.queue_free()
				else:
					pass
		
		if $derecha.is_colliding():
			var colision3=$derecha.get_collider()
			if colision3!=null:
				if colision3.is_in_group("enemigos"):
					Muerte()
				elif colision3.is_in_group("power_Up"):
					if not MarioGrandeInstanciado:
						InstanceGrande()
						MarioGrandeInstanciado = true
						colision3.queue_free()
				elif colision3.is_in_group("vida"):
					Singleton.vidas+=1
					colision3.queue_free()
				elif colision3.is_in_group("bandera"):
					colision3.muevete()
				else:
					pass
					
				if colision3.is_in_group("tubossalibles"):
					estaAladoDeTuboEntrable=true
				else:
					estaAladoDeTuboEntrable=false
				
		if $izquierda.is_colliding():
			var colision4=$izquierda.get_collider()
			if colision4!=null:
				if colision4.is_in_group("enemigos"):
					Muerte()
				elif colision4.is_in_group("power_Up"):
					if not MarioGrandeInstanciado:
						InstanceGrande()
						MarioGrandeInstanciado = true
						colision4.queue_free()
				elif colision4.is_in_group("vida"):
					Singleton.vidas+=1
					colision4.queue_free()
				else:
					pass
			
func teletransportarABonus():
	$entraATubo.play()
	get_tree().get_nodes_in_group("mario_peque")[0].global_position = get_tree().get_nodes_in_group("entradabonus")[0].global_position
	get_tree().get_nodes_in_group("camara")[0].enabled = false
	get_tree().get_nodes_in_group("camarabonus")[0].enabled = true

func salirDelBonus():
	$entraATubo.play()
	get_tree().get_nodes_in_group("mario_peque")[0].global_position = get_tree().get_nodes_in_group("salidabonus")[0].global_position
	get_tree().get_nodes_in_group("camarabonus")[0].enabled = false
	get_tree().get_nodes_in_group("camara")[0].enabled = true

func desactivarPhysicsProcesses():
	var goombas = get_tree().get_nodes_in_group("enemigos")
	for goomba in goombas:
		goomba.set_physics_process(false)
	var hongos = get_tree().get_nodes_in_group("power_Up")
	for hongo in hongos:
		hongo.set_physics_process(false)

func Muerte():
	Singleton.puedesonartheme=false
	Morir=true
	get_tree().get_nodes_in_group("camara")[0].puedo_seguir=false
	Singleton.primeraVezApareciendo=true
	$morir.play()
	$Animacion.play("dead")
	$arriba.enabled=false
	$arriba2.enabled=false
	$derecha.enabled=false
	$izquierda.enabled=false
	$abajo.enabled=false
	$abajo2.enabled=false
	desactivarPhysicsProcesses() #para dejar todo quieto
	await(get_tree().create_timer(5).timeout)
	queue_free()
	
	Singleton.Respawn()
	
	#saltar_valido=ha tocado el piso
func InstanceGrande():
	if not MarioGrandeInstanciado: 
		var MarioGrande= load("res://scenes/Marios/mario_grande.tscn")
		var Mario_instance= MarioGrande.instantiate()
		Mario_instance.global_position= global_position
		get_tree().root.add_child(Mario_instance)
		MarioGrandeInstanciado=true
		queue_free()
	

