extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	#Player Stats
	#FCC
	
	#Reset all the stats of FCC
	for stats in AutoLoad.fcc_stats:
		AutoLoad.fcc_stats[stats] = AutoLoad.fcc_base_stats[stats]
		
	#This is the set the real time health of FCC
	AutoLoad.fcc_stats['realtime_health'] = AutoLoad.fcc_stats['health']
	
	
	
	
#	AutoLoad.fcc_health = AutoLoad.global_player_health + 150.0
#	AutoLoad.fcc_base_speed = AutoLoad.global_player_speed + 150.0
#	AutoLoad.fcc_kollecter_speed = AutoLoad.global_kollecter_speed + 10
#	AutoLoad.fcc_force_repair = false
#
#	AutoLoad.fcc_auto_damage = 150.0
#	AutoLoad.fcc_flak_damage = 50.0
#	AutoLoad.fcc_can_fire = true
#	AutoLoad.fcc_deploy = false
#
#	AutoLoad.fcc_auto_damage_up = 5
#	AutoLoad.fcc_flak_damage_up = 15
#	AutoLoad.fcc_health_up = 20
#	AutoLoad.fcc_base_speed_up = 2
#	AutoLoad.fcc_kollecter_speed_up =1
	

	#Mobs & Spawners
	AutoLoad.diffbar = 0
	AutoLoad.global_mob_dps = 0.0
	AutoLoad.global_mob_health = 0
	AutoLoad.global_mob_speed = 0.0
	AutoLoad.global_mob_spawner_dps = 0.0
	AutoLoad.global_mob_spawner_health = 0
	AutoLoad.final_boss = false
	
	#Did player beat the high score? and reset the score
	if AutoLoad.score > AutoLoad.high_score:
		AutoLoad.high_score = AutoLoad.score
	AutoLoad.score = 0
	
	
	#To the Save and Load Function!
	save_n_load()

	#Others
	AutoLoad.player_is_dead = false
	
	

	
	
	
func save_n_load():
	
	
	#Save Game
	AutoLoad.save_game()
	
	#Load Game
	AutoLoad.load_game()
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
