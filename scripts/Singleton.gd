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


#COSAS DEL BOWSER
var rng = RandomNumberGenerator.new()
var mePegaron = false
var mePegoFuego = false

func timerDePegar():
	mePegoFuego = true
	mePegaron = true
	await(get_tree().create_timer(4).timeout)
	mePegaron = false
	mePegoFuego = true
func generarNumeroAlAzar():
	var numeroAlAzar : int = rng.randf_range(0,130)
	return numeroAlAzar

func accionDeBowser(numeroDeAccion):
	var bowser = get_tree().get_nodes_in_group("bowser")[0]
	if numeroDeAccion==0:
		bowser.saltar()

var fueNivel2=0;
func _ready():
	if ledioplay==true:
		Spawn()

func instancearFuego():
	var fuego = load("res://scenes/enemigos/fuego_bowser.tscn").instantiate()
	add_child(fuego)
	fuego.global_position = get_tree().get_nodes_in_group("spawnDeFuego")[0].global_position

func Spawn():
	print(fueNivel2)
	if ledioplay==true:
		mario = load("res://scenes/Marios/mario_pequeno.tscn")
		var mario_instance = mario.instantiate()
		add_child(mario_instance)
		if fueNivel2==0:
			
			mario_instance.global_position =get_tree().get_nodes_in_group("spawnmario")[0].global_position
		
		elif fueNivel2>0:
			print("si es mayor que 0")
			get_tree().get_nodes_in_group("camara")[0].enabled = false
			get_tree().get_nodes_in_group("camaraNivel2")[0].enabled = true
			mario_instance.global_position= get_tree().get_nodes_in_group("nivel2")[0].global_position
			

func MostrarMensajeMuerte():
	var mensajeMuerteInstance = mensajeMuerteScene.instantiate()
	get_tree().root.add_child(mensajeMuerteInstance)

	
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
			sePuedenEliminarVidas=false
			MostrarMensajeMuerte()
			sePuedenEliminarVidas=false
			
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
	var raycastArriba1 = cosa.get_node("arriba")
	var raycastArriba2 = cosa.get_node("arriba2")
	var raycastDerecha = cosa.get_node("derecha")
	var raycastIzquierda = cosa.get_node("izquierda") 
	var raycastAbajo1 = cosa.get_node("abajo")
	var raycastAbajo2 = cosa.get_node("abajo2")
	if mePegoFuego == false:
		if raycastArriba1:
			if raycastArriba1.is_visible_in_tree():
				raycastArriba1.enabled = false  # Disable the raycast derecha
		if raycastArriba2:
			if raycastArriba2.is_visible_in_tree():
				raycastArriba2.enabled = false  # Disable the raycast derecha
		
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
					
		if raycastArriba1 and raycastArriba2.is_visible_in_tree():
			for goomba in goombas:
				if goomba.is_visible_in_tree():
					raycastArriba1.add_exception(goomba)
			for slime in slimes:
				if slime.is_visible_in_tree():
					raycastArriba2.add_exception(slime)

		
		if raycastAbajo2 and raycastAbajo2.is_visible_in_tree():
			for goomba in goombas:
				if goomba.is_visible_in_tree():
					raycastAbajo2.add_exception(goomba)
			for slime in slimes:
				if slime.is_visible_in_tree():
					raycastAbajo2.add_exception(slime)

func activarRaycasts(cosa):
	if cosa != null and mePegoFuego == false:
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
		mario = get_tree().get_nodes_in_group("mario_peque")[0]
		spr = get_tree().get_nodes_in_group("spritePeque")[0]
	elif esGrande:
		mario = get_tree().get_nodes_in_group("marioGrande")[0]
		spr = get_tree().get_nodes_in_group("spriteGrande")[0]
	elif esGangster:
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
