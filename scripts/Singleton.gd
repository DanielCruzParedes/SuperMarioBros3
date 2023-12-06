extends Node

var mario = load("res://scenes/Marios/mario_pequeno.tscn")
var hongo = load("res://scenes/Power_Ups/hongo.tscn")

var mensajeMuerteScene = preload("res://scenes/mensaje_dead.tscn")
var goombas
var spr
var sePuedenEliminarVidas = true
var vidas = 5
var monedas = 0
var primeraVezApareciendo = true
var puedesonartheme = false
func _ready():
	Spawn()



func Spawn():
	mario = load("res://scenes/Marios/mario_pequeno.tscn")
	var mario_instance = mario.instantiate()
	add_child(mario_instance)
	
	mario_instance.global_position =get_tree().get_nodes_in_group("spawnmario")[0].global_position

func MostrarMensajeMuerte():
	var mensajeMuerteInstance = mensajeMuerteScene.instantiate()
	get_tree().root.add_child(mensajeMuerteInstance)
	await(get_tree().create_timer(2).timeout)  # Ajusta el tiempo según sea necesario
	mensajeMuerteInstance.queue_free()
	Respawn()  
	
func sonar1up():
	get_tree().get_nodes_in_group("audiovida")[0].play()
	print("sono la vida")

func Respawn():
	if sePuedenEliminarVidas:
		vidas -= 1
		print("vida eliminada")
		sePuedenEliminarVidas = false
		if vidas>0:
			
			Spawn()
			get_tree().reload_current_scene()
			sePuedenEliminarVidas=true
		
		else:
			MostrarMensajeMuerte()
	
	

func _physics_process(_delta):
	get_tree().get_nodes_in_group("vidas")[0].text = str(vidas)
	get_tree().get_nodes_in_group("coins")[0].text = str(monedas)
	if monedas == 100:
		vidas += 1
		monedas = 0

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
	spr = get_tree().get_nodes_in_group("spr")[0]
	#agrega la collision exception a todos los goombas
	for goomba in goombas:
		mario.add_collision_exception_with(goomba)
	desactivarRaycasts(mario)
	EfectoInmunidad()
	await get_tree().create_timer(3).timeout
	activarRaycasts(mario)
	
func EfectoInmunidad():
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,0.5)
	await get_tree().create_timer(0.1).timeout
	spr.modulate = Color(1,1,1,1)
