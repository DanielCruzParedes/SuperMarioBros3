extends Camera2D

var player
var puedo_seguir=true
func _ready():
	update_player_reference()
	
func update_player_reference():
	var mario_nodes= get_tree().get_nodes_in_group("mario")
	if mario_nodes:
		player= mario_nodes[0]
	else:
		player= null
		
func _physics_process(_delta):
	update_player_reference()
	if puedo_seguir and player:
		if(player.global_position.x > global_position.x):
			global_position.x = player.global_position.x
		
		if(player.global_position.x < global_position.x):
			global_position.x = player.global_position.x

