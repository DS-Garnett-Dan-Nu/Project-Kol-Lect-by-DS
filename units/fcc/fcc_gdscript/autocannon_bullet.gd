extends Area3D
class_name autocannon

#Stats
var speed = 100
var dir = Vector3()

#Node Variables
@onready var body = $body
@onready var hit = $hit

func _ready():
	set_as_top_level(true)
	
func _process(delta): 
	
	#To make the bullet go to it's direction
	position += transform.basis.x * speed * delta
	body.rotation_degrees.x += 180
	




func _on_area_entered(area):
	if area is platform:
		hit_effect()
	else:
		hit_effect()

func hit_effect():
	$a.global_position = $c.global_position
	$b.global_position = $c.global_position
	$hit.global_position = $c.global_position
	$d.global_position = $c.global_position
	
	
	
	$hitbox.set_deferred("disabled",true)
	$body.hide()
	$Timer.start()
	hit.emitting = true
	speed = 0


func _on_timer_timeout():
	queue_free()
