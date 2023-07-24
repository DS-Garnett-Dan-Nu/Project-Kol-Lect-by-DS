extends Node3D


#nodes
@onready var cam_control = $camcontrol
@onready var workshop = $menu_hud

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Reset the world 
	#I can't put this in the resent and save function 
	#because if i do, the depoly function doesn't work anymore for some reason...
	AutoLoad.service_station_appear = 0
	
	#In menu signal
	AutoLoad.in_menu = true
	
	#Hide the menu hud
	workshop.hide()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Disable the upgrade buttons of Engion in storage goes less then 50
	if AutoLoad.global_engion <= 50 or AutoLoad.global_engion < AutoLoad.global_player_stats['health_up']:
		$menu_hud/Global_Upgrades/hp.set_deferred("disabled",true)
	else:
		$menu_hud/Global_Upgrades/hp.set_deferred("disabled",false)
	
	if AutoLoad.global_engion <= 50 or AutoLoad.global_engion < AutoLoad.global_player_stats['speed_up']:
		$menu_hud/Global_Upgrades/sp.set_deferred("disabled",true)
	else:
		$menu_hud/Global_Upgrades/sp.set_deferred("disabled",false)
		
	if AutoLoad.global_engion <= 50 or AutoLoad.global_engion < AutoLoad.global_player_stats['k_speed_up']:
		$menu_hud/Global_Upgrades/ksp.set_deferred("disabled",true)
	else:
		$menu_hud/Global_Upgrades/ksp.set_deferred("disabled",false)
	
	
	#You go me right round baby right round... 
	cam_control.rotation_degrees.y += 0.1
	
	
	#engion count
	$menu_hud/engion.text = "Engion: %sg" % round(AutoLoad.global_engion)
	
	#show the global cost
	global_upgrades_info()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://test/test_scenes/test_world.tscn")
	

func global_upgrades_info():
	
	
	
	
	
	#Btn Cost
	$menu_hud/Global_Upgrades/hp.text = "-%sg" % round(AutoLoad.global_player_stats['health_up'])
	$menu_hud/Global_Upgrades/sp.text = "-%sg" % round(AutoLoad.global_player_stats['speed_up'])
	$menu_hud/Global_Upgrades/ksp.text = "-%sg" % round(AutoLoad.global_player_stats['k_speed_up'])
	
	#Health Cost
	$menu_hud/Global_Upgrades/hpa.text = "Current: %s" % AutoLoad.global_player_stats['health']
	$menu_hud/Global_Upgrades/hpb.text = "Next: %s" % [AutoLoad.global_player_stats['health'] + round(AutoLoad.global_player_stats['health_up']/3)]
	
	#Health Cost
	$menu_hud/Global_Upgrades/spa.text = "Current: %s" % AutoLoad.global_player_stats['speed']
	$menu_hud/Global_Upgrades/spb.text = "Next: %s" % [AutoLoad.global_player_stats['speed'] + 1]
	
	#Health Cost
	$menu_hud/Global_Upgrades/kspa.text = "Current: %s" % AutoLoad.global_player_stats['k_speed']
	$menu_hud/Global_Upgrades/kspb.text = "Next: %s" % [AutoLoad.global_player_stats['k_speed'] + 1]

func _on_hp_pressed():
	AutoLoad.global_player_stats['health'] += round(AutoLoad.global_player_stats['health_up']/3)
	AutoLoad.global_engion -= AutoLoad.global_player_stats['health_up']
	AutoLoad.global_player_stats['health_up'] += (AutoLoad.global_player_stats['health'] * 1.4) + 15


func _on_sp_pressed():
	AutoLoad.global_player_stats['speed'] += 1
	AutoLoad.global_engion -= AutoLoad.global_player_stats['speed_up']
	AutoLoad.global_player_stats['speed_up'] += (AutoLoad.global_player_stats['speed'] * 1.5) + 40


func _on_ksp_pressed():
	AutoLoad.global_player_stats['k_speed'] += 1
	AutoLoad.global_engion -= AutoLoad.global_player_stats['k_speed_up']
	AutoLoad.global_player_stats['k_speed_up'] += (AutoLoad.global_player_stats['k_speed'] * 1.1) + 35











func _on_workshop_btn_toggled(button_pressed):
	if button_pressed:
		workshop.show()
	else:
		workshop.hide()


func _on_quit_pressed():
	get_tree().quit()
