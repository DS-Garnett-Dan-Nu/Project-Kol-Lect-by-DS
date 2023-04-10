extends CharacterBody3D
class_name player

#Player Movement Stats

##These varibles are needed to be left empty if another controlable character is added
var speed = AutoLoad.fcc_base_speed
var jump_boost = AutoLoad.fcc_base_speed * 2
var jump_strength = AutoLoad.fcc_jump_velocity
##The Selected controlable character stats are to be declared in the _ready() function
###########


#Misc
var gravity = AutoLoad.global_gravity
var _snap_vector := Vector3.DOWN
@onready var _spring_arm: SpringArm3D = $SpringArm
############



# Called when the node enters the scene tree for the first time.
func _ready():
	#Send the location value for mobs to locate ...currently not in used
	AutoLoad.player_location = global_position


func _physics_process(delta: float) -> void:
	
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
		_snap_vector = Vector3.ZERO
	elif just_landed:
		speed = AutoLoad.fcc_base_speed #Disengage Boost
		_snap_vector = Vector3.DOWN
		
	move_and_slide()
	
	#Send the location value for mobs to locate ...currently not in used
	AutoLoad.player_location = global_position




	#Camera... Rotating eh?
	if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
		pass
	elif  Input.is_action_pressed("Go_Right") and _spring_arm.rotation_degrees.y > -5:
		_spring_arm.rotation_degrees.y -= 1.5
		_spring_arm.position.x += 1

	elif  Input.is_action_pressed("Go_Left") and _spring_arm.rotation_degrees.y < 5:
		_spring_arm.rotation_degrees.y += 1.5
		_spring_arm.position.x -= 1

	if  Input.is_action_pressed("reset_camera"):
		_spring_arm.rotation_degrees.y = 0
		_spring_arm.position.x = 0
	
