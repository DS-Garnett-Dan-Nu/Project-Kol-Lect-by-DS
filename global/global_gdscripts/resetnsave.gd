extends Node3D

#nodes
@onready var difficulty = $difficulty

#Variables
var enemy_stats_additions = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	#Player Stats
	#FCC
	
	#Reset all the stats of FCC
	for stats in AutoLoad.fcc_stats:
		AutoLoad.fcc_stats[stats] = AutoLoad.fcc_base_stats[stats]
		
	#This is the set the real time health of FCC
	AutoLoad.fcc_stats['realtime_health'] = AutoLoad.fcc_stats['health']
	
	####################################################################

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
	
	
	
	
	#Set the increasing difficulty according to the highscore
	difficulty.stop() #Stop the timer
	if AutoLoad.high_score >= 19990: #Timier's wait time cannot be zero
		difficulty.wait_time = 0.055
	else:
		difficulty.wait_time = 1 - AutoLoad.high_score/20000 #Calculate the difficulty level
	enemy_stats_additions += AutoLoad.high_score/10000
	if AutoLoad.in_menu == false : difficulty.start() #Start the timer
	
	
	
	
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


func _on_difficulty_timeout():
	
	AutoLoad.diffbar += 0.1
	AutoLoad.global_mob_dps += enemy_stats_additions/10 - enemy_stats_additions/80
	AutoLoad.global_mob_health += enemy_stats_additions*0.2
	AutoLoad.global_mob_speed += enemy_stats_additions/10
	AutoLoad.global_mob_spawner_dps += enemy_stats_additions/10 - enemy_stats_additions/80
	
	if AutoLoad.diffbar == 100:
		AutoLoad.player_is_dead = true
