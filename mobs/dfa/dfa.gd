extends Node3D


var dir = Vector3()
var speed = AutoLoad.dfa_speed
var health = AutoLoad.dfa_health
var rotation_speed = round(randi_range(-3,3))
var died = false


@onready var explodeSFX = $explode

#Load da resources
@onready var engion = preload("res://resources/engion/engion_scene.tscn")

#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$spawn.play()
	$flying.play()
	look_at(AutoLoad.kollector_location + Vector3(round(randi_range(5,15)),0,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#spin!!!
	$DFA.rotation_degrees.z += rotation_speed
	
	#movement
	position += transform.basis.z * -speed * delta
	
	#die
	if health <= 0 and died == false:
		died = true
		die()


func _on_hitbox_area_entered(area):
	#Define the bullet type
	if area is autocannon:
		health -= AutoLoad.fcc_stats['auto_damage']
		
		#Score Time!
		AutoLoad.score += round((randi_range(20,30)))
		
	if area is flak_cannon:
		health -= AutoLoad.fcc_stats['flak_damage']
		
		#Score Time!
		AutoLoad.score += round((randi_range(20,30)))
		
	if area is platform:
		die()
	if area.is_in_group("player_hit"):
		die()

func die():
	
	
	
	#Others
	$hitbox/CollisionShape3D.set_deferred("disabled",true)
	$DFA.hide()
	$flying.stop()
	
	#drop engion
	var range = round(randi_range(10,20))
	drop_engion(range)
	
	#add explosion
	var ex = basic_explosion.instantiate()
	add_child(ex)
	ex.scale = Vector3(2,2,2)
	ex.reparent($"../node")
		
	explodeSFX.play()
	

func _on_explode_finished():
	queue_free()


func drop_engion(range):
	for i in range(range):
		var engionC1 = engion.instantiate()
		$spt.add_child(engionC1)
		engionC1.reparent($"../node")#Reparenting makes the child node independent from ehd
