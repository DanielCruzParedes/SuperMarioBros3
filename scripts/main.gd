extends Node

func _ready():
	Singleton.startTimer()
	
	print("ha cargado el nivel")
	if Singleton.fueNivel2==0:
		get_tree().get_nodes_in_group("camara")[0].enabled = true
		get_tree().get_nodes_in_group("camaraNivel2")[0].enabled = false
		
		
	else:
		$"level-1/level template/nive1_ pedacito2".visible=false
		$"level-1/Castillo template/castillo_pedacito".visible=true
		get_tree().get_nodes_in_group("camara")[0].enabled = false
		get_tree().get_nodes_in_group("camaraNivel2")[0].enabled = true
		Singleton.puedesonartheme = false
		Singleton.puedesonarthemcastillo = true
		
	if Singleton.vidas==0:
		$"GUI/texto vidas".visible=false
		$GUI/num_monedas.visible=false
		$GUI/vidas.visible=false
		




	


func _physics_process(_delta):

	if Singleton.fueNivel2 != 0:
		Singleton.puedesonartheme = false
		Singleton.puedesonarthemcastillo = true
	
	if not $"main theme".playing and Singleton.puedesonartheme:
		$"main theme".play()
	
	if Singleton.puedesonartheme==false:
		$"main theme".stop()
	
	if not $themeSegundoNivel.playing and Singleton.puedesonarthemcastillo and Singleton.fueNivel2 != 0:
		$themeSegundoNivel.play()
		$"main theme".stop()
		
	if Singleton.puedesonarthemcastillo == false:
		$themeSegundoNivel.stop()
		
	
	
	


