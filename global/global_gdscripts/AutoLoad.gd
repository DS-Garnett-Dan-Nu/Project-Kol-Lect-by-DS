extends Node

#Platform Generation Control
var platform_normal = true
var platform_wide = false

#Global Weapon Selection
var primary_weapon = true
var secondary_weapon = false

#FCC gun control
var fcc_can_fire = true






# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("primary_weapon"):
		primary_weapon = true
		secondary_weapon = false
	
	if Input.is_action_just_pressed("secondary_weapon"):
		primary_weapon = false
		secondary_weapon = true
