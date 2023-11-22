extends StaticBody2D
var hongo_instanciado = false
var puede_moverse=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$hongo.set_physics_process(false)
	$hongo.visible = false
	pass # Replace with function body.
func muevete():
	if puede_moverse:
		$aparecepowerup.play()
		puede_moverse=false
		position.y-=3
		$activado.visible=false
		await(get_tree().create_timer(0.12).timeout)
		position.y+=3
		$hongo.set_physics_process(true)
		$hongo.visible = true
		
		#instanciar()

func instanciar():
	if not hongo_instanciado:
		var hongo= preload("res://scenes/Power_Ups/hongo.tscn")
		var hongo_instance=hongo.instantiate()
		hongo_instance.global_position= $spawn_hongo.global_position
		get_tree().root.add_child(hongo_instance)
		hongo_instanciado = true
	
	
func Destruir():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
