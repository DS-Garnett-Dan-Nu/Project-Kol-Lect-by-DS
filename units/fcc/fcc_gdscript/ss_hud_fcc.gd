extends Control


#Nodes
@onready var pridam = $pridamage
@onready var secdam = $secdamage
@onready var maxhealth = $maxhealth
@onready var maxspeed = $maxspeed
@onready var kollectorspeed = $kollectorspeed
@onready var btn_sfx = $btn_sfx

#controls
var pridamcost = 5
var secdamcost = 15
var maxhealthcost = 10
var maxspeedcost = 20
var kollectorcost = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# to umm... you know what this is...
	pridam.text = "-%s g" % pridamcost
	secdam.text = "-%s g" % secdamcost
	maxhealth.text = "-%s g" % maxhealthcost
	maxspeed.text = "-%s g" % maxspeedcost
	kollectorspeed.text = "-%s g" % kollectorcost
	
	#Upgrade Conditions
	upgrade_condition(pridamcost,pridam)
	upgrade_condition(secdamcost,secdam)
	upgrade_condition(maxhealthcost,maxhealth)
	upgrade_condition(maxspeedcost,maxspeed)
	upgrade_condition(kollectorcost,kollectorspeed)
	
	
	
	
func upgrade_condition(cost,btn):
	if cost > AutoLoad.global_engion:
		btn.set_deferred("disabled",true)
	else:
		btn.set_deferred("disabled",false)


func _on_pridamage_pressed():
	pridamcost = upgrade_time(pridamcost,pridam,1)
	



func _on_secdamage_pressed():
	secdamcost = upgrade_time(secdamcost,secdam,2)


func _on_maxhealth_pressed():
	maxhealthcost = upgrade_time(maxhealthcost,maxhealth,3)


func _on_maxspeed_pressed():
	maxspeedcost = upgrade_time(maxspeedcost,maxspeed,4)

func _on_ks_pressed():
	kollectorcost = upgrade_time(kollectorcost,kollectorspeed,5)
	
func upgrade_time(cost,btn,stat):
	
	#Reduce the Engion
	AutoLoad.global_engion -= cost
	cost += cost
	
	#Checking Which to Upgrade
	if stat == 1:
		AutoLoad.fcc_auto_damage += AutoLoad.fcc_auto_damage_up
		AutoLoad.fcc_auto_damage_up += 2
	elif stat == 2:
		AutoLoad.fcc_flak_damage += AutoLoad.fcc_flak_damage_up
		AutoLoad.fcc_flak_damage_up += 4
	elif stat == 3:
		AutoLoad.fcc_health += AutoLoad.fcc_health_up
		AutoLoad.fcc_health_up += 10
	elif stat == 4:
		AutoLoad.fcc_base_speed += 2
		AutoLoad.fcc_base_speed_up += 1
	elif stat == 5:
		AutoLoad.fcc_kollecter_speed += 1
		AutoLoad.fcc_kollecter_speed_up += 1
	
	#SFX
	btn_sfx.play(0.1)
	
	
	return cost
	
	



