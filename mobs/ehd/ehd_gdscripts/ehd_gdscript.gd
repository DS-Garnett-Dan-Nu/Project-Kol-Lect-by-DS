extends CharacterBody3D



#Stats
var health = AutoLoad.ehd_health
var speed = AutoLoad.ehd_speed
var jump_velocity = 30
var jump_boost = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = AutoLoad.global_gravity

#Movements controls
var jump_control = false

#Damage Control
@onready var dmg_dectr = $DamageDectector/CollisionShape3D

#Physics Process
func _physics_process(delta):
	
	
	
	#If enemy is on the floor duh...
	if is_on_floor():
		jump_boost = 2
		
	#Die!
	if health <= 0:
		queue_free()
	
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		jump_control = false

	#Make it move to the left
	var move_direction := Vector3.ZERO
	move_direction.x = 1 - jump_boost
	
	#Move Speed
	velocity.x = move_direction.x * speed
	velocity.y -= gravity * delta
	
	#Jump Control
	if jump_control and is_on_floor():
		jump_boost = 3
		velocity.y = jump_velocity

	move_and_slide()
	
	
#Jump Detecter
func _on_jump_dectector_area_entered(area):
	jump_control = true


func _on_damage_dectector_area_entered(area):
	
	#The Lower the health, the faster the speed
	speed += health/70
	
	#Define the damage type
	if area is autocannon:
		health -= AutoLoad.fcc_auto_damage
	if area is flak_cannon:
		health -= AutoLoad.fcc_flak_damage
	




