extends StaticBody2D
var hongo_instanciado = false
var puede_moverse=true
var one_way_collision_shape

# Called when the node enters the scene tree for the first time.
func _ready():
	$hongoV.set_physics_process(false)
	$hongoV.visible = false
	pass # Replace with function body.
	one_way_collision_shape = $CollisionShape2D

func muevete():
	if puede_moverse:
		$aparecevida.play()
		puede_moverse=false
		position.y -= 3
		$activado.visible = false
		one_way_collision_shape.one_way_collision = false 
		await(get_tree().create_timer(0.12).timeout)
		position.y += 3
		$hongoV.set_physics_process(true)
		$hongoV.visible = true
		$desactivado.visible=true
		one_way_collision_shape.one_way_collision = false  # Desactiva la colisión one-way
		#instanciar()

func instanciar():
	if not hongo_instanciado:
		var hongo= preload("res://scenes/Power_Ups/hongo_v.tscn")
		var hongo_instance=hongo.instantiate()
		hongo_instance.global_position= $spawn_hongo.global_position
		get_tree().root.add_child(hongo_instance)
		hongo_instanciado = true
	
	
func Destruir():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
