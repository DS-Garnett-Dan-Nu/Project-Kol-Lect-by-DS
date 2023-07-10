extends Node3D
class_name fcc


#Node Variables
@onready var gun_control = $"fcc/Upper Base/Gun" #Gun's Base Elevation Control
@onready var animations = $"Ani" #Animation Controls
@onready var fcc_kollector = $fcc_kollector

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
var reload_time = 0

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

#HUD
@onready var hud = $fcc_hud


#No use for now, butt too lazy to write again, so imma keep this :3
func _ready():
	
	#to hide the hud in mainmenu
	hud.hide()
	
	#Ani
	animations.play("RESET")
	
	#Reload Flak
	flak_reload.start()



#Physics Processes eh?
func _physics_process(delta):
	
	#for reloading hud
	$fcc_hud/flakreload.value = reload_time
	
	#Force Repair
	if Input.is_action_pressed("force_repair") and health <= AutoLoad.fcc_health:
		health += 0.5
		AutoLoad.global_engion -= 1
		AutoLoad.fcc_force_repair = true
	elif Input.is_action_just_released("force_repair"):
		AutoLoad.fcc_force_repair = false
	
	#Send FCC Kollector Location to Kollect Resources
	AutoLoad.kollector_location = fcc_kollector.global_position
	
	#For HUD to show
	if AutoLoad.in_menu == false:
		hud.show()
	else:
		hud.hide()
		
		
	
	#For Deploy
	deploy()
	
	
	#For Health Bar
	AutoLoad.fcc_healthbar = health
	
	#Die!
	if health <= 0:
		AutoLoad.player_is_dead = true
		hide()
	
	#Flak Ammo
	if flak_ammo <= 0 and flak_reload.is_stopped():
		flak_reload.start()
		reload_time = 0
	
	#Gun Elevations
	gun_elevations()
	

#FCC Ability: Deploy
func deploy():
	
	#Catch the Deploy Command
	if Input.is_action_just_pressed("ability") and AutoLoad.fcc_deploy == false:
		animations.play("deploy")
		AutoLoad.fcc_deploy = true

	elif Input.is_action_just_pressed("ability") and AutoLoad.fcc_deploy == true:
		animations.play("undeploy")
		AutoLoad.fcc_deploy = false

	

	

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
	if gun_rotation_speed <= 5:
		
		gun_rotation_speed += 0.1
			
#Firing Logic
func _on_auto_cannon_shot_interval_timeout():
	
	#Gun Fire Control, i.e. both feet are need to be on the floor to Fire.
	if Input.is_action_pressed("Fire") and AutoLoad.global_engion > 0:
		
		
			

		#Autocannon staggering shot
		if one_side_of_the_gun == true:
			
			if AutoLoad.primary_weapon:
				
				#Reduce Ammo!
				reduce_engion(1)
				
				#fire the autocannon!  
				var left_bullet = bullet.instantiate()
				left_bullet.rotation_degrees = Auto_muzzle_Left.global_transform.basis.get_euler()
				Auto_muzzle_Left.add_child(left_bullet)
				
			
			elif AutoLoad.secondary_weapon and flak_ammo > 0 and AutoLoad.fcc_deploy == true:
				
				#Reduce Ammo!
				reduce_engion(5)
				
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
				
				#Reduce Ammo!
				reduce_engion(1)
				
				#fire the autocannon!
				var right_bullet = bullet.instantiate()
				right_bullet.rotation_degrees = Auto_muzzle_Right.global_transform.basis.get_euler()
				Auto_muzzle_Right.add_child(right_bullet)
			
			elif AutoLoad.secondary_weapon and flak_ammo > 0 and AutoLoad.fcc_deploy == true:
				
				#Reduce Ammo!
				reduce_engion(5)
				
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
	
	reload_time += 2.5
	
	if reload_time == 100:
		flak_ammo = 2
		flak_reload.stop()
		print('Flak Ready!')
	

func reduce_engion(amount):
	if AutoLoad.in_menu == false:
		AutoLoad.global_engion -= amount


func _on_health_area_entered(area):
	
	#damage_resistance duh...
	var damage_resistance = 1
	
	#Check if FCC is deployed
	if AutoLoad.fcc_deploy:
		damage_resistance = 2.5
	else:
		damage_resistance = 1		
	
	#Calculate the damage
	if area is ehd:
		health -= AutoLoad.ehd_dps/damage_resistance
	
	if area is spwnr_t1:
		health -= AutoLoad.spwnt1_dps/damage_resistance
		
	if area is dfa:
		health -= AutoLoad.dfa_damage/damage_resistance
		
	

func _on_health_area_exited(area):
	pass
	

func _on_auto_repair_timeout():
	if health < AutoLoad.fcc_health and AutoLoad.global_engion >= 0:
		health += 0.05



