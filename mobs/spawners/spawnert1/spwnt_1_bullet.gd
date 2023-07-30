extends Area3D
class_name spwnr_t1

var dir = Vector3()
var speed = 10
var health = 30

var control = 0

var stop = false

var player_is_far = 2

#Nodes
@onready var ani = $ani
@onready var flyingSFX = $flyingsfx
@onready var explodeSFX = $explode

#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")

func _ready():
	ani.play("flames")
	
func _process(delta):
	
	
	
	if control <= 3:
		position.y += 0.2
	elif control <= 5 and control > 3:
		position.y -= 0.1
		$Rocket/Flames.scale.x += 0.05
	elif control <= 15 and control > 5:
		position.y += player_is_far
	elif stop == false:
		
		global_position.z = 0
		position.z = 0
		
		look_at(AutoLoad.player_location)
		
		position += transform.basis.z * -speed * delta
		
		if flyingSFX.playing == false:
			flyingSFX.play()
	
	control += 0.1
	
	#Die!
	if health <= 0 and explodeSFX.playing == false:
		
		die()
	





func _on_area_entered(area):
	#Define the bullet type
	if area is autocannon:
		health -= AutoLoad.fcc_stats['auto_damage']
		
		#Only Score Time if shot down!
		AutoLoad.score += 1
		
	if area is flak_cannon:
		health -= AutoLoad.fcc_stats['flak_damage']
		
		#Only Score Time if shot down!
		AutoLoad.score += 2
		
	if area is platform:
		die()
	if area.is_in_group("player_hit"):
		die()


func die():
	explodeSFX.play()
	
	
	
	#add explosion
	var ex = basic_explosion.instantiate()
	add_child(ex)
	ex.scale = Vector3(0.5,0.5,0.5)
		
	flyingSFX.stop()
	stop = true
	$Rocket.hide()
	$hitbox.set_deferred("disabled",true)
	



func _on_explode_finished():
	queue_free()
