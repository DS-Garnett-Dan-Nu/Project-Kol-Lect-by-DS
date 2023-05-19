extends Node

#Global Misc
#Global Gravity
var global_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")*3

#Platform Generation Control
var platform_normal = true
var platform_wide = false

#Global Weapon Selection
var primary_weapon = true
var secondary_weapon = false

#Global Player Stats #For Global Upgrades
var global_player_health = 0.0
var global_player_speed = 0.0
var global_player_jump_velocity = 0.0

#Global Mob Stats #For Global Difficulty
var global_mob_health = 0.0
var global_mob_speed = 0.0
var global_mob_dps = 0.0

#Global Mob Spawner Stats #For Global Difficulty
var global_mob_spawner_health = 0.0
var global_mob_spawner_dps = 0.0

#Global Service Time!
var global_service_time = false
var global_service_end = false
var global_service_ing = false

#Global Resources in Storage
var global_engion = 0.0
###########

#FCC - First Controlable Character #For Character Specific Upgrades
#FCC Stats
var fcc_health = global_player_health + 150.0
var fcc_base_speed = global_player_speed + 50.0
var fcc_jump_velocity = global_player_jump_velocity + 17.0
var fcc_healthbar

#FCC gun control
var fcc_auto_damage = 15.0
var fcc_flak_damage = 50.0
var fcc_can_fire = true
var fcc_deploy = false
############

#Mobs aka Enemies
#EHD Stats #For Enemy Specific Difficulty
var ehd_dps = global_mob_dps + 1.0
var ehd_health = global_mob_health + 100.0
var ehd_speed = global_mob_speed + 10.0

#Mobs aka Enemy Spawners
#Spawner T1
var spwnt1_health = global_mob_spawner_health + 500.0
var spwnt1_dps = global_mob_spawner_dps + 15.0

#Mob Controls
var player_location = Vector3()
############

#Stations
#service station
var service_station_spawn_pt_1 = 10
var service_station_appear = 0

#Local Misc
#Print Control
var to_print
############

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("primary_weapon"):
		primary_weapon = true
		secondary_weapon = false
		
	
	if Input.is_action_just_pressed("secondary_weapon"):
		primary_weapon = false
		secondary_weapon = true
		
