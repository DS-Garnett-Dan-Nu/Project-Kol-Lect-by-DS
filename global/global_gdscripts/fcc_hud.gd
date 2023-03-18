extends Control


@onready var SeWe = $SelectedWeapon
@onready var Noti = $Noti




# Called when the node enters the scene tree for the first time.
func _ready():
	Noti.hide()


# Called every frame. 'delta' is the elapsed time sinddce the previous frame.
func _process(delta):
	
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

