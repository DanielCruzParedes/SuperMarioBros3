extends StaticBody2D

var bloque_destruir = load("res://scenes/bloques/destruccion_bloque.tscn")

func _ready():
	pass
	
func muevete():
	position.y-=3
	await(get_tree().create_timer(0.12).timeout)
	position.y+=3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func Destruir():
	var bloque_instance = bloque_destruir.instantiate()
	bloque_instance.position = global_position
	
	get_tree().get_nodes_in_group("main")[0].add_child(bloque_instance)
	queue_free()
