extends Spatial


# Declare member variables here. Examples:
# var a = 2
onready var gun_control = $"fcc/Upper Base/Duel EFC 100g and others/Null2/Gun"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _physics_process(delta):
	
	#Gun Elevations
	if Input.is_action_pressed("GE_Up") and gun_control.rotation_degrees.z < 210 and gun_control.rotation_degrees.z > -30:
		gun_control.rotation_degrees.z += 1
	if Input.is_action_pressed("GE_Down") and gun_control.rotation_degrees.z < 210 and gun_control.rotation_degrees.z > -30:
		gun_control.rotation_degrees.z -= 1
	
	#Gun Elevations Control cuz godot's physics_process always overshot the degress and gets stuck :3
	if Input.is_action_pressed("GE_Up") and gun_control.rotation_degrees.z > 208:
		gun_control.rotation_degrees.z = 209
		
	if Input.is_action_pressed("GE_Down") and gun_control.rotation_degrees.z < -28:
		gun_control.rotation_degrees.z = -29
