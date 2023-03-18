extends Area3D

var dir = Vector3()
var speed = 100

@onready var body = $body

func _ready():
	set_as_top_level(true)
	
func _process(delta): 
	position += transform.basis.x * speed * delta
	body.rotation_degrees.x += 100
	



func _on_Projectile_body_entered(body):
	queue_free()
