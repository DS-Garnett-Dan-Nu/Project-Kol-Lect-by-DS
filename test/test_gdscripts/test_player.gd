extends KinematicBody


# Declare member variables here. Examples:
export var speed := 15.0
export var jump_strength := 50.0
export var gravity := 75.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	
	#Movements
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("Go_Left") - Input.get_action_strength("Go_Right")
	#move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") #this is for z movement, if needed
	
	_velocity.x = move_direction.x * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed(("jump"))
	
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
		
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)




	#Camera... Rotating eh?
	if  Input.is_action_pressed("Go_Left") and Input.is_action_pressed("Go_Right"):
		pass
	elif  Input.is_action_pressed("Go_Left") and _spring_arm.rotation_degrees.y > -5:
		_spring_arm.rotation_degrees.y -= 1.5

	elif  Input.is_action_pressed("Go_Right") and _spring_arm.rotation_degrees.y < 5:
		_spring_arm.rotation_degrees.y += 1.5


		
	
	
#func _process(delta):
#	_spring_arm.translation = translation
