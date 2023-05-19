extends Node3D
class_name fcc


#Node Variables
@onready var gun_control = $"fcc/Upper Base/Gun" #Gun's Base Elevation Control
@onready var animations = $"Ani" #Animation Controls


#Projectile
@onready var bullet = preload("res://units/fcc/fcc_scenes/autocannon_bullet.tscn")
@onready var flak_bullet = preload("res://units/fcc/fcc_scenes/flak_bullet.tscn")
############

#Gun
#Auto-cannon
@onready var Auto_muzzle_Left = $"fcc/Upper Base/Gun/AimLeft"
@onready var Auto_muzzle_Right = $"fcc/Upper Base/Gun/AimRight"  
#Flak-cannon
@onready var Flak_muzzle_Left = $"fcc/Upper Base/Gun/AimLeftF"
@onready var Flak_muzzle_Right = $"fcc/Upper Base/Gun/AimRightF"  

#Autocannon staggering shot
var one_side_of_the_gun = true

#Flakcannon control
var flak_ammo = 2
@onready var flak_reload = $flak_reload

#Gun Rotation Control
var gun_rotation_speed = 0
@onready var g_r_c = $gun_rotation_acceleration

############

#Stats
var health = AutoLoad.fcc_health


#No use for now, butt too lazy to write again, so imma keep this :3
func _ready():
	
	#Ani
	animations.play("RESET")
	
	#Reload Flak
	flak_reload.start()
	pass # Replace with function body.


#Physics Processes eh?
func _physics_process(delta):
	
	#For Deploy
	deploy()
	
	
	#For Health Bar
	AutoLoad.fcc_healthbar = health
	
	#Die!
	if health <= 0:
		hide()
	
	#Flak Ammo
	if flak_ammo <= 0 and flak_reload.is_stopped():
		flak_reload.start()
	
	#Gun Elevations
	gun_elevations()
	

#FCC Ability: Deploy
func deploy():
	
	#Catch the Deploy Command
	if Input.is_action_just_pressed("ability") and AutoLoad.fcc_deploy == false:
		animations.play("deploy")
		AutoLoad.fcc_deploy = true
		print("True")
	elif Input.is_action_just_pressed("ability") and AutoLoad.fcc_deploy == true:
		animations.play("undeploy")
		AutoLoad.fcc_deploy = false
		print("False")
	

	

#Gun Elevations
func gun_elevations():
	if Input.is_action_pressed("GE_Up") and gun_control.rotation_degrees.z < 200 and gun_control.rotation_degrees.z > -20:		
		if g_r_c.is_stopped():
			g_r_c.start()
		gun_control.rotation_degrees.z += gun_rotation_speed
	if Input.is_action_pressed("GE_Down") and gun_control.rotation_degrees.z < 200 and gun_control.rotation_degrees.z > -20:
		if g_r_c.is_stopped():
			g_r_c.start()
		gun_control.rotation_degrees.z += -gun_rotation_speed
		
	#For Gun Elevation Acceleration Stopping
	if Input.is_action_just_released("GE_Up") and gun_control.rotation_degrees.z < 200 and gun_control.rotation_degrees.z > -20:
		g_r_c.stop()
		gun_rotation_speed = 0
	if Input.is_action_just_released("GE_Down") and gun_control.rotation_degrees.z < 200 and gun_control.rotation_degrees.z > -20:
		g_r_c.stop()
		gun_rotation_speed = 0
	
	#Gun Elevations Control cuz godot's physics_process always overshot the degress and gets stuck :3
	if Input.is_action_pressed("GE_Up") and gun_control.rotation_degrees.z > 198:
		gun_control.rotation_degrees.z = 199
	if Input.is_action_pressed("GE_Down") and gun_control.rotation_degrees.z < -18:
		gun_control.rotation_degrees.z = -19
	
#	#For Movement Animations
#	#If both buttons are pressed together, the animation will stop.
#	if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
#		animations.pause()
#	else:
#		#Normal Movement Animations
#		if Input.is_action_pressed("Go_Right"):
#			animations.play("walking")
#		if Input.is_action_just_released("Go_Right"):
#			animations.pause()
#
#		if Input.is_action_pressed("Go_Left"):
#			animations.play_backwards("walking")
#		if Input.is_action_just_released("Go_Left"):
#			animations.pause()



func _on_gun_rotation_acceleration_timeout():
	print("here!")
	if gun_rotation_speed <= 1:
		
		gun_rotation_speed += 0.1
			
#Firing Logic
func _on_auto_cannon_shot_interval_timeout():
	
	#Gun Fire Control, i.e. both feet are need to be on the floor to Fire.
	if Input.is_action_pressed("Fire"):
			

		#Autocannon staggering shot
		if one_side_of_the_gun == true:
			
			if AutoLoad.primary_weapon:
				#fire the autocannon!  
				var left_bullet = bullet.instantiate()
				left_bullet.rotation_degrees = Auto_muzzle_Left.global_transform.basis.get_euler()
				Auto_muzzle_Left.add_child(left_bullet)
			
			elif AutoLoad.secondary_weapon and flak_ammo > 0 and AutoLoad.fcc_deploy == true:
				
				#To notify the player
				AutoLoad.fcc_can_fire = true
				
				#fire the flakcannon!  
				var left_bullet1 = flak_bullet.instantiate()
				left_bullet1.rotation_degrees = Flak_muzzle_Left.global_transform.basis.get_euler()
				Flak_muzzle_Left.add_child(left_bullet1)
				
				#Flak Ammo
				flak_ammo -= 1
				
			elif flak_ammo <= 0:
				print("Flak is Reloading!")
				
			else:
				#To notify the player
				AutoLoad.fcc_can_fire = false
			
			#change side!
			one_side_of_the_gun = false
			
			#Rest!
			
		elif one_side_of_the_gun == false:
			
			if AutoLoad.primary_weapon:
				
				#fire the autocannon!
				var right_bullet = bullet.instantiate()
				right_bullet.rotation_degrees = Auto_muzzle_Right.global_transform.basis.get_euler()
				Auto_muzzle_Right.add_child(right_bullet)
			
			elif AutoLoad.secondary_weapon and flak_ammo > 0 and AutoLoad.fcc_deploy == true:
				
				#To notify the player
				AutoLoad.fcc_can_fire = true
				
				#fire the flakcannon!
				var right_bullet1 = flak_bullet.instantiate()
				right_bullet1.rotation_degrees = Flak_muzzle_Right.global_transform.basis.get_euler()
				Flak_muzzle_Right.add_child(right_bullet1)
				
				#Flak Ammo
				flak_ammo -= 1
			
			elif flak_ammo <= 0:
				print("Flak is Reloading!")
				
			else:
				#To notify the player
				AutoLoad.fcc_can_fire = false
			
			#change side!
			one_side_of_the_gun = true
				
	

#Flak Timer
func _on_flak_reload_timeout():
	flak_ammo = 2
	print('Flak Ready!')
	



func _on_health_area_entered(area):
	
	#damage_resistance duh...
	var damage_resistance = 1
	
	#Check if FCC is deployed
	if AutoLoad.fcc_deploy:
		damage_resistance = 2
	else:
		damage_resistance = 1		
	
	#Calculate the damage
	if area is ehd:
		health -= AutoLoad.ehd_dps/damage_resistance
	
	if area is spwnr_t1:
		health -= AutoLoad.spwnt1_dps/damage_resistance
	
	









