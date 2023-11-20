extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650
var salto_valido=false;
var colision
var Morir=false
var MarioPequenoInstanciado=false

@export var MarioPeque = load("res://scenes/Marios/mario_pequeno.tscn")
func _ready():
	print("soy mario grande")
	
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
	elif Input.is_action_pressed("abajo") and salto_valido:
		$Animacion.play("down")
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
		##else:
			##salto_valido=false
					
				
	if $arriba.is_colliding() or $arriba2.is_colliding():
		var colision2
		if $arriba.is_colliding():
			colision2=$arriba.get_collider()
		elif $arriba.is_colliding():
			colision2=$arriba2.get_collider()
				
		if colision2!=null:
			if colision2.is_in_group("bloques"):
				colision2.Destruir()
			else:
				pass
		
	if $derecha.is_colliding():
		var colision2=$derecha.get_collider()
		if colision2!=null:
			if colision2.is_in_group("enemigos"):
				InstanceMarioPeque()
			pass
	if $izquierda.is_colliding():
		var colision2=$izquierda.get_collider()
		if colision2!=null:
			if colision2.is_in_group("enemigos"):
				InstanceMarioPeque()
			pass
			
				
	#saltar_valido=ha tocado el piso
	
func InstanceMarioPeque():
	var InstanceMario  = MarioPeque.instantiate()
	InstanceMario.global_position = global_position
	get_tree().get_nodes_in_group("main")[0].add_child(InstanceMario)
	Singleton.Inmunidad()
	queue_free()
	
	
