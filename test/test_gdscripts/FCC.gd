extends Spatial


#Node Variables
onready var gun_control = $"fcc/Upper Base/Gun" #Gun's Base Elevation Control
onready var animations = $Anis #Animation Controls

#These nodes are for Fire Control, i.e. both feet are need to be on the floor to Fire.
onready var left_feet = $"fcc/Left Feet +50cm Y is Floor" 
onready var right_feet = $"fcc/Right Feet +50cm Y is Floor"


#No use for now, butt too lazy to write again, so imma keep this :3
func _ready():
	pass # Replace with function body.


#Physics Processes eh?
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

	#Gun Fire Control, i.e. both feet are need to be on the floor to Fire.
	if Input.is_action_just_pressed("Fire"):
		if left_feet.translation.y < - 1.0 and right_feet.translation.y < - 1.0:
			print("Fire!")
		else:
			print("WARNING! Both Feet are needed to be on the ground to Fire.")







	#For Movement Animations
	#If both buttons are pressed together, the animation will stop.
	if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
		animations.stop(false)
	else:
		#Normal Movement Animations
		if Input.is_action_pressed("Go_Right"):
			animations.play("walking")
		if Input.is_action_just_released("Go_Right"):
			animations.stop(false)
			
		if Input.is_action_pressed("Go_Left"):
			animations.play_backwards("walking")
		if Input.is_action_just_released("Go_Left"):
			animations.stop(false)
