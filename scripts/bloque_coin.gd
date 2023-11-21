extends StaticBody2D

var bloque_destruir = load("res://scenes/bloques/destruccion_bloque.tscn")
var puedeSacarMoneda = true
var contador=0
var moneda_mostrada = false

func _ready():
	$coin.visible=false
	
func muevete():
	
	if contador <10 :
		if puedeSacarMoneda==true:
			contador += 1
			puedeSacarMoneda=false
		
			position.y-=3
			await(get_tree().create_timer(0.12).timeout)
			position.y+=3
			$AnimationPlayer.play("moneda")
			moneda_mostrada=true
			print(contador)
			await(get_tree().create_timer(0.3).timeout)
			puedeSacarMoneda = true
		else: pass
		
	else:
		$Sprite2D.visible=false
		$desactivado.visible=true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

