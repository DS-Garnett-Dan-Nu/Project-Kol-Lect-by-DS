extends Node3D

#nodes
@onready var sure = $sure
@onready var btn = $button

#Variables
var exist = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sure.hide()
	btn.hide()
	btn.text = "Exist The VOID"
	exist = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_end_area_entered(area):
	btn.show()


func _on_end_area_exited(area):
	sure.hide()
	btn.hide()
	btn.text = "Exist The VOID"
	exist = false


func _on_button_pressed():
	sure.show()
	btn.text = "Confirm Evacuation"
	if exist:
		get_tree().change_scene_to_file("res://misc/thank_you_demo/thank_you.tscn")
		AutoLoad.in_menu = true
		AutoLoad.service_station_appear = 0
	exist = true
	
	


