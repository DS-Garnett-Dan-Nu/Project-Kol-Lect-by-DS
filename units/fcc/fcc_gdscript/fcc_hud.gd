extends Control

#Nodes
@onready var SeWe = $SelectedWeapon
@onready var Noti = $Noti
@onready var EngionT = $Engion
@onready var healthbar = $HealthBar
@onready var deployindie = $DepolyIndicater
@onready var ammonoti = $ammo_noti
@onready var noti_timer = $noti_timer
@onready var diffbar = $diffbar

#Show Controls
@onready var controls = $Controls
@onready var ctrl = false
@onready var ctrl_btn = $Controls/ctrl

#Stats
@onready var btn_sfx = $fcc_ss_hud/ss_hud_fcc/btn_sfx
@onready var stats_btn = $showstats
@onready var stats = $Stats
@onready var audam = $Stats/audam
@onready var fkdam = $Stats/fkdam
@onready var maxhealth = $Stats/health
@onready var maxspeed = $Stats/speed
@onready var kollector_speed = $Stats/kollectorspeed
var stats_control = false

#Info hud
@onready var ab = $infohud/ab
@onready var fb = $infohud/fb
@onready var dp = $infohud/dp
@onready var fw = $infohud/fw
@onready var bw = $infohud/bw
@onready var fr = $infohud/fr
@onready var grup = $infohud/grup
@onready var grdw = $infohud/grdw
@onready var fire = $infohud/fire

#FCC Service Station HUD
@onready var fcc_ss_hud = $fcc_ss_hud
#text = "Score: %s" % score


# Called when the node enters the scene tree for the first time.
func _ready():
	Noti.hide()
	deployindie.hide()
	EngionT.text = "Engion: %s" % AutoLoad.global_engion
	


# Called every frame. 'delta' is the elapsed time sinddce the previous frame.
func _process(delta):
	
	#for score
	$hi_score.text = "High Score: %s" % AutoLoad.high_score
	$score.text = "Score: %s" % AutoLoad.score
	
	#For info hud
	infohud(AutoLoad.primary_weapon,ab)
	infohud(AutoLoad.secondary_weapon,fb)
	infohud(AutoLoad.fcc_stats['deploy'],dp)
	infohud(AutoLoad.fcc_stats['force_repair'],fr)
	
	if Input.is_action_pressed("Go_Right"):
		infohud(true,fw)
	else:
		infohud(false,fw)
	
	if Input.is_action_pressed("Go_Left"):
		infohud(true,bw)
	else:
		infohud(false,bw)
		
	if Input.is_action_pressed("GE_Up"):
		infohud(true,grup)
	else:
		infohud(false,grup)
		
	if Input.is_action_pressed("GE_Down"):
		infohud(true,grdw)
	else:
		infohud(false,grdw)
	
	if Input.is_action_pressed("Fire"):
		infohud(true,fire)
	else:
		infohud(false,fire)
	
	
	if $flakreload.value == 100:
		$flakreload.modulate = Color("4bffff")
	else:
		$flakreload.modulate = Color("ffffff")
		
	diffbar.value = AutoLoad.diffbar
	
	
	#Show Service Station Upgrades for FCC
	if AutoLoad.global_service_time and fcc_ss_hud.position.x > 1136:
		fcc_ss_hud.position.x -= 5
	elif AutoLoad.global_service_time == false and fcc_ss_hud.position.x < 1344:
		fcc_ss_hud.position.x += 5
		
	
	#Input stats' data
	audam.text = "Current: %s\nNext: %s" % [AutoLoad.fcc_stats['auto_damage'],AutoLoad.fcc_stats['auto_damage_up']+AutoLoad.fcc_stats['auto_damage']]
	fkdam.text = "Current: %s\nNext: %s" % [AutoLoad.fcc_stats['flak_damage'],AutoLoad.fcc_stats['flak_damage_up']+AutoLoad.fcc_stats['flak_damage']]
	maxhealth.text = "Current: %s\nNext: %s" % [AutoLoad.fcc_stats['health'],AutoLoad.fcc_stats['health_up']+AutoLoad.fcc_stats['health']]
	maxspeed.text = "Current: %s\nNext: %s" % [AutoLoad.fcc_stats['speed'],AutoLoad.fcc_stats['speed_up']+AutoLoad.fcc_stats['speed']]
	kollector_speed.text = "Current: %s\nNext: %s" % [AutoLoad.fcc_stats['k_speed'],AutoLoad.fcc_stats['k_speed_up']+AutoLoad.fcc_stats['k_speed']]
	
	#Show Controls
	if ctrl and controls.position.y < 281:
		controls.position.y += 5
	elif ctrl == false and controls.position.y > -1:
		controls.position.y -= 5
		
	#show controls by holding by Left Control
	if Input.is_action_just_pressed("show_ctrls"):
		ctrl_btn.set_deferred("button_pressed",true)
	elif Input.is_action_just_released("show_ctrls"):
		ctrl_btn.set_deferred("button_pressed",false)
	
	
	
	
	#Show Stats
	if stats_control and stats.position.y > 504:
		stats.position.y -= 5
	elif stats_control == false and stats.position.y < 640:
		stats.position.y += 5
	
	#show stats by holding by left shift
	if Input.is_action_just_pressed("show_stats"):
		stats_btn.set_deferred("button_pressed",true)
	elif Input.is_action_just_released("show_stats"):
		stats_btn.set_deferred("button_pressed",false)
		
	
	
	if AutoLoad.global_engion <= 0 and Input.is_action_pressed("Fire"):
		ammonoti.text = "<= Out of Engion"
	else:
		ammonoti.text = ""
	
	#For deploy indicator
	if AutoLoad.fcc_stats['deploy']:
		deployindie.show()
	else:
		deployindie.hide()
	
	#For Health Bar
	healthbar.max_value = AutoLoad.fcc_stats['health']
	healthbar.value = AutoLoad.fcc_stats['healthbar']
	
	if healthbar.value <= 100 and healthbar.value > 75:
		healthbar.modulate =  Color("2bff00")
	if healthbar.value <= 75 and healthbar.value > 50:
		healthbar.modulate =  Color("c4ff00")
	if healthbar.value <= 50 and healthbar.value > 25:
		healthbar.modulate =  Color("ffc400")
	if healthbar.value <= 25 and healthbar.value > 0:
		healthbar.modulate =  Color("ff0000")
	
	#Show the Enigon count
	EngionT.text = "Engion: %s g" % AutoLoad.global_engion
	
	#Gun Controls n Stuffs
	var fcc_can_fire = AutoLoad.fcc_stats['can_fire']
	var fcc_primary_weapon = AutoLoad.primary_weapon
	var fcc_secondary_weapon = AutoLoad.secondary_weapon
	
	if fcc_can_fire or AutoLoad.primary_weapon:
		Noti.hide()

	elif fcc_can_fire == false and Input.is_action_just_pressed("Fire") and AutoLoad.primary_weapon == false:
		Noti.show()
		noti_timer.start()
		
		

	if fcc_primary_weapon:
		SeWe.text = "1"
	
	if fcc_secondary_weapon:
		SeWe.text = "2"


func _on_showstats_toggled(button_pressed):
	if button_pressed:
		stats_control = true
	else:
		stats_control = false
		
func infohud(condition,type):
	
	if condition == true:
		type.modulate = Color("ffffff")
	elif condition == false:
		type.modulate = Color("555555")






func _on_noti_timer_timeout():
	Noti.hide()


func _on_ctrl_toggled(button_pressed):
	if button_pressed:
		ctrl = true
	else:
		ctrl = false
