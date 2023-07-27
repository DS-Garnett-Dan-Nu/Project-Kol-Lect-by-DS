extends Node

#Global Misc
#Is player death
var player_is_dead = false

#Score
var high_score = 0
var score = 0

#Global Gravity
var global_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")*3

#Platform Generation Control
var platform_normal = true
var platform_wide = false

#Global Weapon Selection
var primary_weapon = true
var secondary_weapon = false

#Global Player Stats #For Global Upgrades
var global_player_stats = {
	
	#Stats
	health = 0,
	speed = 0,
	k_speed = 0,
	
	#Upgrades
	health_up = 10,
	speed_up = 25,
	k_speed_up = 20
	
	
}

#Global Mob Stats #For Global Difficulty
var global_mob_health = 0.0
var global_mob_speed = 0.0
var global_mob_dps = 0.0

#Global Mob Spawner Stats #For Global Difficulty
var global_mob_spawner_health = 0.0
var global_mob_spawner_dps = 0.0

#Global Increasing Difficulty
var global_difficulty = 1

#Global Service Time!
var global_service_time = false

#Global Resources in Storage
var global_engion = 100
var out_of_engion = false

#Mainmenu Scene
var in_menu = true

#Global_Difficulty
var diffbar = 0

#Final Boss Time!
var final_boss = false
var final_boos_spt = 39
###########

#FCC - First Controlable Character #For Character Specific Upgrades

#FCC Base Stats
var fcc_base_stats

#FCC Dynamic Stats
var fcc_stats

############

#Mobs aka Enemies
#EHD Stats #For Enemy Specific Difficulty
var ehd_dps = global_mob_dps + 1.0
var ehd_health = global_mob_health + 100.0
var ehd_speed = global_mob_speed + 10.0

#DFA Stats #For Enemy Specific Difficulty
var dfa_damage = global_mob_dps + 30
var dfa_health = global_mob_health + 50
var dfa_speed = global_mob_speed + 20

#Mobs aka Enemy Spawners
#Spawner T1
var spwnt1_health = global_mob_spawner_health + 500.0
var spwnt1_dps = global_mob_spawner_dps + 7.5

#Mob Controls
var player_location = Vector3()
var kollector_location = Vector3()
############

#Stations
#service station
var service_station_spawn_pt_1 = 10
var service_station_spawn_pt_2 = 20
var service_station_spawn_pt_3 = 30
var service_station_appear = 0

#Local Misc
#Print Control
var to_print
############

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Check if the file already exits to prevent overiting
	if FileAccess.file_exists("user://SaveFiles.txt"):
		load_game()
	else:
		
		#Create a file in disk
		var file_save = FileAccess.open("user://SaveFiles.txt", FileAccess.WRITE)
	#############################################################################
	
	
	#Set FCC's Stats
	set_fcc_stats()
	
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#For Increasing Difficulty
	ehd_dps = global_mob_dps + 1.0
	ehd_health = global_mob_health + 100.0
	ehd_speed = global_mob_speed + 10.0
	
	dfa_damage = global_mob_dps + 30
	dfa_health = global_mob_health + 50
	dfa_speed = global_mob_speed + 20
	
	spwnt1_dps = global_mob_spawner_dps + 7.5
	
	
	
	#Global Key Catching
	
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
		service_station_appear = 0
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("primary_weapon"):
		primary_weapon = true
		secondary_weapon = false
		
	
	if Input.is_action_just_pressed("secondary_weapon"):
		primary_weapon = false
		secondary_weapon = true
		

func load_game():
	#This was a pian in the ass to make... 
	var temp_saves = []
	
	#Load to game file
	var file_load = FileAccess.open("user://SaveFiles.txt", FileAccess.READ)
	file_load.get_as_text(true)
	while not file_load.eof_reached():
		var line = file_load.get_line().to_int()
		temp_saves.append(line)
		
	#print(temp_saves)
	
	#To prevent null index error
	if temp_saves.size() == 9:
		global_engion = temp_saves[0]
		global_player_stats['health'] = temp_saves[1]
		global_player_stats['speed'] = temp_saves[2]
		global_player_stats['k_speed'] = temp_saves[3]
		high_score = temp_saves[4]
		global_player_stats['health_up'] = temp_saves[5]
		global_player_stats['speed_up'] = temp_saves[6]
		global_player_stats['k_speed_up'] = temp_saves[7]

	temp_saves.clear()

func save_game():
	
	#Save Method: Engion , Health , Speed , K-speed, Hi-score, global health up, global speed up, global k-speed up
	var values_to_save = [
		global_engion,
		global_player_stats['health'],
		global_player_stats['speed'],
		global_player_stats['k_speed'],
		high_score,
		global_player_stats['health_up'],
		global_player_stats['speed_up'],
		global_player_stats['k_speed_up']
		]
		
	
	
	#Save to disk
	var file_save = FileAccess.open("user://SaveFiles.txt", FileAccess.WRITE)
	for i in values_to_save:
		file_save.store_string("%s\n" % i)
		
		
		

func set_fcc_stats():
	
	fcc_base_stats = {
	
	#Defensive
	health = global_player_stats['health'] + 150.0, #health
	speed = global_player_stats['speed'] + 15.0, #speed
	k_speed = global_player_stats['k_speed'] + 10, #Kollector collection Speed
	
	#Offensive
	auto_damage = 15.0, #Maak damage
	flak_damage = 50.0, #HMC damage
	can_fire = true, #if FCC can fire condition
	deploy = false, #if FCC is deploy or not condition
	force_repair = false, #Ability Force Repair
	
	#Upgrades
	auto_damage_up = 5, #Maak upgrade damage
	flak_damage_up = 15, #HMC upgrade damage
	health_up = 20, #health upgrade damage
	speed_up = 2, #speed upgrade damage
	k_speed_up = 1, #kollecter collection upgrade damage
	
	#HUD
	realtime_health = 0
	
	}
	
	fcc_stats = fcc_base_stats.duplicate(true)
	
	#To set the healthbar of fcc
	fcc_stats['realtime_health'] = fcc_stats['health']
	
	
