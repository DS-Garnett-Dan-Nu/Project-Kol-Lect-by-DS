extends Node3D

#Load the player
@onready var Player = preload("res://global/global_scenes/player_global.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if AutoLoad.in_menu == false:
		var p = Player.instantiate()
		$player_spawn_point.add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
