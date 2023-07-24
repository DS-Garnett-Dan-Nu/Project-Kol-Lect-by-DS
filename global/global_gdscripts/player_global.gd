extends CharacterBody3D
class_name player




##These varibles are needed to be left empty if another controlable character is added
var speed = 0
var move_direction := Vector3.ZERO
##The Selected controlable character stats are to be declared in the _ready() function
###########


#Misc
var gravity = AutoLoad.global_gravity
var _snap_vector := Vector3.DOWN
var acceleration = 0
############



# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Send the location value for mobs to locate 
	AutoLoad.player_location = $playerlocation.global_position


func _physics_process(delta: float) -> void:
	
	#changecamera for boss
	if AutoLoad.final_boss:
		$CameraBoss.current = true
		$CameraOrta.current = false
	else:
		$CameraOrta.current = true
		$CameraBoss.current = false
	
	#Send the location value for mobs to locate
	AutoLoad.player_location = $playerlocation.global_position
	
	#Capturing Movements
	
	
	#For acceleration
	if Input.is_action_pressed("Go_Right") or Input.is_action_pressed("Go_Left"):
		
		if Input.is_action_pressed("Go_Right") and move_direction.x < 0:
			speed = 0
		elif Input.is_action_pressed("Go_Left") and move_direction.x > 0:
			speed = 0
		
		elif speed < AutoLoad.fcc_stats['speed'] and AutoLoad.fcc_stats['deploy'] == false:
			speed += 0.2
			
		move_direction.x = Input.get_action_strength("Go_Right") - Input.get_action_strength("Go_Left")
		
	elif speed >= 0 and AutoLoad.fcc_stats['deploy'] == false:
		
		if Input.is_action_just_released("Go_Right"):
			move_direction.x = 1
		elif Input.is_action_just_released("Go_Left"):
			move_direction.x = -1
			
		speed -= 0.2
		
		
		
	
	
	
	
	
	
	
	
	#this is for z movement, if i ever wanted to implement Z axis ...?
	#move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	#Defining Movements
	velocity.x = move_direction.x * speed
	velocity.y -= gravity * delta
	
#	#Jump or no jump conditions
#	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
#	var is_jumping := is_on_floor() and Input.is_action_just_pressed(("jump"))
	
#	#Check for Jump Activity
#	if is_jumping:
#		speed = jump_boost #Boost to jump over gaps
#		velocity.y = jump_strength
#		#_snap_vector = Vector3.ZERO
#	elif just_landed:
#		speed = AutoLoad.fcc_base_speed #Disengage Boost
#		#_snap_vector = Vector3.DOWN
		
	#No Move Move when delpoyed
	if AutoLoad.fcc_stats['deploy']:
		speed = 0
#		jump_boost = 0
#		jump_strength = 0
#	else:
#		jump_boost = AutoLoad.fcc_base_speed * 3
#		jump_strength = AutoLoad.fcc_jump_velocity
		
	move_and_slide()
	
	#Send the location value for mobs to locate 
	AutoLoad.player_location = $playerlocation.global_position




#	#Camera... Rotating eh?
#	if !AutoLoad.global_service_ing:
#		if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
#			pass
#		elif  Input.is_action_pressed("Go_Right") and cam_pers.rotation_degrees.y > -6:
#			cam_pers.rotation_degrees.y -= 1.5
#			cam_pers.position.x += 2
#
#		elif  Input.is_action_pressed("Go_Left") and cam_pers.rotation_degrees.y < 6:
#			cam_pers.rotation_degrees.y += 1.5
#			cam_pers.position.x -= 2
#
#		if  Input.is_action_pressed("reset_camera"):
#			cam_pers.rotation_degrees.y = 0
#			cam_pers.position.x = 0
#
#
#	#Service station event
#	if AutoLoad.global_service_time:
#		ani.play("service_time")
#		AutoLoad.global_service_time = false
#	elif AutoLoad.global_service_end:
#		ani.play_backwards("service_time")
#		AutoLoad.global_service_end = false
	
	





func _on_enemy_harder_timeout():
	
	AutoLoad.diffbar += 0.1
	AutoLoad.global_mob_dps += 0.01
	AutoLoad.global_mob_health += 0.02
	AutoLoad.global_mob_speed += 0.01
	AutoLoad.global_mob_spawner_dps += 0.01
	
	if AutoLoad.diffbar == 100:
		AutoLoad.player_is_dead = true
