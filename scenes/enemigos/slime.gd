extends CharacterBody2D

const SPEED = 50.0
var pegoDerecha=false
var pegoIzquierda=false
var puedoMoverme = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_physics_process(false)
	$Sprite2D.flip_h = true
	
func _physics_process(delta):
	detectar()
	position.y -= 7
	
	if not is_on_floor():
		velocity.y += gravity * delta
		move_and_slide()
	if pegoDerecha==false and pegoIzquierda==false:
		velocity.x = -SPEED
		move_and_slide()
	elif pegoDerecha==true:
		$Sprite2D.flip_h = true
		velocity.x = -SPEED
		move_and_slide()
	elif pegoIzquierda==true:
		$Sprite2D.flip_h = false
		velocity.x = SPEED
		move_and_slide()
	$AnimationPlayer.play("idle")
	
	
	
func detectar():
	#para que rebote cuando pegue a los costados
		if $derecha.is_colliding():
			pegoDerecha=true
			pegoIzquierda=false
		elif $izquierda.is_colliding():
			pegoIzquierda=true
			pegoDerecha=false
		elif $abajo.is_colliding() and $abajo.get_collider().is_in_group("bloqueM"):
			$colisionSlime.disabled = true
			$Sprite2D.visible=false

func desaparecer():
	$colisionSlime.disabled = true
	$AnimationPlayer.play("dead")
	#$aplastamiento.play()
	set_physics_process(false)
	
	await(get_tree().create_timer(0.4).timeout)
	queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
