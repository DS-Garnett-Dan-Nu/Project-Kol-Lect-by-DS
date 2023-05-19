extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detection_area_entered(area):
	AutoLoad.global_service_time = true
	AutoLoad.global_service_ing = true
	print(AutoLoad.global_service_time)


func _on_player_detection_area_exited(area):
	AutoLoad.global_service_end = true
	AutoLoad.global_service_ing = false
	print(AutoLoad.global_service_time)
