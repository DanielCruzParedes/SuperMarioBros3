extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var salto_valido=false;
var tiempo_salto=0.0

func _physics_process(delta):
	detectar()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		tiempo_salto=0.0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		if Input.is_action_just_pressed("saltar") and salto_valido:
			if tiempo_salto<0.2:
				velocity.y=+JUMP_VELOCITY
				tiempo_salto+=delta
				salto_valido=false
		elif Input.is_action_just_released("saltar") and velocity.y<-150:
			velocity.y +=100
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func detectar():
		if $abajo.is_colliding():
			var colision=$abajo.get_collider()
			if colision.is_in_group("suelos"):
				salto_valido=true
				
	#saltar_valido=ha tocado el suelo
