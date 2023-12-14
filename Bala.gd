extends RigidBody2D

class_name Bala

var SPEED = 1000
var objective: Vector2 = Vector2(-1000, -1000)


func set_objective(_obj: Vector2):
	objective = _obj
	
func _ready():
	SPEED = 800
	var marioGangster = get_tree().get_nodes_in_group("mariogangster")[0]
	#get_tree().get_nodes_in_group("bala")[0].add_exception(marioGangster)
	
	
func _physics_process(delta):
	detectar()
	if objective == Vector2(-1000, -1000):
		return
	
	var velocity = (objective + objective) * SPEED
	move_and_collide(velocity * delta);

func detectar():
	if $derecha.is_colliding():
		var colisionDerecha = $derecha.get_collider()
		if colisionDerecha.is_in_group("enemigos") and not colisionDerecha.is_in_group("bowser"):
			print("pego derecha")
			colisionDerecha.queue_free()
			queue_free()
		else:
			queue_free()
			
	if $arriba.is_colliding():
		var colisionArriba = $arriba.get_collider()
		if colisionArriba.is_in_group("enemigos") and not colisionArriba.is_in_group("bowser"):
			print("pego derecha")
			colisionArriba.queue_free()
			queue_free()
		else:
			queue_free()
	
	if $izquierda.is_colliding():
		var colisionIzquierda = $izquierda.get_collider()
		if colisionIzquierda.is_in_group("enemigos") and not colisionIzquierda.is_in_group("bowser"):
			colisionIzquierda.queue_free()
			print("pego izquierda")
			queue_free()
		else:
			queue_free()
	
	if $abajo.is_colliding():
		var colisionAbajo = $abajo.get_collider()
		if colisionAbajo.is_in_group("enemigos") and not colisionAbajo.is_in_group("bowser"):
			colisionAbajo.queue_free()
			print("pego abajo")
			queue_free()
		else:
			queue_free()
	
