extends CharacterBody3D
class_name player



##These varibles are needed to be left empty if another controlable character is added
var speed = AutoLoad.fcc_base_speed
var jump_boost = AutoLoad.fcc_base_speed * 3
var jump_strength = AutoLoad.fcc_jump_velocity
##The Selected controlable character stats are to be declared in the _ready() function
###########


#Misc
var gravity = AutoLoad.global_gravity
var _snap_vector := Vector3.DOWN
@onready var cam_pers = $CameraPers
@onready var cam_orta = $CameraOrta
@onready var ani = $Ani
############



# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Reset the camera
	ani.play("RESET")
	
	#Send the location value for mobs to locate ...currently not in used
	AutoLoad.player_location = global_position


func _physics_process(delta: float) -> void:
	
	#Change Camera Perspective
	if Input.is_action_just_pressed("cam_Pers"):
		cam_orta.current = false
		cam_pers.current = true
	if Input.is_action_just_pressed("cam_orta"):
		cam_orta.current = true
		cam_pers.current = false
	
	
	
	#Send the location value for mobs to locate ...currently not in used
	AutoLoad.player_location = global_position
	
	#Capturing Movements
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("Go_Right") - Input.get_action_strength("Go_Left")
	
	#this is for z movement, if i ever wanted to implement Z axis ...?
	#move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	#Defining Movements
	velocity.x = move_direction.x * speed
	velocity.y -= gravity * delta
	
	#Jump or no jump conditions
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed(("jump"))
	
	#Check for Jump Activity
	if is_jumping:
		speed = jump_boost #Boost to jump over gaps
		velocity.y = jump_strength
		#_snap_vector = Vector3.ZERO
	elif just_landed:
		speed = AutoLoad.fcc_base_speed #Disengage Boost
		#_snap_vector = Vector3.DOWN
		
	#No Move Move when delpoyed
	if AutoLoad.fcc_deploy:
		speed = 0
		jump_boost = 0
		jump_strength = 0
	else:
		speed = AutoLoad.fcc_base_speed
		jump_boost = AutoLoad.fcc_base_speed * 3
		jump_strength = AutoLoad.fcc_jump_velocity
		
	move_and_slide()
	
	#Send the location value for mobs to locate ...currently not in used
	AutoLoad.player_location = global_position




	#Camera... Rotating eh?
	if !AutoLoad.global_service_ing:
		if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
			pass
		elif  Input.is_action_pressed("Go_Right") and cam_pers.rotation_degrees.y > -6:
			cam_pers.rotation_degrees.y -= 1.5
			cam_pers.position.x += 2

		elif  Input.is_action_pressed("Go_Left") and cam_pers.rotation_degrees.y < 6:
			cam_pers.rotation_degrees.y += 1.5
			cam_pers.position.x -= 2

		if  Input.is_action_pressed("reset_camera"):
			cam_pers.rotation_degrees.y = 0
			cam_pers.position.x = 0
		
		
	#Service station event
	if AutoLoad.global_service_time:
		ani.play("service_time")
		AutoLoad.global_service_time = false
	elif AutoLoad.global_service_end:
		ani.play_backwards("service_time")
		AutoLoad.global_service_end = false
	
	
