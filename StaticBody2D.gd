extends StaticBody2D
var puede_moverse=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func muevete():
	if not puede_moverse:
		bandera()

func bandera():
	$AnimationPlayer.play("bandera")
	await(get_tree().create_timer(0.8).timeout)
	puede_moverse = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
