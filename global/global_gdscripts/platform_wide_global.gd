extends Node3D

#Load da platforms
@onready var spawnert1 = load("res://mobs/spawners/spawnert1/spawnert1.tscn")
@onready var final_boss = load("res://platforms/platform_wide/final_boss/final_boss.tscn")


# Declare member variables here. Examples:

var x = true
var y = 0.1
var platform_movement 
# var b = "text"
@onready var c = $s

# Called when the node enters the scene tree for the first time.
func _ready():

	
	if AutoLoad.service_station_appear == AutoLoad.final_boos_spt:            

		var b = final_boss.instantiate()
		$s.add_child(b)
		
	else:
		var spnt1 = spawnert1.instantiate()
		$s.add_child(spnt1)
		
		pass

#
	platform_movement = round(randf_range(0,2))
	
	if platform_movement <= 2:
		position.y = randf_range(-5,5)
	
	y = randf_range(0.01,0.05)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#Controlling if the platform will move or not
	if platform_movement == 0:
		if x == true:
			c.position.y -= y
			if c.position.y < -2:
				x = false
				
		if x == false:
			c.position.y += y
			if c.position.y > 2:
				x = true
	else:
		pass
	


	
		
