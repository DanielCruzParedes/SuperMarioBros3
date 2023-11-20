extends StaticBody2D
var puede_moverse=true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func muevete():
	if puede_moverse:
		puede_moverse=false
		position.y-=3
		$activado.visible=false
		await(get_tree().create_timer(0.12).timeout)
		position.y+=3

func Destruir():
	muevete()

func _process(_delta):
	pass
