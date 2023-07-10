extends ColorRect


#Load da Scenes!
var mainmenu = load("res://misc/mainmenu/mainmenu.tscn")

#Misc Vars
var is_paused = false : set = set_is_paused

#Variables
var exist = false

#nodes
@onready var exit_btn = $exit
@onready var sure = $sure

# Called when the node enters the scene tree for the first time.
func _ready():
	
	visible = false
	exist = false

func _unhandled_input(event):
	if event.is_action_pressed("pause") and AutoLoad.player_is_dead == false:
		is_paused = !is_paused
		exist = false


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_resume_pressed():
	is_paused = false
	visible = false


func _on_exit_pressed():
	
	if exist == true:
		is_paused = false
		AutoLoad.in_menu = true
		AutoLoad.service_station_appear = 0
		get_tree().change_scene_to_packed(mainmenu)
	exist = true
	
func _process(delta):
	
	#Are you sure?
	if exist:
		sure.show()
		exit_btn.text = "Confirm Evacuation"
	else:
		sure.hide()
		exit_btn.text = "Exit The VOID"
	
	#Show Engion in Storage and High Score 
	$hi_score.text = "High Score: %s" % AutoLoad.high_score
	$score.text = "Score: %s" % AutoLoad.score
	$e_store.text = " Engion: %sg" % AutoLoad.global_engion
	
