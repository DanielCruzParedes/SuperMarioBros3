extends Node2D
var nivel1 = load("res://scenes/level1-1.tscn")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	Singleton.ledioplay=true
	Singleton.Spawn()
	get_tree().change_scene_to_file("res://scenes/level1-1.tscn")
	

func _on_quit_pressed():
	get_tree().quit()
