extends Area3D

var dir = Vector3()
var speed = 125


func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += transform.basis.x * speed * delta
	rotation.x += 1
	



func _on_Projectile_body_entered(body):
	queue_free()
