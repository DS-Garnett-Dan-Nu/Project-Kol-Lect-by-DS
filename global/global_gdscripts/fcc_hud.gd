extends Control

#Nodes
@onready var SeWe = $SelectedWeapon
@onready var Noti = $Noti
@onready var EngionT = $Engion
@onready var healthbar = $HealthBar
@onready var deployindie = $DepolyIndicater


#text = "Score: %s" % score


# Called when the node enters the scene tree for the first time.
func _ready():
	Noti.hide()
	deployindie.hide()
	EngionT.text = "Engion: %s" % AutoLoad.global_engion
	


# Called every frame. 'delta' is the elapsed time sinddce the previous frame.
func _process(delta):
	
	#For deploy indicator
	if AutoLoad.fcc_deploy:
		deployindie.show()
	else:
		deployindie.hide()
	
	#For Health Bar
	healthbar.max_value = AutoLoad.fcc_health
	healthbar.value = AutoLoad.fcc_healthbar
	
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
	var fcc_can_fire = AutoLoad.fcc_can_fire
	var fcc_primary_weapon = AutoLoad.primary_weapon
	var fcc_secondary_weapon = AutoLoad.secondary_weapon

	if fcc_can_fire:
		Noti.hide()

	if fcc_can_fire == false:
		Noti.show()

	if fcc_primary_weapon:
		SeWe.text = "1"
	
	if fcc_secondary_weapon:
		SeWe.text = "2"
