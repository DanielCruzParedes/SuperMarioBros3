extends Node



func _physics_process(_delta):
	if not $"main theme".playing and Singleton.puedesonartheme:
		$"main theme".play()
	
	if Singleton.puedesonartheme==false:
		$"main theme".stop()
		



