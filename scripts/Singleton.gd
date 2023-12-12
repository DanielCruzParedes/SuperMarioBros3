extends Node

var mario = load("res://scenes/Marios/mario_pequeno.tscn")
var hongo = load("res://scenes/Power_Ups/hongo.tscn")

var estaEnInmunidad = false

var mensajeMuerteScene = preload("res://scenes/mensaje_dead.tscn")
var goombas
var slimes
var spr
var sePuedenEliminarVidas = true
var vidas = 5
var monedas = 0
var primeraVezApareciendo = true
var puedesonartheme = false
var ledioplay = false
var conteoMenu=0

var esPeque = false
var esGrande = false
var esGangster = false


var fueNivel2=0;
func _ready():
	if ledioplay==true:
		Spawn()



func Spawn():
	if ledioplay==true:
		print("spawnea")
		mario = load("res://scenes/Marios/mario_pequeno.tscn")
		var mario_instance = mario.instantiate()
		add_child(mario_instance)
		if fueNivel2==0:
			mario_instance.global_position =get_tree().get_nodes_in_group("spawnmario")[0].global_position
		elif fueNivel2>0:
			mario_instance.global_position= get_tree().get_nodes_in_group("nivel2")[0].global_position

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
			
			
			sePuedenEliminarVidas=true
		
		else:
			MostrarMensajeMuerte()
	Spawn()
	get_tree().reload_current_scene()
	

func _physics_process(_delta):
	var vidas_nodes = get_tree().get_nodes_in_group("vidas")
	var coins_nodes = get_tree().get_nodes_in_group("coins")
	if vidas_nodes.size() > 0:
		vidas_nodes[0].text = str(vidas)
	if coins_nodes.size() > 0:
		coins_nodes[0].text = str(monedas)
	if monedas == 100:
		vidas += 1
		monedas = 0

func desactivarRaycasts(cosa):
	print(cosa)
	var raycastDerecha = cosa.get_node("derecha")
	var raycastIzquierda = cosa.get_node("izquierda") 
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
		for slime in slimes:
			if slime.is_visible_in_tree():
				raycastAbajo1.add_exception(slime)

	
	if raycastAbajo2 and raycastAbajo2.is_visible_in_tree():
		for goomba in goombas:
			if goomba.is_visible_in_tree():
				raycastAbajo2.add_exception(goomba)
		for slime in slimes:
			if slime.is_visible_in_tree():
				raycastAbajo2.add_exception(slime)

func activarRaycasts(cosa):
	if cosa != null:
		if not cosa.is_queued_for_deletion():
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
				for slime in slimes:
					if slime.is_visible_in_tree():
						raycastAbajo1.remove_exception(slime)

			
			if raycastAbajo2 and raycastAbajo2.is_visible_in_tree():
				for goomba in goombas:
					if goomba.is_visible_in_tree():
						raycastAbajo2.remove_exception(goomba)
					for slime in slimes:
						if slime.is_visible_in_tree():
							raycastAbajo2.remove_exception(slime)


func Inmunidad():
	print("se hizo inmune")
	estaEnInmunidad = true
	if esPeque:
		print("es peque inmune")
		mario = get_tree().get_nodes_in_group("mario_peque")[0]
		spr = get_tree().get_nodes_in_group("spritePeque")[0]
	elif esGrande:
		print("es grande inmune")
		mario = get_tree().get_nodes_in_group("marioGrande")[0]
		spr = get_tree().get_nodes_in_group("spriteGrande")[0]
	elif esGangster:
		print("es gangster inmune")
		mario = get_tree().get_nodes_in_group("mariogangster")[0]
		spr = get_tree().get_nodes_in_group("spriteGangster")[0]
		
	goombas = get_tree().get_nodes_in_group("enemigos")
	slimes = get_tree().get_nodes_in_group("slimes")
	
	#agrega la collision exception a todos los goombas
	for slime in slimes:
		mario.add_collision_exception_with(slime)
	for goomba in goombas:
		mario.add_collision_exception_with(goomba)
	desactivarRaycasts(mario)
	EfectoInmunidad()
	await get_tree().create_timer(3).timeout
	activarRaycasts(mario)
	estaEnInmunidad = false
	
func EfectoInmunidad():
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.1).timeout
	if estaEnInmunidad:
		spr.modulate = Color(1,1,1,0.5)
		await get_tree().create_timer(0.1).timeout
		spr.modulate = Color(1,1,1,1)
	
	if estaEnInmunidad == false:
		spr.modulate = Color(1,1,1,1)
