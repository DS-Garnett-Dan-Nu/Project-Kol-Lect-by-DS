extends Node3D
class_name spnr

#Load the t1 mob senes
var ehd_v1 = preload("res://mobs/ehd/ehd_scenes/ehd_scene.tscn")

#Spawning Controls
var door_open = false
var detector = true
@onready var spwn_intrvl = $spawn_interval
@onready var door_timer = $door_timer

#Spawn Point
@onready var spn_pt = $body

#Animation
@onready var ani = $AniT1

#Stats
var health = AutoLoad.spwnt1_health
var dps = AutoLoad.spwnt1_dps

#Defence
@onready var gun = $gun
@onready var muzzle = $gun/muzzle
var bullet = preload("res://mobs/spawners/spawnert1/spwnt_1_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Die!
	if health <= 0:
		queue_free()
	
	gun.look_at(AutoLoad.player_location)
	muzzle.look_at(AutoLoad.player_location)



func _on_player_detecter_area_entered(area):
	#Triggers when player enters the detect zone
	if detector:
		
		detector = false #Disable the dectector to prevent repeated triggers
		spwn_intrvl.start() #Time to spawn mobs! 
		#print("area")
		
func _on_spawn_interval_timeout():
	door_open = false #<-- "External Control"
	ani.play("open_door") #play the open door animation
	#print("spn tm out")
	
	#Fire Control
	var b = bullet.instantiate()
	muzzle.global_transform.basis.get_euler()
	muzzle.add_child(b)
	
	
func _on_open_door_animation_finished(open_door): #This specifying animation doesn't work, so I had to add an external control
	# triggers when the open door animation has finished and door is closed
	if door_open == false:
		var e = ehd_v1.instantiate()
		spn_pt.global_transform.basis.get_euler()
		spn_pt.add_child(e)
		door_timer.start()
		#print("open_door tm out")

func _on_door_timer_timeout():
	door_open = true #<-- "External Control"
	ani.play("close_door") #play the close door animation
	#print("door_timer tm out")
	
func _on_close_door_animation_finished(close_door): #This specifying animation doesn't work, so I had to add an external control
	if door_open and spwn_intrvl.is_stopped() == true: #if door is open, play close door animation and restart the timer
		
		spwn_intrvl.start()
		if spwn_intrvl.wait_time > 1:
			spwn_intrvl.wait_time -= 0.1
		
		
		
		#print("close_door tm out")
		#And the cycle continues





func _on_hurt_box_area_entered(area):
	if area is autocannon:
		health -= AutoLoad.fcc_auto_damage
	if area is flak_cannon:
		health -= AutoLoad.fcc_flak_damage
