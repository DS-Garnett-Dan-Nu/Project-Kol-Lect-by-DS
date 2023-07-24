extends ColorRect


#Load da Scenes!
var mainmenu = load("res://misc/mainmenu/mainmenu.tscn")



#nodes
@onready var exit_btn = $exit
@onready var sure = $sure

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hide()



func _on_exit_pressed():
	
	
	
	get_tree().paused = false
	hide()
	AutoLoad.player_is_dead = false
	AutoLoad.in_menu = true
	AutoLoad.final_boss = false
	AutoLoad.service_station_appear = 0
	
	
	get_tree().change_scene_to_packed(mainmenu)
	
func _process(delta):
	
	if AutoLoad.player_is_dead:
		show()
		get_tree().paused = true
	else:
		hide()

	
	#Show Engion in Storage and High Score 
	$hi_score.text = "High Score: %s" % AutoLoad.high_score
	$score.text = "Score: %s" % AutoLoad.score
	$e_store.text = " Engion: %sg" % AutoLoad.global_engion
	
