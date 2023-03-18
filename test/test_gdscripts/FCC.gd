extends Node3D


#Node Variables
@onready var gun_control = $"FCC Ani/fcc/Upper Base/Gun" #Gun's Base Elevation Control
@onready var animations = $"FCC Ani/AnimationPlayer" #Animation Controls

#These nodes are for Fire Control, i.e. both feet are need to be on the floor to Fire.
@onready var left_feet = $"FCC Ani/fcc/Left Feet +50cm Y is Floor" 
@onready var right_feet = $"FCC Ani/fcc/Right Feet +50cm Y is Floor"

#Projectile
@onready var bullet = preload("res://global/global_scenes/Projectile.tscn")

#Gun
@onready var Auto_muzzle_Left = $"FCC Ani/fcc/Upper Base/Gun/AimLeft"
@onready var Auto_muzzle_Right = $"FCC Ani/fcc/Upper Base/Gun/AimRight"

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
		if left_feet.position.y < - 1.0 and right_feet.position.y < - 1.0:
			print("Fire!")
			
			var left_bullet = bullet.instantiate()
			left_bullet.rotation_degrees = Auto_muzzle_Left.global_transform.basis.get_euler()
			Auto_muzzle_Left.add_child(left_bullet)
			
			var right_bullet = bullet.instantiate()
			Auto_muzzle_Right.rotation_degrees = Auto_muzzle_Right.global_transform.basis.get_euler()
			Auto_muzzle_Right.add_child(right_bullet)
			
		else:
			print("WARNING! Both Feet are needed to be on the ground to Fire.")


	#For Movement Animations
	#If both buttons are pressed together, the animation will stop.
	if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
		animations.pause()
	else:
		#Normal Movement Animations
		if Input.is_action_pressed("Go_Right"):
			animations.play("walking")
		if Input.is_action_just_released("Go_Right"):
			animations.pause()
			
		if Input.is_action_pressed("Go_Left"):
			animations.play_backwards("walking")
		if Input.is_action_just_released("Go_Left"):
			animations.pause()
			
			
			

