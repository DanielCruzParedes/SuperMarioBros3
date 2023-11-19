extends Node

var mario
var goombas

func _ready():
	pass

func _physics_process(_delta):
	pass

func desactivarRaycasts(cosa):
	var raycastDerecha = cosa.get_node("derecha") # Replace with the actual path of the raycast derecha node
	var raycastIzquierda = cosa.get_node("izquierda") # Replace with the actual path of the raycast izquierda node
	var raycastAbajo1 = cosa.get_node("abajo")
	var raycastAbajo2 = cosa.get_node("abajo2")
	if raycastDerecha:
		if raycastDerecha.is_visible_in_tree():
			raycastDerecha.enabled = false  # Disable the raycast derecha
	
	if raycastIzquierda:
		if raycastIzquierda.is_visible_in_tree():
			raycastIzquierda.enabled = false  # Disable the raycast izquierda
	
	if raycastAbajo1 and raycastAbajo1.is_visible_in_tree():
		for goomba in goombas:
			if goomba.is_visible_in_tree():
				raycastAbajo1.add_exception(goomba)

	
	if raycastAbajo2 and raycastAbajo2.is_visible_in_tree():
		for goomba in goombas:
			if goomba.is_visible_in_tree():
				raycastAbajo2.add_exception(goomba)

func activarRaycasts(cosa):
	var raycastDerecha = cosa.get_node("derecha") # Replace with the actual path of the raycast derecha node
	var raycastIzquierda = cosa.get_node("izquierda") # Replace with the actual path of the raycast izquierda node
	var raycastAbajo1 = cosa.get_node("abajo")
	var raycastAbajo2 = cosa.get_node("abajo2")
	if raycastDerecha:
		if raycastDerecha.is_visible_in_tree():
			raycastDerecha.enabled = true  # Disable the raycast derecha
	
	if raycastIzquierda:
		if raycastIzquierda.is_visible_in_tree():
			raycastIzquierda.enabled = true  # Disable the raycast izquierda
	
	if raycastAbajo1 and raycastAbajo1.is_visible_in_tree():
		for goomba in goombas:
			if goomba.is_visible_in_tree():
				raycastAbajo1.remove_exception(goomba)

	
	if raycastAbajo2 and raycastAbajo2.is_visible_in_tree():
		for goomba in goombas:
			if goomba.is_visible_in_tree():
				raycastAbajo2.remove_exception(goomba)


func Inmunidad():
	mario = get_tree().get_nodes_in_group("mario_peque")[0]
	goombas = get_tree().get_nodes_in_group("enemigos")
	
	#agrega la collision exception a todos los goombas
	for goomba in goombas:
		mario.add_collision_exception_with(goomba)
		
	desactivarRaycasts(mario) 
	await get_tree().create_timer(3).timeout 
	activarRaycasts(mario)
	
	
