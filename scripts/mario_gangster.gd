extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650
var salto_valido=false;
var colision
var Morir=false
var MarioPequenoInstanciado=false
var estaSobreTuboEntrable = false
var estaAladoDeTuboEntrable = false
var estaEntradaCastillo=false

var ultimoDisparo = 0
const cooldownDisparo = 0.2

@export var MarioGrande = load("res://scenes/Marios/mario_grande.tscn")
func _ready():
	Singleton.esPeque=false
	Singleton.esGrande=false
	Singleton.esGangster=true
	$mariocreciendo.play()
	print("soy mario gangster")
	
func _physics_process(delta):
	
	detectar()
	# Detectar si colisiono con alguna moneeda
	var areas = $Area2D.get_overlapping_areas()
	for a in areas:
		var area: Area2D = a
		print(area.get_parent().name)
		if (area.get_parent().is_in_group("moneda")):
			$sonidomoneda.play()
			Singleton.monedas += 1
			area.get_parent().queue_free() #Eliminar moneda
		if (area.get_parent().is_in_group("fuegoBowser") and Singleton.mePegaron == false):
			Singleton.timerDePegar()
			InstanceMarioPeque()
			print("me pegaron")
	
	velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("izquierda", "derecha" )
	#if Input.is_action_pressed("derecha") or Input.is_action_pressed("izquierda"): 
	velocity.x = direction * SPEED
	if Input.is_action_pressed("disparar"):
	
		if ultimoDisparo + cooldownDisparo < Time.get_unix_time_from_system():
			# Detectar direccion de bala 1 derecha, -1 izquierda
			var dir = 1 if $SpriteMario.flip_h == false else -1
			print(dir)
			
			# Vector para decirle a la bala donde debe de ir
			var objetivo_bala = Vector2((global_position.x + 20) * dir, global_position.y+1)		
			var bala = preload("res://Bala.tscn").instantiate()
			
			# Crear la posicion inicial de la bala
			
			var pos_inicial = global_position
			pos_inicial.x += (15 * dir)
			
			# Inidicarle a la bala donde debe ir
			bala.set_objective(global_position.direction_to(objetivo_bala))
			
			# Asignar pos donde va a spawnear a bala
			bala.global_position = pos_inicial
			get_parent().add_child(bala)
			#$Animacion.play("disparar")
			print("dispara dispara")
			ultimoDisparo = Time.get_unix_time_from_system()
	
	if Input.is_action_just_pressed("abajo") and estaSobreTuboEntrable==true:
		print("intento entrar")
		teletransportarABonus()
		estaSobreTuboEntrable=false
			
	if Input.is_action_just_pressed("derecha") and estaAladoDeTuboEntrable == true:
		print("intenta salir")
		salirDelBonus()
		estaAladoDeTuboEntrable=false
	
	if Input.is_action_pressed("derecha") and estaEntradaCastillo==true:
			print("intento nivel2")
			teletransportarNivel2()
			Singleton.fueNivel2+=1
			estaEntradaCastillo=false
		
		
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
		$brincargrande.play()
		
		
			
	elif Input.is_action_just_released("saltar") and salto_valido:
		$Animacion.play("jump")
		velocity.y +=175
		salto_valido=false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
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
			elif colision.is_in_group("vida"):
				Singleton.vidas+=1
				colision.queue_free()
				Singleton.sonar1up()
			elif colision.is_in_group("power_Up"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision.queue_free()
			elif colision.is_in_group("pistolapowerup"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision.queue_free()
			elif colision.is_in_group("bloqueM"):
				InstanceMarioPeque()
				
			if colision.is_in_group("tubosentrables"):
				estaSobreTuboEntrable=true
				salto_valido=true
			else:
				estaSobreTuboEntrable=false
		##else:
			##salto_valido=false
					
				
	if $arriba.is_colliding() or $arriba2.is_colliding():
		var colision2
		if $arriba.is_colliding():
			colision2=$arriba.get_collider()
		if $arriba2.is_colliding():
			colision2=$arriba2.get_collider()
				
		if colision2!=null:
			if colision2.is_in_group("oculto"):
					colision2.muevete()
			if colision2.is_in_group("power_up"):
				colision2.muevete()
			elif colision2.is_in_group("bloquePowerUp"):
				colision2.muevete()
			elif colision2.is_in_group("power_Up"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision2.queue_free()
			elif colision2.is_in_group("pistolapowerup"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision2.queue_free()
			elif colision2.is_in_group("vida"):
				Singleton.vidas+=1
				colision2.queue_free()
				Singleton.sonar1up()
			elif colision2.is_in_group("bloques"):
				colision2.Destruir()
			elif colision2.is_in_group("aqum_coins"):
				colision2.muevete()
#			elif colision2.is_in_group("moneda"):
#					colision2.queue_free()
#					Singleton.monedas+=1
#					$sonidomoneda.play()
			elif colision2.is_in_group("enemigos"):
				InstanceMarioPeque()
			else:
				pass
		
	if $derecha.is_colliding():
		var colision3=$derecha.get_collider()
		if colision3!=null:
			if colision3.is_in_group("enemigos"):
				InstanceMarioPeque()
			elif colision3.is_in_group("bandera"):
					$audioBandera.play()
					colision3.muevete()
			elif colision3.is_in_group("pistolapowerup"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision3.queue_free()
			elif colision3.is_in_group("power_Up"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision3.queue_free()
			
			elif colision3.is_in_group("vida"):
				Singleton.vidas+=1
				colision3.queue_free()
				Singleton.sonar1up()
			pass
			
			if colision3.is_in_group("tubossalibles"):
				estaAladoDeTuboEntrable=true
			else:
				estaAladoDeTuboEntrable=false
			
			if colision3.is_in_group("castillo"):
				estaEntradaCastillo=true
			else:
				estaEntradaCastillo=false

	if $izquierda.is_colliding():
		var colision4=$izquierda.get_collider()
		if colision4!=null:
			if colision4.is_in_group("enemigos"):
				InstanceMarioPeque()
			elif colision4.is_in_group("pistolapowerup"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision4.queue_free()
				print(colision4.name)
			elif colision4.is_in_group("power_Up"):
				$sonidomoneda.play()
				Singleton.monedas += 1
				colision4.queue_free()
			elif colision4.is_in_group("vida"):
				Singleton.vidas+=1
				colision4.queue_free()
				Singleton.sonar1up()
			pass
			
				
	#saltar_valido=ha tocado el piso
	
func InstanceMarioPeque():
	Singleton.primeraVezApareciendo=false
	print("se hizo false")
	var InstanceMario  = MarioGrande.instantiate()
	InstanceMario.global_position = global_position
	get_tree().get_nodes_in_group("main")[0].add_child(InstanceMario)
	Singleton.Inmunidad()
	queue_free()
	
func teletransportarNivel2():
	get_tree().get_nodes_in_group("mario")[0].global_position = get_tree().get_nodes_in_group("nivel2")[0].global_position
	get_tree().get_nodes_in_group("camara")[0].enabled = false
	get_tree().get_nodes_in_group("camaraNivel2")[0].enabled = true
	
func teletransportarABonus():
	$entraATubo.play()
	get_tree().get_nodes_in_group("mario")[0].global_position = get_tree().get_nodes_in_group("entradabonus")[0].global_position
	get_tree().get_nodes_in_group("camara")[0].enabled = false
	get_tree().get_nodes_in_group("camarabonus")[0].enabled = true

func salirDelBonus():
	$entraATubo.play()
	get_tree().get_nodes_in_group("mario")[0].global_position = get_tree().get_nodes_in_group("salidabonus")[0].global_position
	get_tree().get_nodes_in_group("camarabonus")[0].enabled = false
	get_tree().get_nodes_in_group("camara")[0].enabled = true


func InstangeGrande():
	pass

func InstanceGangster():
	pass
