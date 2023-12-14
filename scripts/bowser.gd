extends CharacterBody2D

var vida = 30
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
	# que se baje la vida al disparar
	var areas = $Area2D.get_overlapping_areas()
	for a in areas:
		var area: Area2D = a
		print("area que le entra al bowser: ")
		print(area.get_parent().name)
		if (area.get_parent().is_in_group("bala")):
			vida -= 1
			print(vida)
			if vida == 0:
				desaparecer()
	#para que rebote cuando pegue a los costados
	if $derecha.is_colliding():
		pegoDerecha=true
		pegoIzquierda=false
	elif $izquierda.is_colliding():
		pegoIzquierda=true
		pegoDerecha=false
	elif $abajo.is_colliding() and $abajo.get_collider().is_in_group("bloqueM"):
		$colisionBowser.disabled = true
		$Sprite2D.visible=false

func desaparecer():
	$colisionBowser.disabled = true
#	$AnimationPlayer.play("dead")
	#$aplastamiento.play()
	set_physics_process(false)
#	$aplastamiento.play()
	await(get_tree().create_timer(0.4).timeout)
	queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)
