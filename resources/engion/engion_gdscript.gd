extends CharacterBody3D

#Stats
var collected = false
var disappear = false
var speed = 2
var gravity = AutoLoad.global_gravity
var direction = Vector3()
@onready var light = $OmniLight3D

#Controls
var move_controls = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Spawn Direction
	direction = Vector3(randf_range(-2,2),randf_range(9,10),randf_range(-2,2))
	
	#Idle
	light.set_deferred("visible",false)
	
	#trail
	$look.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	
	#Initial Movement
	if move_controls >= 0.2:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y = direction.y * speed
	
	if move_controls < 0.2:
		#Gravity
		velocity.y -= gravity * delta
	
	#Go to be collected
	if collected:
		speed = AutoLoad.fcc_kollecter_speed
		velocity = global_position.direction_to(AutoLoad.kollector_location) * speed
		
		#Look at the Kollector
		$look.look_at(AutoLoad.kollector_location)
		
	if collected == false and move_controls < 0.2:
		speed = 0
	
	#Movement Calculation
	move_and_slide()
	
	#Remove when collected or got to the player's position
	if disappear:
		hide()
		
		$collected/CollisionShape3D.set_deferred("disabled",true)
		
	
	
	
	

#Detects player
func _on_collected_area_entered(area):
	
	if area.is_in_group("triggers"):
		collected = true
		light.set_deferred("visible",true)
		light.set_deferred("light_color","0cffff")
		$look.show()
		

	if area.is_in_group("kollectors"):
		AutoLoad.global_engion += 1
		disappear = true
		$sfx.volume_db = -25
		$sfx.play(0.25)
	
	

func _on_collected_area_exited(area):
	
	if area.is_in_group("triggers"):
		collected = false
		light.set_deferred("visible",false)
		$look.hide()
		

	

#Initial Movement Timer
func _on_timer_timeout():
	if move_controls >= 0.2:
		speed -= 0.1
		move_controls -= 0.5





func _on_sfx_finished():
	queue_free()


func _on_decay_timeout():
	queue_free()
