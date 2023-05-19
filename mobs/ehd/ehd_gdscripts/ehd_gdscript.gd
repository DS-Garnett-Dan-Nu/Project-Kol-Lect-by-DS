extends CharacterBody3D



#Stats
var health = AutoLoad.ehd_health
var speed = AutoLoad.ehd_speed
var jump_velocity = 30
var jump_boost = 2
var max_resource = 6
var resource_freed = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = AutoLoad.global_gravity

#Movements controls
var jump_control = false

#Damage Control
@onready var dmg_dectr = $DamageDectector/CollisionShape3D

#Load da resources
@onready var engion = preload("res://resources/engion/engion_scene.tscn")

@onready var resource_spawnpt = get_node("../spawnpt")
@onready var node = get_node("../node")

#Physics Process
func _physics_process(delta):
	
	
	
	
	
	
	#If enemy is on the floor duh...
	if is_on_floor():
		jump_boost = 2
		
	#Die!
	if health <= 0:
		die()
	
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
	
	#Engion Drop Chance
	var x = round(randf_range(0,1))
	
	
	#The Lower the health, the faster the speed
	speed += health/70
	
	#Define the damage type
	if area is autocannon:
		
		#Reduce Health
		health -= AutoLoad.fcc_auto_damage
		
		#Drop style
		if x == 0 and max_resource > 0:
			drop_engion(1)
			
	if area is flak_cannon:
		
		#Reduce Health
		health -= AutoLoad.fcc_flak_damage
		
		#Drop style Single
		if x == 0:
			drop_engion(1)
			
		#Drop style Triple
		elif x == 1 and max_resource > 0:
			drop_engion(3)
				
				
		
	
func drop_engion(range):
	for i in range(range):
		var engionC1 = engion.instantiate()
		add_child(engionC1)
		engionC1.reparent(node)#Reparenting makes the child node independent from ehd
		
		
		
		
	
	
	
func die():
	queue_free()
#	speed = 0
#	$EHD_V1.set_deferred("visible",false)
#	$CollisionShape3D.position.y = 0
#	$DamageDectector/CollisionShape3D.set_deferred("disabled",true)
#	$DamagerGiver/CollisionShape3D.set_deferred("disabled",true)
	



