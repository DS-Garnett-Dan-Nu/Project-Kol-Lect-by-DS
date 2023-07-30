extends Node3D


#Load da resources
@onready var engion = preload("res://resources/engion/engion_scene.tscn")
@onready var resource_spwnpt = $spawnpt
var max_resource = 50

#Load the t1 mob senes
var ehd_v1 = preload("res://mobs/ehd/ehd_scenes/ehd_scene.tscn")

#Spawning Controls
var door_open = false
var detector = true
@onready var spwn_intrvl = $spawn_interval
@onready var door_timer = $door_timer

#Spawn Points
@onready var spn_pt = $body
@onready var node = get_node("../node")

#Animation
@onready var ani = $AniT1

#Stats
var health = AutoLoad.spwnt1_health
var dps = AutoLoad.spwnt1_dps
var died = true

#Defence and its controls
var inrange = false
@onready var gun = $gun
@onready var muzzle = $gun/muzzle
var bullet = load("res://mobs/spawners/spawnert1/spwnt_1_bullet.tscn")

#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	#Die!
	if health <= 0 and died:
		
		died = false
		
		#Score Time!
		AutoLoad.score += round((randi_range(20,30)))
		
		#add explosion
		var ex = basic_explosion.instantiate()
		$Door.add_child(ex)
		ex.scale = Vector3(1,1,1)
		ex.reparent(node)
		
		queue_free()
	
	#Gun Look at player
	#gun.look_at(AutoLoad.player_location)
	#muzzle.look_at(AutoLoad.player_location)



func _on_player_detecter_area_entered(area):
	#Triggers when player enters the detect zone
	if detector:
		inrange = true #Short range fire mechanism activate!
		detector = false #Disable the dectector to prevent repeated triggers
		spwn_intrvl.start() #Time to spawn mobs! 
		#print("area")
		
func _on_spawn_interval_timeout():
	
	#More and more difficult over time
	health += AutoLoad.global_difficulty+2
	
	door_open = false #<-- "External Control"
	ani.play("open_door") #play the open door animation
	#print("spn tm out")
	
	
	
	
func _on_open_door_animation_finished(open_door): #This specifying animation doesn't work, so I had to add an external control
	# triggers when the open door animation has finished and door is closed
	if door_open == false:
		var e = ehd_v1.instantiate()
		spn_pt.global_transform.basis.get_euler()
		spn_pt.add_child(e)
		e.reparent(node)
		door_timer.start()
		#print("open_door tm out")
	pass

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
	
	#Engion Drop Chance
	var x = round(randf_range(0,1))
	
	
	if area is autocannon:
		health -= AutoLoad.fcc_stats['auto_damage']
		
		#Drop style
		if x == 0 and max_resource > 0:
			drop_engion(round(AutoLoad.fcc_stats['auto_damage']/3))
			max_resource -= round(AutoLoad.fcc_stats['auto_damage']/3)
			
		
	if area is flak_cannon:
		health -= AutoLoad.fcc_stats['flak_damage']
		
		#Drop style Single
		if x == 0 and max_resource > 0:
			drop_engion(round(AutoLoad.fcc_stats['flak_damage']/6))
			max_resource -= round(AutoLoad.fcc_stats['flak_damage']/6)
			
		#Drop style Triple
		elif x == 1 and max_resource > 0:
			drop_engion(round(AutoLoad.fcc_stats['flak_damage']/5))
			max_resource -= round(AutoLoad.fcc_stats['flak_damage']/5)

func drop_engion(range):
	for i in range(range):
		var engionC1 = engion.instantiate()
		resource_spwnpt.add_child(engionC1)
		engionC1.reparent(node)#Reparenting makes the child node independent from spawnert1
		


func _on_fire_timer_timeout():
	
	#Randomize to shoot or not
	var shootorNo = round(randi_range(0,5))
	
	
	#Fire Control
	if shootorNo < 2:
		var b = bullet.instantiate()
		#muzzle.global_transform.basis.get_euler()
		muzzle.add_child(b)
		
		if inrange:
			b.player_is_far = 0.3
		
		b.reparent(node)
