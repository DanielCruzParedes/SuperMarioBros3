extends Node

func _ready():
	print("ha cargado el nivel")

func _physics_process(_delta):
	if not $"main theme".playing and Singleton.puedesonartheme:
		$"main theme".play()
	
	if Singleton.puedesonartheme==false:
		$"main theme".stop()
		



