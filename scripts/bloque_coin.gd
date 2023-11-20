extends StaticBody2D

var bloque_destruir = load("res://scenes/bloques/destruccion_bloque.tscn")

var contador=0
var moneda_mostrada = false

func _ready():
	$Label.visible=false
	
func muevete():
	contador += 1	
	if contador <=28:
		position.y-=3
		await(get_tree().create_timer(0.12).timeout)
		position.y+=3
		$AnimationPlayer.play("moneda")
		moneda_mostrada=true
		
	else:
		$Sprite2D.visible=false
		$desactivado.visible=true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

