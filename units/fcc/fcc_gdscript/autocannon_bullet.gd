extends Area3D
class_name autocannon

#Stats
var speed = 100
var dir = Vector3()

#Node Variables
@onready var body = $body

func _ready():
	set_as_top_level(true)
	
func _process(delta): 
	
	#To make the bullet go to it's direction
	position += transform.basis.x * speed * delta
	body.rotation_degrees.x += 180
	




func _on_area_entered(area):
	queue_free()
