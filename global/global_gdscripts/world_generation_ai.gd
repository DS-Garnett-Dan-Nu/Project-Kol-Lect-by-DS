extends Node3D

#Platforms
var platform_normal = preload("res://global/global_scenes/platform_normal_global.tscn")
var platform_wide = preload("res://global/global_scenes/platform_wide_global.tscn")

#Platforms' Intervals
var N_N = 75
var N_W = 107
var W_N = 107
var W_W = 139
var global_interval = 0

#Platforms' Controls
var platform_type_old = 0 # 0 = platform)normal // 1 = platform_wide
var platform_type_new 
var platform_length = 0
var max_platform_length = 11
@onready var placer = $Placer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Pre place the normal one for spawning
	var P_T = platform_normal.instantiate()
	P_T.position.x = placer.global_position.x
	add_child(P_T)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#For service station event
	if AutoLoad.service_station_appear == AutoLoad.service_station_spawn_pt_1:
		AutoLoad.platform_normal = true
		AutoLoad.platform_wide = false
		
	
		
	#Control the Amount of platform to spawn
	if platform_length <= max_platform_length:
		
		
		
		
		
		
		
		#To spawn the platform normal
		if AutoLoad.platform_normal:
			time_to_create_platform(platform_normal, 0)
			print(AutoLoad.service_station_appear)
			
		#To spawn the platform wide
		elif AutoLoad.platform_wide:
			time_to_create_platform(platform_wide, 1)
		



func time_to_create_platform(platform_type, platform_type_no):
	
	#Platform Interval Calculation
	platform_type_new = platform_type_no
	var platform_interval = platform_interval_calculator()
	platform_type_old = platform_type_new
	
	#Adding the interval value to the into global interval, then into Placer
	global_interval += platform_interval
	placer.global_position.x = global_interval
	
	#Add the platform at the position of Placer
	var P_T = platform_type.instantiate()
	P_T.position.x = placer.global_position.x
	add_child(P_T)
	
	#Increment the numer of platform
	platform_length += 1
	
	#For service station event
	AutoLoad.service_station_appear += 1
	
	#Randomize the platform to be spawned: Current 2:1
	var r = round(randf_range(0,2))
	if r <= 1:
		AutoLoad.platform_normal = true
		AutoLoad.platform_wide = false
	elif r == 2:
		AutoLoad.platform_normal = false
		AutoLoad.platform_wide = true


func platform_interval_calculator():
	
	#Calculate the platform interval
	if platform_type_old == 0 and platform_type_new == 0:
		return N_N
	elif platform_type_old == 0 and platform_type_new == 1:
		return N_W
	elif platform_type_old == 1 and platform_type_new == 0:
		return W_N
	elif platform_type_old == 1 and platform_type_new == 1:
		return W_W





