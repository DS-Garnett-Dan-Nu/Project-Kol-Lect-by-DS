extends Area3D
class_name flak_cannon

var dir = Vector3()
var speed = 175



func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += transform.basis.x * speed * delta
	





func _on_area_entered(area):
	queue_free()

