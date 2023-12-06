extends StaticBody2D
var hongo_instanciado = false
var puede_moverse=true
var one_way_collision_shape

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	one_way_collision_shape = $CollisionShape2D

func muevete():
	if puede_moverse:
		puede_moverse=false
		$activado.visible = false
		one_way_collision_shape.one_way_collision = false 
		await(get_tree().create_timer(0.12).timeout)
		position.y += 3
		$desactivado.visible=true
		one_way_collision_shape.one_way_collision = false  # Desactiva la colisión one-way
		#instanciar()

	
func Destruir():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
