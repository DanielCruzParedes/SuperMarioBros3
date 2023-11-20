extends StaticBody2D
var puede_moverse=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible=false

func muevete():
	if puede_moverse:
		monedas()
		puede_moverse=false
		position.y-=3
		$activado.visible=false
		await(get_tree().create_timer(0.12).timeout)
		position.y+=3

func Destruir():
	muevete()
	
func monedas():
	$Label.visible=true
	$AnimationPlayer.play("moneda")
	await(get_tree().create_timer(0.5).timeout)
	$Label.visible=false

func _process(_delta):
	pass
