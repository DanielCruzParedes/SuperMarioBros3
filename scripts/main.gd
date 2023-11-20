extends Node
var mario = load("res://scenes/Marios/mario_pequeno.tscn")
var vidas = 3

func _ready():
	$GUI/vidas.text = str(vidas)
	Spawn()
	

func Spawn():
	var mario_instance = mario.instantiate()
	add_child(mario_instance)
	mario_instance.global_position = $"level-1/spawn".global_position
	
func Respawn():
	vidas -= 1
	if vidas>0:
		Spawn()
	else:
		pass

func _physics_process(_delta):
	$GUI/vidas.text = str(vidas)
	
