extends CharacterBody3D

#Stats
var collected = false
var speed = 2
var gravity = AutoLoad.global_gravity
var direction = Vector3()

#Controls
var move_controls = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Spawn Direction
	direction = Vector3(randf_range(-2,2),randf_range(9,10),randf_range(-2,2))


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
		speed = 10
		velocity = global_position.direction_to(AutoLoad.player_location) * speed
		
	if collected == false and move_controls < 0.2:
		speed = 0
	
	#Movement Calculation
	move_and_slide()
	
	#Remove when collected or got to the player's position
	if global_position <= AutoLoad.player_location + Vector3(0.1,0.1,0.1):
		AutoLoad.global_engion += 1
		print("Collected!")
		queue_free()
	
	
	
	

#Detects player
func _on_collected_area_entered(area):
	collected = true
	
	

func _on_collected_area_exited(area):
	collected = false

#Initial Movement Timer
func _on_timer_timeout():
	if move_controls >= 0.2:
		speed -= 0.1
		move_controls -= 0.5
