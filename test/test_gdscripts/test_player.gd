extends KinematicBody


# Declare member variables here. Examples:
export var speed := 15.0
export var jump_strength := 35.0
export var gravity := 75.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $smth




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	_velocity.x = move_direction.x * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed(("ui_up"))
	
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
		
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)

	



	#Camera... Rotating eh?
	if  Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		pass
	elif  Input.is_action_pressed("ui_right") and _spring_arm.rotation_degrees.y > -15:
		_spring_arm.rotation_degrees.y -= 1.5
	elif  Input.is_action_pressed("ui_left") and _spring_arm.rotation_degrees.y < 15:
		_spring_arm.rotation_degrees.y += 1.5
#	elif  !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right") and _spring_arm.rotation_degrees.y < 0:
#		_spring_arm.rotation_degrees.y += 0.5
#	elif  !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right") and _spring_arm.rotation_degrees.y > 0:
#		_spring_arm.rotation_degrees.y -= 0.5
		
		
	
	
#func _process(delta):
#	_spring_arm.translation = translation
