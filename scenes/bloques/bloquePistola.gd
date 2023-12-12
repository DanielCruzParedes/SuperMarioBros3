extends StaticBody2D
var pistola_instanciada = false
var puede_moverse=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$pistola.set_physics_process(false)
	$pistola.visible = false
	pass # Replace with function body.
func muevete():
	if puede_moverse:
		$aparecepowerup.play()
		puede_moverse=false
		position.y-=3
		$activado.visible=false
		await(get_tree().create_timer(0.12).timeout)
		position.y+=3
		$pistola.set_physics_process(true)
		$pistola.visible = true
		
		#instanciar()

func instanciar():
	if not pistola_instanciada:
		var pistola= preload("res://scenes/Power_Ups/pistola.tscn")
		var pistola_instance=pistola.instantiate()
		pistola_instance.global_position= $spawn_pistola.global_position
		get_tree().root.add_child(pistola_instance)
		pistola_instanciada = true
	
	
func Destruir():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
