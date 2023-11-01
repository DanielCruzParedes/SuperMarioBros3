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
	else:
		position.y -= 1
		move_and_slide()
		await get_tree().create_timer(0.25).timeout
		puedoMoverme=true
		$colisionHongo.disabled=false
		

func detectar():
		if $derecha.is_colliding():
			pegoDerecha=true
			pegoIzquierda=false
		elif $izquierda.is_colliding():
			pegoIzquierda=true
			pegoDerecha=false
		
