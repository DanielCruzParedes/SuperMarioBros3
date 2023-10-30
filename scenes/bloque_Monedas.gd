extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func muevete():
	position.y-=3
	$activado.visible=false
	await(get_tree().create_timer(0.12).timeout)
	position.y+=3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
