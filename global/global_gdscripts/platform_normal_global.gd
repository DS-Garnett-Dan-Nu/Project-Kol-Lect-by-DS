extends Node3D

#Events
var service_station = preload("res://stations/service_station/ss_scenes/service_station.tscn")

#Event Control
@onready var event_pos = $s/events

# Declare member variables here. Examples:
var x = true
var y = 0.1
var platform_movement 
# var b = "text"
@onready var c = $s

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Add the service station
	if AutoLoad.service_station_appear == AutoLoad.service_station_spawn_pt_1:
		var b = service_station.instantiate()
		event_pos.add_child(b)
	
	platform_movement = round(randf_range(0,1))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#Controlling if the platform will move or not
	if platform_movement < 1:
		if x == true:
			c.position.y -= y
			if c.position.y < -2:
				x = false
				y = randf_range(0.01,0.05)
		if x == false:
			c.position.y += y
			if c.position.y > 2:
				x = true
				y = randf_range(0.01,0.05)
	else:
		pass
	
