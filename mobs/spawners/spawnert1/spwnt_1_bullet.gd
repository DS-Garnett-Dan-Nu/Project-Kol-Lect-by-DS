extends Area3D
class_name spwnr_t1

var dir = Vector3()
var speed = 40
var health = 30


func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += transform.basis.z * -speed * delta
	
	#Die!
	if health <= 0:
		queue_free()
	





func _on_area_entered(area):
	#Define the bullet type
	if area is autocannon:
		health -= AutoLoad.fcc_auto_damage
	if area is flak_cannon:
		health -= AutoLoad.fcc_flak_damage
	if area.is_in_group("player_hit"):
		queue_free()

