extends Node3D

#Events
var service_station = preload("res://stations/service_station/ss_scenes/service_station.tscn")
var spawn_pt = preload("res://platforms/platform_normal/plspw/plspw.tscn")
var end_pt = preload("res://platforms/platform_normal/plept/plept.tscn")
var plnv1 = preload("res://platforms/platform_normal/plnv1/plnv1.tscn")
var dfa_in = load("res://mobs/dfa/dfa.tscn")

#Event Control
var enemy_spawn_or_nah = false
@onready var event_pos = $s/events
@onready var enemyspawnpt = $enemyspawnpt

# Declare member variables here. Examples:

var x = true
var y = 0.1
var platform_movement 
# var b = "text"
@onready var c = $s




# Called when the node enters the scene tree for the first time.
func _ready():
	
	#enemy spawn point movement
	$ani.play("spawtptmovement")
	
	
	#Add the spawn tech place thing...
	if AutoLoad.service_station_appear == 0:
		var spt = spawn_pt.instantiate()
		event_pos.add_child(spt)
	
	#Add the service station
	elif AutoLoad.service_station_appear == AutoLoad.service_station_spawn_pt_1 or AutoLoad.service_station_appear == AutoLoad.service_station_spawn_pt_2 or AutoLoad.service_station_appear == AutoLoad.service_station_spawn_pt_3:
		var b = service_station.instantiate()
		event_pos.add_child(b)
	
	elif AutoLoad.service_station_appear == 40:
		var spt = end_pt.instantiate()
		event_pos.add_child(spt)
		
	#Add plnv1
	else:
		var b = plnv1.instantiate()
		event_pos.add_child(b)
	
	platform_movement = round(randf_range(0,2))
	y = randf_range(0.01,0.05)
	
	if platform_movement <= 2:
		position.y = randf_range(-5,5)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	
	
	#Controlling if the platform will move or not
	if platform_movement == 0:
		if x == true:
			c.position.y -= y
			if c.position.y < -5:
				x = false
				
		if x == false:
			c.position.y += y
			if c.position.y > 5:
				x = true

	


func _on_player_detecter_area_entered(area):
	enemy_spawn_or_nah = true


func _on_player_detecter_area_exited(area):
	enemy_spawn_or_nah = false


func _on_timer_timeout():
	
	
	
	#Spawn DFA
	var x = round(randi_range(0,10))
	
	if enemy_spawn_or_nah == true and AutoLoad.global_service_time == false and x == 0:
		
		print("Yes!")
		
		var d = dfa_in.instantiate()
		$enemyspawnpt.add_child(d)
		d.reparent($node)
