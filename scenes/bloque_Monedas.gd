extends StaticBody2D
var puede_moverse=true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Coin.visible=false

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
	$Coin.visible=true
	$AnimationPlayer.play("moneda")
	await(get_tree().create_timer(0.3).timeout)
	$Coin.visible=false

func _process(_delta):
	pass
