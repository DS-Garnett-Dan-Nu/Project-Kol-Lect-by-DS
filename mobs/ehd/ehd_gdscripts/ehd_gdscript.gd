extends CharacterBody3D


#Stats
var health = AutoLoad.ehd_health
var speed = AutoLoad.ehd_speed
var jump_velocity = 15
var jump_boost = 2
var max_resource = 36
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

#Health Visual
@onready var on_fire1 = $EHD_V1/Fires/Fire1
@onready var on_fire2 = $EHD_V1/Fires/Fire2
@onready var on_fire3 = $EHD_V1/Fires/Fire3

#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")

func _ready():
	
	health = AutoLoad.ehd_health
	speed = AutoLoad.ehd_speed
	
	print(health)
	
	
	
	#Hide da FIRE!
	on_fire1.hide()
	on_fire2.hide()
	on_fire3.hide()
	
#Physics Process
func _physics_process(delta):
	
	
	
	global_position.z = 0
	position.z = 0
	
	
	
	
	#Convert the health into percentage
	var health_in_percent = (health*100)/AutoLoad.ehd_health
	
	if health_in_percent <= 75:
		on_fire1.show()
	if health_in_percent <= 50:
		on_fire2.show()
	if health_in_percent <= 25:
		on_fire3.show()
		
	
	
	
	#Die!
	if health <= 0:
		die()
	else:
		look_at(AutoLoad.player_location)
		position += transform.basis.z * -speed * delta
	
		
	
	
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		jump_control = false

	velocity.y -= gravity * delta
	
	move_and_slide()
	
	
		
	
	
	
#Jump Detecter
func _on_jump_dectector_area_entered(area):
	jump_control = true


func _on_damage_dectector_area_entered(area):
	
	#More and more difficult over time
	health += AutoLoad.global_difficulty
	
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
			drop_engion(round(AutoLoad.fcc_auto_damage/4))
			max_resource -= round(AutoLoad.fcc_auto_damage/4)
			
	if area is flak_cannon:
		
		#Reduce Health
		health -= AutoLoad.fcc_flak_damage
		
		#Drop style Single
		if x == 0 and max_resource > 0:
			drop_engion(round(AutoLoad.fcc_flak_damage/7))
			max_resource -= round(AutoLoad.fcc_flak_damage/7)
			
		#Drop style Triple
		elif x == 1 and max_resource > 0:
			drop_engion(round(AutoLoad.fcc_flak_damage/5))
			max_resource -= round(AutoLoad.fcc_flak_damage/5)
				
				
		
	
func drop_engion(range):
	for i in range(range):
		var engionC1 = engion.instantiate()
		add_child(engionC1)
		engionC1.reparent(node)#Reparenting makes the child node independent from ehd
		
		
		
		
	
	
	
func die():
	speed = 0
	#$EHD_V1.set_deferred("visible",false)
	$CollisionShape3D.position.y = 1.2
	$DamageDectector/CollisionShape3D.set_deferred("disabled",true)
	$DamagerGiver/CollisionShape3D.set_deferred("disabled",true)
	$EHD_V1/DrillHead.hide()
	$"EHD_V1/EHD_V1-Light".hide()
	$hovers.hide()
	
	
	
	if $Timer.is_stopped():
		$Timer.start()
		
		#Score Time!
		AutoLoad.score += round((randi_range(5,10)))
		
		#add explosion
		var ex = basic_explosion.instantiate()
		add_child(ex)
		ex.scale = Vector3(2,2,2)
		ex.reparent(node)
		





func _on_timer_timeout():
	queue_free()
