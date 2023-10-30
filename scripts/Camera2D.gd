extends Camera2D

var player

func _ready():
	player = get_tree().get_nodes_in_group("mario")[0]

func _physics_process(delta):
	if(player.global_position.x > global_position.x):
		global_position.x = player.global_position.x
	
	if(player.global_position.x < global_position.x):
		global_position.x = player.global_position.x


